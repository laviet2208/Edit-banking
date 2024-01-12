import 'dart:html';
import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mbedit/Dataclass/Datetime.dart';
import 'package:mbedit/Dataclass/paymentinfor.dart';
import 'package:mbedit/Dataclass/vcbpayinfo.dart';
import 'package:mbedit/Dataclass/vssidinfo.dart';
import 'package:mbedit/utils/utils.dart';

import 'Dataclass/EtaxData.dart';
import 'OTHER/Button/Buttontype1.dart';

class SCREENmain extends StatefulWidget {
  const SCREENmain({Key? key}) : super(key: key);

  @override
  State<SCREENmain> createState() => _SCREENmainState();
}

class _SCREENmainState extends State<SCREENmain> {
  final tennguoidung = TextEditingController();
  final taikhoan = TextEditingController();
  final matkhau = TextEditingController();
  bool loading = false;
  bool loading1 = false;
  bool loading2 = false;
  bool loading4 = false;
  List<List<String>> parsedData = [];

  void parseData(String input) {
    parsedData.clear();
    List<String> lines = input.split('\n');
    List<List<String>> parsedLines = [];

    for (String line in lines) {
      List<String> attributes = line.split('|');
      parsedLines.add(attributes);
    }

    setState(() {
      parsedData = parsedLines;
    });
  }

  String generateRandomString(int length) {
    const chars = "abcdefghijklmnopqrstuvwxyz0123456789";
    Random random = Random();
    String result = "";

    for (int i = 0; i < length; i++) {
      int randomIndex = random.nextInt(chars.length);
      result += chars[randomIndex];
    }

    return result;
  }

  bool isDateValid(String input) {
    RegExp datePattern = RegExp(r'^\d{2}/\d{2}/\d{4}$');
    return datePattern.hasMatch(input);
  }

  bool canConvertToDouble(String input) {
    try {
      double.parse(input);
      return true;
    } catch (e) {
      return false;
    }
  }

  int extractDay(String dateString) {
    List<String> dateParts = dateString.split('/');
    if (dateParts.length == 3) {
      return int.tryParse(dateParts[0]) ?? 0;
    }
    return 0;
  }

  int extractMonth(String dateString) {
    List<String> dateParts = dateString.split('/');
    if (dateParts.length == 3) {
      return int.tryParse(dateParts[1]) ?? 0;
    }
    return 0;
  }

  int extractYear(String dateString) {
    List<String> dateParts = dateString.split('/');
    if (dateParts.length == 3) {
      return int.tryParse(dateParts[2]) ?? 0;
    }
    return 0;
  }


  Future<void> pushData(String pass, List<payInfor> list) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child(pass).remove();

      for (int i = 0 ; i < list.length ; i++) {
        await databaseRef.child(pass).child(i.toString()).set(list[i].toJson());
      }

      setState(() {
        loading = false;
      });
      toastMessage('đăng Hóa đơn thành công');

    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  Future<void> pushData1(String pass, List<vcbpayinfo> list) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('vietcombank/' + pass).remove();

      for (int i = 0 ; i < list.length ; i++) {
        await databaseRef.child('vietcombank/' + pass).child(i.toString()).set(list[i].toJson());
      }

