part of 'contact_list_bloc.dart';

enum ContactListStatus { loading, failure, success }

final class ContactListState extends Equatable {
  const ContactListState({
    this.status = ContactListStatus.loading,
    this.contacts = const <ContactModel>[],
    this.filteredContacts = const <ContactModel>[],
    this.searchQuery = '',
  });

  final ContactListStatus status;
  final List<ContactModel> contacts;

  final String searchQuery;
  final List<ContactModel> filteredContacts;

  ContactListState copyWith({
    String? searchQuery,
    ContactListStatus? status,
    List<ContactModel>? contacts,
  }) {
    final updatedSearchQuery = searchQuery ?? this.searchQuery;
    final updatedContacts = contacts ?? this.contacts;
    final updatedFilteredContacts = updatedSearchQuery.isEmpty
        ? updatedContacts
        : updatedContacts.where((contact) {
          final cleanedName = contact.name.trim().toLowerCase();
          final cleanedEmail = contact.email.trim().toLowerCase();
          final cleanedQuery = updatedSearchQuery.trim().toLowerCase();
      return cleanedName.contains(cleanedQuery) || cleanedEmail.contains(cleanedQuery);
    }).toList();

    return ContactListState(
      status: status ?? this.status,
      contacts: updatedContacts,
      searchQuery: updatedSearchQuery,
      filteredContacts: updatedFilteredContacts,
    );
  }

  @override
  String toString() {
    return '''ContactListState { status: $status, contacts: ${contacts.length} }''';
  }

  @override
  List<Object> get props => [status, contacts, searchQuery];
}
