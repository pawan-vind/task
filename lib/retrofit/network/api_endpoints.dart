class AppApiEndpoints {
  //Base URL:
  static const String baseUrl = "https://mmfinfotech.co/machine_test";

  //Login Module
  static const String _authResource = "/api/";

  static const String loginUrl = "$baseUrl${_authResource}userLogin";
  static const String register = "$baseUrl${_authResource}userRegister";
  static const String userList = "$baseUrl${_authResource}userList";
  static const String logout = "$baseUrl${_authResource}logout";
}