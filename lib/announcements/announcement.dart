import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';

class Announcements extends StatefulWidget {
  const Announcements({super.key});

  @override
  State<Announcements> createState() => _AnnouncementsState();
}

class _AnnouncementsState extends State<Announcements> {
  final GlobalKey<ExpansionTileCardState> cardA = GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardB = GlobalKey();
  Color? ContainerColor;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 16, 16, 16),
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('announcements').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Lottie.asset('assets/images/loading.json',
                    height: 150, width: 150));
          }
          if (snapshot.hasError) {
            return erroralertbox();
          }
          if (snapshot.data!.docs.length == 0) {
            return nodataalertbox();
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
                  : Padding(
                      padding: const EdgeInsets.only(
                          top: 10, bottom: 10, left: 20, right: 20),
                      child: ExpansionTileCard(
                        title: Text(
                          data['heading'],
                          style: TextStyle(
                              color: (data['color'] == 'Colors.greenAccent')
                                  ? Colors.black
                                  : (data['color'] == 'Colors.yellowAccent')
                                      ? Colors.black
                                      : Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600),
                        ),
                        baseColor: (data['color'] == 'Colors.redAccent')
                            ? Colors.redAccent.withOpacity(1)
                            : (data['color'] == 'Colors.yellowAccent')
                                ? Colors.yellowAccent.withOpacity(1)
                                : (data['color'] == 'Colors.blue')
                                    ? Colors.blue.withOpacity(1)
                                    : (data['color'] == 'Colors.greenAccent')
                                        ? Colors.greenAccent.withOpacity(1)
                                        : const Color.fromARGB(255, 26, 26, 26),
                        borderRadius: BorderRadius.circular(40),
                        expandedColor: (data['color'] == 'Colors.redAccent')
                            ? Colors.redAccent.withOpacity(1)
                            : (data['color'] == 'Colors.yellowAccent')
                                ? Colors.yellowAccent.withOpacity(1)
                                : (data['color'] == 'Colors.blue')
                                    ? Colors.blue.withOpacity(1)
                                    : (data['color'] == 'Colors.greenAccent')
                                        ? Colors.greenAccent.withOpacity(1)
                                        : const Color.fromARGB(255, 26, 26, 26),
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 10, bottom: 20),
                            child: Text(
                              data['Desc'],
                              style: TextStyle(
                                  color: (data['color'] == 'Colors.greenAccent')
                                      ? Colors.black
                                      : (data['color'] == 'Colors.yellowAccent')
                                          ? Colors.black
                                          : Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 0, bottom: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  data['clubname'],
                                  style: TextStyle(
                                      color: (data['color'] ==
                                              'Colors.greenAccent')
                                          ? Colors.black
                                          : (data['color'] ==
                                                  'Colors.yellowAccent')
                                              ? Colors.black
                                              : Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    print('Clicked Link');
                                  },
                                  child: Icon(
                                    CupertinoIcons.link_circle_fill,
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 0, bottom: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  data['datePosted'],
                                  style: TextStyle(
                                      color: (data['color'] ==
                                              'Colors.greenAccent')
                                          ? Colors.black
                                          : (data['color'] ==
                                                  'Colors.yellowAccent')
                                              ? Colors.black
                                              : Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  data['timePosted'],
                                  style: TextStyle(
                                      color: (data['color'] ==
                                              'Colors.greenAccent')
                                          ? Colors.black
                                          : (data['color'] ==
                                                  'Colors.yellowAccent')
                                              ? Colors.black
                                              : Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          )
                        ],
                        leading: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              image: DecorationImage(
                                  image: NetworkImage(data['imagelink']),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                    );
            }).toList(),
          );
        },
      ),
    );
  }

  Container nodataalertbox() {
    return Container(
      height: 500,
      width: double.maxFinite,
      child: Column(
        children: [
          Lottie.asset('assets/images/nodata.json'),
          SizedBox(
            height: 30,
          ),
          Text(
            'No Events Found',
            style: TextStyle(
                color: Colors.redAccent,
                fontSize: 20,
                fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }

  Container erroralertbox() {
    return Container(
      height: 500,
      width: double.maxFinite,
      child: Column(
        children: [
          Lottie.asset('assets/images/error.json'),
          SizedBox(
            height: 30,
          ),
          Text(
            'Oops! Something went wrong. Blame the aliens! 👽',
            style: TextStyle(
                color: Colors.redAccent,
                fontSize: 20,
                fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
