
import 'dart:io';

import 'package:yabo_bank/activity/profile/interactor/ProfileMVPInteractor.dart';
import 'package:yabo_bank/activity/profile/view/ProfileMVPView.dart';
import 'package:yabo_bank/base/presenter/BasePresenter.dart';
import 'package:yabo_bank/data/network/response/ApiResponse.dart';
import 'package:yabo_bank/data/network/response/LoginResponse.dart';
import 'package:yabo_bank/model/User.dart';
import 'package:yabo_bank/util/AppConstants.dart';

import 'ProfileMVPPresenter.dart';


class ProfilePresenter < V extends ProfileMVPView , I extends ProfileMVPInteractor > extends BasePresenter< V, I > implements ProfileMVPPresenter<V, I>
{
  ProfilePresenter(ProfileMVPInteractor interactor) : super(interactor);

  @override
  void getUser() async {
    interactor.doGetUser(  ).then( ( ApiResponse response ){
        if( response.data == null ) return;

        this.getView().onUserLoad( response.data );
    });
  }

  @override
  void updateUser(dynamic userData ) {
    // return ;
    int userId = interactor.getUserId();
    userData["user_id"] = userId.toString();
    
    this.getView().showProgress();
    interactor.doServerUpdateUser( userData ).then( ( ApiResponse response ){
      if( response == null ) return;
      if( response.success )   
      {
        interactor.updateUserInSharedPref( response, LoggedInMode.LOGGED_IN_MODE_SERVER );
        this.getView().onUserLoad( response.data );
      }else{
        this.getUser();
      }

      if( response.success )   
        this.getView().showMessage(  response.message, 1 );
      else
        this.getView().showMessage(  response.message, 0 );

      this.getView().hideProgress();
    } );
  }

  @override
  void uploadImage(File image) {
   
    this.getView().showProgressCircle();
    interactor.doUploadImage( image ).then( ( ApiResponse response ) {
          if( response == null ) return;

          if( response.success )   
          {
            interactor.updateUserInSharedPref( response, LoggedInMode.LOGGED_IN_MODE_SERVER );
            this.getView().onUserLoad( response.data );
          }else{
            this.getUser();
          }
          
          if( response.success )   
            this.getView().showMessage(  response.message, 1 );
          else
            this.getView().showMessage(  response.message, 0 );
          
          this.getView().hideProgressCircle();
    });
  }

}