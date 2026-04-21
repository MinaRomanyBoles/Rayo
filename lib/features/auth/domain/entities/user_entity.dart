class UserEntity {
  final String id;
  final String? username;
  final String? email;
  final String? avatarUrl;
  final String? country;
  final String? governorate;
  final bool isGuest;

  const UserEntity({
    required this.id,
    this.username,
    this.email,
    this.avatarUrl,
    this.country,
    this.governorate,
    this.isGuest = false,
  });

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      id: map['id'] as String,
      username: map['username'] as String?,
      email: map['email'] as String?,
      avatarUrl: map['avatar_url'] as String?,
      country: map['country'] as String?,
      governorate: map['governorate'] as String?,
    );
  }

  factory UserEntity.guest(String id) {
    return UserEntity(id: id, username: 'Guest', isGuest: true);
  }
}
