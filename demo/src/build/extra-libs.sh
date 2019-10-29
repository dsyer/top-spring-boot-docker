#!/bin/sh

TARGET=`dirname $0`/../../target

if [ -z ${THIN_VERSION} ]; then THIN_VERSION=1.0.23.BUILD-SNAPSHOT; fi
if [ -z ${JAR_FILE} ]; then JAR_FILE=${TARGET}/docker-demo-0.0.1-SNAPSHOT.jar; fi
M2_THIN_REPO=~/.m2/repository/org/springframework/boot/experimental/spring-boot-thin-launcher

./mvnw dependency:get -Dartifact=org.springframework.boot.experimental:spring-boot-thin-launcher:${THIN_VERSION}:jar:exec -Dtransitive=false
CPPARENT=`java -Dthin.trace=true -jar ${M2_THIN_REPO}/${THIN_VERSION}/spring-boot-thin-launcher-${THIN_VERSION}-exec.jar --thin.archive=${JAR_FILE} --thin.classpath`
CPCHILD=`java -Dthin.trace=true -jar ${M2_THIN_REPO}/${THIN_VERSION}/spring-boot-thin-launcher-${THIN_VERSION}-exec.jar --thin.archive=${JAR_FILE} --thin.classpath --thin.parent=${JAR_FILE} --thin.profile=k8s`

mkdir -p ${TARGET}/dependency/ext
for f in `echo $CPCHILD | sed -e "s,$CPPARENT,," | tr ':' ' '`; do
  cp $f ${TARGET}/dependency/ext;
done