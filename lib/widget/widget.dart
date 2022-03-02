import 'dart:async';
import 'dart:convert';
import 'package:finwallet/helper/authSave.dart';
import 'package:finwallet/model/Data.dart';
import 'package:finwallet/pages/TransactionsPage.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/material.dart';

import 'indicator.dart';

Widget signinPage(BuildContext context, bool p) {
  GlobalKey<FormState> _key = new GlobalKey<FormState>();
  String email = "", password = "", name = "";
  Map _usrdet = {};
  return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(3, 7, 30, 1)),
        alignment: Alignment.center,
        child: AnimatedContainer(
            padding: EdgeInsets.all(15),
            width: 350,
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(15)),
            curve: Curves.easeIn,
            duration: Duration(milliseconds: 1000),
            child: SingleChildScrollView(
              child: Form(
                key: _key,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.account_balance_wallet_outlined,
                            color: Colors.redAccent[400],
                            size: 55,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Fin-Wallet",
                            style: TextStyle(
                                fontSize: 45,
                                color: Colors.redAccent[400],
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 70,
                      ),
                      Text(
                        p ? "Sign Up" : "Sign In",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      p
                          ? SizedBox(
                              height: 25,
                            )
                          : SizedBox(
                              height: 0,
                            ),
                      p
                          ? TextFormField(
                              onSaved: (value) {
                                name = value!;
                              },
                              validator: (value) {
                                if (value!.isEmpty ||
                                    !RegExp(r'^[A-Za-z\s]{1,}[\.]{0,1}[A-Za-z\s]{0,}$')
                                        .hasMatch(value)) {
                                  //allow upper and lower case alphabets and space
                                  return "Incorrect Email";
                                } else {
                                  return null;
                                }
                              },
                              style: TextStyle(color: Colors.white),
                              decoration: InputDecoration(
                                  labelStyle: TextStyle(color: Colors.white),
                                  labelText: "Full Name",
                                  errorStyle: TextStyle(color: Colors.red),
                                  fillColor: Color.fromRGBO(247, 247, 245, 0.5),
                                  filled: false,
                                  prefixIcon: Icon(
                                    Icons.verified_user,
                                    color: Colors.amber,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: Colors.white,
                                          width: 2,
                                          style: BorderStyle.solid)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      borderSide: BorderSide(
                                          color: Colors.amber,
                                          width: 2,
                                          style: BorderStyle.solid))),
                            )
                          : SizedBox(
                              height: 0,
                            ),
                      SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        onSaved: (value) {
                          email = value!;
                        },
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                  .hasMatch(value)) {
                            //allow upper and lower case alphabets and space
                            return "Incorrect Email";
                          } else {
                            return null;
                          }
                        },
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.white),
                            labelText: "Email",
                            errorStyle: TextStyle(color: Colors.red),
                            fillColor: Color.fromRGBO(247, 247, 245, 0.5),
                            filled: false,
                            prefixIcon: Icon(
                              Icons.email,
                              color: Colors.amber,
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 2,
                                    style: BorderStyle.solid)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: Colors.amber,
                                    width: 2,
                                    style: BorderStyle.solid))),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        onSaved: (value) {
                          password = value!;
                        },
                        validator: (value) {
                          if (value!.isEmpty ||
                              !RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{5,}$')
                                  .hasMatch(value)) {
                            //allow upper and lower case alphabets and space
                            return "Minimum 5 digit password with atleast one Uppercase, one LowerCase,\none Digit, and one Special Character";
                          } else {
                            return null;
                          }
                        },
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.white),
                            labelText: "Password",
                            fillColor: Color.fromRGBO(247, 247, 245, 0.5),
                            errorStyle: TextStyle(color: Colors.red),
                            filled: false,
                            prefixIcon: Icon(
                              Icons.key,
                              color: Colors.amber,
                            ),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 2,
                                    style: BorderStyle.solid)),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(
                                    color: Colors.amber,
                                    width: 2,
                                    style: BorderStyle.solid))),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                          alignment: Alignment.topRight,
                          child: Text(
                            "Forgot password",
                            style: TextStyle(color: Colors.white),
                          )),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () {
                            //submit button

                            if (_key.currentState!.validate()) {
                              _key.currentState!.save();
                              _key.currentState!.reset();

                              p
                                  ? signup(
                                      name, email, password, "default", context)
                                  : login(email, password, "default", context);
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.transparent,
                                border: Border.all(
                                    color: Colors.blue,
                                    width: 1,
                                    style: BorderStyle.solid)),
                            padding: EdgeInsets.fromLTRB(30, 8, 30, 8),
                            child: Text(
                              p ? "Sign Up" : "Sign In",
                              style: TextStyle(color: Vx.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      GestureDetector(
                        onTap: () {
                          p
                              ? Navigator.of(context)
                                  .pushReplacementNamed('/signin')
                              : Navigator.of(context)
                                  .pushReplacementNamed('/signup');
                        },
                        child: Center(
                            child: Text(
                          p
                              ? "Have an account? Sign In"
                              : "Don't Have an account? Sign Up",
                          style: TextStyle(color: Colors.white),
                        )),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: GestureDetector(
                          onTap: () {
                            //google sign in
                            GoogleSignIn().signIn().then((value) async => {
                                  p
                                      ? signup(
                                          value!.displayName.toString(),
                                          value.email.toString(),
                                          value.email.toString(),
                                          value.photoUrl.toString(),
                                          context)
                                      : login(
                                          value!.email.toString(),
                                          value.email.toString(),
                                          value.photoUrl.toString(),
                                          context)
                                });
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.blue,
                                      width: 1,
                                      style: BorderStyle.solid)),
                              padding: EdgeInsets.fromLTRB(30, 8, 30, 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    './lib/assets/g_icon.png',
                                    width: 25,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    p
                                        ? "Sign in With Google"
                                        : "Sign up With Google",
                                    style: TextStyle(
                                        color: Color.fromRGBO(3, 7, 30, 1),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              )),
                        ),
                      ),
                    ]),
              ),
            )),
      ));
}

