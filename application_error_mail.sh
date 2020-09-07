tail -150 /var/log/tomcat/tomcat.log | egrep -v "INFO|DEBUG|WARN|Full URL" | grep -w -A 100 "ERROR" > /var/log/tomcat-server/tomcat.txt

sed -i '/^$/d' /var/log/tomcat-server/tomcat.txt

c=`diff /var/log/tomcat-server/tomcat.txt /var/log/tomcat-server/tomcatdummy.txt`

if [ "$?" != 0 ]
then
l=`ls -1 /var/log/tomcat-server/tomcat.txt`

        if [ -s "$l" ]
        then
        sed -n '/ERROR/, /2018/p' /var/log/tomcat-server/tracker.txt | egrep -v "INFO|DEBUG|WARN|Full URL" | mail -s "PROD-CarEye Tomcat Exception" -r prodtomcat1@raytech.com abc@raytech.com

        tail -150 /var/log/tomcat/tomcat.log | egrep -v "INFO|DEBUG|WARN|Full URL" | grep -w -A 100 "ERROR" > /var/log/tomcat/tomcatdummy.txt
        sed -i '/^$/d' /var/log/tomcat-server/tomcatdummy.txt
        fi
fi
