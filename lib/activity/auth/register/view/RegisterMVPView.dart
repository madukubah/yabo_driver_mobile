import 'package:yabo_bank/base/view/MVPView.dart';
import 'package:yabo_bank/model/Group.dart';

abstract class RegisterMVPView extends MVPView {
  void showMessage( String message, int status );
  void openMainAvtivity(  );

}