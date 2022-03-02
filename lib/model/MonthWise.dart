import 'package:finwallet/model/Data.dart';

class MonthWise {
  List<Data>? data;
  String? month;

  MonthWise({this.data, this.month});

  MonthWise.fromJson(String month, List<Data> data) {}
}
