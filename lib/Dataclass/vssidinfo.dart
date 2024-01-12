class vssidinfo {
  String tuthang;
  String denthang;
  String donvi;
  String chucvu;
  double mn1;
  double mn2;
  int type;

  vssidinfo({required this.tuthang, required this.denthang , required this.donvi, required this.chucvu, required this.type,required this.mn1, required this.mn2});

  factory vssidinfo.fromJson(Map<dynamic, dynamic> json) {
    return vssidinfo(
        tuthang: json['tuthang'].toString(),
        denthang: json['denthang'].toString(),
        donvi: json['donvi'].toString(),
        chucvu: json['chucvu'].toString(),
        type: int.parse(json['type'].toString()),
        mn1: double.parse(json['mn1'].toString()),
        mn2: double.parse(json['mn2'].toString())
    );
  }

  Map<dynamic, dynamic> toJson() => {
    'tuthang': tuthang,
    'denthang': denthang,
    'donvi': donvi,
    'chucvu' : chucvu,
    'mn1': mn1,
    'mn2': mn2,
    'type' : type
  };
}