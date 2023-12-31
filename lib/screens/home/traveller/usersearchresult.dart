import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../main.dart';
import '../../../models/user.dart';
import '../../../services/auth.dart';
import '../../../services/databaseService.dart';
import '../owner/addjourney.dart';
import '../owner/openstreetmaplink.dart';

class MySearch extends StatefulWidget {
  const MySearch({required this.user});
  final NewUser user;

  @override
  State<MySearch> createState() => _MySearchState();
}

class _MySearchState extends State<MySearch> {
  @override
  Widget build(BuildContext context) {
    print("clicked");
    return StreamProvider.value(
        value: JourneyDatabaseService().journeylist,
        initialData: null,
        child: MySearchData(
          user: widget.user,
        ));
  }
}

class MySearchData extends StatefulWidget {
  const MySearchData({required this.user});
  final NewUser user;

  @override
  State<MySearchData> createState() => _MySearchDataState();
}

class _MySearchDataState extends State<MySearchData> {
  List<String> startlocat = [], endlocat = [];
  TextEditingController startLoc = TextEditingController();
  TextEditingController endLoc = TextEditingController();
  TextEditingController tdate = TextEditingController();
  bool vis = false;
  List<Journey> searchlist = [];
  @override
  Widget build(BuildContext context) {
    final journeylist = Provider.of<List<Journey>?>(context) ?? [];
    print("journey list size is " + journeylist.length.toString());
    for (int i = 0; i < journeylist.length; i++) {
      startlocat.add(journeylist[i].startingloc);
      endlocat.add(journeylist[i].endingloc);
      startlocat = [
        ...{...startlocat}
      ];
      endlocat = [
        ...{...endlocat}
      ];
    }
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height / 2,
        child: Column(
          children: [
            ListTile(
              leading: Container(
                width: MediaQuery.of(context).size.width / 1.3,
                child: TextField(
                  readOnly: true,
                  controller: startLoc,
                  decoration: InputDecoration(
                    labelText: 'Start location',
                    icon: IconButton(
                      onPressed: () {
                        // method to show the search bar
                        showSearch(
                            context: context,
                            // delegate to customize the search bar
                            delegate: CustomSearchDelegate(
                                searchcont: startLoc, searchTerms: startlocat));
                      },
                      icon: const Icon(Icons.location_on_outlined),
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Container(
                width: MediaQuery.of(context).size.width / 1.3,
                child: TextField(
                  readOnly: true,
                  controller: endLoc,
                  decoration: InputDecoration(
                    labelText: 'End location',
                    icon: IconButton(
                      onPressed: () {
                        // method to show the search bar
                        showSearch(
                            context: context,
                            // delegate to customize the search bar
                            delegate: CustomSearchDelegate(
                                searchcont: endLoc, searchTerms: endlocat));
                      },
                      icon: Icon(Icons.location_city),
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Container(
                decoration: BoxDecoration(
                    //border: Border.all(color: Colors.black87)
                    ),
                width: MediaQuery.of(context).size.width / 1.3,
                child: TextField(
                  readOnly: true,
                  controller: tdate,
                  decoration: InputDecoration(
                    labelText: 'date',
                    icon: IconButton(
                      onPressed: () async {
                        await showDialog(
                            context: context,
                            builder: (_) {
                              return Dialog(
                                child: Calender(locctrl: tdate),
                              );
                            });
                        if (tdate.text != null)
                          print(tdate.text.split(' ').first);
                      },
                      icon: Icon(Icons.date_range),
                    ),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              // trailing: Icon(Icons.date_range),
            ),
            ElevatedButton(
                onPressed: () async {
                  print(vis);
                  searchlist = checker(journeylist);
                  print(searchlist);
                  setState(() {
                    vis = true;
                    print(vis);
                  });
                },
                child: Text('search')),
            Visibility(
                visible: vis,
                child: Container(
                  height: MediaQuery.of(context).size.height / 10,
                  child: ListView.builder(
                    itemCount: searchlist.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        child: Container(
                          padding:
                              EdgeInsets.only(top: 10, right: 20, bottom: 10),
                          height: MediaQuery.of(context).size.height / 25,
                          child: Card(
                              child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text('journey'),
                                  ),
                                  Expanded(
                                      flex: 3,
                                      child:
                                          Text(searchlist[index].startingloc)),
                                  Expanded(
                                    flex: 1,
                                    child: Text('------->'),
                                  ),
                                  Expanded(
                                      flex: 3,
                                      child: Text(searchlist[index].endingloc))
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text('Time'),
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child:
                                          Text(searchlist[index].startingtime)),
                                  Expanded(
                                    flex: 1,
                                    child: Text('-----to------'),
                                  ),
                                  Expanded(
                                      flex: 2,
                                      child: Text(searchlist[index].endingtime))
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text('Remaining setas'),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Text(searchlist[index].remseats)),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: Text('journey driver'),
                                  ),
                                  Expanded(
                                      flex: 1,
                                      child: Text(searchlist[index].email)),
                                ],
                              ),
                            ],
                          )),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SelectJourney(
                                        user: widget.user,
                                        selected: searchlist[index],
                                      )));
                        },
                      );
                    },
                  ),
                )),
          ],
        ),
      ),
    );
  }

  List<Journey> checker(journeylist) {
    List<Journey> searchlist = [];
    for (int i = 0; i < journeylist.length; i++) {
      print(journeylist[i].endingloc);
      if (journeylist[i].startingloc == startLoc.text &&
          journeylist[i].endingloc == endLoc.text &&
          double.parse(journeylist[i].remseats) > 0) {
        searchlist.add(journeylist[i]);
        print(double.parse(journeylist[i].remseats));
      }
    }
    return searchlist;
  }
}

