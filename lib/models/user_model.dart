class User {
  int? userId;
  String? email;
  String? username;
  int? age;
  String? bio;
  int? noOfApples;
  String? location;
  String? imageUrl;
  bool? isOnline;
  bool? isVerified;
  String? createdAt;
  List<String>? interests;

  User({
    this.userId,
    this.email,
    this.username,
    this.age,
    this.bio,
    this.noOfApples,
    this.location,
    this.imageUrl,
    this.isOnline,
    this.createdAt,
    this.interests,
    this.isVerified,
  });
}
