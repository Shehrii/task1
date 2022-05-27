import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'distance.model.dart';

class MainController extends GetxController {

  var fromController = TextEditingController();
  var distanceController = TextEditingController();
  var toController = TextEditingController();

  var from = "".obs, to = "".obs;
  var distance = 0.obs;
  var distanceModelList = <Distance>[].obs;

  isValidFields() {
    if (from.value.isEmpty || to.value.isEmpty || distance.value == 0) {
      return false;
    }
    return true;
  }

  void addDistance() {
    distanceModelList.add(Distance(
      from: from.value,
      to: to.value,
      distance: distance.value,
    ));

    fromController.clear();
    toController.clear();
    distanceController.clear();

    from("");
    to("");
    distance(0);
  }

  sortList(int i) {
    distanceModelList.sort((a, b) => a.distance!.compareTo(b.distance!));
    if(i == 1){
      distanceModelList(distanceModelList.reversed.toList());
    }
  }
}
