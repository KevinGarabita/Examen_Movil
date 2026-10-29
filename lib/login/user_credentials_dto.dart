class UserCredentialsDto {
  final String username;
  final String password;
  final int expiresInMins;

  UserCredentialsDto({
    required this.username,
    required this.password,
    this.expiresInMins = 30,
  });

  Map<String, dynamic> toJson() => {
    'username': username,
    'password': password,
    'expiresInMins': expiresInMins,
  };
}

// Usuario que inició sesión, con los tokens que devuelve el login
class AuthResponseDto {
  final int id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String gender;
  final String image;
  final String accessToken;
  final String refreshToken;

  AuthResponseDto({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.image,
    required this.accessToken,
    required this.refreshToken,
  });

  factory AuthResponseDto.fromJson(Map<String, dynamic> json) {
    return AuthResponseDto(
      id: json['id'] ?? 0,
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      gender: json['gender'] ?? '',
      image: json['image'] ?? '',
      accessToken: json['accessToken'] ?? '',
      refreshToken: json['refreshToken'] ?? '',
    );
  }
}
