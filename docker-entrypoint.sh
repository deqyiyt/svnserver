#!/bin/bash

# 启动tomcat
sh /usr/local/tomcat/bin/startup.sh
# 启动httpd
/usr/sbin/httpd
# 启动svn
/usr/bin/svnserve --daemon --foreground --root /svn
