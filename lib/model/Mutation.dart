class Mutation {
  final int id;
  final int customer_id;
  final int transaction_id;
  final int nominal;
  final int position;
  final String description;
  final String created_at;

  Mutation(
      {
        this.id,
        this.customer_id,
        this.transaction_id,
        this.nominal,
        this.position,
        this.description,
        this.created_at,
      
      });

  Mutation.fromMap(Map<String, dynamic> map)
      : id             = map['id'] ,
        customer_id    = map['customer_id'] ,
        transaction_id = map['transaction_id'] ,
        nominal        = map['nominal'] ,
        position       = map['position'] ,
        description    = map['description'] ,
        created_at     = map['created_at'] 
         ;
}
