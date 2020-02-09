class ProcessedRequest {
  final int id;
  final int customer_id;
  final int status;
  final String info;
  final String created_at;
  final String driver_name;
  final String confirm_at;

  ProcessedRequest(
      {
        this.id,
        this.customer_id,
        this.status,
        this.info,
        this.created_at ,    
        this.confirm_at ,    
        this.driver_name     
      });

  ProcessedRequest.fromMap(Map<String, dynamic> map)
      : id             = map['id'] ,
        customer_id    = map['customer_id'] ,
        status         = map['status'] ,
        info           = map['info'] ,
        driver_name    = map['driver_name'] ,
        confirm_at     = map['confirm_at'] ,
        created_at     = map['created_at']
         ;
}
