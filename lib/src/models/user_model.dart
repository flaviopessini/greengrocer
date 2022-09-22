import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  String? id;

  String? name;

  String? phone;

  String? email;

  String? password;

  String? cpf;

  String? token;

  UserModel({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.password,
    this.cpf,
    this.token,
  });

  // factory UserModel.fromMap(Map<String, dynamic> map) {
  //   return UserModel(
  //     id: map['id'],
  //     name: map['fullname'],
  //     phone: map['phone'],
  //     email: map['email'],
  //     password: map['password'],
  //     cpf: map['cpf'],
  //     token: map['token'],
  //   );
  // }
  //
  // Map<String, dynamic> toMap() {
  //   return {
  //     'id': id,
  //     'fullname': name,
  //     'phone': phone,
  //     'email': email,
  //     'password': password,
  //     'cpf': cpf,
  //     'token': token,
  //   };
  // }

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  String toString() {
    return 'UserModel{name: $name, cpf: $cpf}';
  }
}
