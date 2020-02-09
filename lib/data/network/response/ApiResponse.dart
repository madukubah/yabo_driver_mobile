import 'package:yabo_bank/model/User.dart';

class ApiResponse
{
  final bool success;
  final String message;
  final dynamic data;

  ApiResponse( { this.success, this.message, this.data });

  ApiResponse.fromMap(Map<String, dynamic> map)
      : success = ( map['success'] == null ) ?  null : map['success'],
        message = ( map['message'] == null ) ?  null : map['message'],
        data = ( map['data'] == null ) ? null: ( map['data'].isEmpty ) ? null: new User.fromMap( map['data']['user'] );
}