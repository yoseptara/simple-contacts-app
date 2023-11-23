import 'package:simple_contacts_app/services/http_service.dart';
import 'package:simple_contacts_app/shared/models/contact_model.dart';

class ContactRepository {
  Future<List<ContactModel>> getAll() async {
    final resJson = await HttpService().get('/contacts');
    final contacts = (resJson?['data'] as List? ?? []).map(
      (e) => ContactModel.fromJson(e),
    ).toList();

    return contacts;
  }
}
