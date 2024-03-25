import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:livit/eventModal/authController.dart';
import 'package:lottie/lottie.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:url_launcher/url_launcher_string.dart';

class onGoing extends StatefulWidget {
  onGoing({super.key});

  @override
  State<onGoing> createState() => _onGoingState();
}

class _onGoingState extends State<onGoing> {
  String? oldRegs;
  AuthController controller = Get.find();
  DateTime now = DateTime.now();
  DateTime getTodayDate() {
    return DateTime.now();
  }

  bool isDate1AfterDate2(String dateStr1, String dateStr2) {
    // Parse date strings into DateTime objects
    DateTime date1 = _parseDateFromString(dateStr1);
    DateTime date2 = _parseDateFromString(dateStr2);
    return date1.isAfter(date2);
  }

  DateTime _parseDateFromString(String dateStr) {
    // Split the date string into day, month, and year components
    List<String> parts = dateStr.split('-');
    int day = int.parse(parts[0]);
    int month = int.parse(parts[1]);
    int year = int.parse(parts[2]);

    // Create a DateTime object from the components
    return DateTime(year, month, day);
  }

  Widget detailEvents(IconData Iconname, String data, String heading) {
    return IntrinsicHeight(
      child: Container(
        width: double.maxFinite,
        child: Row(
          children: [
            Icon(
              Iconname,
              size: 24,
              color: Colors.red,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              heading + ' - ',
              maxLines: null,
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                  fontWeight: FontWeight.w600),
            ),
            Expanded(
              child: Container(
                child: Text(
                  data,
                  maxLines: null,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd-MM-yy').format(now);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 16, 16, 16),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('events').snapshots(),
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
              String startDate = data['startdate'];
              String endDate = data['lastdate'];
              bool isDateBetween(
                  String date, String startDate, String endDate) {
                return (date == startDate ||
                    date == endDate ||
                    (isDate1AfterDate2(date, startDate) &&
                        !isDate1AfterDate2(date, endDate)));
              }

              // Check if today's date is equal to the start date or falls between start and end date
              if (isDateBetween(formattedDate, startDate, endDate)) {
                return eventDisplay(data, context);
              } else {
                return Container();
              }
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
    Get.back();
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

  Padding eventDisplay(Map<String, dynamic> data, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
      child: IntrinsicHeight(
        child: GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context, // Access context here
              backgroundColor: Color.fromARGB(255, 15, 15, 15),
              enableDrag: true,
              elevation: 15,
              isDismissible: true,
              showDragHandle: true,
              isScrollControlled: true,
              useSafeArea: true,
              builder: (BuildContext context) {
                return SingleChildScrollView(
                  child: Container(
                    // height: MediaQuery.of(context).size.height,
                    width: double.maxFinite, // Adjust height as needed
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Add widgets here to display detailed event information
                        // Example:
                        Container(
                          height: 300,
                          width: double.maxFinite,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30)),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Image.network(
                                data['path'],
                                fit: BoxFit.cover,
                                width: 300,
                                height: 300,
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 40, top: 20, right: 40),
                          child: Text(
                            data['name'],
                            maxLines: null,
                            style: TextStyle(
                                color: Colors.redAccent,
                                fontSize: 22,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 40, top: 5, right: 40),
                          child: Text(
                            data['clubname'],
                            maxLines: null,
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 40, top: 20, right: 40, bottom: 20),
                          child: Text(
                            data['desc'],
                            maxLines: null,
                            style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 40, right: 40, top: 20),
                          child: GestureDetector(
                            onTap: () async {
                              DocumentReference docRef = FirebaseFirestore
                                  .instance
                                  .collection('events')
                                  .doc(data['name']);

                              DocumentSnapshot document =
                                  await FirebaseFirestore.instance
                                      .collection('events')
                                      .doc(data['name'])
                                      .get();

                              oldRegs =
                                  document['registeredContestants'].toString();

                              if (oldRegs!.contains(controller.userEmail!)) {
                                // print('Already Registered');
                                showTopSnackBar(
                                  Overlay.of(context),
                                  const CustomSnackBar.error(
                                    message: "Already Registered for Event",
                                  ),
                                );
                              } else {
                                docRef.update({
                                  'registeredContestants':
                                      ('${controller.userEmail} , ${oldRegs!}')
                                });
                                docRef.update(
                                    {'registered': FieldValue.increment(1)});
                                showTopSnackBar(
                                  Overlay.of(context),
                                  const CustomSnackBar.success(
                                    message:
                                        "Registered For the Event\nCheck Your Registrations",
                                  ),
                                );
                              }
                            },
                            child: Container(
                              height: 55,
                              width: double.maxFinite,
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    CupertinoIcons.add_circled_solid,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Registered',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(
                              left: 40, right: 40, top: 10),
                          child: GestureDetector(
                            onTap: () async {
                              DocumentReference docRef = FirebaseFirestore
                                  .instance
                                  .collection('events')
                                  .doc(data['name']);

                              DocumentSnapshot document =
                                  await FirebaseFirestore.instance
                                      .collection('events')
                                      .doc(data['name'])
                                      .get();

                              oldRegs = document['rsvpContestants'].toString();

                              if (oldRegs!.contains(controller.userEmail!)) {
                                // print('Already Registered');
                                showTopSnackBar(
                                  Overlay.of(context),
                                  const CustomSnackBar.error(
                                    message:
                                        "You are already going for the Event",
                                  ),
                                );
                              } else {
                                docRef.update({
                                  'rsvpContestants':
                                      ('${controller.userEmail} , ${oldRegs!}')
                                });
                                docRef
                                    .update({'rsvp': FieldValue.increment(1)});
                                showTopSnackBar(
                                  Overlay.of(context),
                                  const CustomSnackBar.success(
                                    message:
                                        "Added your name for the Refreshments List",
                                  ),
                                );
                              }
                            },
                            child: Container(
                              height: 55,
                              width: double.maxFinite,
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    CupertinoIcons.command,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'RSVP',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 40, right: 40, top: 10),
                          child: GestureDetector(
                            onTap: () async {
                              print(data['externalwebsite']);
                              try {
                                await launchUrlString(data['externalwebsite']);
                              } catch (e) {
                                print(e);
                                // print('cantopen because of $e');
                              }
                            },
                            child: Container(
                              height: 55,
                              width: double.maxFinite,
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    CupertinoIcons.link_circle_fill,
                                    size: 30,
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Visit Website',
                                    // data['externalwebsite'],
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 40, right: 40, top: 30),
                          child: detailEvents(CupertinoIcons.location_solid,
                              data['venue'], 'Venue'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 40, right: 40, top: 10),
                          child: detailEvents(
                              CupertinoIcons.list_bullet_below_rectangle,
                              data['category'],
                              'Category'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 40, right: 40, top: 10),
                          child: detailEvents(
                              CupertinoIcons.antenna_radiowaves_left_right,
                              data['eventMode'],
                              'Mode'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 40, right: 40, top: 10),
                          child: detailEvents(CupertinoIcons.add_circled_solid,
                              'Open', 'Registrations'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 40, right: 40, top: 10),
                          child: detailEvents(CupertinoIcons.calendar,
                              data['startdate'], 'Starts'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 40, right: 40, top: 10, bottom: 0),
                          child: detailEvents(CupertinoIcons.calendar,
                              data['lastdate'], 'Ends'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 40, right: 40, top: 10, bottom: 40),
                          child: detailEvents(CupertinoIcons.person_3_fill,
                              data['collabName'], 'Collaboration'),
                        ),

                        //
                      ],
                    ),
                  ),
                );
              },
            );
          },
          child: Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 20, 20, 20),
                border: Border.all(
                    color: Color.fromARGB(255, 44, 44, 44), width: 2),
                borderRadius: BorderRadius.circular(30)),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Lottie.asset('assets/images/live.json',
                            height: 20, width: 20),
                        Text('Live',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600))
                      ]),
                ),
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
                                image: NetworkImage(data['path']),
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
                                  color:
                                      const Color.fromARGB(255, 101, 101, 101),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              data['tagline'],
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
                                    CupertinoIcons
                                        .antenna_radiowaves_left_right,
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
                                    'Registrations - ${data['registered']}',
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
      ),
    );
  }
}
