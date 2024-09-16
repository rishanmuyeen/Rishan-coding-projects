class UserEntity {
  String? username;
  String? email;
  String? imageUrl;


  // Use named parameters for constructor
  UserEntity({this.imageUrl, this.username, this.email});
}