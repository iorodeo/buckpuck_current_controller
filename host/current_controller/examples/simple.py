from current_controller import CurrentController

port = '/dev/ttyUSB0'
cc = CurrentController(port)
cc.set_current_value('a',200)
raw_input('press enter to continue')
cc.close()
