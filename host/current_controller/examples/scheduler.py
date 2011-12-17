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
            self.updateLight() 
            time.sleep(self.sleepDt)

    def updateLight(self):
        """
        Update the current value for the LED lights using the current time
        value.
        """
        nowStruct = time.localtime()
        nowTuple = nowStruct.tm_hour, nowStruct.tm_min, nowStruct.tm_sec
        nowSec = tuple2sec(nowTuple)
        lightValue = self.getCurrent(nowSec)
        self.dev.set_current_value(self.channel, lightValue)
        print nowTuple, lightValue

    def getCurrent(self,t):
        """
        Get current value for the given time in seconds based on the
        current light schedule parameters.
        """
        if t < self.onBegin:
            current = 0
        elif t < self.onFinish:
            tvals = self.onBegin, self.onFinish
            xvals = 0, self.onCurrent
            current = interpolate(t, tvals, xvals)
        elif t < self.offBegin:
            current =  self.onCurrent
        elif t < self.offFinish:
            tvals = self.offBegin, self.offFinish
            xvals = self.onCurrent, 0
            current = interpolate(t, tvals, xvals)
        else:
            current = 0
        return current


    def setSchedParams(self, params):
        """
        Set method for the params propery which contains the light schedule
        parameters. Performs some basic checks of the parameters. 
        """

        # Extract arguments and convert if necessary
        onBegin = tuple2sec(params['onBegin'])
        onFinish = tuple2sec(params['onFinish'])
        offBegin = tuple2sec(params['offBegin'])
        offFinish = tuple2sec(params['offFinish'])
        onCurrent = params['onCurrent']
        channel = params['channel']

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

        # Everything OK assign values
        self._params = params
        self.channel = channel
        self.onCurrent = onCurrent
        self.onBegin = onBegin
        self.onFinish = onFinish
        self.offBegin = offBegin
        self.offFinish = offFinish

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

    params = { 
            'channel'    : 'a',
            'onCurrent'  : 100, 
            'onBegin'    : (18,24,0), # Time in (hr,min,sec), hr should be in 
            'onFinish'   : (18,25,0), # 24 hr time - e.g. 6pm is (18,0,0)
            'offBegin'   : (18,26,0),
            'offFinish'  : (18,27,0),
            }

    sched = LightScheduler(params,'/dev/ttyUSB0')
    sched.run()





