# Load Tomcat Native Library
LD_LIBRARY_PATH=/opt/alfresco/common/lib:$LD_LIBRARY_PATH

JAVA_HOME=/opt/alfresco/java
JRE_HOME=$JAVA_HOME
JAVA_OPTS="-XX:+DisableExplicitGC -XX:+UseConcMarkSweepGC -XX:+UseParNewGC -Djava.awt.headless=true -Dalfresco.home=/opt/alfresco -XX:ReservedCodeCacheSize=128m $JAVA_OPTS "
# remove default memory settings
JAVA_OPTS=`echo $JAVA_OPTS | sed 's/-Xmx[^ ]* //g' | sed 's/-Xms[^ ]* //g'`
export JAVA_OPTS
JAVA_OPTS="-Xms2048M -Xmx2048M $JAVA_OPTS " # java-memory-settings
export JAVA_HOME
if [ "$XMX" ]; then
     JAVA_OPTS=`echo $JAVA_OPTS | sed 's/-Xmx[^ ]* //g'`
     JAVA_OPTS="-Xmx"$XMX"M $JAVA_OPTS " # max heap java-memory-settings
     export JAVA_OPTS
fi
if [ "$XMS" ]; then
     JAVA_OPTS=`echo $JAVA_OPTS | sed 's/-Xms[^ ]* //g'`
     JAVA_OPTS="-Xms"$XMS"M $JAVA_OPTS " # starting heap java-memory-settings
     export JAVA_OPTS
fi

export JRE_HOME
export JAVA_OPTS
export LD_LIBRARY_PATH

