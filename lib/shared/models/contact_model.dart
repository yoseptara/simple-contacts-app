class ContactModel {
  final String id;
  final String name;
  final String email;

  const ContactModel(this.id, this.name, this.email);

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      json['id'] as String,
      json['name'] as String,
      json['email'] as String,
    );
  }
}
