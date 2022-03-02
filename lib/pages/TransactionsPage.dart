import 'dart:convert';
import 'package:finwallet/helper/authSave.dart';
import 'package:finwallet/model/MonthWise.dart';
import 'package:finwallet/widget/widget.dart';
import 'package:http/http.dart' as http;
import 'package:finwallet/model/Data.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class TransactionsPage extends StatefulWidget {
  Function update;
  TransactionsPage({Key? key, required this.update}) : super(key: key);

  @override
  _TransactionsPageState createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  Map<String, List<Data>> dataSet = {};
  List<String> keys = [];
  double inc = 0, exp = 0;
  String dp = "";
  int index = 0;
  String id = "";
  bool loaded = false;
  GlobalKey<FormState> _key = new GlobalKey<FormState>();
  getData() async {
    await authSave.getId().then((value) => id = value!);

    var url = Uri.parse('https://finwallet-backend.herokuapp.com/getMonthData');
    var response = await http.post(url,
        body: json.encode({'id': id}),
        headers: {'content-type': 'application/json'});
    var data = jsonDecode(response.body);
    var ss = [];
    ss.addAll(data['data'].keys);
    keys = new List<String>.from(ss);
    var ds = [];
    keys.forEach((ele) {
      //dataSet.addEntries(data['da'])
      List<Data> p = [];
      ds = (data['data'][ele]);
      ds.forEach((element) {
        Data d = new Data.fromJson(element);
        p.add(d);
      });
      dataSet[ele] = p;
    });
    dp = keys[index];
    getValue();
    setState(() {
      loaded = true;
    });
  }

  getValue() {
    exp = 0;
    inc = 0;
    dataSet[dp]!.forEach((element) {
      if (element.type == "Debit") {
        exp += element.amount!;
      }
      if (element.type == "Credit") {
        inc += element.amount!;
      }
    });
  }

  delete(String id) async {
    var url = Uri.parse('https://finwallet-backend.herokuapp.com/delItem');
    var response = await http.post(url,
        body: json.encode({'id': id}),
        headers: {'content-type': 'application/json'});
    getData();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(3, 7, 30, 1),
        toolbarHeight: 28,
        leading: IconButton(
          onPressed: () {
            widget.update();
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
      ),
      body: loaded
          ? Container(
              padding: context.screenWidth > 600
                  ? EdgeInsets.fromLTRB(context.screenWidth * 0.15, 35,
                      context.screenWidth * 0.15, 5)
                  : EdgeInsets.fromLTRB(35, 35, 35, 5),
              color: Color.fromRGBO(3, 7, 30, 1),
              child: ListView(children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Choose Month",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 22,
                            color: Vx.white),
                      ),
                      SizedBox(
                        width: 25,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Vx.white,
                                width: 2,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(10)),
                        child: DropdownButton<String>(
                          value: dp,
                          elevation: 16,
                          style: TextStyle(color: Colors.white),
                          dropdownColor: Color.fromRGBO(3, 7, 30, 1),
                          onChanged: (String? newValue) {
                            setState(() {
                              dp = newValue!;
                              index = keys.indexOf(newValue);
                              getValue();
                            });
                          },
                          items: keys
                              .toList()
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 18,
                                    color: Vx.white),
                              ),
                            );
                          }).toList(),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
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
                                fontWeight: FontWeight.normal,
                                fontSize: 22,
                                color: Vx.white),
                          ),
                          Spacer(),
                          Text('₹ ${inc - exp}',
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 22,
                                  color: Vx.white)),
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
                            Text(
                              'Current Month',
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18,
                                  color: Vx.white),
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
                              fontWeight: FontWeight.w600,
                              fontSize: 25,
                              color: Vx.white)),
                      SizedBox(
                        height: 25,
                      ),
                      dataSet[dp]!.length > 0
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemBuilder: ((context, ind) {
                                return Container(
                                  margin: EdgeInsets.all(5),
                                  padding: EdgeInsets.symmetric(horizontal: 25),
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: dataSet[dp]![ind].type == 'Debit'
                                          ? Colors.redAccent.shade400
                                          : Colors.green,
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Center(
                                    child: Row(children: [
                                      Text(
                                          dataSet[dp]![ind]
                                              .description
                                              .toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 18,
                                              color: Vx.white)),
                                      Spacer(),
                                      Text('₹ ${dataSet[dp]![ind].amount}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize: 18,
                                              color: Vx.white)),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            delete(dataSet[dp]![ind]
                                                .sId
                                                .toString());
                                          },
                                          icon: Icon(Icons.delete_forever))
                                    ]),
                                  ),
                                  height: 80,
                                );
                              }),
                              itemCount: dataSet[dp]!.length,
                            )
                          : Container(
                              alignment: Alignment.center,
                              child: Text("No Data"),
                            ),
                    ])),
                SizedBox(
                  height: 50,
                ),
                Column(
                  children: chartData(inc, exp),
                )
              ]),
            )
          : Container(
              alignment: Alignment.center,
              color: Color.fromRGBO(3, 7, 30, 1),
              child: CircularProgressIndicator(
                color: Vx.white,
              ),
            ),
    );
  }
}
