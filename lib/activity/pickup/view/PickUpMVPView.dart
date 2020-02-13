import 'package:yabo_bank/base/view/MVPView.dart';
import 'package:yabo_bank/model/PickUp.dart';
// import 'package:yabo_bank/model/Group.dart';

abstract class PickUpMVPView extends MVPView {
  void showMessage( String message, int status );
  void setPickUps( List<PickUp> items );
}