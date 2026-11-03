import 'dart:convert';

import 'package:ChernPetHospital/app.dart';
import 'package:ChernPetHospital/container_count_stless.dart';
import 'package:ChernPetHospital/model/countstock_class.dart';
import 'package:ChernPetHospital/widget/button_style.dart';
import 'package:flutter/material.dart';

import 'package:ChernPetHospital/screens/scan_product_form.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class count_stock extends StatefulWidget {
  const count_stock({super.key});

  @override
  State<count_stock> createState() => _count_stock();
}

class _count_stock extends State<count_stock> {
  TextEditingController edt_search = TextEditingController();
  TextEditingController edt_count = TextEditingController();
  TextEditingController edt_comment = TextEditingController();
  List Lst_product_count = [];
  List Lst_searchproduct_count = [];
  List<product_class> Lst_tempcount = [];
  List<Map<String, dynamic>> Lst_tempcountMaps = [];

  String _proidpick = '';
  String _proidnamepick = '';
  String _proamountpick = '0';
  String _proamountcount = '0';
  String _proamountdiff = '0';
  String branch_amount = '0';
  String _procomment = '';

  FocusNode? _focuscount;
  FocusNode? _focussearch;
  FocusNode? _focuscomment;

  @override
  void initState() {
    super.initState();
    _focuscount = FocusNode();
    _focussearch = FocusNode();
    _loadProduct_count();
    _loadTempCount();
  }

  @override
  void dispose() {
    _focuscount?.dispose(); // Important for resource management
    _focussearch?.dispose();
    super.dispose();
  }

  void _SearchdProduct(String enteredKeyword) async {
    List results = [];

    if (enteredKeyword.isEmpty) {
      results = Lst_product_count;
    } else {
      results = Lst_product_count.where(
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
      Lst_searchproduct_count = results;
    });
  }

  Future<void> _loadProduct_count() async {
    String url = "${root_url}selectproduct.php";

    final Response = await http.get(Uri.parse(url));
    if (Response.statusCode == 200) {
      setState(() {
        Lst_product_count = json.decode(Response.body);
        Lst_searchproduct_count = Lst_product_count;
      });
    }
  }

  void _getproidpick(String proidpick, String proidname) {
    setState(() {
      _proidpick = proidpick;
      _proidnamepick = proidname;

      edt_comment.text = '';
    });
  }

  void _getproamountpick(String proamountpick) {
    setState(() {
      _proamountpick = proamountpick;
      _proamountcount = proamountpick;
      _proamountdiff = '0';

      edt_count.text = _proamountcount;
    });
  }

  void _removecount() {
    setState(() {
      _proamountcount = (int.parse(_proamountcount) - 1).toString();
      _proamountdiff = (int.parse(_proamountpick) - int.parse(_proamountcount))
          .toString();
    });
  }

  void _addcount() {
    setState(() {
      _proamountcount = (int.parse(_proamountcount) + 1).toString();
      _proamountdiff = (int.parse(_proamountpick) - int.parse(_proamountcount))
          .toString();
    });
  }

  void _addlist(
    String p_id,
    String p_name,
    String p_amount,
    String p_count,
    String p_diff,
    String count_username,
    String count_branchid,
    String p_comment,
  ) {
    if (p_id != '') {
      product_class? foundObject;
      for (var obj in Lst_tempcount) {
        if (obj.c_product_id.contains(p_id)) {
          foundObject = obj;
          break; // Exit the loop once found
        }
      }

      if (foundObject == null) {
        setState(() {
          Lst_tempcount.add(
            product_class(
              p_id,
              p_name,
              int.parse(p_amount),
              int.parse(p_count),
              int.parse(p_diff),
              count_username,
              count_branchid,
              p_comment,
            ),
          );
          Map<String, dynamic> map_tempcount = {
            'c_product_id': p_id,
            'c_product_bname': p_name,
            'c_product_amount': int.parse(p_amount),
            'c_product_count': int.parse(p_count),
            'c_product_diff': int.parse(p_diff),
            'c_username': count_username,
            'c_branchid': count_branchid,
            'c_comment': p_comment,
          };

          Lst_tempcountMaps.add(map_tempcount);
        });
      }
    }
  }

  void _removelist(int indextemp) {
    setState(() {
      Lst_tempcount.removeAt(indextemp);
    });
  }

