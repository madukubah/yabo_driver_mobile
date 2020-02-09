import 'package:yabo_bank/base/interactor/BaseInteractor.dart';
import 'package:yabo_bank/data/network/ApiHelper.dart';
import 'package:yabo_bank/data/network/response/ApiResponse.dart';
import 'package:yabo_bank/data/preferences/PreferenceHelper.dart';

import 'MutationMVPInteractor.dart';

class MutationInteractor extends BaseInteractor implements MutationMVPInteractor
{
  MutationInteractor(PreferenceHelper preferenceHelper, ApiHelper apiHelper) : super(preferenceHelper, apiHelper);

  @override
  Future<ApiResponse> doGetMutations( String startDate, String endDate ) {
    return apiHelper.performGetMutations( startDate, endDate ).then( ( ApiResponse response ){
          return response;
      } );
  }

}