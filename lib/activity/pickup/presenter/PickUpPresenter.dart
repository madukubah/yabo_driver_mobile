
import 'package:yabo_bank/activity/pickup/interactor/PickUpMVPInteractor.dart';
import 'package:yabo_bank/activity/pickup/view/PickUpMVPView.dart';
import 'package:yabo_bank/base/presenter/BasePresenter.dart';

import '../../../data/network/response/ApiResponse.dart';
import 'PickUpMVPPresenter.dart';


class PickUpPresenter < V extends PickUpMVPView , I extends PickUpMVPInteractor > extends BasePresenter< V, I > implements PickUpMVPPresenter<V, I>
{
  PickUpPresenter(PickUpMVPInteractor interactor) : super(interactor);

  @override
  void getPickUps() {
    this.getView().showProgress(  );

    interactor.doGetPickUps().then( ( ApiResponse response ){
          print( response );
          // return response;
          // this.getView().setRequests( response.data[0] );
          this.getView().setPickUps( response.data );
          this.getView().hideProgress(  );
      } );
  }
  
}