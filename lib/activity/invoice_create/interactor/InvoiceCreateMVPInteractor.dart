import 'package:yabo_bank/base/interactor/MVPInteractor.dart';
import 'package:yabo_bank/data/network/response/ApiResponse.dart';

abstract class InvoiceCreateMVPInteractor extends MVPInteractor {
  Future<ApiResponse> doGetPriceLists(  );
  Future<ApiResponse> doCreateTransaction( dynamic formData );

  
}