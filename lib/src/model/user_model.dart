sealed class UserModel {
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.avatar,
  });

  final int id;
  final String name;
  final String email;
  final String? avatar;

  factory UserModel.fromMap(Map<String, dynamic> json) {
    return switch (json['profile']) {
      'ADM' => UserModelAdm.fromMap(json),
      'EMPLOYEE' => UserModelEmployee.fromMap(json),
      _ => throw ArgumentError('Usuario não existe'),
    };
  }
}

class UserModelAdm extends UserModel {
  final List<String>? workDays;
  final List<int>? workHours;
  UserModelAdm({
    required super.id,
    required super.name,
    required super.email,
    super.avatar,
    this.workDays,
    this.workHours,
  });
  factory UserModelAdm.fromMap(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': final int id,
        'name': final String name,
        'email': final String email,
      } =>
        UserModelAdm(
          id: id,
          name: name,
          email: email,
          avatar: json['avatar'],
          workDays: json['work_days']?.cast<String>(),
          workHours: json['work_hours']?.cast<int>(),
        ),
      _ => throw ArgumentError(
          'json Invalido',
        )
    };
  }
}

class UserModelEmployee extends UserModel {
  final int barberShopId;
  final List<String> workDays;
  final List<int> workHours;
  UserModelEmployee({
    required super.id,
    required super.name,
    required super.email,
    super.avatar,
    required this.workDays,
    required this.workHours,
    required this.barberShopId,
  });

  factory UserModelEmployee.fromMap(Map<String, dynamic> map) {
    return switch (map) {
      {
        'id': final int id,
        'name': final String name,
        'email': final String email,
        'barbershop_id': final int barbershop_id,
        'work_days': final List workDays,
        'work_hours': final List workHours,
      } =>
        UserModelEmployee(
          id: id,
          name: name,
          email: email,
          barberShopId: barbershop_id,
          avatar: map['avatar'],
          workDays: workDays.cast<String>(),
          workHours: workHours.cast<int>(),
        ),
      _ => throw ArgumentError(
          'json Invalido',
        )
    };
  }
}
