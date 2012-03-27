from __future__ import print_function
import time
import atexit
from current_controller import CurrentController

MAX_CURRENT = 1000
ALLOWED_CHANNELS = ('a','b','c','d')

class LightScheduler(object):

    """
    A simple program for scheduling day/night light cycles using the 
    LED current controller.
    """

    def __init__(self,params,port,sleepDt=0.5):
        self.dev = CurrentController(port)
        atexit.register(self.cleanupDev)
        self.params = params
        self.sleepDt = sleepDt

    def cleanupDev(self):
        """
        Close the serial connection to the LED current controller -
        provides some clean up. 
        """
        self.dev.close()

    def run(self):
        """
        Runs forever - setting the light level based on the schedule
        parameters.
        """
        while 1: 
            self.updateLights() 
            time.sleep(self.sleepDt)

    def updateLights(self):
        """
        Update the current value for the LED lights using the current time
        value.
        """
        nowStruct = time.localtime()
        nowTuple = nowStruct.tm_hour, nowStruct.tm_min, nowStruct.tm_sec
        nowSec = tuple2sec(nowTuple)
        print('time: {0}'.format(nowTuple))
        for channel in sorted(self.params.keys()):
            lightValue = self.getCurrent(channel, nowSec)
            self.dev.set_current_value(channel, lightValue)
            print('chan: {0}, current: {1}'.format(channel, lightValue))
        print()

    def getCurrent(self, channel, t):
        """
        Get current value for the given time in seconds based on the
        current light schedule parameters.
        """
        # Extract times and current setting for given channel
        onBegin = self.params[channel]['onBegin']
        onFinish = self.params[channel]['onFinish']
        offBegin = self.params[channel]['offBegin']
        offFinish = self.params[channel]['offFinish']
        onCurrent = self.params[channel]['onCurrent']

        # Convert times
        onBegin = tuple2sec(onBegin)
        onFinish = tuple2sec(onFinish)
        offBegin = tuple2sec(offBegin)
        offFinish = tuple2sec(offFinish)

        # Determine current
        if t < onBegin:
            current = 0
        elif t < onFinish:
            tvals = onBegin, onFinish
            xvals = 0, onCurrent
            current = interpolate(t, tvals, xvals)
        elif t < offBegin:
            current =  onCurrent
        elif t < offFinish:
            tvals = offBegin, offFinish
            xvals = onCurrent, 0
            current = interpolate(t, tvals, xvals)
        else:
            current = 0
        return current

    def setSchedParams(self, params):
        """
        Set method for the params propery which contains the light schedule
        parameters. Performs some basic checks of the parameters. 
        """

        for channel, chanParams in params.iteritems():

            # Extract arguments and convert if necessary
            onBegin = tuple2sec(params[channel]['onBegin'])
            onFinish = tuple2sec(params[channel]['onFinish'])
            offBegin = tuple2sec(params[channel]['offBegin'])
            offFinish = tuple2sec(params[channel]['offFinish'])
            onCurrent = params[channel]['onCurrent']

            maxTime = tuple2sec((23,59,59))
            if onBegin > maxTime:
                raise ValueError, 'onBegin too large'
            if onFinish > maxTime:
                raise ValueError, 'offFinish too large'
            if offBegin > maxTime:
                raise ValueError, 'offBegin too large'
            if offFinish > maxTime:
                raise ValueError, 'offFinish too large'
            if offFinish < offBegin:
                raise ValueError, 'offFinish must be >= offBegin'
            if offBegin < onFinish:
                raise ValueError, 'offBegin must be >= onFinish'
            if onFinish < onBegin:
                raise ValueError, 'onFinish must be >= onBegin'
            if onCurrent < 0: 
                raise ValueError, 'onCurrent must be > 0'
            if onCurrent >= MAX_CURRENT:
                raise ValueError, 'onCurrent must <= {0}'.format(MAX_CURRENT)
            if not channel in ALLOWED_CHANNELS:
                raise ValueError, 'channel not in {0}'.format(ALLOWED_CHANNELS)


        self._params = params

    def getSchedParams(self):
        """
        Get method for the params property which contains the light schedule
        parameters.  
        """
        return self._params

    params = property(getSchedParams,setSchedParams)


def tuple2sec(timeTuple):
    """
    Converts a time tuple (hr,min,sec) to secs
    """
    h,m,s = timeTuple 
    return 60*60*h + 60*m + s 

def interpolate(t, tvals, xvals):
    """
    Linear interpolation between (t0,x0) and (t1,x1)
    
    f(t0) = x0, f(t1) = x1, f(t) = a*t + b 
    Notes, t_vals = (t0,t1),  x_vals = (x0,x1)
    """
    t0, t1 = tvals
    x0, x1 = xvals
    if t < t0 or t > t1:
        raise ValueError, 'out of range'
    if t0 == t1:
        result = x1 
    else:
        a = (x0 - x1)/float((t0 - t1))
        b = x0 - a*t0
        result = a*t + b
    return int(result)


# -----------------------------------------------------------------------------
if __name__ == '__main__':

    port = '/dev/ttyUSB0'

    params = {} 

    # Channel a parameters
    params['a'] = { 
            'onCurrent'  : 100, 
            'onBegin'    : (9,51,0), # Time in (hr,min,sec), hr should be in 
            'onFinish'   : (9,51,30), # 24 hr time - e.g. 6pm is (18,0,0) 
            'offBegin'   : (9,52,0), 
            'offFinish'  : (9,52,30), 
            }

    # Channel b parameters
    params['b'] = { 
            'onCurrent'  : 100, 
            'onBegin'    : (9,40,0),  
            'onFinish'   : (9,40,30), 
            'offBegin'   : (9,41,0), 
            'offFinish'  : (9,41,30), 
            }

    # Channel c parameters
    params['c'] = { 
            'onCurrent'  : 100, 
            'onBegin'    : (9,42,0),  
            'onFinish'   : (9,42,30), 
            'offBegin'   : (9,43,0), 
            'offFinish'  : (9,43,30), 
            }

    # Channel d parameters
    params['d'] = { 
            'onCurrent'  : 100, 
            'onBegin'    : (9,44,0),  
            'onFinish'   : (9,44,30), 
            'offBegin'   : (9,45,0), 
            'offFinish'  : (9,45,30), 
            }

    sched = LightScheduler(params,port)
    sched.run()





