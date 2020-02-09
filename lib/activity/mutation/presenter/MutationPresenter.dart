
import 'package:yabo_bank/activity/mutation/interactor/MutationMVPInteractor.dart';
import 'package:yabo_bank/activity/mutation/view/MutationMVPView.dart';
import 'package:yabo_bank/base/presenter/BasePresenter.dart';
import 'package:yabo_bank/data/network/response/ApiResponse.dart';
import 'package:intl/intl.dart';

import 'MutationMVPPresenter.dart';


class MutationPresenter < V extends MutationMVPView , I extends MutationMVPInteractor > extends BasePresenter< V, I > implements MutationMVPPresenter<V, I>
{
  MutationPresenter(MutationMVPInteractor interactor) : super(interactor);

  @override
  void getMutations( DateTime startDate, DateTime endDate ) {
    this.getView().showProgress(  );
    var timeFormatter = new DateFormat('yyyy-MM-dd');

    String start = timeFormatter.format( startDate );
    String end = timeFormatter.format( endDate );
    interactor.doGetMutations( start, end ).then( ( ApiResponse response ){
          print( response.data.mutations.length );
          // return response;
          this.getView().setAccount( response.data );
          this.getView().hideProgress(  );
      } );
  }
}