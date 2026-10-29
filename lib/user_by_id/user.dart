class User {
  const User({
    required this.id,
    required this.email,
    required this.username,
    required this.name,
    required this.address,
    required this.phone,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      username: json['username'],
      name: UserName.fromJson(json['name']),
      address: Address.fromJson(json['address']),
      phone: json['phone'],
    );
  }

  final int id;
  final String email;
  final String username;
  final UserName name;
  final Address address;
  final String phone;

  String get fullName => '${name.firstname} ${name.lastname}';
}

class UserName {
  const UserName({required this.firstname, required this.lastname});

  factory UserName.fromJson(Map<String, dynamic> json) {
    return UserName(firstname: json['firstname'], lastname: json['lastname']);
  }

  final String firstname;
  final String lastname;
}

class Address {
  const Address({
    required this.city,
    required this.street,
    required this.number,
    required this.zipcode,
    required this.latitude,
    required this.longitude,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    final geolocation = json['geolocation'];
    return Address(
      city: json['city'],
      street: json['street'],
      number: json['number'],
      zipcode: json['zipcode'],
      latitude: geolocation['lat'],
      longitude: geolocation['long'],
    );
  }

  final String city;
  final String street;
  final int number;
  final String zipcode;
  final String latitude;
  final String longitude;
}
