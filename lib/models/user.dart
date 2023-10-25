// ignore_for_file: public_member_api_docs, sort_constructors_first

class User {
  String fullname;
  String email;
  String phone;
  String picture;
  User({
    required this.fullname,
    required this.email,
    required this.phone,
    required this.picture,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'fullname': fullname,
      'email': email,
      'phone': phone,
      'picture': picture,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      fullname: map['fullname'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      picture: map['picture'] as String,
    );
  }

  static User get empty => User(
        fullname: 'fullname',
        email: 'email',
        phone: 'phone',
        picture: 'picture',
      );

  @override
  String toString() {
    return 'User(fullname: $fullname, email: $email, phone: $phone, picture: $picture)';
  }
}
