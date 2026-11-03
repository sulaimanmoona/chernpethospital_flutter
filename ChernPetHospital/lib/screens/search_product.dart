import 'package:ChernPetHospital/app.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ChernPetHospital/screens/scan_product_form.dart';
import 'package:ChernPetHospital/container_stless.dart';

class search_product extends StatefulWidget {
  const search_product({super.key});

  @override
  State<search_product> createState() => _search_product();
}

class _search_product extends State<search_product> {
  TextEditingController edt_search = TextEditingController();
  List Lst_product = [];
  List Lst_searchproduct = [];

  @override
  void initState() {
    super.initState();
    _loadProduct();
  }

  void _SearchdProduct(String enteredKeyword) async {
    List results = [];

    if (enteredKeyword.isEmpty) {
      results = Lst_product;
    } else {
      results = Lst_product.where(
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
      Lst_searchproduct = results;
    });
  }

  Future<void> _loadProduct() async {
    String url = "${root_url}selectproduct.php";

    final Response = await http.get(Uri.parse(url));
    if (Response.statusCode == 200) {
      setState(() {
        Lst_product = json.decode(Response.body);
        Lst_searchproduct = Lst_product;
      });
    }
  }

  Widget _TextAuthorizeTitle() {
    if (glo_Lst_user_authorize[0]["user_authorize"][1] == "1") {
      return Text(
        "Search Product",
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      );
    } else {
      return Text(
        "Search Product [BRANCH:" + glo_branchstock + "]",
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      );
    }
  }

  /////////Show
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: _TextAuthorizeTitle(),
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
                          edt_search.text = qrCode.toString();
                          _SearchdProduct(qrCode.toString());
                        }
                      },
                    ),
                    hintText: 'Search product ...',
                    contentPadding: const EdgeInsets.all(15),
                    border: InputBorder.none,
                  ),
                  controller: edt_search,
                  onChanged: (value) {
                    _SearchdProduct(value);
                  },
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: Lst_searchproduct.length,
                itemBuilder: (context, index) {
                  return container_stless(
                    "[" +
                        Lst_searchproduct[index]["product_id"] +
                        "] " +
                        Lst_searchproduct[index]["product_bname"],
                    Lst_searchproduct[index]["product_unit_name"],
                    int.parse(Lst_searchproduct[index]["product_amount"]),
                    Lst_searchproduct[index]["product_amount00"],
                    Lst_searchproduct[index]["product_amount02"],
                    Lst_searchproduct[index]["product_amount04"],
                    Lst_searchproduct[index]["product_amountPD"],

                    Lst_searchproduct[index]["product_image_path"],
                    double.parse(
                      Lst_searchproduct[index]["product_sale_price"],
                    ),
                    double.parse(
                      Lst_searchproduct[index]["product_sale_price2"],
                    ),
                    double.parse(
                      Lst_searchproduct[index]["product_sale_price3"],
                    ),
                    double.parse(
                      Lst_searchproduct[index]["product_sale_price4"],
                    ),
                    double.parse(
                      Lst_searchproduct[index]["product_sale_price5"],
                    ),
                    double.parse(Lst_searchproduct[index]["lastavgprice"]),
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
