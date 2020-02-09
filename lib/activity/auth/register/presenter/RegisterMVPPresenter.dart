

import 'package:yabo_bank/activity/auth/register/interactor/RegisterMVPInteractor.dart';
import 'package:yabo_bank/activity/auth/register/view/RegisterMVPView.dart';

abstract class RegisterMVPPresenter < V extends RegisterMVPView , I extends RegisterMVPInteractor > 
{
    void onServerRegisterClicked( Object registerData );
}