signup(String name, String email, String password, String imgUrl,
    BuildContext context) async {
  var url = Uri.parse('https://finwallet-backend.herokuapp.com/signUp');
  var response = await http.post(url,
      body: json
          .encode({'full_name': name, 'email': email, 'password': password}),
      headers: {'content-type': 'application/json'});
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
  var data = jsonDecode(response.body);
  if (data['message'] == "User Created") {
    Map _usrdet = {};
    _usrdet.addAll({
      'id': data['id'],
      'email': data['email'],
      'name': data['full_name'],
      'profile_img': imgUrl,
    });
    await authSave().saveLoginData(_usrdet);
  }

  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      data['message'] == "User Created" ? "Signing Up" : data['message'],
      style: TextStyle(
          color: data['message'] == "User Created"
              ? Colors.green.shade900
              : Colors.red.shade900),
    ),
    backgroundColor: data['message'] == "User Created"
        ? Colors.green.shade200
        : Colors.red.shade200,
  ));
  Timer(
      Duration(milliseconds: 1500),
      () => {
            if (data['message'] == "User Created")
              {Navigator.pushReplacementNamed(context, '/home')}
          });
}

login(
    String email, String password, String imgUrl, BuildContext context) async {
  var url = Uri.parse('https://finwallet-backend.herokuapp.com/login');
  var response = await http.post(url,
      body: json.encode({'email': email, 'password': password}),
      headers: {'content-type': 'application/json'});
  print('Response status: ${response.statusCode}');
  print('Response body: ${response.body}');
  var data = jsonDecode(response.body);

  if (data['message'] == "Logged In") {
    Map _usrdet = {};
    _usrdet.addAll({
      'id': data['id'],
      'email': data['email'],
      'name': data['full_name'],
      'profile_img': imgUrl,
    });

    await authSave().saveLoginData(_usrdet);
  }

  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      data['message'] == "Logged In" ? "Logging In" : data['message'],
      style: TextStyle(
          color: data['message'] == "Logged In"
              ? Colors.green.shade900
              : Colors.red.shade900),
    ),
    backgroundColor: data['message'] == "Logged In"
        ? Colors.green.shade200
        : Colors.red.shade200,
  ));
  Timer(
      Duration(milliseconds: 1500),
      () => {
            if (data['message'] == "Logged In")
              {Navigator.pushReplacementNamed(context, '/home')}
          });
}

