import org.apache.hadoop.io.Text;
import org.json.*;
import org.apache.hadoop.hive.ql.exec.UDF;

public class XML2JSONConvertor extends UDF {

    public static int PRETTY_PRINT_INDENT_FACTOR = 4;
   // public static String TEST_XML_STRING ="<?xml version=\"1.0\" ?><test attrib=\"moretest\">Turn this to JSON</test>";

    public Text evaluate(final Text s) {
        try {
			JSONObject xmlJSONObj = XML.toJSONObject(s.toString());
			String jsonPrettyPrintString = xmlJSONObj.toString(PRETTY_PRINT_INDENT_FACTOR);
			return new Text(jsonPrettyPrintString);
        } catch (JSONException je) {
            return new Text("Error while converting XML to JSON");
        }
    }
}