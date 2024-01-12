import 'Datetime.dart';

class vcbpayinfo {
  Datetimecustom date;
  String sogiaodich;
  double phatsinhno;
  double phatsinhco;
  String noidung;

  vcbpayinfo({required this.date,  required this.noidung, required this.phatsinhco, required this.phatsinhno, required this.sogiaodich});

  factory vcbpayinfo.fromJson(Map<dynamic, dynamic> json) {
    return vcbpayinfo(
        date: Datetimecustom.fromJson(json['date']),
        noidung: json['noidung'].toString(),
        phatsinhco: double.parse(json['phatsinhco'].toString()),
        phatsinhno: double.parse(json['phatsinhno'].toString()),
        sogiaodich: json['noidung'].toString(),
    );
  }

  Map<dynamic, dynamic> toJson() => {
    'date' : date.toJson(),
    'phatsinhno' : phatsinhno,
    'phatsinhco' : phatsinhco,
    'noidung' : noidung,
    'sogiaodich' : sogiaodich,
  };
}