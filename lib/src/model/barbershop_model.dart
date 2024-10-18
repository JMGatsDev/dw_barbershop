class BarbershopModel {
  final int id;
  final String name;
  final String email;
  final List<String> openingDays;
  final List<int> openingHours;
  BarbershopModel({
    required this.id,
    required this.name,
    required this.email,
    required this.openingDays,
    required this.openingHours,
  });
  factory BarbershopModel.fromMap(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': final int id,
        'name': final String name,
        'email': final String email,
        'openin_days': final List openingDays,
        'opening_hours': final List openingHours,
      } =>
        BarbershopModel(
          id: id,
          name: name,
          email: email,
          openingDays: openingHours.cast<String>(),
          openingHours: openingHours.cast<int>(),
        ),
      _ => throw ArgumentError(
          'json Invalido',
        )
    };
  }
}
