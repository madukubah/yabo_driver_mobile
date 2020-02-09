
import 'package:yabo_bank/activity/main/interactor/HomeMVPInteractor.dart';
import 'package:yabo_bank/activity/main/view/HomeMVPView.dart';
import 'package:yabo_bank/base/presenter/BasePresenter.dart';

import 'HomeMVPPresenter.dart';


class HomePresenter < V extends HomeMVPView , I extends HomeMVPInteractor > extends BasePresenter< V, I > implements HomeMVPPresenter<V, I>
{
  HomePresenter(HomeMVPInteractor interactor) : super(interactor);

  @override
  void logout() {
    interactor.doServerLogOut();
    interactor.performUserLogout();
    interactor.isUserLoggedIn().then( ( bool loggedIn ){
      print( "loggedIn $loggedIn" );
      if( !loggedIn ) 
        this.getView().toLoginPage(  );
    } );
  }
}