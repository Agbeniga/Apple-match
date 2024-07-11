class UserData {
  UserData({
    required this.uid,
    required this.name,
    required this.profilePic,
    required this.isOnline,
    this.photoUrl,
    this.email,
    this.displayName,
    this.phoneNumber,
  });

  final String name;
  final String uid;
  final String profilePic;
  final bool isOnline;
  String? photoUrl;
  String? email;
  String? displayName;
  String? phoneNumber;

  factory UserData.fromMap(Map<String, dynamic> json) => UserData(
        uid: json["uid"],
        photoUrl: json["photoURL"],
        email: json["email"],
        displayName: json["displayName"],
        phoneNumber: json["phoneNumber"],
        name: json['name'] ?? '',
        profilePic: json['profilePic'] ?? '',
        isOnline: json['isOnline'] ?? false,
      );

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "photoURL": photoUrl,
        "email": email,
        "displayName": displayName,
        "phoneNumber": phoneNumber,
        'name': name,
        'profilePic': profilePic,
        'isOnline': isOnline,
      };
}
