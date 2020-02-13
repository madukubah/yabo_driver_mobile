import 'package:yabo_bank/base/interactor/BaseInteractor.dart';
import 'package:yabo_bank/data/network/ApiHelper.dart';
import 'package:yabo_bank/data/network/response/ApiResponse.dart';
import 'package:yabo_bank/data/preferences/PreferenceHelper.dart';

import 'InvoiceCreateMVPInteractor.dart';

class InvoiceCreateInteractor extends BaseInteractor implements InvoiceCreateMVPInteractor
{
  InvoiceCreateInteractor(PreferenceHelper preferenceHelper, ApiHelper apiHelper) : super(preferenceHelper, apiHelper);

  @override
  Future<ApiResponse> doGetPriceLists() {
    return apiHelper.performGetPriceLists().then( ( ApiResponse response ){
        return response;
    });
  }

  @override
  Future<ApiResponse> doCreateTransaction(formData) {
    return apiHelper.performCreateTransaction( formData ).then( ( ApiResponse response ){
        return response;
    });
  }
}