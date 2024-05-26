// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class User {
  // final String id; // Уникальный идентификатор пользователя
  // final String name; // Имя пользователя
  final String email; // Электронная почта пользователя
  // final String phone; // Номер телефона пользователя
  // final String? profilePictureUrl; // URL профильной фотографии пользователя
  // final String? paymentMethod; // Предпочитаемый метод оплаты пользователя
  // final List<String>
  //     recentDestinations; // Список недавних мест назначения пользователя

  const User({
    // this.profilePictureUrl,
    // this.paymentMethod,
    required this.email,
  });

  User copyWith({
    String? email,
  }) {
    return User(
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      email: map['email'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source){
return User.fromMap(json.decode(source) as Map<String, dynamic>);
  }

  @override
  String toString() => 'User(email: $email)';

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;
  
    return 
      other.email == email;
  }

  @override
  int get hashCode => email.hashCode;
}

// class UserRepository extends Stat {

//   Future<User> getVerifyCode(String email) async {
//     return User( );
//   }
// }
