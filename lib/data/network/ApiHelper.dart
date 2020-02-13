import 'dart:io';

import 'LoginRequest.dart';
import 'response/ApiResponse.dart';

abstract class ApiHelper
{
  Future<ApiResponse> performServerLogin( LoginRequest loginRequest );
  Future<ApiResponse> performServerLogOut(  );

  Future<ApiResponse> performServerRegister( Object registerData );

  Future<ApiResponse> performServerUpdateUser( dynamic userData );
  Future<ApiResponse> performGetUser(  );

  Future<ApiResponse> performUserUploadImage( File image );

  Future<ApiResponse> performGetRequests(  );
  Future<ApiResponse> performCreateRequests(  dynamic formData, File image );
  Future<ApiResponse> performDeleteRequests(  int requestId );

  Future<ApiResponse> performGetPickUps(  );

  Future<ApiResponse> performGetPriceLists(  );
  Future<ApiResponse> performCreateTransaction( dynamic formData );



}