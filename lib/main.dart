import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const CricketLiveScore());
}

class CricketLiveScore extends StatelessWidget {
  const CricketLiveScore({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CricketScore(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CricketScore extends StatefulWidget {
  const CricketScore({super.key});

  @override
  State<CricketScore> createState() => _CricketScoreState();
}

class _CricketScoreState extends State<CricketScore> {
  //create instance
  final firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Live Score"),
      ),
      body: Column(
        children: [
          Card(
            color: Colors.greenAccent,
            elevation: 5,
            margin: EdgeInsets.all(20),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: StreamBuilder(
                  stream: firestore
                      .collection('cricket_score')
                      .doc("i9vhq1y15TT0p9IxxXz4")
                      .snapshots(),
                  builder: (context, snapshot) {
                    DocumentSnapshot<Map<String,dynamic>>?doc=snapshot.data;
                    return  Column(
                      children: [
                         Text(
                           doc?.get('match') ?? "unknown",
                            style: const TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w500,
                            )),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(doc?.get('score').toString() ?? "unknown",
                                style: const TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.w500,
                                )),
                            Text("/",
                                style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.w500,
                                )),
                            Text(doc?.get('wickets').toString() ?? "unknown",
                                style: const TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.w500,
                                )),
                          ],
                        ),
                        Text(doc?.get('overs').toString() ?? "unknown",
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            )),
                        const Text("Batsman on Pitch",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            )),
                        Text(doc?.get('active-batsman') ?? "unknown",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ))
                      ],
                    );
                  }),
            ),
          )
        ],
      ),
    );
  }
}
