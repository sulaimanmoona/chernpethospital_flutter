import 'package:flutter/material.dart';
import 'package:ChernPetHospital/app.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ChernPetHospital/screens/scan_product_form.dart';
import 'package:ChernPetHospital/container_edit_stless.dart';

class edit_product extends StatefulWidget {
  const edit_product({super.key});

  @override
  State<edit_product> createState() => _edit_productState();
}

class _edit_productState extends State<edit_product> {
  TextEditingController edt_search_edit = TextEditingController();
  List Lst_product_edit = [];
  List Lst_searchproduct_edit = [];

  @override
  void initState() {
    super.initState();
    _loadProduct_edit();
  }

  void _SearchdProduct_edit(String enteredKeyword) async {
    List results = [];

    if (enteredKeyword.isEmpty) {
      results = Lst_product_edit;
    } else {
      results = Lst_product_edit.where(
        (product) =>
            product["product_id"].toLowerCase().contains(
              enteredKeyword.toLowerCase(),
            ) ||
            product["product_bname"].toLowerCase().contains(
              enteredKeyword.toLowerCase(),
            ) ||
            product["product_barcode"].toLowerCase().contains(
              enteredKeyword.toLowerCase(),
            ) ||
            product["product_barcode2"].toLowerCase().contains(
              enteredKeyword.toLowerCase(),
            ) ||
            product["product_barcode3"].toLowerCase().contains(
              enteredKeyword.toLowerCase(),
            ) ||
            product["product_barcode4"].toLowerCase().contains(
              enteredKeyword.toLowerCase(),
            ) ||
            product["product_barcode5"].toLowerCase().contains(
              enteredKeyword.toLowerCase(),
            ),
      ).toList();
      // we use the toLowerCase() method to make it case-insensitive
    }
    setState(() {
      Lst_searchproduct_edit = results;
    });
  }

  Future<void> _loadProduct_edit() async {
    String url = "${root_url}selectproduct.php";

    final Response = await http.get(Uri.parse(url));
    if (Response.statusCode == 200) {
      setState(() {
        Lst_product_edit = json.decode(Response.body);
        Lst_searchproduct_edit = Lst_product_edit;
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
          "Edit Product",
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
                  decoration: InputDecoration(
                    prefixIcon: IconButton(
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
                          edt_search_edit.text = qrCode.toString();
                          _SearchdProduct_edit(qrCode.toString());
                        }
                      },
                    ),
                    hintText: 'Search product ...',
                    contentPadding: const EdgeInsets.all(15),
                    border: InputBorder.none,
                  ),
                  controller: edt_search_edit,
                  onChanged: (value) {
                    _SearchdProduct_edit(value);
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: Lst_searchproduct_edit.length,
                itemBuilder: (context, index) {
                  return container_edit_stless(
                    Lst_searchproduct_edit[index]["product_id"],
                    Lst_searchproduct_edit[index]["product_bname"],
                    Lst_searchproduct_edit[index]["product_barcode"],
                    Lst_searchproduct_edit[index]["product_unit_name"],
                    Lst_searchproduct_edit[index]["product_type"],
                    int.parse(Lst_searchproduct_edit[index]["product_amount"]),
                    int.parse(Lst_searchproduct_edit[index]["product_hire"]),
                    Lst_searchproduct_edit[index]["product_amount00"],
                    Lst_searchproduct_edit[index]["product_amount02"],

                    Lst_searchproduct_edit[index]["product_amount04"],
                    Lst_searchproduct_edit[index]["product_amountPD"],

                    Lst_searchproduct_edit[index]["product_image_path"],
                    double.parse(
                      Lst_searchproduct_edit[index]["product_sale_price"],
                    ),
                    double.parse(
                      Lst_searchproduct_edit[index]["product_sale_price2"],
                    ),
                    double.parse(
                      Lst_searchproduct_edit[index]["product_sale_price3"],
                    ),
                    double.parse(
                      Lst_searchproduct_edit[index]["product_sale_price4"],
                    ),
                    double.parse(
                      Lst_searchproduct_edit[index]["product_sale_price5"],
                    ),
                    double.parse(
                      Lst_searchproduct_edit[index]["product_sale_price_PD"],
                    ),
                    double.parse(
                      Lst_searchproduct_edit[index]["product_sale_price2_PD"],
                    ),
                    double.parse(
                      Lst_searchproduct_edit[index]["product_sale_price3_PD"],
                    ),
                    double.parse(
                      Lst_searchproduct_edit[index]["product_sale_price4_PD"],
                    ),
                    double.parse(
                      Lst_searchproduct_edit[index]["product_sale_price5_PD"],
                    ),
                    double.parse(
                      Lst_searchproduct_edit[index]["product_sale_price_BML2"],
                    ),
                    double.parse(
                      Lst_searchproduct_edit[index]["product_sale_price2_BML2"],
                    ),
                    double.parse(
                      Lst_searchproduct_edit[index]["product_sale_price3_BML2"],
                    ),
                    double.parse(
                      Lst_searchproduct_edit[index]["product_sale_price4_BML2"],
                    ),
                    double.parse(
                      Lst_searchproduct_edit[index]["product_sale_price5_BML2"],
                    ),
                    double.parse(Lst_searchproduct_edit[index]["lastavgprice"]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
