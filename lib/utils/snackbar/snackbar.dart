import 'package:flutter/material.dart';
import 'package:get/get.dart';

void successSnackbar(String content) {
  Get.snackbar(
    "Successful",
    content,
    backgroundColor: const Color.fromARGB(255, 30, 251, 1),
    colorText: Colors.white,
    snackPosition: SnackPosition.TOP,
    margin: const EdgeInsets.all(3),
  );
}

void failureSnackbar(String content) {
  Get.snackbar(
    "Unsuccessful",
    content,
    backgroundColor: const Color.fromARGB(255, 172, 9, 9),
    colorText: Colors.white,
    snackPosition: SnackPosition.TOP,
    margin: const EdgeInsets.all(5),
  );
}
