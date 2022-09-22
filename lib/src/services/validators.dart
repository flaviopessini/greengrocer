import 'package:get/get.dart';

String? emailValidator(String? email) {
  if (email == null || email.isEmpty) {
    return 'Digite seu e-mail';
  }
  if (!email.isEmail) {
    return 'Endereço de e-mail inválido';
  }
  return null;
}

String? passwordValidator(String? password) {
  if (password == null || password.isEmpty) {
    return 'Informe a senha';
  }
  if (password.length < 6) {
    return 'Inválida';
  }
  return null;
}

String? nameValidator(String? name) {
  if (name == null || name.isEmpty) {
    return 'Nome inválido';
  }
  final names = name.split(' ');
  if (names.length == 1) {
    return 'Digite seu nome completo';
  }
  return null;
}

String? phoneValidator(String? phone) {
  if (phone == null || phone.isEmpty) {
    return 'Informe seu telefone';
  }
  if (!phone.isPhoneNumber || phone.length < 14) {
    return 'Digite um número de telefone válido';
  }
  return null;
}

String? cpfValidator(String? cpf) {
  if (cpf == null || cpf.isEmpty) {
    return 'Informe seu CPF';
  }
  if (!cpf.isCpf) {
    return 'Digite um CPF válido';
  }
  return null;
}
