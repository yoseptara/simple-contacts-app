part of 'contact_list_bloc.dart';

abstract class ContactListEvent {}

class FetchContactList extends ContactListEvent {
  FetchContactList();
}

class UpdateSearchQuery extends ContactListEvent {
  final String query;

  UpdateSearchQuery(this.query);
}