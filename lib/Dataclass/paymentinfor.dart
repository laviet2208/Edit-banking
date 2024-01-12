
import 'Datetime.dart';

class payInfor {
  Datetimecustom date;
  double phatsinhno;
  double phatsinhco;
  String noidung;
  String nguoinhan;
  String sotaikhoan;
  String nganhangnhan;

  payInfor({required this.date, required this.nganhangnhan , required this.nguoinhan, required this.noidung, required this.phatsinhco, required this.phatsinhno, required this.sotaikhoan});

  factory payInfor.fromJson(Map<dynamic, dynamic> json) {
    return payInfor(
        date: Datetimecustom.fromJson(json['date']),
        nganhangnhan: json['nganhangnhan'].toString(),
        nguoinhan: json['sotaikhoan'].toString(),
        noidung: json['noidung'].toString(),
        phatsinhco: double.parse(json['phatsinhco'].toString()),
        phatsinhno: double.parse(json['phatsinhno'].toString()),
        sotaikhoan: json['sotaikhoan'].toString()
    );
  }

  Map<dynamic, dynamic> toJson() => {
    'date' : date.toJson(),
    'phatsinhno' : phatsinhno,
    'phatsinhco' : phatsinhco,
    'noidung' : noidung,
    'nguoinhan' : nguoinhan,
    'sotaikhoan' : sotaikhoan,
    'nganhangnhan' : nganhangnhan,
  };
}