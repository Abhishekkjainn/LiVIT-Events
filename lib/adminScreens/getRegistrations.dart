import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class RegistrationsDetails extends StatefulWidget {
  final String? registeredContestants;
  const RegistrationsDetails(this.registeredContestants, {Key? key});

  @override
  _RegistrationsDetailsState createState() => _RegistrationsDetailsState();
}

class _RegistrationsDetailsState extends State<RegistrationsDetails> {
  late TextEditingController searchController = TextEditingController();
  late List<String> allContestants;
  late List<String> filteredContestants;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    String trimmedData =
        widget.registeredContestants!.trim(); // Trim the input string
    allContestants = trimmedData.isNotEmpty
        ? trimmedData.split(',').map((e) => e.trim()).toList()
        : []; // Check if the trimmedData is not empty
    if (allContestants.isNotEmpty && allContestants.last.isEmpty) {
      allContestants.removeLast(); // Remove the last element if it's empty
    }
    filteredContestants = List.from(allContestants);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 16, 16, 16),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: TextFormField(
                controller: searchController,
                onChanged: onSearchTextChanged,
                cursorColor: Colors.redAccent,
                maxLines: null,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
                decoration: InputDecoration(
                    label: Text('Search Contestants'),
                    labelStyle: TextStyle(
                        fontSize: 14,
                        letterSpacing: 0.8,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey),
                    hintText: 'Email',
                    hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 42, 40, 40),
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                    prefixIcon: const Icon(
                      CupertinoIcons.search_circle_fill,
                      color: Colors.redAccent,
                    ),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 207, 207, 207),
                            width: 2),
                        borderRadius: BorderRadius.circular(40)),
                    enabled: true,
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromARGB(255, 88, 88, 88), width: 2),
                        borderRadius: BorderRadius.circular(40))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, top: 20),
              child: Text(
                'Total Registrations - ${allContestants.length}',
                style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              child: filteredContestants.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 42, 42, 42),
                            borderRadius: BorderRadius.circular(30)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            itemCount: filteredContestants.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.only(right: 20, left: 20),
                                child: Container(
                                  height: 20,
                                  width: double.maxFinite,
                                  child: Row(
                                    children: [
                                      Text(
                                        (index + 1).toString() + '. ',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        filteredContestants[index],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        'No results found',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
            ),
          ],
        ),
      ),
      appBar: appbarGetRegistrations(),
    );
  }

  void onSearchTextChanged(String value) {
    setState(() {
      filteredContestants = allContestants.where((contestant) {
        return contestant.toLowerCase().contains(value.toLowerCase());
      }).toList();
    });
  }

  AppBar appbarGetRegistrations() {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 16, 16, 16),
      title: Text(
        'Registrations',
        style: TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
      ),
      leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                color: const Color.fromARGB(255, 37, 37, 37),
                borderRadius: BorderRadius.circular(40)),
            child: Icon(
              CupertinoIcons.back,
              color: Colors.redAccent,
            ),
          ),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            print(widget.registeredContestants);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 37, 37, 37),
                  borderRadius: BorderRadius.circular(40)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  CupertinoIcons.cloud_download_fill,
                  color: Colors.redAccent,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
