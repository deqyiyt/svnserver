docker run --restart=always --name fishkj.svnserver \
	-v /svn:/svn \
	-v jdbc.properties:/usr/local/tomcat/webapps/admin/WEB-INF/jdbc.properties
	-v /etc/localtime:/etc/localtime:ro \
	-d fishkj/svn:1.7.14 
