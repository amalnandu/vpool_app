import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled1/main.dart';

import 'package:untitled1/screens/home/traveller/travelleruserhome.dart';
import 'package:untitled1/screens/home/traveller/userbookings.dart';
import 'package:untitled1/screens/home/traveller/usernotification.dart';
import 'package:untitled1/screens/home/traveller/usersearchresult.dart';
import '../../../models/user.dart';
import '../../../services/auth.dart';
import 'package:qr_flutter/qr_flutter.dart';

class UserHome extends StatefulWidget {
  const UserHome({required this.user});
  final NewUser user;

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  int pageIndex = 0;
  final AuthService _auth = AuthService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      MyUserHome(user: widget.user),
      MySearch(user: widget.user),
      UserNotification(user: widget.user),
      UserBookings(user: widget.user),
    ];

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.grey, // shadow color
                    blurRadius: 20, // shadow radius
                    offset: Offset(5, 5), // shadow offset
                    spreadRadius:
                        0.1, // The amount the box should be inflated prior to applying the blur
                    blurStyle: BlurStyle.normal // set blur style
                    ),
              ],
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30)),
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[Colors.cyan, Colors.green])),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(30),
              bottomLeft: Radius.circular(30)),
        ),
        toolbarHeight: MediaQuery.of(context).size.height / 15,
        title: Center(
            child: Text(
          'V-Pool',
          style: GoogleFonts.poppins(fontSize: 24),
        )),
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: BackButton(
          onPressed: () {
            //Navigator.of(context).pushNamed(Login.id);
          },
        ),
        actions: [
          PopupMenuButton(itemBuilder: (context) {
            return [
              const PopupMenuItem<int>(
                value: 0,
                child: Text("My Account"),
              ),
              const PopupMenuItem<int>(
                value: 1,
                child: Text("my qr"),
              ),
              const PopupMenuItem<int>(
                value: 2,
                child: Text("Logout"),
              ),
            ];
          }, onSelected: (value) async {
            if (value == 0) {
              print("My account menu is selected.");
            } else if (value == 1) {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return QrTraveller(
                  user: widget.user,
                );
              }));
            } else if (value == 2) {
              await _auth.signOut();
            }
          }),
        ],
      ),
      body: Stack(
        children: [
          Container(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.height / 50,
                  right: MediaQuery.of(context).size.height / 50),
              height: MediaQuery.of(context).size.height,
              child: pages[pageIndex]),
          Positioned(
              top: MediaQuery.of(context).size.height / 1.25,
              right: 5,
              left: 5,
              child: buildMyNavBar(context)),
          // Positioned(top: MediaQuery.of(context).size.height/1.30,left: MediaQuery.of(context).size.width/2.35,
          //     child: FloatingActionButton.extended(onPressed: (){}, label: Icon(Icons.person),elevation: 5,)),
        ],
      ),
    );
  }

  Container buildMyNavBar(BuildContext context) {
    return Container(
      height: 80,
      decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black54, // shadow color
                blurRadius: 20, // shadow radius
                offset: Offset(5, 5), // shadow offset
                spreadRadius:
                    0.1, // The amount the box should be inflated prior to applying the blur
                blurStyle: BlurStyle.normal // set blur style
                ),
          ],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.topLeft,
              colors: <Color>[Colors.cyan, Colors.green])),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(children: [
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 0;
                });
              },
              icon: pageIndex == 0
                  ? const Icon(
                      Icons.home_filled,
                      color: Colors.white,
                      size: 35,
                    )
                  : const Icon(
                      Icons.home_outlined,
                      color: Colors.white,
                      size: 35,
                    ),
            ),
            const Text("Home")
          ]),
          Column(children: [
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 1;
                });
              },
              icon: pageIndex == 1
                  ? const Icon(
                      Icons.saved_search_sharp,
                      color: Colors.white,
                      size: 35,
                    )
                  : const Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 35,
                    ),
            ),
            const Text('Search')
          ]),
          // Column(children:[
          //   IconButton(
          //     enableFeedback: false,
          //     onPressed: () {
          //       // setState(() {
          //       //   pageIndex = 2;
          //       // });
          //     },
          //     icon: pageIndex == 2
          //         ? const Icon(
          //       Icons.filter_none,
          //       color: Colors.transparent,
          //       size: 35,
          //     )
          //         : const Icon(
          //       Icons.filter_none,
          //       color: Colors.transparent,
          //       size: 35,
          //     ),
          //   ),const Text('')]),
          Column(children: [
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 2;
                });
              },
              icon: pageIndex == 2
                  ? const Icon(
                      Icons.notifications_active,
                      color: Colors.white,
                      size: 35,
                    )
                  : const Icon(
                      Icons.notifications_active_outlined,
                      color: Colors.white,
                      size: 35,
                    ),
            ),
            const Text('Notification')
          ]),
          Column(children: [
            IconButton(
              enableFeedback: false,
              onPressed: () {
                setState(() {
                  pageIndex = 3;
                });
              },
              icon: pageIndex == 3
                  ? const Icon(
                      Icons.person_2,
                      color: Colors.white,
                      size: 35,
                    )
                  : const Icon(
                      Icons.person_2_outlined,
                      color: Colors.white,
                      size: 35,
                    ),
            ),
            const Text('My Bookings')
          ]),
        ],
      ),
    );
  }
}

class QrTraveller extends StatefulWidget {
  const QrTraveller({required this.user});
  final NewUser user;

  @override
  State<QrTraveller> createState() => _QrTravellerState();
}

class _QrTravellerState extends State<QrTraveller> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: QrImageView(
        data: widget.user.username,
        version: QrVersions.auto,
        size: MediaQuery.of(context).devicePixelRatio,
      ),
    );
  }
}