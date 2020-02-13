import 'package:yabo_bank/base/interactor/MVPInteractor.dart';

import '../../../data/network/response/ApiResponse.dart';

abstract class PickUpMVPInteractor extends MVPInteractor {
  Future<ApiResponse> doGetPickUps(  );
  
}