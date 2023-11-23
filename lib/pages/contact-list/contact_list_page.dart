import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_contacts_app/pages/contact-list/bloc/contact_list_bloc.dart';
import 'package:simple_contacts_app/repositories/contact_repository.dart';
import 'package:simple_contacts_app/shared/models/contact_model.dart';

class ContactListPage extends StatelessWidget {
  static const route = '/contact_list_page';

  const ContactListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: BlocProvider(
          create: (_) =>
              ContactListBloc(context.read<ContactRepository>())..add(FetchContactList()),
          child: const _Body(),
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SearchBox(),
        Expanded(
          child: _ContactList(),
        )
      ],
    );
  }
}

class _ContactList extends StatelessWidget {
  const _ContactList();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContactListBloc, ContactListState>(builder: (context, state) {
      switch (state.status) {
        case ContactListStatus.failure:
          return const Center(child: Text('failed to fetch contacts'));
        case ContactListStatus.success:
          if (state.contacts.isEmpty) {
            return const Center(child: Text('no contacts'));
          }
          return CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 22),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Contacts',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final contact = state.filteredContacts[index];
                      return Column(
                        children: [
                          _ContactItemTile(
                            contact: contact,
                          ),
                          if (index + 1 < state.filteredContacts.length)
                            const SizedBox(
                              height: 12,
                            )
                        ],
                      );
                      // Add more widgets if necessary
                    },
                    childCount:
                        state.filteredContacts.length, // Replace with your dynamic count
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 48),
              ),
            ],
          );
        case ContactListStatus.loading:
          return const Center(child: CircularProgressIndicator());
      }
    });
  }
}

class _ContactItemTile extends StatelessWidget {
  const _ContactItemTile({
    super.key,
    required this.contact,
  });

  final ContactModel contact;

  String getInitials(String name) {
    return name
        .split(' ')
        .where((word) => word.isNotEmpty)
        .map((word) => word[0].toUpperCase())
        .take(2)
        .join();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            offset: const Offset(3, 3),
            blurRadius: 2,
            spreadRadius: -3,
          ),
        ],
        color: Colors.white,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  offset: const Offset(0, 4),
                  blurRadius: 2,
                  spreadRadius: -2,
                ),
              ],
              color: Colors.pinkAccent.shade100,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  getInitials(contact.name),
                  style: const TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                contact.name,
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                    color: Colors.black,
                    height: 0.8),
              ),
              Text(
                contact.email,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _SearchBox extends StatefulWidget {
  const _SearchBox({
    super.key,
  });

  @override
  State<_SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<_SearchBox> {
  final searchCtrler = TextEditingController();

  @override
  void dispose() {
    searchCtrler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            offset: const Offset(0, 2),
            blurRadius: 2,
            spreadRadius: -3,
          ),
        ],
        color: Colors.white,
      ),
      child: TextField(
        controller: searchCtrler,
        onChanged: (String val) {
          context.read<ContactListBloc>().add(UpdateSearchQuery(val));
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          hintText: 'Search...',
          filled: true,
          fillColor: Colors.cyan.shade50,
          prefixIcon: const Icon(Icons.search_outlined),
          suffixIcon: IconButton(
            onPressed: () {
              searchCtrler.clear();
              context.read<ContactListBloc>().add(UpdateSearchQuery(''));
            },
            icon: const Icon(Icons.highlight_remove),
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
            borderSide: BorderSide.none,
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
