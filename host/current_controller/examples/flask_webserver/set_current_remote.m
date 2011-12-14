function set_current_remote(ip, channel ,value)
% set_current_remote
%
% Usage:
%
%  set_current_remote('192.168.0.10', 'a', 100)
%
%  ip = IP of remote computer as string
%  channel = curernt controller channel - 'a', 'b', 'c' or 'd'
%  value = current value in mA (0-1000)
%
% Demonstrate how to use the urlread function to set the current for a 
% given channel on IO Rodeo's LED controller when running the web server
% interface on a remote computer.
%
% Note, assumes that web server is running on port 5000 - which is the
% default.
% -------------------------------------------------------------------------
url = sprintf('http://%s:5000/set_current?channel=%s&value=%d',ip,channel,value);
msg = urlread(url);