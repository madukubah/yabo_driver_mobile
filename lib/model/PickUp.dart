
class PickUp {
  final int id;
  final int customerId;
  final String customerName;
  final String customerAddress;
  final String customerPhone;
  final String requestInfo;
  final String requestDate;

  PickUp(
      {
        this.id,
        this.customerId,
        this.customerName,
        this.customerAddress,
        this.customerPhone,
        this.requestInfo, 
        this.requestDate, 
      });

  PickUp.fromMap(Map<String, dynamic> map)
      : id              = map['id'] ,
        customerId      = map['customer_id'] ,
        customerName    = map['customer_name'] ,
        customerAddress = map['customer_address'] ,
        customerPhone   = map['customer_phone'] ,
        requestDate     = map['request_date'] ,
        requestInfo     = map['request_info']        
         ;
}
