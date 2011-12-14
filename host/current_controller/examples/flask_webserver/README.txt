Requirements
------------

* Python

* this package 'current_controller'  

* flask - python web microframework

  Windows:

  Flask can be installed using easy_install. Easy install is found in
  setup_tools which can be downloaded from here

  http://pypi.python.org/pypi/setuptools#downloads 
  
  .exe installers for windows can be found towards the bottom of the page after
  installing. After installing insure that both 
  C:\Python2X and C:\Python2X\Scripts system path.  

  To instal flask open a command window and entry

  easy_install.exe Flask

  Ubuntu: 

  sudo apt-get install python-flask or get the latest version from
  here ttp://flask.pocoo.org/ 


Usage
-----

* For access from localhost only run 

  python controller_we_app.py com3 local

  Note, you should replace 'com3' with the serial port address for the LED
  controller on you device.

* For remote and local access

  python controller_web_app.py com3 builtin 

  Again, you should replace 'com3' with the serial port address for the LED
  controller on you device.

