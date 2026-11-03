import 'package:ChernPetHospital/model/countstock_class.dart';
import 'package:ChernPetHospital/screens/login_form.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

List glo_Lst_user_authorize = [];
String root_url = "http://10.0.2.2:8080/chernphp/";
bool isFolded = false;
DateTime glo_datetime = DateTime.now();
DateTime glo_datetime2 = DateTime.now();
String glo_branchid = '';
String glo_username = '';
String glo_branchstock = '';
List<product_class> glo_tempcount = [];
List<Map<String, dynamic>> glo_tempcountmaps = [];
List glo_netsale = [];
//NumberFormat glo_format_currency = NumberFormat.decimalPattern();
NumberFormat glo_format_currency = NumberFormat('#,##0.00', 'en_US');
Color glo_colortheme = Color.fromARGB(255, 46, 212, 241);

//"http://127.0.0.1:8080/chernphp/";  //Chrome
//"http://10.0.2.2:8080/chernphp/"; //Emulator
//"http://192.168.1.39:8080/chernphp/"; //Real Device
//"http://moryapharmacy.co.th:8003/morya/"; //Host

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    isFolded = MediaQuery.of(context).size.width >= 550; //True

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: glo_colortheme,
          brightness: Brightness.light,
        ),
      ),
      home: const login(),
    );
  }
}
