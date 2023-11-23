part of 'contact_list_bloc.dart';

enum ContactListStatus { fetching, failure, fetched }

final class ContactListState extends Equatable {
  const ContactListState({
    this.status = ContactListStatus.fetching,
    this.contacts = const <ContactModel>[],
  });

  final ContactListStatus status;
  final List<ContactModel> contacts;

  ContactListState copyWith({
    ContactListStatus? status,
    List<ContactModel>? contacts,
    bool? hasReachedMax,
  }) {
    return ContactListState(
      status: status ?? this.status,
      contacts: contacts ?? this.contacts,
    );
  }

  @override
  String toString() {
    return '''ContactListState { status: $status, contacts: ${contacts.length} }''';
  }

  @override
  List<Object> get props => [status, contacts];
}
