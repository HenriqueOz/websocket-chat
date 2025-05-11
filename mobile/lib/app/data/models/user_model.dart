// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String name;

  UserModel({
    required this.name,
  });

  @override
  String toString() {
    return 'UserModel(name: $name)';
  }
}
