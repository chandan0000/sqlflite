import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fvx_deepdive/db.dart';
import 'package:fvx_deepdive/user.dart';
import 'package:velocity_x/velocity_x.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PersonDatabaseProvider? personDatabaseProvider;
  late Future<List<UserDetails>> userDetails;
  // ScrollController? scrollController;
  @override
  void initState() {
    super.initState();

    personDatabaseProvider = PersonDatabaseProvider();
    loadData();
  }

  Future<List<UserDetails>> loadData() async {
    userDetails = personDatabaseProvider!.getUserDetails();
    return userDetails;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: FutureBuilder(
                  future: userDetails,
                  builder:
                      (context, AsyncSnapshot<List<UserDetails>> snapshot) {
                    if (snapshot.hasData) {
                      return RefreshIndicator(
                        onRefresh: () async {
                          setState(() {
                            loadData();
                          });
                        },
                        child: ListView.builder(
                          reverse: false,
                          shrinkWrap: true,
                          // shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Dismissible(
                              direction: DismissDirection.endToStart,
                              onDismissed: ((direction) {
                                setState(() {
                                  log('delted');
                                  personDatabaseProvider!
                                      .delete(snapshot.data![index].id!);
                                  userDetails =
                                      personDatabaseProvider!.getUserDetails();
                                  snapshot.data!.remove(snapshot.data![index]);
                                });
                              }),
                              background: Container(
                                color: Colors.red,
                                child: Icon(Icons.delete_forever),
                              ),
                              key: ValueKey<int?>(snapshot.data![index].id),
                              child: Card(
                                child: ListTile(
                                  title: Text(snapshot.data![index].name),
                                  subtitle: Text(snapshot.data![index].email),
                                  trailing: Text("${snapshot.data![index].id}"),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }

                    return const Center(child: CircularProgressIndicator());
                  }),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: () async {
              personDatabaseProvider?.deleteTableContent();
            },
            child: Icon(Icons.delete),
          ),
          SizedBox(
            width: 20,
          ),
          FloatingActionButton(
            onPressed: () async {
              personDatabaseProvider!
                  .insert(
                    UserDetails(
                        address: 'abhipur mohali',
                        email: 'kumarchandan41u@gmail.com',
                        name: 'chandan',
                        phone: 95),
                  )
                  .then((value) => log('insert success'))
                  .onError((error, stackTrace) => log(error.toString()));
            },
            child: const Icon(Icons.add),
          ),
          IconButton(
              onPressed: () {
                // scrollController.removeListener(() { }) ;
              },
              icon: Icon(Icons.remove_red_eye_sharp))
        ],
      ),
    );
  }
}
