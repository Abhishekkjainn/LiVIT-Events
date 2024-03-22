// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';

class eventModal extends GetxController {
  String eventName;
  String eventDesc;
  String clubName;
  String regstartDate;
  String venue;
  String reglastDate;
  String eventDay;
  String eventType;
  String noOfDays;
  String fromTime;
  String toTime;
  String eventMode;
  String collaboration;
  eventModal({
    required this.eventName,
    required this.eventDesc,
    required this.clubName,
    required this.regstartDate,
    required this.venue,
    required this.reglastDate,
    required this.eventDay,
    required this.eventType,
    required this.noOfDays,
    required this.fromTime,
    required this.toTime,
    required this.eventMode,
    required this.collaboration,
  });
  // Serialization logic
  Map<String, dynamic> toJson() {
    return {
      'eventName': eventName,
      'eventDesc': eventDesc,
      'clubName': clubName,
      'regstartDate': regstartDate,
      'venue': venue,
      'reglastDate': reglastDate,
      'eventDay': eventDay,
      'eventType': eventType,
      'noOfDays': noOfDays,
      'fromTime': fromTime,
      'toTime': toTime,
      'eventMode': eventMode,
      'collaboration': collaboration,
    };
  }

  // Deserialization logic
  factory eventModal.fromJson(Map<String, dynamic> json) {
    return eventModal(
      eventName: json['eventName'],
      eventDesc: json['eventDesc'],
      clubName: json['clubName'],
      regstartDate: json['regstartDate'],
      venue: json['venue'],
      reglastDate: json['reglastDate'],
      eventDay: json['eventDay'],
      eventType: json['eventType'],
      noOfDays: json['noOfDays'],
      fromTime: json['fromTime'],
      toTime: json['toTime'],
      eventMode: json['eventMode'],
      collaboration: json['collaboration'],
    );
  }
}
