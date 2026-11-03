import 'dart:convert';
import 'package:ChernPetHospital/app.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:grouped_list/grouped_list.dart';

class sale_detail extends StatefulWidget {
  const sale_detail({super.key});

  @override
  State<sale_detail> createState() => _sale_detail();
}

class _sale_detail extends State<sale_detail> {
  TextEditingController edt_search = TextEditingController();
  List Lst_saledetail = [];

  @override
  void initState() {
    super.initState();
    _loadSaleDetail();
  }

  Future<void> _loadSaleDetail() async {
    String url = "${root_url}selectsaledetail.php";

    final Response = await http.get(
      Uri.parse(url).replace(
        queryParameters: {
          'sale_date':
              '${glo_datetime.year}-${glo_datetime.month}-${glo_datetime.day}',
          'sale_date2':
              '${glo_datetime2.year}-${glo_datetime2.month}-${glo_datetime2.day}',
          'branchid': glo_branchid,
        },
      ),
    );
    if (Response.statusCode == 200) {
      setState(() {
        if (json.decode(Response.body) != '') {
          Lst_saledetail = json.decode(Response.body);
        }
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
          "Sale History",
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
          // image: DecorationImage(
          //   image: AssetImage("assets/images/bkbg.png"),
          //   fit: BoxFit.cover,
          //   alignment: Alignment.topCenter,
          // ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 5),
            Expanded(child: _createGroupedListView()),
          ],
        ),
      ),
    );
  }

  _createGroupedListView() {
    return GroupedListView<dynamic, String>(
      elements: Lst_saledetail,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      groupBy: (Lst_saledetail) => Lst_saledetail['bill_id'],
      groupComparator: (value1, value2) => value2.compareTo(value1),
      itemComparator: (item1, item2) =>
          item1['pro_id'].compareTo(item2['pro_id']),
      order: GroupedListOrder.DESC,
      useStickyGroupSeparators: true,
      stickyHeaderBackgroundColor: Colors.white,
      groupSeparatorBuilder: (String value) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(
              value,
              textAlign: TextAlign.left,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Spacer(), // Adds space to push the button to the right
            ElevatedButton(
              onPressed: () => showDialog<String>(
                context: context,
                builder: (BuildContext context) {
                  String paytype = "";
                  if (Lst_saledetail[Lst_saledetail.indexWhere(
                        (Lst_saledetail) => Lst_saledetail['bill_id'] == value,
                      )]['pay_type'] ==
                      "Ca") {
                    paytype = "Cash";
                  } else if (Lst_saledetail[Lst_saledetail.indexWhere(
                        (Lst_saledetail) => Lst_saledetail['bill_id'] == value,
                      )]['pay_type'] ==
                      "Ct") {
                    paytype = "Transfer";
                  } else if (Lst_saledetail[Lst_saledetail.indexWhere(
                        (Lst_saledetail) => Lst_saledetail['bill_id'] == value,
                      )]['pay_type'] ==
                      "Cr") {
                    paytype = "Credit";
                  }

                  return Dialog(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "\nBill No.: " +
                              Lst_saledetail[Lst_saledetail.indexWhere(
                                (Lst_saledetail) =>
                                    Lst_saledetail['bill_id'] == value,
                              )]['bill_id'] +
                              "\nDate: " +
                              Lst_saledetail[Lst_saledetail.indexWhere(
                                (Lst_saledetail) =>
                                    Lst_saledetail['bill_id'] == value,
                              )]['sale_date'] +
                              "\nTime: " +
                              Lst_saledetail[Lst_saledetail.indexWhere(
                                (Lst_saledetail) =>
                                    Lst_saledetail['bill_id'] == value,
                              )]['sale_time'] +
                              "\nPayment: " +
                              paytype +
                              "\n",
                        ),
                        const SizedBox(height: 20),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Close'),
                        ),
                      ],
                    ),
                  );
                },
              ),

              child: Text(
                glo_format_currency.format(
                  double.parse(
                    Lst_saledetail[Lst_saledetail.indexWhere(
                      (Lst_saledetail) => Lst_saledetail['bill_id'] == value,
                    )]['net_amount'],
                  ),
                ),
                //   .toString(),
              ),
              //   child: Text(Lst_saledetail[2]['net_amount'].toString()),
            ),
          ],
        ),
      ),
      itemBuilder: (c, Lst_saledetail) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 0.0),
          child: ListTile(
            dense: true,
            minTileHeight: 1.0,
            trailing: Text(
              glo_format_currency.format(
                    (int.parse(Lst_saledetail['sale_value']) *
                        double.parse(
                          Lst_saledetail['sale_price'],
                        )), //.toStringAsFixed(2)
                  ) +
                  "฿",
              style: const TextStyle(
                inherit: true,
                fontWeight: FontWeight.w700,
                fontSize: 12.0,
              ),
            ),
            title: Row(
              children: [
                Flexible(
                  child: Column(
                    children: [
                      Text(
                        Lst_saledetail['product_bname'] +
                            " " +
                            Lst_saledetail['product_unit_name'],
                        style: const TextStyle(
                          inherit: true,
                          fontSize: 12,
                          color: Colors.black,
                          height: 0.5,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            subtitle: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Qty. " +
                        Lst_saledetail['sale_value'] +
                        " X " +
                        Lst_saledetail['sale_price'],
                    style: const TextStyle(
                      inherit: true,
                      fontSize: 12.0,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      height: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
