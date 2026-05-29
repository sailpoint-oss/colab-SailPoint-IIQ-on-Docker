#!/bin/bash
sleep 10s
initFile="/tmp/init.txt"

if [ -s "$initFile" ]
then  
    initDefault="/usr/local/tomcat/webapps/identityiq/WEB-INF/config/init.xml"
    if [ -f "$initDefault" ]
    then
       sh /usr/local/tomcat/webapps/identityiq/WEB-INF/bin/iiq console -c "import $initDefault"
       sleep 5s
    fi 

    initUpgrade="/usr/local/tomcat/webapps/identityiq/WEB-INF/config/patch/identityiq-8.5p1-objects.xml"
    if [ -f "$initUpgrade" ]
    then
       sh /usr/local/tomcat/webapps/identityiq/WEB-INF/bin/iiq patch "8.5p1"
       sleep 5s
    fi

    initCustom="/usr/local/tomcat/webapps/identityiq/WEB-INF/config/sp.init-custom.xml"
    if [ -f "$initCustom" ]
    then
       sh /usr/local/tomcat/webapps/identityiq/WEB-INF/bin/iiq console -c "import $initCustom"
       sleep 5s
    fi

    initLcm="/usr/local/tomcat/webapps/identityiq/WEB-INF/config/init-lcm.xml"
    if [ -f "$initLcm" ]
    then
       sh /usr/local/tomcat/webapps/identityiq/WEB-INF/bin/iiq console -c "import $initLcm"
       sleep 5s
    fi   
    rm -f $initFile
fi
sh bin/catalina.sh run