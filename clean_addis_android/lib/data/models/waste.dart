

class Waste{
  final int ?id;
  final int ?seller;
  final int ?buyer;
  final String ?for_waste;
  final String ?waste_name;
  final String ?waste_type;
  final int ?price_per_unit;
  final int ?quantity;
  final String ?metric;
  final String ?image;
  final String ?loaction;
  final bool ?sold;
  final bool ?bought;
  final bool ?donated;
  final String ?description;
  final DateTime ?post_date;

  Waste({
    this.id,
    this.waste_name, 
    this.waste_type, 
    this.price_per_unit, 
    this.quantity,
    this.for_waste,
    this.seller,
    this.buyer,
    this.metric, 
    this.image, 
    this.loaction, 
    this.sold, 
    this.bought, 
    this.donated,
    this.description, 
    this.post_date
  });


   factory Waste.fromJSON(Map<String,dynamic> jsonMap){
    final result = Waste(
      id:jsonMap['id'],
      buyer: jsonMap['buyer'],
      seller: jsonMap['seller'],
      for_waste: jsonMap['for_waste'],
      waste_name:jsonMap['waste_name'],
      waste_type:jsonMap['waste_type'],
      price_per_unit:jsonMap['price_per_unit'],
      quantity:jsonMap['quantity'],
      metric:jsonMap['metric'],
      image:jsonMap['image'],
      loaction:jsonMap['loaction'],
      sold:jsonMap['sold'],
      bought:jsonMap['bought'],
      donated:jsonMap['donated'],
      description:jsonMap['description'],
      post_date:jsonMap['post_date'],
  );
    return result;
  }
}
