class ApiEndpoint {
  static const String viewClient = "viewclient";
  static const String listClient = "listclient";
  static const String addClient = "addclient";


  // Endpoints with dynamic parameters
  static String editClient(int id) => "editclient/$id";
  static String changeStatusClient(String id) => "changestatusclient/$id";

  static const String viewProvince = "viewprovince"; 
  static  String viewDistrict(int provinceId) => "viewdistrict/${provinceId}";
  static String viewCommunce(int districtId) => "viewcommunce/$districtId";
  static String viewVillage(int communceId) => "viewvillage/$communceId";
}