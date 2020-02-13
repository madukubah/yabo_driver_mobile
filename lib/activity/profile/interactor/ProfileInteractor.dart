import 'dart:io';

import 'package:yabo_bank/base/interactor/BaseInteractor.dart';
import 'package:yabo_bank/data/network/ApiHelper.dart';
import 'package:yabo_bank/data/network/response/ApiResponse.dart';
import 'package:yabo_bank/data/preferences/PreferenceHelper.dart';

import 'ProfileMVPInteractor.dart';

class ProfileInteractor extends BaseInteractor implements ProfileMVPInteractor
{
  ProfileInteractor(PreferenceHelper preferenceHelper, ApiHelper apiHelper) : super(preferenceHelper, apiHelper);

  @override
  Future<ApiResponse> doGetUser( ) async {
    return apiHelper.performGetUser(  ).then( ( ApiResponse response ){
      return response;
    } );
  }

  @override
  int getUserId() {
    return preferenceHelper.getCurrentUserId();
  }

  @override
  Future<ApiResponse> doServerUpdateUser(dynamic userData) async {
    return apiHelper.performServerUpdateUser( userData ).then( ( ApiResponse response ){
      return response;
    } );
  }

  @override
  Future<ApiResponse> doUploadImage(File image) {
    return this.apiHelper.performUserUploadImage(image).then( ( ApiResponse response ) {
      return response;
    });
  }

}