Widget Header(String name, String imgUrl) {
  return Container(
      child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hi,",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 22, color: Vx.white),
          ),
          Text(name.split(' ').first,
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 35, color: Vx.white)),
        ],
      ),
      ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Image.network(
          imgUrl,
          width: 50,
        ),
      )
    ],
  ));
}

Widget Transactions(BuildContext context, double inc, double exp, int bal,
    List<Data> dataSet, String id, Function update) {
  return Container(
      child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SizedBox(
        height: 35,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Current Balance",
            style: TextStyle(
                fontWeight: FontWeight.normal, fontSize: 22, color: Vx.white),
          ),
          Spacer(),
          Text('₹ ${bal}',
              style: TextStyle(
                  fontWeight: FontWeight.w300, fontSize: 22, color: Vx.white)),
        ],
      ),
      SizedBox(
        height: 25,
      ),
      Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Color.fromRGBO(20, 33, 61, 0.8),
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(
                  'Current Month',
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                      color: Vx.white),
                ),
                Spacer(),
                Text(
                  '₹ ${inc - exp}',
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 18,
                      color: Vx.white),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      "Expense",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 18,
                          color: Vx.white),
                    ),
                    Text('₹ ${exp}',
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                            color: Vx.white)),
                  ],
                ),
                Container(
                  width: 1,
                  height: 40,
                  color: Vx.black,
                ),
                Column(
                  children: [
                    Text(
                      "Income",
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 18,
                          color: Vx.white),
                    ),
                    Text('₹ ${inc}',
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                            color: Vx.white)),
                  ],
                )
              ],
            )
          ],
        ),
      ),

      SizedBox(
        height: 25,
      ),

      Text("Transactions",
          style: TextStyle(
              fontWeight: FontWeight.w600, fontSize: 25, color: Vx.white)),

      SizedBox(
        height: 25,
      ),

      ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: ((context, index) {
          return Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.symmetric(horizontal: 25),
            width: double.infinity,
            decoration: BoxDecoration(
                color: dataSet[dataSet.length - 1 - index].type == 'Debit'
                    ? Colors.redAccent.shade400
                    : Colors.green,
                borderRadius: BorderRadius.circular(15)),
            child: Center(
              child: Row(children: [
                Text(dataSet[dataSet.length - 1 - index].description.toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                        color: Vx.white)),
                Spacer(),
                Text('₹ ${dataSet[dataSet.length - 1 - index].amount}',
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                        color: Vx.white))
              ]),
            ),
            height: 80,
          );
        }),
        itemCount: dataSet.length > 4 ? 4 : dataSet.length,
      ),
      GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => TransactionsPage(
                    update: update,
                  )));
        },
        child: Container(
          margin: EdgeInsets.all(5),
          child: Center(
            child: Text(dataSet.length > 0 ? "See More" : "No Transaction Data",
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 18,
                    color: Vx.white)),
          ),
          decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(
                  color: Colors.grey.shade400,
                  style: BorderStyle.solid,
                  width: 2),
              borderRadius: BorderRadius.circular(15)),
          height: 80,
          width: double.infinity,
        ),
      ),

      SizedBox(
        height: 25,
      ),

      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              shDialog(context, false, id, update);
            },
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                      color: Colors.red, width: 1, style: BorderStyle.solid)),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.red,
                    ),
                    SizedBox(width: 15),
                    Text("Add Debit",
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                            color: Vx.white)),
                    SizedBox(width: 10),
                  ]),
            ),
          ),
          GestureDetector(
            onTap: () {
              shDialog(context, true, id, update);
            },
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                      color: Colors.green, width: 1, style: BorderStyle.solid)),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(width: 10),
                    Text("Add Credit",
                        style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 18,
                            color: Vx.white)),
                    SizedBox(width: 15),
                    Icon(
                      Icons.expand_less,
                      color: Colors.green,
                    ),
                  ]),
            ),
          )
        ],
      )
      //ListView.builder()//
    ],
  ));
}