      setState(() {
        loading1 = false;
      });
      toastMessage('đăng Hóa đơn thành công');

    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      throw error;
    }
  }

  Future<void> pushData2(String pass, List<vssidinfo> list) async{
    try {
      toastMessage('Vui lòng đợi tải thông tin');
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      setState(() {
        loading2 = true;
      });
      await databaseRef.child('Vssid/' + pass + '/data').remove();

      for (int i = 0 ; i < list.length ; i++) {
        await databaseRef.child('Vssid/' + pass + '/data').child(i.toString()).set(list[i].toJson());
      }

      setState(() {
        loading2 = false;
      });
      toastMessage('đăng Hóa đơn thành công');

    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      toastMessage('Đã xảy ra lỗi khi đẩy');
      setState(() {
        loading2 = false;
      });
      throw error;
    }
  }

  Future<void> pushData21(String pass, String name) async{
    try {
      toastMessage('Vui lòng đợi tải thông tin tên');
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      setState(() {
        loading2 = true;
      });

      await databaseRef.child('Vssid/' + pass + '/name').set(name);

      setState(() {
        loading2 = false;
      });
      toastMessage('đăng tên thành công');
      setState(() {
        loading2 = false;
      });
      Navigator.of(context).pop();
    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      toastMessage('Đã xảy ra lỗi khi đẩy');
      setState(() {
        loading2 = false;
      });
      throw error;
    }
  }

  Future<void> pushData3(String pass, List<EtaxData> list) async{
    try {
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      setState(() {
        loading4 = true;
      });
      await databaseRef.child('Etacmobi/' + pass).remove();

      for (int i = 0 ; i < list.length ; i++) {
        await databaseRef.child('Etacmobi/' + pass).child(i.toString()).set(list[i].toJson());
      }

      setState(() {
        loading4 = false;
      });
      toastMessage('đăng Hóa đơn thành công');

    } catch (error) {
      print('Đã xảy ra lỗi khi đẩy catchOrder: $error');
      toastMessage('Đã xảy ra lỗi khi đẩy');
      setState(() {
        loading4 = false;
      });
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: (screenWidth - screenWidth/2.5)/2,
              child: Container(
                width: screenWidth/2.5,
                height: screenHeight,
                child: ListView(
                  children: [
                    Container(height: 30,),

                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Thông tin giao dịch',
                          style: TextStyle(
                              fontFamily: 'arial',
                              fontSize: 28,
                              color: Colors.deepOrange,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),

                    Container(height: 20,),

                    Container(height: 20,),

                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        'Nhập mật khẩu tài khoản',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'arial',
                            fontWeight: FontWeight.normal
                        ),
                      ),
                    ),

                    Container(height: 10,),

                    Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Container(
                          height: 50,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                ),
                              ],
                              border: Border.all(
                                width: 2,
                                color: Colors.grey,
                              )
                          ),

                          child: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Form(
                              child: TextFormField(
                                controller: matkhau,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'arial',
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Nhập đúng mật khẩu tài khoản muốn thêm giao dịch',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontFamily: 'arial',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                    ),

                    Container(height: 20,),

                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        'Nhập data',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'arial',
                            fontWeight: FontWeight.normal
                        ),
                      ),
                    ),

                    Container(height: 10,),

                    Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Container(
                          height: 500,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                ),
                              ],
                              border: Border.all(
                                width: 2,
                                color: Colors.grey,
                              )
                          ),

                          child: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Form(
                              child: TextFormField(
                                controller: taikhoan,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'arial',
                                ),
                                maxLines: null, // Cho phép nhiều dòng
                                keyboardType: TextInputType.multiline, // Loại bàn phím dành cho nhiều dòng
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Nhập data vào đây',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontFamily: 'arial',
                                  ),
                                ),
                              ),
                            ),
                          ),

                        )
                    ),

                    Container(height: 40,),

                    Padding(
                      padding: EdgeInsets.only(left: 10,right: 10),
                      child: ButtonType1(Height: 60, Width: screenWidth/5*2-40, color: Colors.redAccent, radiusBorder: 30, title: 'Thêm giao dịch MB', fontText: 'arial', colorText: Colors.white,
                        onTap: () async{
                        if (taikhoan.text.isNotEmpty && matkhau.text.isNotEmpty) {
                          setState(() {
                            loading = true;
                          });
                          parseData(taikhoan.text.toString());
                          List<payInfor> list = [];
                          for(int i = 0 ; i < parsedData.length ; i++) {
                            payInfor pay = payInfor(
                                date: Datetimecustom(day: extractDay(parsedData[i][0]), month: extractMonth(parsedData[i][0]), year: extractYear(parsedData[i][0])),
                                nganhangnhan: parsedData[i][6],
                                nguoinhan: parsedData[i][4],
                                noidung: parsedData[i][3],
                                phatsinhco: double.parse(parsedData[i][1]),
                                phatsinhno: double.parse(parsedData[i][2]),
                                sotaikhoan: parsedData[i][5]
                            );
                            list.add(pay);
                          }
                          await pushData(matkhau.text.toString(), list);
                          setState(() {
                            loading = false;
                          });
                        } else {
                          toastMessage('Nhập đủ thông tin');
                        }

                        }, loading: loading,
                      ),
                    ),

                    Container(height: 20,),

                    Padding(
                      padding: EdgeInsets.only(left: 10,right: 10),
                      child: ButtonType1(Height: 60, Width: screenWidth/5*2-40, color: Colors.green, radiusBorder: 30, title: 'Thêm giao dịch VCB', fontText: 'arial', colorText: Colors.white,
                        onTap: () async{
                          if (taikhoan.text.isNotEmpty && matkhau.text.isNotEmpty) {
                            setState(() {
                              loading1 = true;
                            });
                            parseData(taikhoan.text.toString());
                            List<vcbpayinfo> list = [];
                            for(int i = 0 ; i < parsedData.length ; i++) {
                              vcbpayinfo pay = vcbpayinfo(
                                  date: Datetimecustom(day: extractDay(parsedData[i][0]), month: extractMonth(parsedData[i][0]), year: extractYear(parsedData[i][0])),
                                  noidung: parsedData[i][3],
                                  phatsinhco: double.parse(parsedData[i][1]),
                                  phatsinhno: double.parse(parsedData[i][2]),
                                  sogiaodich: parsedData[i][4],
                              );
                              list.add(pay);
                            }
                            await pushData1(matkhau.text.toString(), list);
                            setState(() {
                              loading1 = false;
                            });
                          } else {
                            toastMessage('Nhập đủ thông tin');
                          }

                        }, loading: loading1,
                      ),
                    ),

                    Container(height: 20,),

                    Padding(
                      padding: EdgeInsets.only(left: 10,right: 10),
                      child: ButtonType1(Height: 60, Width: screenWidth/5*2-40, color: Colors.blueAccent, radiusBorder: 30, title: 'Thêm dữ liệu VSSID', fontText: 'arial', colorText: Colors.white, 
                        onTap: () async{
                           showDialog(
                             context: context,
                             builder: (BuildContext context) {
                               return AlertDialog(
                                 title: Text('Nhập tên người dùng'),
                                 content: Container(
                                   width: screenWidth/3,
                                   height: screenHeight/2,
                                   child: ListView(
                                     padding: EdgeInsets.zero,
                                     children: [
                                       Padding(
                                           padding: EdgeInsets.only(left: 0, right: 0),
                                           child: Container(
                                             height: 50,
                                             alignment: Alignment.centerLeft,
                                             decoration: BoxDecoration(
                                                 color: Colors.white,
                                                 borderRadius: BorderRadius.circular(10),
                                                 boxShadow: [
                                                   BoxShadow(
                                                     color: Colors.grey.withOpacity(0.3),
                                                     spreadRadius: 5,
                                                     blurRadius: 7,
                                                     offset: Offset(0, 3),
                                                   ),
                                                 ],
                                                 border: Border.all(
                                                   width: 2,
                                                   color: Colors.grey,
                                                 )
                                             ),

                                             child: Padding(
                                               padding: EdgeInsets.only(left: 10),
                                               child: Form(
                                                 child: TextFormField(
                                                   controller: tennguoidung,
                                                   style: TextStyle(
                                                     color: Colors.black,
                                                     fontSize: 16,
                                                     fontFamily: 'arial',
                                                   ),
                                                   decoration: InputDecoration(
                                                     border: InputBorder.none,
                                                     hintText: 'Nhập tên người dùng',
                                                     hintStyle: TextStyle(
                                                       color: Colors.grey,
                                                       fontSize: 16,
                                                       fontFamily: 'arial',
                                                     ),
                                                   ),
                                                 ),
                                               ),
                                             ),
                                           )
                                       ),
                                     ],
                                   ),
                                 ),
                                 actions: <Widget>[
                                   TextButton(
                                     onPressed: () async {
                                       if (taikhoan.text.isNotEmpty && matkhau.text.isNotEmpty && tennguoidung.text.isNotEmpty) {
                                         setState(() {
                                           loading2 = true;
                                         });
                                         parseData(taikhoan.text.toString());
                                         List<vssidinfo> list = [];
                                         for(int i = 0 ; i < parsedData.length ; i++) {
                                           vssidinfo data = vssidinfo(
                                               tuthang: parsedData[i][0],
                                               denthang: parsedData[i][1],
                                               donvi: parsedData[i][2],
                                               chucvu: parsedData[i][3],
                                               type: int.parse(parsedData[i][6]),
                                               mn1: double.parse(parsedData[i][4]),
                                               mn2: double.parse(parsedData[i][5])
                                           );
                                           list.add(data);
                                         }

                                         await pushData2(matkhau.text.toString(), list);
                                         await pushData21(matkhau.text.toString(), tennguoidung.text.toString());


                                       } else {
                                         toastMessage('Nhập đủ thông tin');
                                       }
                                     },
                                     child: !loading2 ? Text(
                                       'Lưu thông tin',
                                       style: TextStyle(
                                         color: Colors.blueAccent
                                       ),
                                     ) : CircularProgressIndicator(strokeWidth: 4, color: Colors.blueAccent,),
                                   ),
                                 ],
                               );
                             },
                           );
                        }, loading: loading2,
                      ),
                    ),

                    Container(height: 20,),

                    Padding(
                      padding: EdgeInsets.only(left: 10,right: 10),
                      child: ButtonType1(Height: 60, Width: screenWidth/5*2-40, color: Colors.red, radiusBorder: 30, title: 'Thêm dữ liệu Etax', fontText: 'arial', colorText: Colors.white,
                        onTap: () async{
                          if (taikhoan.text.isNotEmpty && matkhau.text.isNotEmpty) {
                            setState(() {
                              loading4 = true;
                            });
                            parseData(taikhoan.text.toString());
                            List<EtaxData> list = [];
                            for(int i = 0 ; i < parsedData.length ; i++) {
                              EtaxData data = EtaxData(
                                  matochuc: parsedData[i][0],
                                  tentochuc: parsedData[i][1],
                                  thunhapchiuthue: double.parse(parsedData[i][2]),
                                  giamtrugiacanh: double.parse(parsedData[i][4]),
                                  tuthien: double.parse(parsedData[i][5]),
                                  baohiem: double.parse(parsedData[i][6]),
                                  huutri: double.parse(parsedData[i][7]),
                                  thuakhautru: double.parse(parsedData[i][8]),
                                  year: parsedData[i][9],
                                  npt: double.parse(parsedData[i][3]),
                              );
                              list.add(data);
                            }
                            await pushData3(matkhau.text.toString(), list);
                            setState(() {
                              loading4 = false;
                            });
                          } else {
                            toastMessage('Nhập đủ thông tin');
                          }

                        }, loading: loading4,
                      ),
                    ),

                    Container(height: 100,)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
