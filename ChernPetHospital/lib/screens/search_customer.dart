import 'package:ChernPetHospital/app.dart';
import 'package:ChernPetHospital/screens/animal_info_form.dart';
import 'package:ChernPetHospital/screens/medical_history_form.dart';
import 'package:ChernPetHospital/screens/newappointment_form.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//import 'package:ChernPetHospital/card_stless.dart';

class search_customer extends StatefulWidget {
  const search_customer({super.key});

  @override
  State<search_customer> createState() => _search_customer();
}

class _search_customer extends State<search_customer> {
  TextEditingController edt_search = TextEditingController();
  List Lst_customer = [];
  List Lst_searchanimal = [];

  @override
  void initState() {
    super.initState();
    _loadCustomer();
  }

  // String _getInitials(String name) {
  //   if (name.isEmpty) return '';
  //   List<String> parts = name.split(' ');
  //   if (parts.length > 1) {
  //     return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
  //   }
  //   return name[0].toUpperCase();
  // }

  void _SearchCustomer(String enteredKeyword) async {
    List results = [];

    if (enteredKeyword.isEmpty) {
      results = Lst_customer;
    } else {
      results = Lst_customer.where(
        (customer) =>
            customer["pet_id"].toLowerCase().contains(
              enteredKeyword.toLowerCase(),
            ) ||
            customer["pet_name"].toLowerCase().contains(
              enteredKeyword.toLowerCase(),
            ) ||
            customer["cus_name"].toLowerCase().contains(
              enteredKeyword.toLowerCase(),
            ) ||
            customer["cus_surname"].toLowerCase().contains(
              enteredKeyword.toLowerCase(),
            ) ||
            customer["cus_tel"].toLowerCase().contains(
              enteredKeyword.toLowerCase(),
            ),
      ).toList();
      // we use the toLowerCase() method to make it case-insensitive
    }
    setState(() {
      Lst_searchanimal = results;
    });
  }

  Future<void> _loadCustomer() async {
    String url = "${root_url}selectanimal.php";

    final Response = await http.get(Uri.parse(url));
    if (Response.statusCode == 200) {
      setState(() {
        Lst_customer = json.decode(Response.body);
        Lst_searchanimal = Lst_customer;
      });
    }
  }

