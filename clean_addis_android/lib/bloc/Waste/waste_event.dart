part of 'waste_bloc.dart';


abstract class AddWasteEvent extends Equatable {
  const AddWasteEvent();
}

class CreateWasteEvent extends AddWasteEvent {
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
  List<Object?> get props => throw UnimplementedError();
}
