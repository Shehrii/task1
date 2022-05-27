import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:task1/distance.model.dart';
import 'package:task1/main.controller.dart';
import 'package:task1/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final MainController _controller = Get.put(MainController());
  final Completer<GoogleMapController> _googleMapController = Completer();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Task 1"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  customTextField(
                    controller: _controller.fromController,
                    hintText: "From",
                    onChanged: (val) => _controller.from(val),
                  ),
                  customTextField(
                    controller: _controller.toController,
                    hintText: "To",
                    onChanged: (val) => _controller.to(val),
                  ),
                  customTextField(
                    controller: _controller.distanceController,
                    hintText: "Distance(km)",
                    keyboardType: TextInputType.number,
                    onChanged: (val) => _controller.distance(int.parse(val)),
                  ),
                  Container(height: 10,),
                  MaterialButton(
                    color: Colors.blue,
                    onPressed: _onAddIntoListPressed,
                    child: const Text("Add"),
                  )
                ],
              ),
            ),

            Container(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  color: Colors.lightBlue,
                  onPressed: () => _controller.sortList(0),
                  child: const Text("Ascending"),
                ),
                MaterialButton(
                  color: Colors.blue,
                  onPressed: () => _controller.sortList(1),
                  child: const Text("Descending"),
                ),
              ],
            ),
            Container(height: 20,),

            _buildList(),

            SizedBox(
              height: 200,
              child: GoogleMap(
                mapType: MapType.hybrid,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _googleMapController.complete(controller);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onAddIntoListPressed() {
    if (!_controller.isValidFields()) {
      Get.snackbar(
        "Error",
        "Please fill in all the fields",
      );
      return;
    }

    _controller.addDistance();
  }

  _buildList() {
    return Obx(
      () => SizedBox(
        height: (_controller.distanceModelList.length + 1) * 30,
        child: ListView.builder(
          itemCount: _controller.distanceModelList.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Column(
                children: [
                  Row(
                    children: [
                      customExpandedText(text: "From", isBold: true),
                      customExpandedText(text: "To", isBold: true),
                      customExpandedText(text: "Distance", isBold: true)
                    ],
                  ),
                ],
              );
            }
            Distance model = _controller.distanceModelList[index - 1];
            return Column(
              children: [
                Row(
                  children: [
                    customExpandedText(text: model.from!),
                    customExpandedText(text: model.to!),
                    customExpandedText(text: model.distance!.toString() + "km"),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
