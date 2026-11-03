import 'dart:convert';

import 'package:ChernPetHospital/app.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class visitdetail extends StatefulWidget {
  final String VisitID, PetID;

  const visitdetail({Key? key, required this.VisitID, required this.PetID})
    : super(key: key);

  // const visitdetail({super.key});

  @override
  State<visitdetail> createState() => _visitdetailState();
}

class _visitdetailState extends State<visitdetail> {
  String _visithead = "";
  String _visitdetail = "";
  String _v_tx = "";
  String _v_lab = "";
  String _v_product = "";
  String _v_rx = "";
  String _v_admit = "";
  String _v_grm = "";
  String _v_daycare = "";

  List Lst_visit = [];
  List Lst_visitdetail = [];

  Future<void> _loadVisit() async {
    String url = "${root_url}selecthisvisit.php";

    final Response = await http.post(
      Uri.parse(url),

      body: {'visit_id': widget.VisitID, 'pet_id': widget.PetID},
    );

    if (Response.statusCode == 200) {
      setState(() {
        Lst_visit = json.decode(Response.body);

        for (int i = 0; i < Lst_visit.length; i++) {
          _visithead =
              'Visit Date: ' +
              Lst_visit[i]["visit_date"] +
              '  Doctor: ' +
              Lst_visit[i]["doctor"] +
              '\n' +
              'Age: ' +
              Lst_visit[i]["pet_age_y"] +
              'y ' +
              Lst_visit[i]["pet_age_m"] +
              'm ' +
              Lst_visit[i]["pet_age_m"] +
              'd   Weight: ' +
              Lst_visit[i]["pet_weight"] +
              ' k.g.  Temperature: ' +
              Lst_visit[i]["pet_temp"] +
              ' F \n' +
              'CC: ' +
              Lst_visit[i]["pet_cc"] +
              '\n' +
              'Hx: ' +
              Lst_visit[i]["pet_hx"] +
              '\n' +
              'PE: ' +
              Lst_visit[i]["pet_pe"] +
              '\n' +
              'Dx: ' +
              Lst_visit[i]["pet_dx"] +
              '\n'
                  'FU: ' +
              Lst_visit[i]["pet_fu"] +
              '\n';
        }
      });
    }
  }

