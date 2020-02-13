
import 'package:yabo_bank/activity/invoice_create/interactor/InvoiceCreateMVPInteractor.dart';
import 'package:yabo_bank/activity/invoice_create/view/InvoiceCreateMVPView.dart';
import 'package:yabo_bank/base/presenter/BasePresenter.dart';
import 'package:yabo_bank/data/network/response/ApiResponse.dart';
import 'package:yabo_bank/model/PickUp.dart';
import 'package:yabo_bank/model/PriceList.dart';

import 'InvoiceCreateMVPPresenter.dart';


class InvoiceCreatePresenter < V extends InvoiceCreateMVPView , I extends InvoiceCreateMVPInteractor > extends BasePresenter< V, I > implements InvoiceCreateMVPPresenter<V, I>
{
  InvoiceCreatePresenter(InvoiceCreateMVPInteractor interactor) : super(interactor);

  @override
  void getPriceLists() {
    this.getView().showProgress();  
    interactor.doGetPriceLists(  ).then( ( ApiResponse response ){

        this.getView().setPriceLists( response.data );  
        this.getView().hideProgress();  
    });
  }

  @override
  void createTransaction(PickUp pickUp, List<PriceList> priceLists) {
    Map<String, String> dataForm = new Map<String, String>();
    int count = 0;
    for (var i = 0; i < priceLists.length; i++) {
      if( priceLists[i].quantity == 0 ) continue;

      dataForm[ 'product_id[${i}]' ]  = '${priceLists[i].id}';
      dataForm[ 'quantity[${i}]' ]    = '${priceLists[i].quantity}';
      count++;
    }
    dataForm[ 'customer_id' ] = '${pickUp.customerId}';
    dataForm[ 'pickup_id' ]   = '${pickUp.id}';
    
    if( count == 0  ){
      this.getView().showMessage(  "Tidak Ada Yang Di Inputkan", 0 );
      return;
    }
    this.getView().showProgress();  
    interactor.doCreateTransaction( dataForm ).then( ( ApiResponse response ){
          this.getView().hideProgress(  );
          if( response.success )   
            this.getView().showMessage(  response.message, 1 );
          else
            this.getView().showMessage(  response.message, 0 );
    });
  }
}