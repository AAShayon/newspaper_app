class UserEntity {
  final String uid;
  final String email;
  final String? displayName;
  final String? photoURL;

  UserEntity({
    required this.uid,
    required this.email,
    this.displayName,
    this.photoURL,
  });
}