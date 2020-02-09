
import 'dart:io';

import 'package:yabo_bank/activity/request_add/interactor/RequestAddMVPInteractor.dart';
import 'package:yabo_bank/activity/request_add/view/RequestAddMVPView.dart';
import 'package:yabo_bank/base/presenter/BasePresenter.dart';
import 'package:yabo_bank/data/network/response/ApiResponse.dart';

import 'RequestAddMVPPresenter.dart';


class RequestAddPresenter < V extends RequestAddMVPView , I extends RequestAddMVPInteractor > extends BasePresenter< V, I > implements RequestAddMVPPresenter<V, I>
{
  RequestAddPresenter(RequestAddMVPInteractor interactor) : super(interactor);

  @override
  void createRequests(dynamic formData, File image) {
    this.getView().showProgress(  );
    if( image == null )
    {
          this.getView().hideProgress(  );
          this.getView().showMessage(  'Masukkan Gambar', 0 );
          return;
    }
    interactor.doCreateRequests( formData, image ).then( ( ApiResponse response ){
          this.getView().hideProgress(  );
          if( response.success )   
            this.getView().showMessage(  response.message, 1 );
          else
            this.getView().showMessage(  response.message, 0 );
      } );
  }
}