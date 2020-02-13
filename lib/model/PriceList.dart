

class PriceList {
  final int id;
  final String name;
  var price;
  final String unit;
  int quantity;

  PriceList(
      {
        this.id = 0,
        this.name = "plastik",
        this.price = 1000,
        this.unit = "Kg", 
        this.quantity = 0, 
      });

  PriceList.fromMap(Map<String, dynamic> map)
      : id          = map['id'] ,
        name        = map['name'] ,
        price       = map['price'] ,
        quantity    = 0 ,
        unit        = map['unit']        
         ;
}