FROM centos:7.6.1810
MAINTAINER hujiuzhou <hujz@fishkj.com>

# 安装需要的依赖
RUN yum install -y wget unzip httpd httpd-devel mod_dav_svn subversion

# 安装jdk，tomcat，运行war包
# svnadmin：https://github.com/deqyiyt/jsvnadmin.git
RUN wget -P /usr/local/java http://download.hujiuzhou.com/jdk/jdk-8u151-linux-x64.tar.gz \
	&& tar -xzf /usr/local/java/jdk-8u151-linux-x64.tar.gz -C /usr/local/java --strip-components=1 \
	&& rm -rf /usr/local/java/jdk-8u151-linux-x64.tar.gz \
	&& rm -rf /usr/local/java/javafx-src.zip \
	&& rm -rf /usr/local/java/src.zip \
	&& rm -rf /usr/local/java/man \
	&& rm -rf /usr/local/java/db \
	&& wget -P /usr/local/tomcat http://download.hujiuzhou.com/tomcat/apache-tomcat-8.5.32.tar.gz \
	&& tar -xzf /usr/local/tomcat/apache-tomcat-8.5.32.tar.gz -C /usr/local/tomcat --strip-components=1 \
	&& rm -rf /usr/local/tomcat/apache-tomcat-8.5.32.tar.gz \
	&& rm -rf /usr/local/tomcat/webapps/* \
	&& rm -rf /usr/local/tomcat/conf/server.xml \
	&& rm -rf /etc/httpd/conf.modules.d/10-subversion.conf \
	&& wget -P /usr/local/tomcat/webapps http://download.hujiuzhou.com/svn/admin.war \
	&& unzip /usr/local/tomcat/webapps/admin.war -d /usr/local/tomcat/webapps/admin \
	&& rm -rf /usr/local/tomcat/webapps/admin.war

# 配置环境变量
ENV JAVA_HOME /usr/local/java
ENV CLASSPATH $JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
ENV PATH $PATH:$JAVA_HOME/bin

# 拷贝需要修改的文件
COPY server.xml /usr/local/tomcat/conf/server.xml
COPY 10-subversion.conf /etc/httpd/conf.modules.d/10-subversion.conf
COPY docker-entrypoint.sh /entrypoint.sh

# 设置挂载目录
VOLUME /svn

# 设置端口
EXPOSE 80
EXPOSE 9000

# 设置工作目录
WORKDIR /svn

# 执行启动程序
ENTRYPOINT ["sh","/entrypoint.sh"]