shDialog(BuildContext context, bool p, String id, Function update) {
  GlobalKey<FormState> _key = new GlobalKey<FormState>();
  String desc = "";
  int amt = 0;
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            titlePadding: EdgeInsets.all(0),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            title: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Color.fromRGBO(3, 7, 30, 1),
                borderRadius: BorderRadius.circular(20),
              ),
              height: 350,
              width: 350,
              child: Form(
                  key: _key,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(p ? "Add Expense" : "Add Income",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 25,
                                color: Vx.white)),
                        SizedBox(
                          height: 35,
                        ),
                        TextFormField(
                          onSaved: (value) {
                            desc = value!;
                          },
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              labelStyle: TextStyle(color: Colors.white),
                              labelText: "Description",
                              errorStyle: TextStyle(color: Colors.red),
                              fillColor: Color.fromRGBO(247, 247, 245, 0.5),
                              filled: false,
                              prefixIcon: Icon(
                                Icons.description,
                                color: Colors.amber,
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 2,
                                      style: BorderStyle.solid)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                      color: Colors.amber,
                                      width: 2,
                                      style: BorderStyle.solid))),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          onSaved: (value) {
                            amt = int.parse(value!);
                          },
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              labelStyle: TextStyle(color: Colors.white),
                              labelText: "Amount",
                              errorStyle: TextStyle(color: Colors.red),
                              fillColor: Color.fromRGBO(247, 247, 245, 0.5),
                              filled: false,
                              prefixIcon: Icon(
                                Icons.paid,
                                color: Colors.amber,
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 2,
                                      style: BorderStyle.solid)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(
                                      color: Colors.amber,
                                      width: 2,
                                      style: BorderStyle.solid))),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () {
                              _key.currentState!.save();
                              p
                                  ? addCredit(context, id, desc, amt)
                                  : addDebit(context, id, desc, amt);
                              Navigator.of(context).pop();
                              update();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.transparent,
                                  border: Border.all(
                                      color: Colors.blue,
                                      width: 1,
                                      style: BorderStyle.solid)),
                              padding: EdgeInsets.fromLTRB(30, 8, 30, 8),
                              child: Text(
                                "Add",
                                style: TextStyle(color: Vx.white),
                              ),
                            ),
                          ),
                        ),
                      ])),
            ));
      });
}

addCredit(BuildContext context, String id, String desc, int amt) async {
  var url = Uri.parse('https://finwallet-backend.herokuapp.com/addCredit');
  var response = await http.post(url,
      body: json.encode({'userId': id, 'desc': desc, 'amount': amt}),
      headers: {'content-type': 'application/json'});
}

addDebit(BuildContext context, String id, String desc, int amt) async {
  var url = Uri.parse('https://finwallet-backend.herokuapp.com/addDebit');
  var response = await http.post(url,
      body: json.encode({'userId': id, 'desc': desc, 'amount': amt}),
      headers: {'content-type': 'application/json'});
}

List<Widget> chartData(double inc, double exp) {
  return [
    Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Indicator(
            color: const Color(0xff13d38e),
            text: 'Income',
            isSquare: false,
            size: 16,
            textColor: Colors.white),
        Indicator(
          color: const Color(0xfff8b250),
          text: 'Expenses',
          isSquare: false,
          size: 16,
          textColor: Colors.white,
        ),
      ],
    ),
    SizedBox(
      height: 18,
    ),
    Container(
      height: 300,
      child: PieChart(
        PieChartData(
            borderData: FlBorderData(
              show: true,
            ),
            centerSpaceRadius: double.infinity,
            sectionsSpace: 0,
            sections: [
              PieChartSectionData(
                value: inc,
                radius: 80,
                color: Color(0xff13d38e),
                title: inc.toString(),
                titleStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xffffffff)),
              ),
              PieChartSectionData(
                value: exp,
                radius: 80,
                color: Color(0xfff8b250),
                title: exp.toString(),
                titleStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xffffffff)),
              )
            ]),
        swapAnimationCurve: Curves.bounceInOut,
        swapAnimationDuration: Duration(milliseconds: 1500),
      ),
    ),
  ];
}
