part of 'waste_bloc.dart';


abstract class WasteEvent extends Equatable {
  const WasteEvent();
}

class CreateWasteEvent extends WasteEvent {
  final String? waste_name;
  final String waste_type;
  final String for_waste;
  final String metric;
  final int quantity;
  final int price_per_unit;
  final String location;
  final String? seller;
  final File? image;
  final String? description;
  CreateWasteEvent({
    this.waste_name,
    required this.waste_type,
    required this.for_waste,
    required this.metric,
    required this.quantity,
    required this.price_per_unit,
    required this.location,
    this.seller,
    this.image,
    this.description,
  });

  @override
  List<Object?> get props => [
    this.waste_name,
    this.waste_type,
    this.for_waste,
    this.metric,
    this.quantity,
    this.price_per_unit,
    this.location,
    this.seller,
    this.image,
    this.description,
  ];
}

class UpdateWasteEvent extends WasteEvent{
  final int id;
  final String? waste_name;
  final String? waste_type;
  final String? for_waste;
  final String? metric;
  final int? quantity;
  final int? price_per_unit;
  final String? location;
  final String? buyer;
  final bool? sold;
  final bool? donated;
  final File? image;
  final String? description;

  UpdateWasteEvent({
    required this.id,
    this.waste_name,
    this.waste_type,
    this.for_waste,
    this.metric,
    this.quantity,
    this.price_per_unit,
    this.location,
    this.buyer,
    this.sold,
    this.donated,
    this.image,
    this.description,
  });
  @override
  List<Object?> get props => [
    this.id,
    this.waste_name,
    this.waste_type,
    this.for_waste,
    this.metric,
    this.quantity,
    this.price_per_unit,
    this.location,
    this.buyer,
    this.sold,
    this.donated,
    this.image,
    this.description,
  ];

}

class DeleteWasteEvent extends WasteEvent{
  final int id;
  DeleteWasteEvent({required this.id});
  
  @override
  List<Object?> get props => [this.id];
}


class AvailableWasteListEvent extends WasteEvent{
  final String? type;
  AvailableWasteListEvent({this.type});
   @override
  List<Object?> get props => [this.type];
}


class BuyWasteEvent extends WasteEvent{
  final int id;
  BuyWasteEvent({required this.id});
   @override
  List<Object?> get props => [this.id];
}


class WasteSoldEvent extends WasteEvent{
  final int id;
  final String for_waste;
  WasteSoldEvent({required this.id,required this.for_waste});
  @override
  List<Object?> get props => [this.id];
}






