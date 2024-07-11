import 'package:applematch/models/user_model.dart';

class Post {
  User? owner;
  String? interest;
  String? description;
  String? imageUrl;

  Post({this.owner, this.interest, this.description, this.imageUrl});
}
