package com.recycle.utils;

import org.springframework.web.client.RestTemplate;

import java.util.HashMap;
import java.util.Map;

public class AddressParseUtils {

    /**
     * http://lbsyun.baidu.com/index.php?title=webapi/address_analyze
     * 百度地图通过地址来获取经纬度，传入参数address
     * @param
     * @return
     */
/*    public static Map<String,Double> getLngAndLat(String address){
        Map<String,Double> map=new HashMap<String, Double>();
        String url = "http://api.map.baidu.com/geocoder/v2/?address="+address+"&output=json&ak=ak";
        String json = loadJSON(url);
        JSONObject obj = JSONObject.fromObject(json);
        if(obj.get("status").toString().equals("0")){
            double lng=obj.getJSONObject("result").getJSONObject("location").getDouble("lng");
            double lat=obj.getJSONObject("result").getJSONObject("location").getDouble("lat");
            map.put("lng", lng);
            map.put("lat", lat);
            System.out.println("经度：" + lng + "--- 纬度：" + lat);
        }else{
            System.out.println("未找到相匹配的经纬度！");
        }
        return map;
    }
    public static String loadJSON (String url) {
        StringBuilder json = new StringBuilder();
        try {
            URL oracle = new URL(url);
            URLConnection yc = oracle.openConnection();
            BufferedReader in = new BufferedReader(new InputStreamReader(
                    yc.getInputStream()));
            String inputLine = null;
            while ( (inputLine = in.readLine()) != null) {
                json.append(inputLine);
            }
            in.close();
        } catch (Exception e) {
        }
        return json.toString();
    }*/

    public static Map<String,String> parseAddress(String address){

        String key = "jFsuLu2G5kNPhpWllelTUgzcGNG1E3Pt";
        String url = "http://api.map.baidu.com/geocoding/v3/?address=" + address + "&output=json&ak=" + key + "&callback=showLocation";
        RestTemplate restTemplate = new RestTemplate();
        String res = restTemplate.getForObject(url, String.class);
        Map<String,String> map = null;
        if(res.length()>=0){
            int lngStart = res.indexOf("lng\":");
            int lngEnd = res.indexOf(",\"lat");
            int latEnd = res.indexOf("},\"precise");
            if(lngStart > 0 && lngEnd > 0 && latEnd > 0){
                String lng = res.substring(lngStart+5, lngEnd);
                String lat = res.substring(lngEnd+7, latEnd);
                map = new HashMap<String,String>();
                map.put("lng", lng);
                map.put("lat", lat);
                return map;
            }
        }
        return map;
    }



    public static Map<String, Double> baiduMap2txMap(Double lng, Double lat) {
        Map<String, Double> map=new HashMap<>();
        Double xPi = 3.14159265358979324 * 3000.0 / 180.0;
        Double x = lng - 0.0065;
        Double y = lat - 0.006;
        Double z = Math.sqrt(x * x + y * y) - 0.00002 * Math.sin(y * xPi);
        Double theta = Math.atan2(y, x) - 0.000003 * Math.cos(x * xPi);
        Double lng2 = z * Math.cos(theta);
        Double lat2 = z * Math.sin(theta);
        map.put("lng",Double.valueOf(String.format("%.6f",lng2)));
        map.put("lat",Double.valueOf(String.format("%.6f",lat2)));
        return map;
    }
    /**
     *         BufferedReader in = null;
     *         try {
     *             //将地址转换成utf-8的16进制
     *             address = URLEncoder.encode(address, "UTF-8");
     *             URL tirc = new URL("http://api.map.baidu.com/geocoder?address="+ address +"&output=json&key=jFsuLu2G5kNPhpWllelTUgzcGNG1E3Pt");
     *
     *             in = new BufferedReader(new InputStreamReader(tirc.openStream(),"UTF-8"));
     *             String res;
     *             StringBuilder sb = new StringBuilder("");
     *             while((res = in.readLine())!=null){
     *                 sb.append(res.trim());
     *             }
     *             String str = sb.toString();
     *             Map<String,String> map = null;
     *             if(str.length()>=0){
     *                 int lngStart = str.indexOf("lng\":");
     *                 int lngEnd = str.indexOf(",\"lat");
     *                 int latEnd = str.indexOf("},\"precise");
     *                 if(lngStart > 0 && lngEnd > 0 && latEnd > 0){
     *                     String lng = str.substring(lngStart+5, lngEnd);
     *                     String lat = str.substring(lngEnd+7, latEnd);
     *                     map = new HashMap<String,String>();
     *                     map.put("lng", lng);
     *                     map.put("lat", lat);
     *                     return map;
     *                 }
     *             }
     *         }catch (Exception e) {
     *             e.printStackTrace();
     *         }finally{
     *             try {
     *                 in.close();
     *             } catch (IOException e) {
     *                 e.printStackTrace();
     *             }
     *         }
     *         return null;
     */

}
