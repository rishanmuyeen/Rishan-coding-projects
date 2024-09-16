import 'package:musicapp/domain/entities/auth/user.dart';

class UserModel {
  String? fullname;
  String? email;
  String? imageUrl;

  UserModel({this.fullname, this.email, this.imageUrl});

  UserModel.fromJson(Map<String, dynamic> data) {
    fullname = data['name'];
    email = data['email'];
  }
}

// Define the extension separately from the class
extension UserModelExtension on UserModel {
  UserEntity toEntity() {
    return UserEntity(
      email: email,
      username: fullname,
      imageUrl: imageUrl,
    );
  }
}