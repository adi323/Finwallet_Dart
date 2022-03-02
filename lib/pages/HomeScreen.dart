import 'dart:convert';
import 'package:finwallet/helper/authSave.dart';
import 'package:finwallet/model/Data.dart';
import 'package:finwallet/widget/widget.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String id = "";
  Map _usrdet = {};
  List<Data> dataSet = [];
  double exp = 0, inc = 0;
  int touchIndex = -1;
  @override
  initState() {
    // TODO: implement initState
    super.initState();
    //getId();
    update();
  }

  update() async {
    _usrdet.addAll({
      'id': await authSave.getId(),
      'email': await authSave.getEmail(),
      'name': await authSave.getName(),
      'profile_img': await authSave.getImg(),
    });
    var url = Uri.parse('https://finwallet-backend.herokuapp.com/getAll');
    var response = await http.post(url,
        body: json.encode({'userId': _usrdet['id']}),
        headers: {'content-type': 'application/json'});
    var data = jsonDecode(response.body);
    _usrdet['balance'] = data['balance'];
    dataSet = [];
    data['data'].forEach((v) {
      dataSet.add(new Data.fromJson(v));
    });

    exp = 0;
    inc = 0;
    dataSet.forEach(
      (element) {
        if (element.type == "Debit") {
          exp += element.amount!;
        }
        if (element.type == "Credit") {
          inc += element.amount!;
        }
      },
    );
    setState(() {});
  }

  callState() {
    update();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _usrdet['name'] != null
          ? SingleChildScrollView(
              child: Column(
              children: [
                Container(
                  padding: context.screenWidth > 600
                      ? EdgeInsets.fromLTRB(context.screenWidth * 0.15, 50,
                          context.screenWidth * 0.15, 0)
                      : EdgeInsets.fromLTRB(35, 50, 35, 0),
                  child: Header(_usrdet['name'], _usrdet['profile_img']),
                ),
                Container(
                  padding: context.screenWidth > 600
                      ? EdgeInsets.fromLTRB(context.screenWidth * 0.2, 0,
                          context.screenWidth * 0.2, 0)
                      : EdgeInsets.fromLTRB(35, 0, 35, 0),
                  child: Transactions(context, inc, exp, _usrdet['balance'],
                      dataSet, _usrdet['id'], callState),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  padding: context.screenWidth > 600
                      ? EdgeInsets.fromLTRB(context.screenWidth * 0.2, 0,
                          context.screenWidth * 0.2, 5)
                      : EdgeInsets.fromLTRB(35, 0, 35, 5),
                  child: Column(
                    children: inc > 0 && exp > 0 ? chartData(inc, exp) : [],
                  ),
                )
              ],
            ))
          : Container(
              height: double.infinity,
              width: double.infinity,
              child: Center(
                child: CircularProgressIndicator(color: Vx.white),
              )),
    );
    //: Scaffold();
  }
}
