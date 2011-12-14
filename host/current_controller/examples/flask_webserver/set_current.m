function set_current(channel, value)
% set_current
%
% Usage:
% 
%  set_current('a',100)
% 
%  channel = curernt controller channel - 'a', 'b', 'c' or 'd'
%  value = current value in mA (0-1000)
%
% Demonstrates how to use the urlread function to set the current for a 
% given channel on IO Rodeo's LED controller when running the web server
% interface.
% 
% Note, assumes that web server is running on port 5000 - which is the
% default.
%
% Also, assumes that you are accessing the computer. For, an example of 
% controlling an LED Controller on a remote computer see
% set_current_remote.m 
% -------------------------------------------------------------------------

url = sprintf('http://localhost:5000/set_current?channel=%s&value=%d',channel,value);
msg = urlread(url);