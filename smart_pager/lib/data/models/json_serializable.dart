
abstract interface class JsonSerializable<T> {
  JsonSerializable();

  Map<String, dynamic> toJson();

  // weird without return type but it works
  static fromJson(Map<String, dynamic> json) {
    throw UnimplementedError("fromJson not implemented");
  }
}