import 'package:yabo_bank/base/interactor/MVPInteractor.dart';
import 'package:yabo_bank/base/presenter/MVPPresenter.dart';
import 'package:yabo_bank/base/view/MVPView.dart';

abstract class LoginMVPPresenter< V extends MVPView , I extends MVPInteractor > extends MVPPresenter< V, I >
{
  void onServerLoginClicked( String phone ,  String password );
  void start(  );
}