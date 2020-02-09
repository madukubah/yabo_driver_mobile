import 'package:yabo_bank/data/network/response/ApiResponse.dart';
import 'package:yabo_bank/data/network/response/LoginResponse.dart';
import 'package:yabo_bank/util/AppConstants.dart';

abstract class MVPInteractor {
  Future< bool > isUserLoggedIn(  );
  void performUserLogout(  );
  void updateUserInSharedPref( ApiResponse loginResponse, LoggedInMode loggedInMode );
}