String authErrorMessage(String? code) {
  switch(code){
    case 'INVALID_CREDENTIALS':
      return 'E-mail e/ou senha inválidos';
    case 'Invalid session token':
      return 'Token inválido';
    default:
      return 'Erro indefinido';
  }
}