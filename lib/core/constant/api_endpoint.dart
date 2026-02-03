class ApiEndpoint {
  static const String viewClient = "viewclient";
  static const String listClient = "listclient";
  static const String addClient = "addclient";
  static const String loanproduct = "viewloanproduct";
  static const String createloan = "addloan";
  static const String viewdocumenttype = "viewdocumenttype";
  static const String viewuser = "viewuser";
  static const String getloanforcheck = "viewloanforcheck";
  static const String getloanforapprove = "viewloanforapprove";
  static checkloan(int id) => "checkloan/$id";
  static approveloan(int id) => "approveloan/$id";
  static const String viewloan = "viewloan";
  // Endpoints with dynamic parameters
  static String editClient(int id) => "editclient/$id";
  static String changeStatusClient(String id) => "changestatusclient/$id";

  static const String viewProvince = "viewprovince";
  static String viewDistrict(int provinceId) => "viewdistrict/${provinceId}";
  static String viewCommunce(int districtId) => "viewcommunce/$districtId";
  static String viewVillage(int communceId) => "viewvillage/$communceId";
  static String viewschedule(int id) => "viewschedule/${id}";
}

class Message {
  static const String CreateSuccess = "បង្កេីតបានជោគជ័យ";
  static const String CreateError = "បង្កេីតមិនបាន";
  static const String UpdateSuccess = "កែប្រែបានជោគជ័យ";
  static const String UpdateError = "កែប្រែមិនបាន";
  static const String Success = "ជោគជ័យ";
  static const String Error = "បរាជ័យ";
  static const String BadRequest = "បំពេញទិន្នន័យមិនត្រឹមត្រូវ";
  static const String ClientDuplicate = "អិថិជនបានជ្រេីសរេីសម្ដងហេីយ";
  static const String BadRequestClient = "សូមជ្រេីសរេីសអ្នកធានាកម្ចី";
  static const String Checksuccess = "ត្រួតពិនិត្យកម្ចីបានជោគជ័យ";
  static const String Approvesuccess = "អនុម័តកម្ចីបានជោគជ័យ";
}