////////////////////////////////////////////////////////////////////////////////

class SelectJourney extends StatefulWidget {
  const SelectJourney({required this.selected, required this.user});
  final NewUser user;
  final Journey selected;

  @override
  State<SelectJourney> createState() => _SelectJourneyState();
}

class _SelectJourneyState extends State<SelectJourney> {
  final AuthService _auth = AuthService();
  String error = "";
  TextEditingController startingloc = TextEditingController();
  TextEditingController endingloc = TextEditingController();
  TextEditingController numseats = TextEditingController();
  TextEditingController lat = TextEditingController();
  TextEditingController long = TextEditingController();

  String startlat = "", startlong = "", endlat = "", endlong = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ),
        toolbarHeight: MediaQuery.of(context).size.height / 15,
        title: Center(
            child: Text(
          'V-Pool',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
        )),
        backgroundColor: topcolor,
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
              print("My settings menu is selected.");
            } else if (value == 2) {
              await _auth.signOut();
            }
          }),
        ],
      ),
      body: Column(
        children: [
          Text(widget.selected.email),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 1,
                child: Text('journey'),
              ),
              Expanded(flex: 2, child: Text(widget.selected.startingloc)),
              Expanded(
                flex: 1,
                child: Text('------->'),
              ),
              Expanded(flex: 2, child: Text(widget.selected.endingloc))
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Text('Remaining seats'),
              ),
              Expanded(flex: 1, child: Text(widget.selected.remseats)),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Text('journey date'),
              ),
              Expanded(flex: 1, child: Text(widget.selected.date)),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Text('journey begins: '),
              ),
              Expanded(flex: 1, child: Text(widget.selected.startingtime)),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Text('journey ends: '),
              ),
              Expanded(flex: 1, child: Text(widget.selected.endingtime)),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Form(
              child: Column(
            children: [
              ListTile(
                leading: Container(
                  width: MediaQuery.of(context).size.width / 1.3,
                  child: TextField(
                    readOnly: true,
                    controller: startingloc,
                    decoration: InputDecoration(
                      labelText: 'Start location',
                      icon: IconButton(
                        onPressed: () async {
                          await showDialog(
                              context: context,
                              builder: (_) {
                                return Dialog(
                                  child: OpenStreetMapLink(
                                      user: widget.user,
                                      loctra: startingloc,
                                      lat: lat,
                                      long: long),
                                );
                              });
                          startlat = lat.text;
                          startlong = long.text;
                          print("lat is " +
                              startlat +
                              "    long is " +
                              startlong);
                        },
                        icon: Icon(Icons.location_on_outlined),
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: Container(
                  width: MediaQuery.of(context).size.width / 1.3,
                  child: TextField(
                    readOnly: true,
                    controller: endingloc,
                    decoration: InputDecoration(
                      labelText: 'Start location',
                      icon: IconButton(
                        onPressed: () async {
                          await showDialog(
                              context: context,
                              builder: (_) {
                                return Dialog(
                                  child: OpenStreetMapLink(
                                      user: widget.user,
                                      loctra: endingloc,
                                      lat: lat,
                                      long: long),
                                );
                              });
                          endlat = lat.text;
                          endlong = long.text;
                          print("lat is " + endlat + "    long is " + endlong);
                        },
                        icon: Icon(Icons.location_city),
                      ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ),
              TextFormField(
                controller: numseats,
                decoration: InputDecoration(
                  icon: Icon(Icons.numbers),
                  labelText: 'number of seats to be booked',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          )),
          ElevatedButton(
              onPressed: () async {
                double numseats1 = double.parse(widget.selected.remseats);
                double reqseats = double.parse(numseats.text);
                double remseats = numseats1 - reqseats;
                if (remseats >= 0) {
                  await JourneyDriverTravellerConnection(
                          driverid: widget.selected.email)
                      .UpdateDriverJourneyDataInJourney(
                          remseats.toString(), widget.selected.journeyid);
                  await JourneyDriverTravellerConnection(
                          driverid: widget.selected.email)
                      .AddTravellerJourneyData(
                          widget.user.username,
                          startingloc.text,
                          endingloc.text,
                          numseats.text,
                          widget.selected.journeyid,
                          startlat,
                          startlong,
                          endlat,
                          endlong);
                  await JourneyDriverTravellerConnection(
                          driverid: widget.selected.email)
                      .AddAdminJourneyData(
                          widget.user.username,
                          startingloc.text,
                          endingloc.text,
                          numseats.text,
                          widget.selected.journeyid,
                          startlat,
                          startlong,
                          endlat,
                          endlong);
                  await JourneyDriverTravellerConnection(
                          driverid: widget.selected.email)
                      .AddAdminJourneyUserData(
                          widget.selected.date,
                          widget.user.username,
                          startingloc.text,
                          endingloc.text,
                          numseats.text,
                          widget.selected.journeyid,
                          startlat,
                          startlong,
                          endlat,
                          endlong);
                  await JourneyDriverTravellerConnection(
                          driverid: widget.selected.email)
                      .UpdateDriverJourneyDataInUser(
                          remseats.toString(), widget.selected.journeyid);
                  await clear();
                } else {
                  error = "seats not available";
                }
              },
              child: Text('add')),
          Text(error),
        ],
      ),
    );
  }

  Future<void> clear() async {
    startingloc.text = "";
    endingloc.text = "";
    numseats.text = "";
  }
}

////////////////////////////////////////////////////////////////////////////////

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate({required this.searchcont, required this.searchTerms});
// Demo list to show querying
  final TextEditingController searchcont;
  final List<String> searchTerms;

// first overwrite to
// clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
    ];
  }

// second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

// third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

// last overwrite to show the
// querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return GestureDetector(
          child: ListTile(
            title: Text(result),
          ),
          onTap: () {
            searchcont.text = result.toString();
            close(context, null);
          },
        );
      },
    );
  }
}
