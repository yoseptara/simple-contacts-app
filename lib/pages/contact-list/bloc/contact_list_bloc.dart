import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_contacts_app/repositories/contact_repository.dart';
import 'package:simple_contacts_app/shared/models/contact_model.dart';

part 'contact_list_event.dart';

part 'contact_list_state.dart';

class ContactListBloc extends Bloc<ContactListEvent, ContactListState> {
  final ContactRepository contactRepo;

  ContactListBloc(this.contactRepo)
      : super(
          const ContactListState(),
        ) {
    on<FetchContactList>(_onFetchContactList);
    on<UpdateSearchQuery>(_onUpdateSearchQuery);
  }

  Future<void> _onUpdateSearchQuery(
    UpdateSearchQuery event,
    Emitter<ContactListState> emit,
  ) async {
    emit(
      state.copyWith(searchQuery: event.query),
    );
  }

  Future<void> _onFetchContactList(
    FetchContactList event,
    Emitter<ContactListState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          status: ContactListStatus.loading,
        ),
      );

      final contacts = await contactRepo.getAll();

      emit(
        state.copyWith(
          status: ContactListStatus.success,
          contacts: contacts,
        ),
      );
    } catch (exception) {
      emit(
        state.copyWith(status: ContactListStatus.failure),
      );
    }
  }
}
