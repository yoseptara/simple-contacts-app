import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_contacts_app/shared/models/contact_model.dart';

part 'contact_list_event.dart';

part 'contact_list_state.dart';

class ContactListBloc extends Bloc<ContactListEvent, ContactListState> {
  ContactListBloc()
      : super(
          ContactListState(),
        ) {
    on<FetchContactList>(_onFetchContactList);
  }

  Future<void> _onFetchContactList(
    FetchContactList event,
    Emitter<ContactListState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          status: ContactListStatus.fetching,
        ),
      );

      emit(
        state.copyWith(status: ContactListStatus.fetched, contacts:[] ),
      );
    } catch (exception) {
      emit(
        state.copyWith(status: ContactListStatus.failure),
      );
    }
  }
}