  Future<void> _loadVisitDetail() async {
    String url = "${root_url}selecthisvisitdetail.php";

    final Response = await http.post(
      Uri.parse(url),

      body: {'visit_id': widget.VisitID, 'pet_id': widget.PetID},
    );

    if (Response.statusCode == 200) {
      setState(() {
        Lst_visitdetail = json.decode(Response.body);

        for (int i = 0; i < Lst_visitdetail.length; i++) {
          if (Lst_visitdetail[i]["product_group"] == 'ผ่าตัด' ||
              Lst_visitdetail[i]["product_group"] == 'ขูดหินปูน' ||
              Lst_visitdetail[i]["product_group"] == 'ทำแผล') {
            _v_tx =
                _v_tx +
                //     'Tx: ' +
                Lst_visitdetail[i]["product_bname"] +
                ' Comment: ' +
                Lst_visitdetail[i]["comment"] +
                '\n';
          } else if (Lst_visitdetail[i]["product_group"] == 'การตรวจเทส') {
            _v_lab =
                _v_lab +
                //      'Lab: ' +
                Lst_visitdetail[i]["product_bname"] +
                ' Result: ' +
                Lst_visitdetail[i]["comment"] +
                '\n';
          } else if (Lst_visitdetail[i]["product_group"] == 'เพ็ทช็อป' ||
              Lst_visitdetail[i]["product_group"] == 'อุปกรณ์การแพทย์' ||
              Lst_visitdetail[i]["product_group"] == 'Towสุนัข' ||
              Lst_visitdetail[i]["product_group"] == 'Towแมว' ||
              Lst_visitdetail[i]["product_group"] == 'Hillสุนัข' ||
              Lst_visitdetail[i]["product_group"] == 'Hillแมว' ||
              Lst_visitdetail[i]["product_group"] == 'Hillรักษาโรคสุนัข' ||
              Lst_visitdetail[i]["product_group"] == 'Hillรักษาโรคแมว' ||
              Lst_visitdetail[i]["product_group"] == 'RC VDสุนัข' ||
              Lst_visitdetail[i]["product_group"] == 'RC VDแมว' ||
              Lst_visitdetail[i]["product_group"] == 'RC VCNสุนัข' ||
              Lst_visitdetail[i]["product_group"] == 'RC VCNแมว' ||
              Lst_visitdetail[i]["product_group"] == 'RC Pet shopสุนัข' ||
              Lst_visitdetail[i]["product_group"] == 'RC Pet shopแมว' ||
              Lst_visitdetail[i]["product_group"] == 'Bakery' ||
              Lst_visitdetail[i]["product_group"] == 'Frozen' ||
              Lst_visitdetail[i]["product_group"] == 'LUK IMM' ||
              Lst_visitdetail[i]["product_group"] == 'Snack' ||
              Lst_visitdetail[i]["product_group"] == 'Canagan' ||
              Lst_visitdetail[i]["product_group"] == 'Orijen' ||
              Lst_visitdetail[i]["product_group"] == 'วัสดุสิ้นเปลือง' ||
              Lst_visitdetail[i]["product_group"] == 'Bakery&Drink') {
            _v_product =
                _v_product +
                //    'Product: ' +
                Lst_visitdetail[i]["product_bname"] +
                ' Value: ' +
                Lst_visitdetail[i]["product_value"] +
                '\n';
          } else if (Lst_visitdetail[i]["product_group"] == 'ยากิน' ||
              Lst_visitdetail[i]["product_group"] == 'ยาฉีด' ||
              Lst_visitdetail[i]["product_group"] == 'ยาใช้ภายนอก' ||
              Lst_visitdetail[i]["product_group"] == 'ยากลุ่มExtoparasite') {
            _v_rx =
                _v_rx +
                //     'Rx: ' +
                Lst_visitdetail[i]["product_bname"] +
                ' Value: ' +
                Lst_visitdetail[i]["product_value"] +
                ' Comment: ' +
                Lst_visitdetail[i]["comment"] +
                '\n';
          } else if (Lst_visitdetail[i]["product_group"] == 'แอดมิท') {
            _v_admit =
                _v_admit +
                //   'Admit: ' +
                Lst_visitdetail[i]["product_bname"] +
                ' Date: ' +
                Lst_visitdetail[i]["date_cure"] +
                ' Doctor: ' +
                Lst_visitdetail[i]["comment"] +
                '\n';
          } else if (Lst_visitdetail[i]["product_group"] == 'อาบน้ำตัดขน') {
            _v_grm =
                _v_grm +
                //        'Grooming: ' +
                Lst_visitdetail[i]["product_bname"] +
                ' Comment: ' +
                Lst_visitdetail[i]["comment"] +
                '\n';
          } else if (Lst_visitdetail[i]["product_group"] == 'ฝากเลี้ยง') {
            _v_daycare =
                _v_daycare +
                //     'Daycare: ' +
                Lst_visitdetail[i]["product_bname"] +
                ' Comment: ' +
                Lst_visitdetail[i]["comment"] +
                '\n';
          }
        }

        if (_v_tx != '') {
          _v_tx = 'Tx: \n' + _v_tx + '\n';
        }

        if (_v_lab != '') {
          _v_lab = 'Lab: \n' + _v_lab + '\n';
        }

        if (_v_product != '') {
          _v_product = 'Product: \n' + _v_product + '\n';
        }

        if (_v_rx != '') {
          _v_rx = 'Rx: \n' + _v_rx + '\n';
        }

        if (_v_admit != '') {
          _v_admit = 'Admit: \n' + _v_admit + '\n';
        }

        if (_v_grm != '') {
          _v_grm = 'Grooming: \n' + _v_grm + '\n';
        }

        if (_v_daycare != '') {
          _v_daycare = 'Daycare: \n' + _v_daycare + '\n';
        }

        _visitdetail =
            _visitdetail +
            _v_tx +
            _v_lab +
            _v_product +
            _v_rx +
            _v_admit +
            _v_grm +
            _v_daycare;
      });
    }
  }

  void initState() {
    super.initState();
    _loadVisit();
    _loadVisitDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          "Medical Record",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        actions: const [],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bkbg.png"),
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 5),
            Expanded(
              child: Container(
                width: double.infinity,
                child: Card(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [Text(_visithead + '\n' + _visitdetail)],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
