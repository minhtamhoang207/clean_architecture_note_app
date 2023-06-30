import 'dart:io';

class User {
  User({required this.id, this.name, this.avatar, this.createAt});

  int? id;
  String? name;
  File? avatar;
  int? createAt;
}
