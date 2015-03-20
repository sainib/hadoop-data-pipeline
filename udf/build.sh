javac -classpath ./:/usr/hdp/2.2.0.0-2041/hadoop/client/hadoop-common-2.6.0.2.2.0.0-2041.jar:/usr/hdp/2.2.0.0-2041/hive/lib/hive-exec.jar *.java
rm -rf target/MyXml2JsonUdf.jar
jar cvf target/MyXml2JsonUdf.jar ./*