  /////////Show
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          "Search Patient",
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
            Container(
              alignment: Alignment.center,
              child: Container(
                margin: const EdgeInsets.only(top: 10),
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    width: 1,
                    color: Colors.blueAccent,
                    style: BorderStyle.solid,
                  ),
                ),
                child: TextField(
                  decoration: const InputDecoration(
                    hintText: 'Search patient...',
                    contentPadding: EdgeInsets.all(15),
                    border: InputBorder.none,
                  ),
                  controller: edt_search,
                  onChanged: (value) {
                    _SearchCustomer(value);
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: Lst_searchanimal.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 5,
                    margin: const EdgeInsets.symmetric(
                      vertical: 2,
                      horizontal: 10,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        ListTile(
                          leading: const CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage(
                              "assets/images/user.png",
                            ),
                          ),
                          title: Text(Lst_searchanimal[index]["pet_name"]),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  text:
                                      'ID: ' +
                                      Lst_searchanimal[index]["pet_id"],
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text:
                                          '  Species: ' +
                                          Lst_searchanimal[index]["animal_type"],
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              RichText(
                                text: TextSpan(
                                  text:
                                      'Client Name: ' +
                                      Lst_searchanimal[index]["cus_name"] +
                                      '  ' +
                                      Lst_searchanimal[index]["cus_surname"],
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text:
                                          '  Tel: ' +
                                          Lst_searchanimal[index]["cus_tel"],
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            TextButton(
                              child: const Text('Information'),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => animal_info(
                                      AnimalID:
                                          Lst_searchanimal[index]["pet_id"],
                                      AnimalName:
                                          Lst_searchanimal[index]["pet_name"],
                                      AnimalType:
                                          Lst_searchanimal[index]["animal_type"],
                                      AnimalSex:
                                          Lst_searchanimal[index]["animal_sex"],
                                      AnimalColor:
                                          Lst_searchanimal[index]["animal_color"],
                                      AnimalBreed:
                                          Lst_searchanimal[index]["animal_breed"],
                                      AnimalMix:
                                          Lst_searchanimal[index]["animal_mix"],
                                      AnimalDOB:
                                          Lst_searchanimal[index]["animal_dob"],
                                      AnimalGroup:
                                          Lst_searchanimal[index]["animal_group"],
                                      AnimalPic:
                                          Lst_searchanimal[index]["animal_image"],
                                      CustomerID:
                                          Lst_searchanimal[index]["cus_id"],
                                      CustomerName:
                                          Lst_searchanimal[index]["cus_name"],
                                      CustomerSurName:
                                          Lst_searchanimal[index]["cus_surname"],
                                      CustomerIDCard:
                                          Lst_searchanimal[index]["cus_idcard"],
                                      CustomerTel:
                                          Lst_searchanimal[index]["cus_tel"],
                                      CustomerTel2:
                                          Lst_searchanimal[index]["cus_tel2"],
                                      CustomerAddress:
                                          Lst_searchanimal[index]["cus_address"],
                                      CustomerProvince:
                                          Lst_searchanimal[index]["cus_province"],
                                      CustomerPic:
                                          Lst_searchanimal[index]["cus_image"],
                                    ),
                                  ),
                                );
                                _loadCustomer();
                              },
                            ),

                            const SizedBox(width: 5),
                            TextButton(
                              child: const Text('Medical History'),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MedicalHistory(
                                      AnimalID:
                                          Lst_searchanimal[index]["pet_id"],
                                      AnimalNote:
                                          Lst_searchanimal[index]["animal_note"],
                                    ),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(width: 5),
                            TextButton(
                              child: const Text('Making Appointment'),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MakeAppointment(
                                      AnimalID:
                                          Lst_searchanimal[index]["pet_id"],
                                      AnimalName:
                                          Lst_searchanimal[index]["pet_name"],
                                      CusID: Lst_searchanimal[index]["cus_id"],
                                      CusName:
                                          Lst_searchanimal[index]["cus_name"] +
                                          ' ' +
                                          Lst_searchanimal[index]["cus_surname"],
                                      CusTel:
                                          Lst_searchanimal[index]["cus_tel"],
                                    ),
                                  ),
                                );
                              },
                            ),
                            //      const SizedBox(width: 5),
                          ],
                        ),
                      ],
                    ),
                  );

                  // card_stless(
                  //   Lst_searchanimal[index]["pet_id"],
                  //   Lst_searchanimal[index]["pet_name"],
                  //   Lst_searchanimal[index]["animal_type"],
                  //   Lst_searchanimal[index]["animal_sex"],
                  //   Lst_searchanimal[index]["animal_color"],
                  //   Lst_searchanimal[index]["animal_breed"],
                  //   Lst_searchanimal[index]["animal_mix"],
                  //   Lst_searchanimal[index]["animal_dob"],
                  //   Lst_searchanimal[index]["animal_group"],
                  //   Lst_searchanimal[index]["animal_image"],
                  //   Lst_searchanimal[index]["cus_id"],
                  //   Lst_searchanimal[index]["cus_name"],
                  //   Lst_searchanimal[index]["cus_surname"],
                  //   Lst_searchanimal[index]["cus_idcard"],
                  //   Lst_searchanimal[index]["cus_tel"],
                  //   Lst_searchanimal[index]["cus_tel2"],
                  //   Lst_searchanimal[index]["cus_address"],
                  //   Lst_searchanimal[index]["cus_province"],
                  //   Lst_searchanimal[index]["cus_image"],
                  // );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
