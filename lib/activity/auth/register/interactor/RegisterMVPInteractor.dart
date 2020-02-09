import 'package:yabo_bank/base/interactor/MVPInteractor.dart';
import 'package:yabo_bank/data/network/response/ApiResponse.dart';

abstract class RegisterMVPInteractor extends MVPInteractor {
  Future<ApiResponse> doServerRegisterApiCall( Object registerData );
  
}