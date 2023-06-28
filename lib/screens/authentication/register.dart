import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../services/auth.dart';

class Register extends StatefulWidget {
  const Register({required this.toggleView});
  final Function toggleView;

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  TextEditingController username1 = new TextEditingController();
  TextEditingController passsord1 = new TextEditingController();
  TextEditingController phno = new TextEditingController();
  TextEditingController adhar = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController drl = new TextEditingController();
  TextEditingController vno = new TextEditingController();
  TextEditingController rcbook = new TextEditingController();

  String dropdownvalue = 'traveller', error = "";
  var users = ['traveller', 'driver', 'dual'];
  String newval = "traveller";
  bool validate = false, visible = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 33,
          ),
          onPressed: () {
            widget.toggleView();
          },
        ),
        backgroundColor: Colors.white,
        flexibleSpace: Container(
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
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30)),
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[Colors.cyan, Colors.green])),
        ),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Sign up',
          style: GoogleFonts.poppins(fontSize: 20),
        ),
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         widget.toggleView();
        //       },
        //       icon: Icon(
        //         Icons.arrow_back,
        //         size: 30,
        //       ))
        // ],
      ),
      body: SingleChildScrollView(
        //physics: NeverScrollableScrollPhysics(),
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(children: [
                    Expanded(
                        flex: 1,
                        child: Icon(
                          Icons.person,
                          size: 40,
                        )),
                    SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      flex: 3,
                      child: TextField(
                        controller: username1,
                        decoration: InputDecoration(hintText: 'Username'),
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: 20,
                  ),
                  Row(children: [
                    Expanded(
                        flex: 1,
                        child: Icon(
                          Icons.mail,
                          size: 40,
                        )),
                    SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        controller: email,
                        decoration: InputDecoration(hintText: 'Email id'),
                        validator: (val) =>
                            val!.isEmpty ? "Email cannot be empty" : null,
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: 20,
                  ),
                  Row(children: [
                    Expanded(
                        flex: 1,
                        child: Icon(
                          Icons.password,
                          size: 40,
                        )),
                    SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        controller: passsord1,
                        decoration: InputDecoration(
                            hintText: 'Password',
                            errorText: validate
                                ? "Password must be atlest eight character long"
                                : ""),
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: 20,
                  ),
                  Row(children: [
                    Expanded(
                        flex: 1,
                        child: Icon(
                          Icons.call,
                          size: 40,
                        )),
                    SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      flex: 3,
                      child: TextField(
                        controller: phno,
                        decoration: InputDecoration(hintText: 'Phone number'),
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: 20,
                  ),
                  Row(children: [
                    Expanded(
                        flex: 1,
                        child: Icon(
                          Icons.credit_card_outlined,
                          size: 40,
                        )),
                    SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      flex: 3,
                      child: TextField(
                        controller: adhar,
                        decoration: InputDecoration(hintText: 'Aadhaar Number'),
                      ),
                    ),
                  ]),
                  SizedBox(
                    height: 20,
                  ),
                  Row(children: [
                    Expanded(
                        flex: 1,
                        child: Icon(
                          Icons.directions_bus_sharp,
                          size: 40,
                        )),
                    SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      flex: 3,
                      child: DropdownButton(
                        value: dropdownvalue,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: users.map((String user) {
                          return DropdownMenuItem(
                            value: user,
                            child: Text(user),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalue = newValue!;
                            print(newValue);
                            newval = newValue;
                            if (newValue != "traveller") {
                              visible = true;
                            } else {
                              visible = false;
                            }
                          });
                        },
                      ),
                    ),
                  ]),
                  Visibility(
                      visible: visible,
                      child: Column(
                        children: [
                          Row(children: [
                            Expanded(
                                flex: 1,
                                child: Icon(
                                  Icons.numbers,
                                  size: 40,
                                )),
                            SizedBox(
                              width: 30,
                            ),
                            Expanded(
                              flex: 3,
                              child: TextField(
                                controller: drl,
                                decoration: InputDecoration(
                                    hintText: 'Driving licence No.'),
                              ),
                            ),
                          ]),
                          SizedBox(
                            height: 20,
                          ),
                          Row(children: [
                            Expanded(
                                flex: 1,
                                child: Icon(
                                  Icons.numbers,
                                  size: 40,
                                )),
                            SizedBox(
                              width: 30,
                            ),
                            Expanded(
                              flex: 3,
                              child: TextField(
                                controller: vno,
                                decoration:
                                    InputDecoration(hintText: 'Vehicle number'),
                              ),
                            ),
                          ]),
                          SizedBox(
                            height: 20,
                          ),
                          Row(children: [
                            Expanded(
                                flex: 1,
                                child: Icon(
                                  Icons.insert_drive_file,
                                  size: 40,
                                )),
                            SizedBox(
                              width: 30,
                            ),
                            Expanded(
                              flex: 3,
                              child: TextField(
                                controller: rcbook,
                                decoration: InputDecoration(hintText: 'RC id'),
                              ),
                            ),
                          ]),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        dynamic result;
                        //if(_formKey.currentState!.validate()){}
                        if (passsord1.text.length > 7) {
                          validate = true;
                        } else {
                          validate = false;
                          showTopSnackBar(
                            Overlay.of(context),
                            const CustomSnackBar.error(
                              message:
                                  'Password must be have minimum 8 characters ',
                            ),
                          );
                          if (newval == 'owner') {
                            dynamic result =
                                await _auth.registerWithEmailandPasswordowner(
                                    email.text,
                                    passsord1.text,
                                    username1.text,
                                    phno.text,
                                    adhar.text,
                                    drl.text,
                                    rcbook.text,
                                    vno.text);
                          } else if (newval == 'traveller') {
                            dynamic result = await _auth
                                .registerWithEmailandPasswordtraveller(
                                    email.text,
                                    passsord1.text,
                                    username1.text,
                                    phno.text,
                                    adhar.text);
                          } else {
                            dynamic result =
                                await _auth.registerWithEmailandPassworddual(
                                    email.text.trim(),
                                    passsord1.text,
                                    username1.text.trim(),
                                    phno.text.trim(),
                                    adhar.text.trim(),
                                    drl.text.trim(),
                                    rcbook.text.trim(),
                                    vno.text.trim());
                          }
                          if (result == null) {
                            setState(() {
                              error = "Registration failed";
                              showTopSnackBar(
                                Overlay.of(context),
                                CustomSnackBar.error(
                                  message: '$error',
                                ),
                              );
                            });
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[400],
                        foregroundColor: Colors.white,
                        shadowColor: Colors.grey,
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                        minimumSize: Size(200, 50), //////// HERE
                      ),
                      child: Text(
                        'Register',
                        style: GoogleFonts.poppins(fontSize: 18),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 10, 5, 5),
                    child: Image.asset(
                      'assets/images/car_reg.jpg',
                      fit: BoxFit.cover,
                      height: 240.0,
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
