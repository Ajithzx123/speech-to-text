import 'package:avatar_glow/avatar_glow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:welkin/HomeScreen/model.dart';

class SpeechScreen extends StatefulWidget {
  const SpeechScreen({super.key});

  @override
  State<SpeechScreen> createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  late CollectionReference collectionReference;

  @override
  void initState() {
    super.initState();
    collectionReference = firebaseFirestore.collection("todo");
  }

  void additem(String texts) {
    if (text != "") {
      collectionReference.add({'notes': texts});
    }
  }

  String text = "Press the button and start speaking";
  bool isListening = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/register.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Speech to Text',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 35),
                    ),
                    IconButton(
                        onPressed: () async {},
                        icon: const Icon(
                          Icons.logout,
                          color: Colors.white,
                        ))
                  ],
                ),
                const SizedBox(
                  height: 35,
                ),
                Expanded(
                  child: Container(
                    color: Colors.transparent,
                    child: StreamBuilder(
                      stream: collectionReference.snapshots(),
                      builder: (context, snapshots) {
                        if (snapshots.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                              child: CircularProgressIndicator(
                            color: Colors.white,
                          ));
                        }
                        return ListView.separated(
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  height: 15,
                                ),
                            // padding: EdgeInsets.all(5),
                            itemCount: snapshots.data!.docs.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onLongPress: () async {
                                  await deleteData(context, snapshots, index);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(.7),
                                      borderRadius: BorderRadius.circular(10)),
                                  width: 300,
                                  height: 70,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                        child: Text(
                                      snapshots.data!.docs[index]['notes'],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    )),
                                  ),
                                ),
                              );
                            });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 0, bottom: 40),
                  child: SizedBox(
                    height: 200,
                    child: Center(
                        child: Text(
                      text,
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w600),
                    )),
                  ),
                )
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 50),
              child: FloatingActionButton(
                backgroundColor: Colors.white,
                onPressed: () {
                  additem(this.text);
                  // setState(() {
                  //    text = "";
                    
                  // });
                 
                },
                child: const Icon(
                  Icons.save,
                  size: 36,
                  color: Colors.blue,
                ),
              ),
            ),
            AvatarGlow(
              animate: isListening,
              endRadius: 75,
              glowColor: Theme.of(context).primaryColor,
              child: FloatingActionButton(
                onPressed: toggleRecording,
                child: Icon(
                  isListening ? Icons.mic : Icons.mic_none,
                  size: 36,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  deleteData(BuildContext context,
      AsyncSnapshot<QuerySnapshot<Object?>> snapshots, int index) async {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext ctx) {
          return CupertinoAlertDialog(
            title: const Text('Please Confirm'),
            content: const Text('Do you want to delete this Note?'),
            actions: [
              // The "Yes" button
              CupertinoDialogAction(
                onPressed: () {
                  firebaseFirestore
                      .runTransaction((Transaction myTransaction) async {
                    await myTransaction
                        .delete(snapshots.data!.docs[index].reference);
                  });

                  Navigator.of(context).pop();
                },
                child: const Text('Yes'),
                isDefaultAction: true,
                isDestructiveAction: true,
              ),
              // The "No" button
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('No'),
                isDefaultAction: false,
                isDestructiveAction: false,
              )
            ],
          );
        });
  }

  Future toggleRecording() {
    return SpeechApi.toggleRecording(onResult: (text) {
      setState(() => this.text = text);
    }, onListening: (isListening) {
      setState((() => this.isListening = isListening));
    });
  }
}
