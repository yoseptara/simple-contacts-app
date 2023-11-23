class ContactModel {
  final String name;
  final String email;

  const ContactModel(this.name, this.email);

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      json['name'] as String,
      json['email'] as String,
    );
  }
}