use default; 
add jar hdfs:///user/admin/data_pipeline_demo/jars/MyXml2JsonUdf.jar;
CREATE FUNCTION convertX2J AS 'XML2JSONConvertor' USING JAR 'hdfs:///user/admin/data_pipeline_demo/jars/MyXml2JsonUdf.jar';
CREATE FUNCTION convertJArr2Obj AS 'JSONObjector' USING JAR 'hdfs:///user/admin/data_pipeline_demo/jars/MyXml2JsonUdf.jar';
