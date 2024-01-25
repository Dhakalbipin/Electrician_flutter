import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electrician/pages/electrician/electrician_list_tile.dart';

import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[50],
        centerTitle: true,
        title: const Text(
          'List of Electrician',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('electricians').snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          return streamSnapshot.hasData
              ? ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 41),
                  itemCount: streamSnapshot.data!.docs.length,
                  itemBuilder: ((context, index) {
                    return ElectricianListTile(
                        electrician: streamSnapshot.data!.docs[index]);
                  }),
                )
              : const Center(
                  child: SizedBox(
                      height: 100,
                      width: 100,
                      child: CircularProgressIndicator()),
                );
        },
      ),
    );
  }
}
