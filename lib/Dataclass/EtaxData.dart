class EtaxData {
  String matochuc;
  String tentochuc;
  String year;
  double thunhapchiuthue;
  double giamtrugiacanh;
  double tuthien;
  double baohiem;
  double huutri;
  double thuakhautru;
  double npt;

  EtaxData({
    required this.matochuc,
    required this.tentochuc,
    required this.year,
    required this.thunhapchiuthue,
    required this.giamtrugiacanh,
    required this.tuthien,
    required this.baohiem,
    required this.huutri,
    required this.thuakhautru,
    required this.npt
  });

  factory EtaxData.fromJson(Map<dynamic, dynamic> json) {
    return EtaxData(
        matochuc: json['matochuc'].toString(),
        tentochuc: json['tentochuc'].toString(),
        thunhapchiuthue: double.parse(json['thunhapchiuthue'].toString()),
        giamtrugiacanh: double.parse(json['giamtrugiacanh'].toString()),
      tuthien: double.parse(json['tuthien'].toString()),
      baohiem: double.parse(json['baohiem'].toString()),
      huutri: double.parse(json['huutri'].toString()),
      thuakhautru: double.parse(json['thuakhautru'].toString()),
      year: json['year'].toString(),
      npt: double.parse(json['npt'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'matochuc': matochuc,
      'tentochuc': tentochuc,
      'thunhapchiuthue': thunhapchiuthue,
      'giamtrugiacanh': giamtrugiacanh,
      'tuthien': tuthien,
      'baohiem': baohiem,
      'huutri': huutri,
      'thuakhautru': thuakhautru,
      'year' : year,
      'npt' : npt
    };
  }
}

