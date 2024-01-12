class Datetimecustom {
  int day;
  int month;
  int year;

  Datetimecustom({required this.day,required this.month,required this.year});

  Map<dynamic, dynamic> toJson() => {
    'day' : day,
    'month' : month,
    'year' : year,
  };

  factory Datetimecustom.fromJson(Map<dynamic, dynamic> json) {
    return Datetimecustom(
      day: int.parse(json['day'].toString()),
      month: int.parse(json['month'].toString()),
      year: int.parse(json['year'].toString()),
    );
  }
}