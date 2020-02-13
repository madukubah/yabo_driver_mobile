import 'dart:io';

import 'package:yabo_bank/base/interactor/MVPInteractor.dart';
import 'package:yabo_bank/data/network/response/ApiResponse.dart';

abstract class ProfileMVPInteractor extends MVPInteractor {
  Future<ApiResponse> doGetUser( );
  int getUserId();
  
  Future<ApiResponse> doServerUpdateUser( dynamic userData );
  Future<ApiResponse> doUploadImage(File image);
}