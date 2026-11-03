import 'dart:convert';
import 'dart:io';

import 'package:ChernPetHospital/screens/edit_product.dart';
import 'package:ChernPetHospital/screens/scan_product_form.dart';
import 'package:ChernPetHospital/widget/button_style.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:ChernPetHospital/app.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';

class new_product extends StatefulWidget {
  const new_product({super.key});

  @override
  State<new_product> createState() => _new_product();
}

class _new_product extends State<new_product> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController c_new_product_id = TextEditingController();
  TextEditingController c_new_product_barcode = TextEditingController();
  TextEditingController c_new_product_bname = TextEditingController();
  TextEditingController c_new_product_unit_name = TextEditingController();
  TextEditingController c_new_product_type = TextEditingController();
  TextEditingController c_new_product_sale_price = TextEditingController();
  TextEditingController c_new_product_sale_price2 = TextEditingController();
  TextEditingController c_new_product_sale_price3 = TextEditingController();
  TextEditingController c_new_product_sale_price4 = TextEditingController();
  TextEditingController c_new_product_sale_price5 = TextEditingController();
  TextEditingController c_new_product_sale_price_PD = TextEditingController();
  TextEditingController c_new_product_sale_price2_PD = TextEditingController();
  TextEditingController c_new_product_sale_price3_PD = TextEditingController();
  TextEditingController c_new_product_sale_price4_PD = TextEditingController();
  TextEditingController c_new_product_sale_price5_PD = TextEditingController();
  TextEditingController c_new_product_sale_price_BML = TextEditingController();
  TextEditingController c_new_product_sale_price2_BML = TextEditingController();
  TextEditingController c_new_product_sale_price3_BML = TextEditingController();
  TextEditingController c_new_product_sale_price4_BML = TextEditingController();
  TextEditingController c_new_product_sale_price5_BML = TextEditingController();
  TextEditingController c_new_product_hire = TextEditingController();
  TextEditingController c_new_product_percent = TextEditingController();

  FocusNode myFocusNode = FocusNode();

  List Lst_searchproduct = [];
  String? _selectedProUnit;
  String? _selectedProType;
  List Lst_productunit = [];
  List Lst_producttype = [
    'ยากิน',
    'ยาฉีด',
    'ยาใช้ภายนอก',
    'ยากลุ่มExtoparasite',
    'เพ็ทช็อป',
    'อุปกรณ์การแพทย์',
    'อาบน้ำตัดขน',
    'ฝากเลี้ยง',
    'แอดมิท',
    'การตรวจเทส',
    'ผ่าตัด',
    'ขูดหินปูน',
    'ทำแผล',
    'Towสุนัข',
    'Towแมว',
    'Hillสุนัข',
    'Hillแมว',
    'Hillรักษาโรคสุนัข',
    'Hillรักษาโรคแมว',
    'RC Pet shopสุนัข',
    'RC Pet shopแมว',
    'RC VCNสุนัข',
    'RC VCNแมว',
    'RC VDสุนัข',
    'RC VDแมว',
    'Bakery',
    'Frozen',
    'LUK IMM',
    'Snack',
    'Canagan',
    'Orijen',
    'วัสดุสิ้นเปลือง',
    'Bakery&Drink',
  ];
  //List<String> Lst_EditPro = [];

  File? _FileImage;
  final _pickImage = ImagePicker();
  bool _GetImage = false;
  bool _ReadType = true;
  Color _ColorPro = Colors.black;
  List<int> Lst_Bytesimage = [];
  String? _StrImage;
  String _ProImageNetwork = '';

  @override
  void initState() {
    super.initState();
    _loadProductUnit();
  }

  Future<void> _loadProductUnit() async {
    String url = "${root_url}selectproductunit.php";

    final Response = await http.get(Uri.parse(url));
    if (Response.statusCode == 200) {
      setState(() {
        Lst_productunit = json.decode(Response.body);
      });
    }
  }

  Future saveNewProToDatabase() async {
    String url = "${root_url}savenewproduct.php";
    String c_type = "";

    if (c_new_product_type.text == 'ยากิน') {
      c_type = 'RX';
    } else if (c_new_product_type.text == 'ยาฉีด') {
      c_type = 'IN';
    } else if (c_new_product_type.text == 'ยาใช้ภายนอก') {
      c_type = 'ED';
    } else if (c_new_product_type.text == 'ยากลุ่มExtoparasite') {
      c_type = 'EX';
    } else if (c_new_product_type.text == 'เพ็ทช็อป') {
      c_type = 'PS';
    } else if (c_new_product_type.text == 'อุปกรณ์การแพทย์') {
      c_type = 'ME';
    } else if (c_new_product_type.text == 'อาบน้ำตัดขน') {
      c_type = 'GM';
    } else if (c_new_product_type.text == 'ฝากเลี้ยง') {
      c_type = 'DC';
    } else if (c_new_product_type.text == 'แอดมิท') {
      c_type = 'AD';
    } else if (c_new_product_type.text == 'การตรวจเทส') {
      c_type = 'LB';
    } else if (c_new_product_type.text == 'ผ่าตัด') {
      c_type = 'OP';
    } else if (c_new_product_type.text == 'ขูดหินปูน') {
      c_type = 'SL';
    } else if (c_new_product_type.text == 'ทำแผล') {
      c_type = 'WD';
    } else if (c_new_product_type.text == 'Towสุนัข') {
      c_type = 'TWC';
    } else if (c_new_product_type.text == 'Towแมว') {
      c_type = 'TWF';
    } else if (c_new_product_type.text == 'Hillสุนัข') {
      c_type = 'HSC';
    } else if (c_new_product_type.text == 'Hillแมว') {
      c_type = 'HSF';
    } else if (c_new_product_type.text == 'Hillรักษาโรคสุนัข') {
      c_type = 'HPC';
    } else if (c_new_product_type.text == 'Hillรักษาโรคแมว') {
      c_type = 'HPF';
    } else if (c_new_product_type.text == 'RC Pet shopสุนัข') {
      c_type = 'POSC';
    } else if (c_new_product_type.text == 'RC Pet shopแมว') {
      c_type = 'POSF';
    } else if (c_new_product_type.text == 'RC VCNสุนัข') {
      c_type = 'VCNC';
    } else if (c_new_product_type.text == 'RC VCNแมว') {
      c_type = 'VCNF';
    } else if (c_new_product_type.text == 'RC VDสุนัข') {
      c_type = 'VDC';
    } else if (c_new_product_type.text == 'RC VDแมว') {
      c_type = 'VDF';
    } else if (c_new_product_type.text == 'Bakery') {
      c_type = 'BK';
    } else if (c_new_product_type.text == 'Frozen') {
      c_type = 'FZ';
    } else if (c_new_product_type.text == 'LUK IMM') {
      c_type = 'LI';
    } else if (c_new_product_type.text == 'Snack') {
      c_type = 'SN';
    } else if (c_new_product_type.text == 'Canagan') {
      c_type = 'CA';
    } else if (c_new_product_type.text == 'Orijen') {
      c_type = 'OR';
    } else if (c_new_product_type.text == 'วัสดุสิ้นเปลือง') {
      c_type = 'CS';
    } else if (c_new_product_type.text == 'Bakery&Drink') {
      c_type = 'BD';
    }

    try {
      final Response = await http.post(
        Uri.parse(url),

        body: {
          'c_new_product_id': c_new_product_id.text,
          'c_new_product_barcode': c_new_product_barcode.text,
          'c_new_product_bname': c_new_product_bname.text,
          'c_new_product_unit_name': c_new_product_unit_name.text,
          'c_new_product_type': c_type,
          'c_new_product_sale_price': c_new_product_sale_price.text,
          'c_new_product_sale_price2': c_new_product_sale_price2.text,
          'c_new_product_sale_price3': c_new_product_sale_price3.text,
          'c_new_product_sale_price4': c_new_product_sale_price4.text,
          'c_new_product_sale_price5': c_new_product_sale_price5.text,
          'c_new_product_sale_price_PD': c_new_product_sale_price_PD.text,
          'c_new_product_sale_price2_PD': c_new_product_sale_price2_PD.text,
          'c_new_product_sale_price3_PD': c_new_product_sale_price3_PD.text,
          'c_new_product_sale_price4_PD': c_new_product_sale_price4_PD.text,
          'c_new_product_sale_price5_PD': c_new_product_sale_price5_PD.text,
          'c_new_product_sale_price_BML': c_new_product_sale_price_BML.text,
          'c_new_product_sale_price2_BML': c_new_product_sale_price2_BML.text,
          'c_new_product_sale_price3_BML': c_new_product_sale_price3_BML.text,
          'c_new_product_sale_price4_BML': c_new_product_sale_price4_BML.text,
          'c_new_product_sale_price5_BML': c_new_product_sale_price5_BML.text,
          'c_new_product_hire': c_new_product_hire.text,
        },
      );

      if (Response.statusCode == 200) {
        if (_GetImage == true) {
          uploadImageToPathServer();
          // uploadImageToDBServer();
        }

        json.decode(Response.body);
        //   if (data == "InsertComplete") {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("BKAPP"),
            content: const Text("Save!!"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
                child: const Text("OK"),
              ),
            ],
          ),
        );

        clearform();
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: Text(
                'Failed to Save data. Status code: ${Response.statusCode}',
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      //   print('Error saving list: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Network Error'),
            content: Text('An error occurred: $e'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  clearform() {
    setState(() {
      _formKey.currentState?.reset();
      c_new_product_id.clear();
      _selectedProType = null;
      c_new_product_barcode.clear();
      c_new_product_bname.clear();
      _selectedProUnit = null;
      c_new_product_unit_name.clear();
      c_new_product_sale_price.clear();
      c_new_product_sale_price2.clear();
      c_new_product_sale_price3.clear();
      c_new_product_sale_price4.clear();
      c_new_product_sale_price5.clear();
      c_new_product_sale_price_PD.clear();
      c_new_product_sale_price2_PD.clear();
      c_new_product_sale_price3_PD.clear();
      c_new_product_sale_price4_PD.clear();
      c_new_product_sale_price5_PD.clear();
      c_new_product_sale_price_BML.clear();
      c_new_product_sale_price2_BML.clear();
      c_new_product_sale_price3_BML.clear();
      c_new_product_sale_price4_BML.clear();
      c_new_product_sale_price5_BML.clear();
      c_new_product_hire.clear();
      c_new_product_percent.clear();
      _FileImage = null;
      _ProImageNetwork = '';
      _GetImage = false;
      _ReadType = true;
      _ColorPro = Colors.black;
    });
  }

  Future<void> _loadMaxProduct() async {
    String url = "${root_url}selectmaxproduct.php";
    String tempformat = "";
    String proid_get = "";
    int proid_pos;
    int proid_max;

    if (_selectedProType == 'ยากิน') {
      tempformat = 'RX-';
    } else if (_selectedProType == 'ยาฉีด') {
      tempformat = 'IN-';
    } else if (_selectedProType == 'ยาใช้ภายนอก') {
      tempformat = 'ED-';
    } else if (_selectedProType == 'ยากลุ่มExtoparasite') {
      tempformat = 'EX-';
    } else if (_selectedProType == 'เพ็ทช็อป') {
      tempformat = 'PS-';
    } else if (_selectedProType == 'อุปกรณ์การแพทย์') {
      tempformat = 'ME-';
    } else if (_selectedProType == 'อาบน้ำตัดขน') {
      tempformat = 'GM-';
    } else if (_selectedProType == 'ฝากเลี้ยง') {
      tempformat = 'DC-';
    } else if (_selectedProType == 'แอดมิท') {
      tempformat = 'AD-';
    } else if (_selectedProType == 'การตรวจเทส') {
      tempformat = 'LB-';
    } else if (_selectedProType == 'ผ่าตัด') {
      tempformat = 'OP-';
    } else if (_selectedProType == 'ขูดหินปูน') {
      tempformat = 'SL-';
    } else if (_selectedProType == 'ทำแผล') {
      tempformat = 'WD-';
    } else if (_selectedProType == 'Towสุนัข') {
      tempformat = 'TWC-';
    } else if (_selectedProType == 'Towแมว') {
      tempformat = 'TWF-';
    } else if (_selectedProType == 'Hillสุนัข') {
      tempformat = 'HSC-';
    } else if (_selectedProType == 'Hillแมว') {
      tempformat = 'HSF-';
    } else if (_selectedProType == 'Hillรักษาโรคสุนัข') {
      tempformat = 'HPC-';
    } else if (_selectedProType == 'Hillรักษาโรคแมว') {
      tempformat = 'HPF-';
    } else if (_selectedProType == 'RC Pet shopสุนัข') {
      tempformat = 'POSC-';
    } else if (_selectedProType == 'RC Pet shopแมว') {
      tempformat = 'POSF-';
    } else if (_selectedProType == 'RC VCNสุนัข') {
      tempformat = 'VCNC-';
    } else if (_selectedProType == 'RC VCNแมว') {
      tempformat = 'VCNF-';
    } else if (_selectedProType == 'RC VDสุนัข') {
      tempformat = 'VDC-';
    } else if (_selectedProType == 'RC VDแมว') {
      tempformat = 'VDF-';
    } else if (_selectedProType == 'Bakery') {
      tempformat = 'BK-';
    } else if (_selectedProType == 'Frozen') {
      tempformat = 'FZ-';
    } else if (_selectedProType == 'LUK IMM') {
      tempformat = 'LI-';
    } else if (_selectedProType == 'Snack') {
      tempformat = 'SN-';
    } else if (_selectedProType == 'Canagan') {
      tempformat = 'CA-';
    } else if (_selectedProType == 'Orijen') {
      tempformat = 'OR-';
    } else if (_selectedProType == 'วัสดุสิ้นเปลือง') {
      tempformat = 'CS-';
    } else if (_selectedProType == 'Bakery&Drink') {
      tempformat = 'BD-';
    }

    final Response = await http.post(
      Uri.parse(url),
      body: {'tempformat': tempformat},
    );

    var data = json.decode(Response.body);
    if (data != null) {
      proid_get = data;
      proid_pos = proid_get.indexOf('-') + 1;
      proid_max = int.parse(proid_get.substring(proid_pos, proid_pos + 5)) + 1;
      c_new_product_id.text = tempformat + proid_max.toString().padLeft(5, '0');
    } else {
      c_new_product_id.text = tempformat + '00001';
    }
  }

  pickGallery() async {
    final PickedFile = await _pickImage.pickImage(
      source: ImageSource.gallery,
      maxWidth: 450,
      maxHeight: 550,
      imageQuality: 70,
    );
    if (PickedFile != null) {
      File rotatedImage = await FlutterExifRotation.rotateImage(
        path: PickedFile.path,
      );
      _FileImage = rotatedImage;
      //File(PickedFile.path);
      _GetImage = true;

      Lst_Bytesimage = await PickedFile.readAsBytes();
      _StrImage = base64Encode(Lst_Bytesimage);

      setState(() {});
    }
  }

  pickCamera() async {
    final PickedFile = await _pickImage.pickImage(
      source: ImageSource.camera,
      maxWidth: 450,
      maxHeight: 550,
      imageQuality: 70,
    );
    if (PickedFile != null) {
      File rotatedImage = await FlutterExifRotation.rotateImage(
        path: PickedFile.path,
      );
      _FileImage = rotatedImage;
      //File(PickedFile.path);
      _GetImage = true;

      Lst_Bytesimage = await PickedFile.readAsBytes();
      _StrImage = base64Encode(Lst_Bytesimage);
      setState(() {});
    }
  }

  Future uploadImageToPathServer() async {
    String url = "${root_url}uploadimagepath.php";
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(
      await http.MultipartFile.fromPath(
        'image',
        _FileImage!.path,
        filename: c_new_product_id.text + '.jpg',
      ),
    );

    var response = await request.send();

    if (response.statusCode == 200) {
      print('Image uploaded successfully!');
    } else {
      print('Image upload failed with status: ${response.statusCode}');
    }
  }

  Future<void> uploadImageToDBServer() async {
    String url = "${root_url}uploadimagedb.php";
    var response = await http.post(
      Uri.parse(url),
      body: {'image': _StrImage, 'c_new_product_id': c_new_product_id.text},
    );

    if (response.statusCode == 200) {
      print('Image uploaded successfully');
    } else {
      print('Image upload failed: ${response.statusCode}');
    }
  }

  bool _ReadOnlyAuth() {
    if (glo_Lst_user_authorize[0]["user_authorize"][1] == "1") {
      return false;
    } else {
      return true;
    }
  }

  bool _ObscureAuth() {
    if (glo_Lst_user_authorize[0]["user_authorize"][1] == "1") {
      return false;
    } else {
      return true;
    }
  }

  /////////Show
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          "New Product",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/bkbg.png"),
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
            child: Column(
              children: [
                Card(
                  margin: EdgeInsets.all(10.0),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(
                          width: 350,
                          child: TextFormField(
                            readOnly: true,
                            style: TextStyle(color: _ColorPro),
                            focusNode: myFocusNode,
                            maxLength: 7,
                            obscureText: false,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Product ID',
                              counterText: '',
                              suffixIcon: IconButton(
                                icon: const Icon(
                                  Icons.edit_document,
                                  color: Color.fromARGB(255, 46, 212, 241),
                                ),
                                onPressed: () async {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Processing Data'),
                                    ),
                                  );

                                  final List<String>? Lst_EditPro =
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return const edit_product();
                                          },
                                        ),
                                      );
                                  if (Lst_EditPro != null) {
                                    c_new_product_id.text = Lst_EditPro[0];
                                    c_new_product_barcode.text = Lst_EditPro[1];
                                    c_new_product_bname.text = Lst_EditPro[2];

                                    c_new_product_sale_price.text =
                                        Lst_EditPro[5];
                                    c_new_product_sale_price2.text =
                                        Lst_EditPro[6];
                                    c_new_product_sale_price3.text =
                                        Lst_EditPro[7];
                                    c_new_product_sale_price4.text =
                                        Lst_EditPro[8];
                                    c_new_product_sale_price5.text =
                                        Lst_EditPro[9];
                                    c_new_product_sale_price_PD.text =
                                        Lst_EditPro[10];
                                    c_new_product_sale_price2_PD.text =
                                        Lst_EditPro[11];
                                    c_new_product_sale_price3_PD.text =
                                        Lst_EditPro[12];
                                    c_new_product_sale_price4_PD.text =
                                        Lst_EditPro[13];
                                    c_new_product_sale_price5_PD.text =
                                        Lst_EditPro[14];
                                    c_new_product_sale_price_BML.text =
                                        Lst_EditPro[15];
                                    c_new_product_sale_price2_BML.text =
                                        Lst_EditPro[16];
                                    c_new_product_sale_price3_BML.text =
                                        Lst_EditPro[17];
                                    c_new_product_sale_price4_BML.text =
                                        Lst_EditPro[18];
                                    c_new_product_sale_price5_BML.text =
                                        Lst_EditPro[19];
                                    c_new_product_hire.text = Lst_EditPro[20];
                                    _ProImageNetwork = Lst_EditPro[21];

                                    _GetImage = false;

                                    c_new_product_percent.text =
                                        (100 -
                                                ((double.parse(
                                                          c_new_product_sale_price5
                                                              .text,
                                                        ) /
                                                        double.parse(
                                                          c_new_product_sale_price
                                                              .text,
                                                        )) *
                                                    100))
                                            .toString();

                                    setState(() {
                                      _selectedProUnit = Lst_EditPro[3];

                                      c_new_product_unit_name.text =
                                          _selectedProUnit!;

                                      if (Lst_EditPro[4] == 'RX') {
                                        _selectedProType = 'ยากิน';
                                      } else if (Lst_EditPro[4] == 'IN') {
                                        _selectedProType = 'ยาฉีด';
                                      } else if (Lst_EditPro[4] == 'ED') {
                                        _selectedProType = 'ยาใช้ภายนอก';
                                      } else if (Lst_EditPro[4] == 'EX') {
                                        _selectedProType =
                                            'ยากลุ่มExtoparasite';
                                      } else if (Lst_EditPro[4] == 'PS') {
                                        _selectedProType = 'เพ็ทช็อป';
                                      } else if (Lst_EditPro[4] == 'ME') {
                                        _selectedProType = 'อุปกรณ์การแพทย์';
                                      } else if (Lst_EditPro[4] == 'GM') {
                                        _selectedProType = 'อาบน้ำตัดขน';
                                      } else if (Lst_EditPro[4] == 'DC') {
                                        _selectedProType = 'ฝากเลี้ยง';
                                      } else if (Lst_EditPro[4] == 'AD') {
                                        _selectedProType = 'แอดมิท';
                                      } else if (Lst_EditPro[4] == 'LB') {
                                        _selectedProType = 'การตรวจเทส';
                                      } else if (Lst_EditPro[4] == 'OP') {
                                        _selectedProType = 'ผ่าตัด';
                                      } else if (Lst_EditPro[4] == 'SL') {
                                        _selectedProType = 'ขูดหินปูน';
                                      } else if (Lst_EditPro[4] == 'WD') {
                                        _selectedProType = 'ทำแผล';
                                      } else if (Lst_EditPro[4] == 'TWC') {
                                        _selectedProType = 'Towสุนัข';
                                      } else if (Lst_EditPro[4] == 'TWF') {
                                        _selectedProType = 'Towแมว';
                                      } else if (Lst_EditPro[4] == 'HSC') {
                                        _selectedProType = 'Hillสุนัข';
                                      } else if (Lst_EditPro[4] == 'HSF') {
                                        _selectedProType = 'Hillแมว';
                                      } else if (Lst_EditPro[4] == 'HPC') {
                                        _selectedProType = 'Hillรักษาโรคสุนัข';
                                      } else if (Lst_EditPro[4] == 'HPF') {
                                        _selectedProType = 'Hillรักษาโรคแมว';
                                      } else if (Lst_EditPro[4] == 'POSC') {
                                        _selectedProType = 'RC Pet shopสุนัข';
                                      } else if (Lst_EditPro[4] == 'POSF') {
                                        _selectedProType = 'RC Pet shopแมว';
                                      } else if (Lst_EditPro[4] == 'VCNC') {
                                        _selectedProType = 'RC VCNสุนัข';
                                      } else if (Lst_EditPro[4] == 'VCNF') {
                                        _selectedProType = 'RC VCNแมว';
                                      } else if (Lst_EditPro[4] == 'VDC') {
                                        _selectedProType = 'RC VDสุนัข';
                                      } else if (Lst_EditPro[4] == 'VDF') {
                                        _selectedProType = 'RC VDแมว';
                                      } else if (Lst_EditPro[4] == 'BK') {
                                        _selectedProType = 'Bakery';
                                      } else if (Lst_EditPro[4] == 'FZ') {
                                        _selectedProType = 'Frozen';
                                      } else if (Lst_EditPro[4] == 'LI') {
                                        _selectedProType = 'LUK IMM';
                                      } else if (Lst_EditPro[4] == 'SN') {
                                        _selectedProType = 'Snack';
                                      } else if (Lst_EditPro[4] == 'CA') {
                                        _selectedProType = 'Canagan';
                                      } else if (Lst_EditPro[4] == 'OR') {
                                        _selectedProType = 'Orijen';
                                      } else if (Lst_EditPro[4] == 'CS') {
                                        _selectedProType = 'วัสดุสิ้นเปลือง';
                                      } else if (Lst_EditPro[4] == 'BD') {
                                        _selectedProType = 'Bakery&Drink';
                                      }

                                      c_new_product_type.text =
                                          _selectedProType!;

                                      _FileImage = null;

                                      _ReadType = false;
                                      _ColorPro = Colors.red;
                                    });
                                  }
                                },
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              } else if (value.length < 5) {
                                return 'Text must be at least 5 characters long';
                              }
                              {
                                return null;
                              }
                            },
                            controller: c_new_product_id,
                          ),
                        ),

                        const SizedBox(height: 10),

                        SizedBox(
                          width: 350,
                          child: DropdownSearch<String>(
                            enabled: _ReadType,
                            selectedItem: _selectedProType,

                            popupProps: PopupProps.menu(showSearchBox: false),
                            decoratorProps: DropDownDecoratorProps(
                              baseStyle: TextStyle(color: _ColorPro),
                              decoration: InputDecoration(
                                labelText: 'Product Type',
                                //    labelStyle: TextStyle(color: _ColorPro),
                                border: OutlineInputBorder(),
                              ),
                            ),
                            items: (filter, infiniteScrollProps) =>
                                Lst_producttype.cast<String>(),
                            onChanged: (value) {
                              setState(() {
                                _selectedProType = value;
                                _loadMaxProduct();
                              });
                            },

                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select menu';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: 350,
                          child: TextFormField(
                            obscureText: false,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: 'Product Barcode',
                              suffixIcon: IconButton(
                                icon: const Icon(
                                  Icons.qr_code_scanner,
                                  color: Color.fromARGB(255, 46, 212, 241),
                                ),
                                onPressed: () async {
                                  final qrCode = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return const scan_product();
                                      },
                                    ),
                                  );
                                  if (qrCode != null) {
                                    c_new_product_barcode.text = qrCode
                                        .toString();
                                  }
                                },
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              } else {
                                return null;
                              }
                            },
                            controller: c_new_product_barcode,
                          ),
                        ),

                        const SizedBox(height: 10),

                        SizedBox(
                          width: 350,
                          child: TextFormField(
                            obscureText: false,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Product Name',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              } else {
                                return null;
                              }
                            },
                            controller: c_new_product_bname,
                          ),
                        ),

                        const SizedBox(height: 10),

                        SizedBox(
                          width: 350,
                          child: DropdownSearch<String>(
                            selectedItem: _selectedProUnit,

                            popupProps: PopupProps.menu(
                              showSearchBox: false, // Enable search field
                              // searchFieldProps: TextFieldProps(
                              //   controller:
                              //       c_new_product_unit_name,
                              // ),
                            ),

                            decoratorProps: DropDownDecoratorProps(
                              decoration: InputDecoration(
                                labelText: 'Product Unit',
                                border: OutlineInputBorder(),
                              ),
                            ),
                            items: (filter, infiniteScrollProps) =>
                                Lst_productunit.cast<String>(),
                            onChanged: (value) {
                              setState(() {
                                _selectedProUnit = value;
                              });
                            },

                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select menu';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),

                        const SizedBox(height: 10),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 114,
                                      child: TextFormField(
                                        readOnly: _ReadOnlyAuth(),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly, // Allow only digits
                                        ],
                                        obscureText: _ObscureAuth(),
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Price 1',
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter some number';
                                          } else {
                                            return null;
                                          }
                                        },
                                        controller: c_new_product_sale_price,
                                      ),
                                    ),

                                    const SizedBox(width: 2),
                                    SizedBox(
                                      width: 114,
                                      child: TextFormField(
                                        readOnly: _ReadOnlyAuth(),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly, // Allow only digits
                                        ],
                                        obscureText: _ObscureAuth(),
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Price 1 PD',
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter some number';
                                          } else {
                                            return null;
                                          }
                                        },
                                        controller: c_new_product_sale_price_PD,
                                      ),
                                    ),
                                    const SizedBox(width: 2),
                                    SizedBox(
                                      width: 114,
                                      child: TextFormField(
                                        readOnly: _ReadOnlyAuth(),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly, // Allow only digits
                                        ],
                                        obscureText: _ObscureAuth(),
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Price 1 BML',
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter some number';
                                          } else {
                                            return null;
                                          }
                                        },
                                        controller:
                                            c_new_product_sale_price_BML,
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 10),

                                Row(
                                  children: [
                                    SizedBox(
                                      width: 114,
                                      child: TextFormField(
                                        readOnly: _ReadOnlyAuth(),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly, // Allow only digits
                                        ],
                                        obscureText: _ObscureAuth(),
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Price 2',
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter some number';
                                          } else {
                                            return null;
                                          }
                                        },
                                        controller: c_new_product_sale_price2,
                                      ),
                                    ),

                                    const SizedBox(width: 2),

                                    SizedBox(
                                      width: 114,
                                      child: TextFormField(
                                        readOnly: _ReadOnlyAuth(),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly, // Allow only digits
                                        ],
                                        obscureText: _ObscureAuth(),
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Price 2 PD',
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter some number';
                                          } else {
                                            return null;
                                          }
                                        },
                                        controller:
                                            c_new_product_sale_price2_PD,
                                      ),
                                    ),

                                    const SizedBox(width: 2),

                                    SizedBox(
                                      width: 114,
                                      child: TextFormField(
                                        readOnly: _ReadOnlyAuth(),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly, // Allow only digits
                                        ],
                                        obscureText: _ObscureAuth(),
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Price 2 BML',
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter some number';
                                          } else {
                                            return null;
                                          }
                                        },
                                        controller:
                                            c_new_product_sale_price2_BML,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),

                                Row(
                                  children: [
                                    SizedBox(
                                      width: 114,
                                      child: TextFormField(
                                        readOnly: _ReadOnlyAuth(),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly, // Allow only digits
                                        ],
                                        obscureText: _ObscureAuth(),
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Price 3',
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter some number';
                                          } else {
                                            return null;
                                          }
                                        },
                                        controller: c_new_product_sale_price3,
                                      ),
                                    ),

                                    const SizedBox(width: 2),

                                    SizedBox(
                                      width: 114,
                                      child: TextFormField(
                                        readOnly: _ReadOnlyAuth(),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly, // Allow only digits
                                        ],
                                        obscureText: _ObscureAuth(),
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Price 3 PD',
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter some number';
                                          } else {
                                            return null;
                                          }
                                        },
                                        controller:
                                            c_new_product_sale_price3_PD,
                                      ),
                                    ),

                                    const SizedBox(width: 2),

                                    SizedBox(
                                      width: 114,
                                      child: TextFormField(
                                        readOnly: _ReadOnlyAuth(),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly, // Allow only digits
                                        ],
                                        obscureText: _ObscureAuth(),
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Price 3 BML',
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter some number';
                                          } else {
                                            return null;
                                          }
                                        },
                                        controller:
                                            c_new_product_sale_price3_BML,
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 10),

                                Row(
                                  children: [
                                    SizedBox(
                                      width: 114,
                                      child: TextFormField(
                                        readOnly: _ReadOnlyAuth(),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly, // Allow only digits
                                        ],
                                        obscureText: _ObscureAuth(),
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Price 4',
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter some number';
                                          } else {
                                            return null;
                                          }
                                        },
                                        controller: c_new_product_sale_price4,
                                      ),
                                    ),

                                    const SizedBox(width: 2),

                                    SizedBox(
                                      width: 114,
                                      child: TextFormField(
                                        readOnly: _ReadOnlyAuth(),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly, // Allow only digits
                                        ],
                                        obscureText: _ObscureAuth(),
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Price 4 PD',
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter some number';
                                          } else {
                                            return null;
                                          }
                                        },
                                        controller:
                                            c_new_product_sale_price4_PD,
                                      ),
                                    ),

                                    const SizedBox(width: 2),

                                    SizedBox(
                                      width: 114,
                                      child: TextFormField(
                                        readOnly: _ReadOnlyAuth(),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly, // Allow only digits
                                        ],
                                        obscureText: _ObscureAuth(),
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: 'Price 4 BML',
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter some number';
                                          } else {
                                            return null;
                                          }
                                        },
                                        controller:
                                            c_new_product_sale_price4_BML,
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 10),

                                Row(
                                  children: [
                                    SizedBox(
                                      width: 114,
                                      child: TextFormField(
                                        readOnly: _ReadOnlyAuth(),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly, // Allow only digits
                                        ],
                                        obscureText: _ObscureAuth(),
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),

                                          labelText: 'Price 5',
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter some number';
                                          } else {
                                            return null;
                                          }
                                        },
                                        controller: c_new_product_sale_price5,
                                      ),
                                    ),

                                    const SizedBox(width: 2),

                                    SizedBox(
                                      width: 114,
                                      child: TextFormField(
                                        readOnly: _ReadOnlyAuth(),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly, // Allow only digits
                                        ],
                                        obscureText: _ObscureAuth(),
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),

                                          labelText: 'Price 5 PD',
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter some number';
                                          } else {
                                            return null;
                                          }
                                        },
                                        controller:
                                            c_new_product_sale_price5_PD,
                                      ),
                                    ),
                                    const SizedBox(width: 2),
                                    SizedBox(
                                      width: 114,
                                      child: TextFormField(
                                        readOnly: _ReadOnlyAuth(),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter
                                              .digitsOnly, // Allow only digits
                                        ],
                                        obscureText: _ObscureAuth(),
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),

                                          labelText: 'Price 5 BML',
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please enter some number';
                                          } else {
                                            return null;
                                          }
                                        },
                                        controller:
                                            c_new_product_sale_price5_BML,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            const SizedBox(width: 5),

                            // Column(
                            //   mainAxisAlignment: MainAxisAlignment
                            //       .center, // Centers children vertically
                            //   children: <Widget>[
                            //     InkWell(
                            //       child: Container(
                            //         width: 180,
                            //         decoration: BoxDecoration(
                            //           color: Colors.blue,
                            //           borderRadius: BorderRadius.circular(5),

                            //           border: Border.all(
                            //             width: 1,
                            //             color: Colors.blueAccent,
                            //             style: BorderStyle.solid,
                            //           ),
                            //         ),
                            //         child: const Row(
                            //           mainAxisAlignment:
                            //               MainAxisAlignment.center,
                            //           //      mainAxisSize: MainAxisSize.max,
                            //           children: [
                            //             Icon(
                            //               Icons.photo_album_rounded,
                            //               color: Colors.white,
                            //               size: 40.0,
                            //             ),
                            //             SizedBox(
                            //               width: 10.0,
                            //             ), // Space between icon and text
                            //             Text(
                            //               'Gallery',
                            //               style: TextStyle(
                            //                 color: Colors.white,
                            //                 fontSize: 18.0,
                            //                 fontWeight: FontWeight.bold,
                            //               ),
                            //             ),
                            //           ],
                            //         ),
                            //       ),

                            //       onTap: () {
                            //         pickGallery();
                            //       },
                            //     ),

                            //     const SizedBox(height: 10),

                            //     InkWell(
                            //       child: Container(
                            //         width: 180,
                            //         decoration: BoxDecoration(
                            //           color: Colors.blue,
                            //           borderRadius: BorderRadius.circular(5),

                            //           border: Border.all(
                            //             width: 1,
                            //             color: Colors.blueAccent,
                            //             style: BorderStyle.solid,
                            //           ),
                            //         ),

                            //         child: const Row(
                            //           mainAxisAlignment:
                            //               MainAxisAlignment.center,
                            //           //      mainAxisSize: MainAxisSize.max,
                            //           children: [
                            //             Icon(
                            //               Icons.photo_camera_rounded,
                            //               color: Colors.white,
                            //               size: 40.0,
                            //             ),
                            //             SizedBox(
                            //               width: 10.0,
                            //             ), // Space between icon and text
                            //             Text(
                            //               'Camera',
                            //               style: TextStyle(
                            //                 color: Colors.white,
                            //                 fontSize: 18.0,
                            //                 fontWeight: FontWeight.bold,
                            //               ),
                            //             ),
                            //           ],
                            //         ),
                            //       ),

                            //       onTap: () {
                            //         pickCamera();
                            //       },
                            //     ),

                            //     const SizedBox(height: 10),

                            //     Container(
                            //       height: 260,
                            //       width: 180,
                            //       decoration: BoxDecoration(
                            //         color: Colors.white,
                            //         borderRadius: BorderRadius.circular(20),

                            //         image: DecorationImage(
                            //           image: _FileImage == null
                            //               ? _ProImageNetwork == ''
                            //                     ? AssetImage(
                            //                         'assets/images/NoImage.png',
                            //                       )
                            //                     : NetworkImage(_ProImageNetwork)
                            //               : FileImage(_FileImage!),
                            //           fit: BoxFit.contain,
                            //           opacity: 0.8,

                            //           // onError: (exception, stackTrace) =>
                            //           //    AssetImage(
                            //           //       'assets/images/NoImage.png',
                            //           //     ),
                            //         ),

                            //         border: Border.all(
                            //           width: 1,
                            //           color: Colors.blueAccent,
                            //           style: BorderStyle.solid,
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              child: Container(
                                width: 170,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),

                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  //      mainAxisSize: MainAxisSize.max,
                                  children: [
                                    const Icon(
                                      Icons.photo_album_rounded,
                                      color: Color.fromARGB(255, 46, 212, 241),
                                      size: 40.0,
                                    ),
                                    const SizedBox(
                                      width: 10.0,
                                    ), // Space between icon and text
                                    Text(
                                      'Gallery',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              onTap: () {
                                pickGallery();
                              },
                            ),

                            const SizedBox(width: 10),

                            InkWell(
                              child: Container(
                                width: 170,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),

                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey,
                                    style: BorderStyle.solid,
                                  ),
                                ),

                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  //      mainAxisSize: MainAxisSize.max,
                                  children: [
                                    const Icon(
                                      Icons.photo_camera_rounded,
                                      color: Color.fromARGB(255, 46, 212, 241),
                                      size: 40.0,
                                    ),
                                    const SizedBox(
                                      width: 10.0,
                                    ), // Space between icon and text
                                    Text(
                                      'Camera',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              onTap: () {
                                pickCamera();
                              },
                            ),
                          ],
                        ),

                        const SizedBox(height: 10),

                        Container(
                          height: 260,
                          width: 350,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),

                            image: DecorationImage(
                              image: _FileImage == null
                                  ? _ProImageNetwork == ''
                                        ? AssetImage(
                                            'assets/images/NoImage.png',
                                          )
                                        : NetworkImage(_ProImageNetwork)
                                  : FileImage(_FileImage!),
                              fit: BoxFit.contain,
                              opacity: 0.8,

                              // onError: (exception, stackTrace) =>
                              //    AssetImage(
                              //       'assets/images/NoImage.png',
                              //     ),
                            ),

                            border: Border.all(
                              width: 1,
                              color: Colors.blueAccent,
                              style: BorderStyle.solid,
                            ),
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              style: raisedButtonStyle,
                              onPressed: () {
                                clearform();
                              },
                              child: Text(
                                'CLEAR',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            const SizedBox(width: 20),

                            ElevatedButton(
                              style: raisedButtonStyle,
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Processing Data'),
                                    ),
                                  );

                                  c_new_product_unit_name.text =
                                      _selectedProUnit!;

                                  saveNewProToDatabase();
                                }
                              },
                              child: Text(
                                'SAVE',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
