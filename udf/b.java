import org.json.*;
import java.util.*;

public class b {

    public static String TEST_STRING ="{\"ItemGroupData\": { \"ItemData\": [ { \"Value\": \"CDISCPILOT01\", \"ItemOID\": \"SV.STUDYID\" }, { \"Value\": \"SV\", \"ItemOID\": \"SV.DOMAIN\" }, { \"Value\": \"01-701-1015\", \"ItemOID\": \"SV.USUBJID\" }, { \"Value\": 1, \"ItemOID\": \"SV.VISITNUM\" }, { \"Value\": \"SCREENING 1\", \"ItemOID\": \"SV.VISIT\" }, { \"Value\": -7, \"ItemOID\": \"SV.VISITDY\" }, { \"Value\": \"2013-12-26\", \"ItemOID\": \"SV.SVSTDTC\" }, { \"Value\": \"2013-12-26\", \"ItemOID\": \"SV.SVENDTC\" } ], \"data:ItemGroupDataSeq\": 1, \"ItemGroupOID\": \"SV\" }}";

    public static void main(String a[]) {
        try {
			JSONObject jsonInArrFormat = new JSONObject(TEST_STRING);
			
			//---COpy Start 
	
			JSONObject jsonRootObject = jsonInArrFormat.getJSONObject("ItemGroupData");
			JSONArray ja = jsonRootObject.getJSONArray("ItemData");
			//System.out.println(ja.toString());
						
			JSONObject tmpArrayJSONElement = null;
			LinkedHashMap objectMap = new LinkedHashMap();
			String name=null;
			Object val=null;
			
			for(int index=0;index<ja.length();index++){
				tmpArrayJSONElement = ja.getJSONObject(index);
				name = tmpArrayJSONElement.getString("ItemOID");
				name = name.substring(name.lastIndexOf(".")+1,name.length()).toLowerCase();
				System.out.println("For index = "+index+" got name="+name);
				val = tmpArrayJSONElement.get("Value");
				objectMap.put(name,val);
			}

			JSONObject newJSONObj = new JSONObject(objectMap);			
			newJSONObj.put("groupOID",jsonRootObject.getString("ItemGroupOID"));
			newJSONObj.put("groupSeq",jsonRootObject.get("data:ItemGroupDataSeq"));


			//---Copy End 
			
			System.out.println(newJSONObj.toString());
			
        } catch (Exception je) {
            je.printStackTrace();
        }
    }
}