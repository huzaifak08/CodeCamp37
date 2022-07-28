import 'package:codecamp37/constants/routes.dart';
import 'package:codecamp37/services/auth/auth_service.dart';
import 'package:codecamp37/services/crud/notes_services.dart';
import 'package:flutter/material.dart';

import '../enums/menu_action.dart';

class NotesView extends StatefulWidget {
  const NotesView({Key? key}) : super(key: key);

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  late final NotesService _notesService;
  String get userEmail => AuthService.firebase().currentUser!.email!;

  @override
  void initState() {
    _notesService = NotesService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Menu Action Button
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(newNoteRoute);
              },
              icon: Icon(Icons.add)),
          PopupMenuButton(
            onSelected: ((value) async {
              switch (value) {
                case MenuAction.logout:
                  final shouldLogout = await showLogOutDialog(context);

                  if (shouldLogout) {
                    await AuthService.firebase().logOut();
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil(loginRoute, (_) => false);
                  }
              }
            }),
            itemBuilder: (context) {
              // It returns a List of Items.
              return [
                PopupMenuItem(
                  value: MenuAction.logout,
                  child: Text("Logout"),
                ),
              ];
            },
          )
        ],
        title: Text("Your Notes"),
      ),
      body: FutureBuilder(
        future: _notesService.getOrCreateUser(email: userEmail),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return StreamBuilder(
                  stream: _notesService.allNotes,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.active:
                        if (snapshot.hasData) {
                          final allNotes = snapshot.data as List<DatabaseNote>;
                          return ListView.builder(
                              itemCount: allNotes.length,
                              itemBuilder: (context, index) {
                                final note = allNotes[index];
                                return ListTile(
                                  title: Text(note.text),
                                );
                                // return Text('Item');
                              });
                        } else {
                          return const CircularProgressIndicator();
                        }

                      default:
                        return const CircularProgressIndicator();
                    }
                  });

            default:
              return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Sign Out"),
        content: Text("Are you sure you want to Logout"),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('Cancel')),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text('Log Out')),
        ],
      );
    },
  ).then((value) => value ?? false);
}
