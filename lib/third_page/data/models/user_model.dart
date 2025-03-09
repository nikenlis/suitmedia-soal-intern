

import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  final String firstName;
  final String lastName;
  final String avatar;

  const UserModel(
      {required super.id,
      required super.email,
      required this.firstName,
      required this.lastName,
      required this.avatar})
      : super(fullName: "$firstName $lastName", profileImageUrl: avatar);

  factory UserModel.fromJson(Map<String, dynamic> data) {
    return UserModel(
        id: data["id"],
        email: data["email"],
        firstName: data["first_name"],
        lastName: data['last_name'],
        avatar: data['avatar']);
  }

    Map<String, dynamic> toJson() {
    return {
      "id": id,
      "email": email,
      "first_name": firstName,
      "last_name": lastName,
      "avatar": avatar
    };
  }

    UserEntity get toEntity => UserEntity(
      id: id, email: email, fullName: "$firstName $lastName", profileImageUrl: avatar,
      );

}
