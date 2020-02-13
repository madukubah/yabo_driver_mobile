import 'package:yabo_bank/base/interactor/MVPInteractor.dart';
import 'package:yabo_bank/data/network/response/ApiResponse.dart';

abstract class LoginMVPInteractor extends MVPInteractor
{
    Future<ApiResponse> doServerLoginApiCall( String identity,  String password );
}