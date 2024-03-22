import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Explore extends StatelessWidget {
  const Explore({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 16, 16, 16),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('events').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              return (snapshot.data!.docs.isEmpty)
                  ? Container(
                      height: 600,
                      width: double.maxFinite,
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : eventDisplay(data);
            }).toList(),
          );
        },
      ),
    );
  }

  Padding eventDisplay(Map<String, dynamic> data) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: IntrinsicHeight(
        child: Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 20, 20, 20),
              border: Border.all(
                  color: const Color.fromARGB(255, 61, 61, 61), width: 2),
              borderRadius: BorderRadius.circular(30)),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Row(
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          image: DecorationImage(
                              image:
                                  AssetImage('assets/images/vinhackposter.jpg'),
                              fit: BoxFit.cover),
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Container(
                      width: 150,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data['name'],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            data['clubname'],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: const Color.fromARGB(255, 101, 101, 101),
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            data['desc'],
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: const Color.fromARGB(255, 71, 71, 71)),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, bottom: 0, top: 8),
                  child: Container(
                    width: double.maxFinite,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              CupertinoIcons.list_bullet_below_rectangle,
                              color: Colors.redAccent,
                              size: 14,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              width: 220,
                              child: Text(
                                'Category - ${data['category']}',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, bottom: 0, top: 8),
                  child: Container(
                    width: double.maxFinite,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(
                              CupertinoIcons.location_solid,
                              color: Colors.redAccent,
                              size: 14,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              width: 220,
                              child: Text(
                                'Venue - ${data['venue']}',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 15, left: 15, top: 10, bottom: 20),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 140,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  CupertinoIcons.calendar,
                                  size: 14,
                                  color: Colors.redAccent,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Starts - ' + data['startdate'],
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Icon(
                                  CupertinoIcons.calendar,
                                  size: 14,
                                  color: Colors.redAccent,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Ends - ' + data['lastdate'],
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 140,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  CupertinoIcons.antenna_radiowaves_left_right,
                                  size: 14,
                                  color: Colors.redAccent,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Mode - ' + data['eventMode'],
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Icon(
                                  CupertinoIcons.add_circled_solid,
                                  size: 14,
                                  color: Colors.redAccent,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Registration - Open',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
