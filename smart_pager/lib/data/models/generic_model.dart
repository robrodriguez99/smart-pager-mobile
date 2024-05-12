
import 'package:equatable/equatable.dart';
import 'package:smart_pager/data/models/json_serializable.dart';


abstract class GenericModel<T> extends Equatable  implements JsonSerializable<T> {
  final String id;

  const GenericModel({required this.id});

  
  @override
  List<Object?> get props => [id];
}
