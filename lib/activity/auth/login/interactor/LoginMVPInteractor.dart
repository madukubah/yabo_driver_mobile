import 'package:yabo_bank/base/interactor/MVPInteractor.dart';
import 'package:yabo_bank/data/network/response/ApiResponse.dart';
import 'package:yabo_bank/data/network/response/LoginResponse.dart';
import 'package:yabo_bank/util/AppConstants.dart';

abstract class LoginMVPInteractor extends MVPInteractor
{
    Future<ApiResponse> doServerLoginApiCall( String identity,  String password );
    // void updateUserInSharedPref( LoginResponse loginResponse, LoggedInMode loggedInMode );
}