  Future<void> saveListToDatabase(List dataList) async {
    String url = "${root_url}savecountstock.php";

    try {
      final response = await http.post(
        Uri.parse(url),

        body: jsonEncode(dataList),
      );

      if (response.statusCode == 200) {
        // print('List saved successfully!');

        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("MORYAAPP"),
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

        setState(() {
          Lst_tempcount.clear();
          Lst_tempcountMaps.clear();
        });
      } else {
        // print('Failed to save list: ${response.statusCode}');

        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: Text(
                'Failed to fetch data. Status code: ${response.statusCode}',
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

  void _loadTempCount() {
    setState(() {
      Lst_tempcount = glo_tempcount;
      Lst_tempcountMaps = glo_tempcountmaps;
    });
  }

  /////////Show
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          "Count Stock [BRANCH:" +
              glo_branchstock +
              " USER:" +
              glo_username +
              "]",
          style: const TextStyle(
            color: Colors.black,
            fontSize: 15,
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
                  focusNode: _focussearch,
                  decoration: InputDecoration(
                    prefixIcon: IconButton(
                      icon: const Icon(Icons.qr_code_scanner),
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
            Container(
              padding: isFolded
                  ? const EdgeInsets.symmetric(horizontal: 100)
                  : const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  width: 1,
                  color: Colors.blueAccent,
                  style: BorderStyle.solid,
                ),
              ),
              //    child: Center(
              child: AspectRatio(
                aspectRatio: 2,

                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return ListView.builder(
                      itemCount: Lst_searchproduct_count.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            _getproidpick(
                              Lst_searchproduct_count[index]["product_id"],
                              Lst_searchproduct_count[index]["product_bname"],
                            );

                            if (glo_branchstock == '00') {
                              branch_amount =
                                  Lst_searchproduct_count[index]["product_amount00"];
                            } else if (glo_branchstock == '01') {
                              branch_amount =
                                  Lst_searchproduct_count[index]["product_amount01"];
                            } else if (glo_branchstock == '02') {
                              branch_amount =
                                  Lst_searchproduct_count[index]["product_amount02"];
                            } else if (glo_branchstock == '04') {
                              branch_amount =
                                  Lst_searchproduct_count[index]["product_amount04"];
                            } else if (glo_branchstock == '05') {
                              branch_amount =
                                  Lst_searchproduct_count[index]["product_amount05"];
                            } else if (glo_branchstock == '07') {
                              branch_amount =
                                  Lst_searchproduct_count[index]["product_amount07"];
                            } else if (glo_branchstock == '08') {
                              branch_amount =
                                  Lst_searchproduct_count[index]["product_amount08"];
                            } else if (glo_branchstock == '09') {
                              branch_amount =
                                  Lst_searchproduct_count[index]["product_amount09"];
                            } else if (glo_branchstock == '10') {
                              branch_amount =
                                  Lst_searchproduct_count[index]["product_amount10"];
                            } else if (glo_branchstock == '11') {
                              branch_amount =
                                  Lst_searchproduct_count[index]["product_amount11"];
                            } else if (glo_branchstock == '12') {
                              branch_amount =
                                  Lst_searchproduct_count[index]["product_amount12"];
                            } else if (glo_branchstock == '13') {
                              branch_amount =
                                  Lst_searchproduct_count[index]["product_amount13"];
                            } else if (glo_branchstock == '14') {
                              branch_amount =
                                  Lst_searchproduct_count[index]["product_amount14"];
                            } else if (glo_branchstock == '15') {
                              branch_amount =
                                  Lst_searchproduct_count[index]["product_amount15"];
                            } else if (glo_branchstock == '20') {
                              branch_amount =
                                  Lst_searchproduct_count[index]["product_amount20"];
                            } else if (glo_branchstock == '21') {
                              branch_amount =
                                  Lst_searchproduct_count[index]["product_amount21"];
                            } else if (glo_branchstock == '24') {
                              branch_amount =
                                  Lst_searchproduct_count[index]["product_amount24"];
                            } else if (glo_branchstock == '26') {
                              branch_amount =
                                  Lst_searchproduct_count[index]["product_amount26"];
                            } else if (glo_branchstock == '27') {
                              branch_amount =
                                  Lst_searchproduct_count[index]["product_amount27"];
                            } else if (glo_branchstock == '28') {
                              branch_amount =
                                  Lst_searchproduct_count[index]["product_amount28"];
                            } else if (glo_branchstock == '29') {
                              branch_amount =
                                  Lst_searchproduct_count[index]["product_amount29"];
                            } else if (glo_branchstock == '30') {
                              branch_amount =
                                  Lst_searchproduct_count[index]["product_amount30"];
                            } else if (glo_branchstock == '31') {
                              branch_amount =
                                  Lst_searchproduct_count[index]["product_amount31"];
                            } else if (glo_branchstock == '32') {
                              branch_amount =
                                  Lst_searchproduct_count[index]["product_amount32"];
                            } else if (glo_branchstock == '33') {
                              branch_amount =
                                  Lst_searchproduct_count[index]["product_amount33"];
                            } else if (glo_branchstock == '34') {
                              branch_amount =
                                  Lst_searchproduct_count[index]["product_amount34"];
                            } else if (glo_branchstock == '35') {
                              branch_amount =
                                  Lst_searchproduct_count[index]["product_amount35"];
                            } else if (glo_branchstock == '36') {
                              branch_amount =
                                  Lst_searchproduct_count[index]["product_amount36"];
                            } else if (glo_branchstock == '37') {
                              branch_amount =
                                  Lst_searchproduct_count[index]["product_amount37"];
                            } else if (glo_branchstock == '38') {
                              branch_amount =
                                  Lst_searchproduct_count[index]["product_amount38"];
                            } else if (glo_branchstock == '39') {
                              branch_amount =
                                  Lst_searchproduct_count[index]["product_amount39"];
                            } else if (glo_branchstock == '40') {
                              branch_amount =
                                  Lst_searchproduct_count[index]["product_amount40"];
                            } else if (glo_branchstock == '41') {
                              branch_amount =
                                  Lst_searchproduct_count[index]["product_amount41"];
                            } else if (glo_branchstock == '42') {
                              branch_amount =
                                  Lst_searchproduct_count[index]["product_amount42"];
                            }
                            ;

                            _getproamountpick(branch_amount);

                            FocusScope.of(context).requestFocus(_focuscount);
                          },
                          child: container_count_stless(
                            "[" +
                                Lst_searchproduct_count[index]["product_id"] +
                                "] " +
                                Lst_searchproduct_count[index]["product_bname"],
                            Lst_searchproduct_count[index]["product_unit_name"],
                            int.parse(
                              Lst_searchproduct_count[index]["product_amount"],
                            ),
                            Lst_searchproduct_count[index]["product_amount00"],
                            Lst_searchproduct_count[index]["product_amount01"],
                            Lst_searchproduct_count[index]["product_amount02"],

                            Lst_searchproduct_count[index]["product_amount04"],
                            Lst_searchproduct_count[index]["product_amount05"],

                            Lst_searchproduct_count[index]["product_amount07"],
                            Lst_searchproduct_count[index]["product_amount08"],
                            Lst_searchproduct_count[index]["product_amount09"],
                            Lst_searchproduct_count[index]["product_amount10"],
                            Lst_searchproduct_count[index]["product_amount11"],
                            Lst_searchproduct_count[index]["product_amount12"],
                            Lst_searchproduct_count[index]["product_amount13"],

                            Lst_searchproduct_count[index]["product_amount14"],
                            Lst_searchproduct_count[index]["product_amount15"],

                            Lst_searchproduct_count[index]["product_amount20"],
                            Lst_searchproduct_count[index]["product_amount21"],

                            Lst_searchproduct_count[index]["product_amount24"],

                            Lst_searchproduct_count[index]["product_amount26"],
                            Lst_searchproduct_count[index]["product_amount27"],
                            Lst_searchproduct_count[index]["product_amount28"],
                            Lst_searchproduct_count[index]["product_amount29"],
                            Lst_searchproduct_count[index]["product_amount30"],
                            Lst_searchproduct_count[index]["product_amount31"],
                            Lst_searchproduct_count[index]["product_amount32"],
                            Lst_searchproduct_count[index]["product_amount33"],
                            Lst_searchproduct_count[index]["product_amount34"],
                            Lst_searchproduct_count[index]["product_amount35"],
                            Lst_searchproduct_count[index]["product_amount36"],
                            Lst_searchproduct_count[index]["product_amount37"],
                            Lst_searchproduct_count[index]["product_amount38"],
                            Lst_searchproduct_count[index]["product_amount39"],
                            Lst_searchproduct_count[index]["product_amount40"],
                            Lst_searchproduct_count[index]["product_amount41"],
                            Lst_searchproduct_count[index]["product_amount42"],
                            Lst_searchproduct_count[index]["product_image_path"],
                            double.parse(
                              Lst_searchproduct_count[index]["product_sale_price"],
                            ),
                            double.parse(
                              Lst_searchproduct_count[index]["product_sale_price5"],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              //     ),
            ),
            const SizedBox(height: 5),

            Container(
              height: 40.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(17.0),
                color: Colors.blue[50],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      'Product : ['
                      '$_proidpick'
                      '] '
                      '$_proidnamepick',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            //      const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: [
                Expanded(
                  child: Container(
                    height: 40.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(17.0),
                      color: Colors.blue[50],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Amount : '
                          '$_proamountpick',
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Expanded(
                  child: TextFormField(
                    focusNode: _focuscount,
                    textAlign: TextAlign.center,

                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(17),
                      ),
                      filled: true, // Must be true to enable background color
                      fillColor: Colors.white,
                      helperStyle: const TextStyle(color: Colors.green),
                      alignLabelWithHint: false,
                    ),
                    onChanged: (value) {
                      setState(() {
                        if (value != null && value.isNotEmpty) {
                          _proamountcount = value;
                          _proamountdiff =
                              (int.parse(_proamountpick) - int.parse(value))
                                  .toString();
                        } else {
                          _proamountcount = '0';
                          _proamountdiff =
                              (int.parse(_proamountpick) - int.parse('0'))
                                  .toString();
                        }
                      });
                    },
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    controller: edt_count,
                  ),

                  // child: Container(
                  //   height: 40.0,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(17.0),
                  //     color: Colors.green,
                  //   ),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //     children: <Widget>[
                  // InkWell(
                  //   onTap: () {
                  //     _removecount();
                  //   },
                  //   child: Container(
                  //     height: 25.0,
                  //     width: 25.0,
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(7.0),
                  //       color: Colors.white,
                  //     ),
                  //     child: Center(
                  //       child: Icon(
                  //         Icons.remove,
                  //         color: Colors.black,
                  //         size: 20.0,
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  // Text(
                  //   '$_proamountcount',
                  //   style: TextStyle(color: Colors.white, fontSize: 15.0),
                  // ),

                  // InkWell(
                  //   onTap: () {
                  //     _addcount();
                  //   },
                  //   child: Container(
                  //     height: 25.0,
                  //     width: 25.0,
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(7.0),
                  //       color: Colors.white,
                  //     ),
                  //     child: Center(
                  //       child: Icon(
                  //         Icons.add,
                  //         color: Colors.black,
                  //         size: 20.0,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  //     ],
                  //   ),
                  // ),
                ),

                Expanded(
                  child: Container(
                    height: 40.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(17.0),
                      color: Colors.blue[50],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Diff : '
                          '$_proamountdiff',
                          style: TextStyle(
                            color: Colors.red[900],
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () async {
                          _addlist(
                            _proidpick,
                            _proidnamepick,
                            _proamountpick,
                            _proamountcount,
                            _proamountdiff,
                            glo_username,
                            glo_branchstock,
                            _procomment,
                          );

                          _getproidpick('', '');
                          _getproamountpick('0');
                          _getproamountpick('0');

                          glo_tempcount = Lst_tempcount;
                          glo_tempcountmaps = Lst_tempcountMaps;

                          FocusScope.of(context).requestFocus(_focussearch);
                        },
                        icon: Icon(
                          Icons.add_circle,
                          color: Colors.black,
                          size: 25,
                        ),
                        label: Text(
                          'ADD',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          // foregroundColor: Colors
                          //     .white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            //   const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Comment'),
                const SizedBox(width: 5),
                Container(
                  alignment: Alignment.center,
                  child: Container(
                    //       margin: const EdgeInsets.only(top: 10),
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
                      focusNode: _focuscomment,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(15),
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _procomment = value;
                        });
                      },
                      controller: edt_comment,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return ListView.builder(
                    itemCount: Lst_tempcount.length,
                    itemBuilder: (context, index) {
                      final tempcount = Lst_tempcount[index];
                      return ListTile(
                        title: Text(
                          tempcount.c_product_bname +
                              '\n' +
                              tempcount.c_comment,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          'Amount :' +
                              tempcount.c_product_amount.toString() +
                              ' Count : ' +
                              tempcount.c_product_count.toString() +
                              ' Diff : ' +
                              tempcount.c_product_diff.toString(),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            _removelist(index);
                            _getproidpick('', '');
                            _getproamountpick('0');
                            _getproamountpick('0');
                          },
                          icon: const Icon(
                            Icons.delete_forever_rounded,
                            color: Colors.red,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Container(
                    height: 40.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.zero,
                      color: Colors.blue[50],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          '  Item Total : ' + Lst_tempcount.length.toString(),
                          style: TextStyle(color: Colors.black, fontSize: 15.0),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: ElevatedButton(
                    style: raisedButtonStyle,
                    onPressed: () {
                      saveListToDatabase(Lst_tempcountMaps);
                    },
                    child: const Text(
                      'SAVE',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
