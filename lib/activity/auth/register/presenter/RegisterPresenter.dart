import 'package:yabo_bank/activity/auth/register/interactor/RegisterMVPInteractor.dart';
import 'package:yabo_bank/activity/auth/register/view/RegisterMVPView.dart';
import 'package:yabo_bank/base/interactor/MVPInteractor.dart';
import 'package:yabo_bank/base/presenter/BasePresenter.dart';
import 'package:yabo_bank/data/network/response/ApiResponse.dart';
import 'package:yabo_bank/util/AppConstants.dart';

import 'RegisterMVPPresenter.dart';


class RegisterPresenter < V extends RegisterMVPView , I extends RegisterMVPInteractor > extends BasePresenter< V, I > implements RegisterMVPPresenter<V, I>
{
  RegisterPresenter(MVPInteractor interactor) : super(interactor);

  @override
  void onServerRegisterClicked(Object registerData) {
    // print( registerData );return;
    this.getView().showProgress();  
    interactor.doServerRegisterApiCall( registerData ).then( ( ApiResponse response ){

        this.getView().hideProgress();  

        if( response.success  ){
            interactor.updateUserInSharedPref( response, LoggedInMode.LOGGED_IN_MODE_SERVER );
            this.getView().openMainAvtivity();
            return;
        }

        String message =  response.message;
        this.getView().showMessage( message.trimRight().trimLeft(), 0 );
    });
  }

}