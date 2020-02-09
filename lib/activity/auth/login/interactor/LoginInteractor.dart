import 'package:yabo_bank/base/interactor/BaseInteractor.dart';
import 'package:yabo_bank/data/network/ApiHelper.dart';
import 'package:yabo_bank/data/network/LoginRequest.dart';
import 'package:yabo_bank/data/network/response/ApiResponse.dart';
import 'package:yabo_bank/data/preferences/PreferenceHelper.dart';
import 'package:yabo_bank/util/AppConstants.dart';

import 'LoginMVPInteractor.dart';

class LoginInteractor extends BaseInteractor implements LoginMVPInteractor
{
  LoginInteractor(PreferenceHelper preferenceHelper, ApiHelper apiHelper) : super(preferenceHelper, apiHelper) {
  }
  String password = "";
  @override
  Future<ApiResponse> doServerLoginApiCall(String identity, String password) async {

      print( "doServerLoginApiCall" );
      // return null;
      this.password = password;
      return apiHelper.performServerLogin( LoginRequest(
        email : identity ,
        password : password ,
      ) ).then( ( ApiResponse loginResponse ){
          return loginResponse;
      } );
  }

  @override
  void updateUserInSharedPref(ApiResponse loginResponse, LoggedInMode loggedInMode) {
    preferenceHelper.setCurrentUserPassword( this.password );
    super.updateUserInSharedPref( loginResponse,  loggedInMode);
  } 
    
}