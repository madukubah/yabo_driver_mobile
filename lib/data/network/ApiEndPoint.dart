class ApiEndPoint
{
  static const BASE_URL = "https://sisa.co.id/api/";
  static const ASSETS_URL = "https://sisa.co.id/";

  static const LOGIN = BASE_URL+"login";
  static const LOGOUT = BASE_URL+"logout";

  static const REGISTER = BASE_URL+"register";

  static const USER_PROFILE = BASE_URL+"profiles";
  static const UPDATE_USER = BASE_URL+"profiles";

  static const USER_UPLOAD_PROFILE = BASE_URL+"upload_photo";
  static const USER_UPLOAD_IDENTITY_PHOTO = BASE_URL+"upload_identity";

  static const USER_PROFILE_PHOTO = ASSETS_URL+"uploads/users/";
  static const CUSTOMER_IDENTITY_PHOTO = ASSETS_URL+"uploads/identity_photo/";

  static const GET_MUTATIONS = BASE_URL+"mutations";
  static const GET_REQUEST = BASE_URL+"requests";
  static const CREATE_REQUEST = BASE_URL+"requests";
  static const DELETE_REQUEST = BASE_URL+"requests";

  static const GET_PICKUPS    = BASE_URL+"pickups";

  static const GET_PRICELIST  = BASE_URL+"pricelists";

  static const CREATE_TRANSACTION  = BASE_URL+"invoices";

}