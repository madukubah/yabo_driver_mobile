import 'package:yabo_bank/base/interactor/BaseInteractor.dart';
import 'package:yabo_bank/data/network/ApiHelper.dart';
import 'package:yabo_bank/data/network/response/ApiResponse.dart';
import 'package:yabo_bank/data/preferences/PreferenceHelper.dart';

import 'PickUpMVPInteractor.dart';

class PickUpInteractor extends BaseInteractor implements PickUpMVPInteractor
{
  PickUpInteractor(PreferenceHelper preferenceHelper, ApiHelper apiHelper) : super(preferenceHelper, apiHelper);

  @override
  Future<ApiResponse> doGetPickUps() {
    return apiHelper.performGetPickUps( ).then( ( ApiResponse response ){
                  return response;
              } );
  }

  

}