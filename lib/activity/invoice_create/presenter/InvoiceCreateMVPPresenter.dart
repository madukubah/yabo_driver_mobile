import 'package:yabo_bank/activity/invoice_create/interactor/InvoiceCreateMVPInteractor.dart';
import 'package:yabo_bank/activity/invoice_create/view/InvoiceCreateMVPView.dart';
import 'package:yabo_bank/model/PickUp.dart';
import 'package:yabo_bank/model/PriceList.dart';

abstract class InvoiceCreateMVPPresenter < V extends InvoiceCreateMVPView , I extends InvoiceCreateMVPInteractor > 
{
    void getPriceLists(  );
    void createTransaction( PickUp pickUp, List<PriceList> priceLists );
}