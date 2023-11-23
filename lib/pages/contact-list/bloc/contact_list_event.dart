part of 'contact_list_bloc.dart';

abstract class ContactListEvent {}

class FetchContactList extends ContactListEvent {
  FetchContactList();
}