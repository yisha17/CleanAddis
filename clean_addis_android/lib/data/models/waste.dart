

import 'package:flutter/material.dart';

class Waste{
  final int ?id;
  final String ?waste_name;
  final String ?waste_type;
  final int ?price_per_unit;
  final int ?quantity;
  final int ?weight;
  final Image ?image;
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
     this.weight, 
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
      waste_name:jsonMap['waste_name'],
      waste_type:jsonMap['waste_type'],
      price_per_unit:jsonMap['price_per_unit'],
      quantity:jsonMap['quantity'],
      weight:jsonMap['weight'],
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
