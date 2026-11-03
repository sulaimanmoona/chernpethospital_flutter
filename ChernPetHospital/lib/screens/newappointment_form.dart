import 'dart:convert';

import 'package:ChernPetHospital/app.dart';
import 'package:ChernPetHospital/widget/button_style.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MakeAppointment extends StatefulWidget {
  final String AnimalID, AnimalName, CusID, CusName, CusTel;

  const MakeAppointment({
    Key? key,
    required this.AnimalID,
    required this.AnimalName,
    required this.CusID,
    required this.CusName,
    required this.CusTel,
  }) : super(key: key);

  @override
  State<MakeAppointment> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MakeAppointment> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController c_pet_id = TextEditingController();
  TextEditingController c_pet_name = TextEditingController();

  TextEditingController c_cus_name = TextEditingController();
  TextEditingController c_cus_tel = TextEditingController();

  TextEditingController c_meet_detail = TextEditingController();
  TextEditingController c_meet_type = TextEditingController();

  String? _selectedMeetType;
  DateTime? _meetday = DateTime.now();
  TimeOfDay _meetTimeStart = TimeOfDay.now();
  TimeOfDay _meetTimeEnd = TimeOfDay.now();

  List Lst_meettype = [
    'พบแพทย์',
    'แอดมิท',
    'อาบน้ำตัดขน',
    'ฝากเลี้ยง',
    'อื่นๆ',
  ];

  void getDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2040),
    ).then((value) {
      setState(() {
        _meetday = value!;
      });
    });
  }

  Future<void> getTimePicker(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _meetTimeStart,
    );
    if (picked != null && picked != _meetTimeStart) {
      setState(() {
        _meetTimeStart = picked;
      });
    }
  }

  Future<void> getTimePicker2(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _meetTimeEnd,
    );
    double toDouble(TimeOfDay myTime) => myTime.hour + myTime.minute / 60.0;

    if (picked != null && picked != _meetTimeEnd) {
      setState(() {
        if (toDouble(picked) > toDouble(_meetTimeStart)) {
          _meetTimeEnd = picked;
        } else {
          _meetTimeEnd = _meetTimeStart;
        }
      });
    }
  }

  Future saveMeetToDatabase() async {
    String url = "${root_url}savenewmeet.php";

    try {
      final Response = await http.post(
        Uri.parse(url),

        body: {
          'c_pet_id': c_pet_id.text,
          'c_pet_name': c_pet_name.text,
          'c_cus_id': widget.CusID,
          'c_cus_name': c_cus_name.text,
          'c_cus_tel': c_cus_tel.text,
          'c_meet_type': _selectedMeetType,
          'c_meet_date':
              '${_meetday!.year}-${_meetday!.month}-${_meetday!.day}',
          'c_meet_time_start':
              '${_meetday!.year}-${_meetday!.month}-${_meetday!.day} ${_meetTimeStart!.hour}:${_meetTimeStart!.minute}',
          'c_meet_time_end':
              '${_meetday!.year}-${_meetday!.month}-${_meetday!.day} ${_meetTimeEnd!.hour}:${_meetTimeEnd!.minute}',
          'c_meet_detail': c_meet_detail.text,
        },
      );

      if (Response.statusCode == 200) {
        json.decode(Response.body);
        //   if (data == "InsertComplete") {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("CHERN"),
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

      _selectedMeetType = null;

      c_meet_detail.clear();
      c_meet_type.clear();

      _meetday = DateTime.now();
      _meetTimeStart = TimeOfDay.now();
      _meetTimeEnd = TimeOfDay.now();
    });
  }

  void initState() {
    super.initState();

    c_pet_id.text = widget.AnimalID;
    c_pet_name.text = widget.AnimalName;

    c_cus_name.text = widget.CusName;
    c_cus_tel.text = widget.CusTel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          "Making Appointment",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),

        actions: [],
      ),

      body:
          // SingleChildScrollView(
          //   child:
          Form(
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: 175,
                                child: TextFormField(
                                  readOnly: true,
                                  obscureText: false,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Pet ID',
                                  ),

                                  controller: c_pet_id,
                                ),
                              ),

                              const SizedBox(width: 5),

                              SizedBox(
                                width: 175,
                                child: TextFormField(
                                  readOnly: true,
                                  obscureText: false,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Pet Name',
                                  ),

                                  controller: c_pet_name,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 5),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: 175,
                                child: TextFormField(
                                  readOnly: true,
                                  obscureText: false,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Name',
                                  ),

                                  controller: c_cus_name,
                                ),
                              ),

                              const SizedBox(width: 5),

                              SizedBox(
                                width: 175,
                                child: TextFormField(
                                  readOnly: true,
                                  obscureText: false,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Tel.',
                                  ),

                                  controller: c_cus_tel,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 5),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: 175,
                                child: DropdownSearch<String>(
                                  selectedItem: _selectedMeetType,

                                  popupProps: PopupProps.menu(
                                    showSearchBox: false,
                                  ),

                                  decoratorProps: DropDownDecoratorProps(
                                    decoration: InputDecoration(
                                      labelText: 'Appoint Type',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  items: (filter, infiniteScrollProps) =>
                                      Lst_meettype.cast<String>(),
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedMeetType = value;
                                    });
                                  },
                                ),
                              ),

                              const SizedBox(width: 5),

                              SizedBox(
                                width: 175,
                                child: Container(
                                  height: 55,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.grey,
                                      style: BorderStyle.solid,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        ' Date  ${_meetday!.day}/${_meetday!.month}/${_meetday!.year}',
                                        selectionColor: Colors.grey,
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          getDatePicker();
                                        },
                                        icon: const Icon(
                                          Icons.arrow_drop_down,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          size: 28,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 5),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: 175,
                                child: Container(
                                  height: 55,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.grey,
                                      style: BorderStyle.solid,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        ' Start  ${_meetTimeStart!.hour}:${_meetTimeStart!.minute}',
                                        selectionColor: Colors.grey,
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          getTimePicker(context);
                                        },
                                        icon: const Icon(
                                          Icons.arrow_drop_down,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          size: 28,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              const SizedBox(width: 5),

                              SizedBox(
                                width: 175,
                                child: Container(
                                  height: 55,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.grey,
                                      style: BorderStyle.solid,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        ' End  ${_meetTimeEnd!.hour}:${_meetTimeEnd!.minute}',
                                        selectionColor: Colors.grey,
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          getTimePicker2(context);
                                        },
                                        icon: const Icon(
                                          Icons.arrow_drop_down,
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          size: 28,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 5),

                          SizedBox(
                            width: 360,
                            child: TextFormField(
                              obscureText: false,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Detail',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                } else {
                                  return null;
                                }
                              },
                              controller: c_meet_detail,
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

                                    c_meet_type.text = _selectedMeetType!;

                                    saveMeetToDatabase();
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
      //     ),
    );
  }
}
