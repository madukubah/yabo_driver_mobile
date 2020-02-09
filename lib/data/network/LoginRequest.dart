class LoginRequest
{
    final String email;
    final String password;

    LoginRequest( { this.email, this.password });

    Map<String, dynamic> toJson() => loginRequestToJson(this);

    Map<String, dynamic> loginRequestToJson(LoginRequest instance) {
    return <String, dynamic>{
        'email': instance.email,
        'password': instance.password,
      };
    }
}