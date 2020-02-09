class Request {
  final int id;
  final int customer_id;
  final int status;
  final String info;
  final String created_at;

  Request(
      {
        this.id,
        this.customer_id,
        this.status,
        this.info,
        this.created_at     
      });

  Request.fromMap(Map<String, dynamic> map)
      : id             = map['id'] ,
        customer_id    = map['customer_id'] ,
        status         = map['status'] ,
        info           = map['info'] ,
        created_at     = map['created_at']
         ;
}
