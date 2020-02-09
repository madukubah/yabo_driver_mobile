import 'package:yabo_bank/base/interactor/MVPInteractor.dart';
import 'package:yabo_bank/data/network/response/ApiResponse.dart';

abstract class MutationMVPInteractor extends MVPInteractor {
  Future<ApiResponse> doGetMutations( String startDate, String endDate );
  // Future<List<Group>> getGroups();
  
}