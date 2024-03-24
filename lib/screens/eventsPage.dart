import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livit/main.dart';
import 'package:livit/screens/ExplorePage.dart';
import 'package:livit/screens/favourites.dart';
import 'package:livit/screens/ongoing.dart';
import 'package:livit/screens/registered.dart';
import 'package:livit/screens/upcomingScreen.dart';

class EventsPage extends StatefulWidget {
  EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  List Screen = [
    Explore(),
    Upcoming(),
    onGoing(),
    Registered(),
    FavouriteEvents()
  ];
  int mainIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 16, 16, 16),
        appBar: catergoryAppBar(),
        body: Screen[mainIndex]);
  }

  AppBar catergoryAppBar() {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 16, 16, 16),
      automaticallyImplyLeading: false,
      excludeHeaderSemantics: true,
      leadingWidth: 0,
      titleSpacing: 0,
      title: Container(
        width: double.maxFinite,
        height: 40,
        // color: Colors.amber,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    mainIndex = 0;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: (mainIndex == 0)
                          ? Colors.redAccent
                          : const Color.fromARGB(255, 37, 37, 37)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 8, right: 12, bottom: 8, top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.bolt_circle_fill,
                          color: (mainIndex == 0) ? Colors.white : Colors.grey,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Explore',
                          style: TextStyle(
                              color:
                                  (mainIndex == 0) ? Colors.white : Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w800),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    mainIndex = 1;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: (mainIndex == 1)
                          ? Colors.redAccent
                          : const Color.fromARGB(255, 37, 37, 37)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 8, right: 12, bottom: 8, top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.calendar_circle_fill,
                          color: (mainIndex == 1) ? Colors.white : Colors.grey,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Upcoming',
                          style: TextStyle(
                              color:
                                  (mainIndex == 1) ? Colors.white : Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w800),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    mainIndex = 2;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: (mainIndex == 2)
                          ? Colors.redAccent
                          : const Color.fromARGB(255, 37, 37, 37)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 8, right: 12, bottom: 8, top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.link_circle_fill,
                          color: (mainIndex == 2) ? Colors.white : Colors.grey,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Live Events',
                          style: TextStyle(
                              color:
                                  (mainIndex == 2) ? Colors.white : Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w800),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    mainIndex = 3;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: (mainIndex == 3)
                          ? Colors.redAccent
                          : const Color.fromARGB(255, 37, 37, 37)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 8, right: 12, bottom: 8, top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.checkmark_alt_circle_fill,
                          color: (mainIndex == 3) ? Colors.white : Colors.grey,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Registered',
                          style: TextStyle(
                              color:
                                  (mainIndex == 3) ? Colors.white : Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w800),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 0, right: 15),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    mainIndex = 4;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: (mainIndex == 4)
                          ? Colors.redAccent
                          : const Color.fromARGB(255, 37, 37, 37)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 8, right: 12, bottom: 8, top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.heart_circle_fill,
                          color: (mainIndex == 4) ? Colors.white : Colors.grey,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Favourites',
                          style: TextStyle(
                              color:
                                  (mainIndex == 4) ? Colors.white : Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w800),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
