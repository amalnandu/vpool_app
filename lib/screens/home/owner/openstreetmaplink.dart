import 'package:flutter/material.dart';
import '../../../models/user.dart';
import 'openstreetmap.dart';


class OpenStreetMapLink extends StatefulWidget {
  const OpenStreetMapLink({required this.user,required this.loctra,required this.lat,required this.long});
  final NewUser user;final TextEditingController loctra, lat,long;


  // @override
  // void dispose() {
  //   Timer? _timer;
  //   if (_timer != null) {
  //     _timer.cancel();
  //     _timer = null;
  //   }
  // }

  @override
  State<OpenStreetMapLink> createState() => _OpenStreetMapLinkState();
}

class _OpenStreetMapLinkState extends State<OpenStreetMapLink> {

  @override
  void initState() {super.initState();}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,
        title: Text('MAP'),backgroundColor: Colors.green,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ), toolbarHeight: MediaQuery.of(context).size.height/15,
      ),
      body: OpenStreetMapSearchAndPick(
          long: widget.long,
          lat: widget.lat,
          loctra: widget.loctra,
          user:widget.user,
          center: LatLong(11.873595198897403,75.37102790426799),
          buttonColor: Colors.deepOrange,
          buttonTextColor: Colors.black,
          buttonText: 'Save the Selected Location',
          onPicked: (pickedData) {
            print(pickedData.latLong.latitude);
            print(pickedData.latLong.longitude);
            //print(pickedData.address);
          }),
    );
  }
}