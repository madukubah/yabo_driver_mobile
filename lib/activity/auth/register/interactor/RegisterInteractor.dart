import 'package:yabo_bank/base/interactor/BaseInteractor.dart';
import 'package:yabo_bank/data/network/ApiHelper.dart';
import 'package:yabo_bank/data/network/response/ApiResponse.dart';
import 'package:yabo_bank/data/preferences/PreferenceHelper.dart';

import 'RegisterMVPInteractor.dart';

class RegisterInteractor extends BaseInteractor implements RegisterMVPInteractor
{
  RegisterInteractor(PreferenceHelper preferenceHelper, ApiHelper apiHelper) : super(preferenceHelper, apiHelper);

  @override
  Future<ApiResponse> doServerRegisterApiCall(Object registerData) async {
    return apiHelper.performServerRegister(registerData).then( ( ApiResponse response ){
        return response;
    });
  }

}