class UserEntity {
  final String uid;
  final String email;
  final String? displayName;
  final String? photoURL; // Add profile image URL

  UserEntity({
    required this.uid,
    required this.email,
    this.displayName,
    this.photoURL, // Optional field for profile image
  });
}