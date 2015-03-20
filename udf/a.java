import org.json.*;

public class a {

    public static int PRETTY_PRINT_INDENT_FACTOR = 4;
    public static String TEST_XML_STRING ="<ItemGroupData data:ItemGroupDataSeq=\"1\" ItemGroupOID=\"SV\"> <ItemData ItemOID=\"SV.STUDYID\" Value=\"CDISCPILOT01\"/> <ItemData ItemOID=\"SV.DOMAIN\" Value=\"SV\"/> <ItemData ItemOID=\"SV.USUBJID\" Value=\"01-701-1015\"/> <ItemData ItemOID=\"SV.VISITNUM\" Value=\"1\"/> <ItemData ItemOID=\"SV.VISIT\" Value=\"SCREENING 1\"/> <ItemData ItemOID=\"SV.VISITDY\" Value=\"-7\"/> <ItemData ItemOID=\"SV.SVSTDTC\" Value=\"2013-12-26\"/> <ItemData ItemOID=\"SV.SVENDTC\" Value=\"2013-12-26\"/> </ItemGroupData>";

    public static void main(String a[]) {
        try {
			JSONObject xmlJSONObj = XML.toJSONObject(TEST_XML_STRING);
			String jsonPrettyPrintString = xmlJSONObj.toString(PRETTY_PRINT_INDENT_FACTOR);
			System.out.println(jsonPrettyPrintString);
        } catch (JSONException je) {
            je.printStackTrace();	
        }
    }
}