import 'package:yabo_bank/base/view/MVPView.dart';
import 'package:yabo_bank/model/PriceList.dart';
// import 'package:yabo_bank/model/Group.dart';

abstract class InvoiceCreateMVPView extends MVPView {
  void showMessage( String message, int status );
  void setPriceLists( List<PriceList> items );

}