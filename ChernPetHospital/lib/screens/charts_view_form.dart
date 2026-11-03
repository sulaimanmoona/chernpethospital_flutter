import 'package:flutter/material.dart';
import 'package:ChernPetHospital/app.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:ChernPetHospital/chartsview1_stless.dart';
import 'package:ChernPetHospital/chartsview2_stless.dart';
import 'package:ChernPetHospital/chartsview3_stless.dart';
import 'package:ChernPetHospital/chartsview4_stless.dart';
import 'package:ChernPetHospital/chartsview5_stless.dart';
import 'package:ChernPetHospital/screens/saledetail_form.dart';

class CardSwiperExample extends StatefulWidget {
  const CardSwiperExample({super.key});

  @override
  State<CardSwiperExample> createState() => _CardSwiperExampleState();
}

class _CardSwiperExampleState extends State<CardSwiperExample> {
  final PageController _pageController = PageController(
    viewportFraction: 0.8,
    initialPage: 0,
  );
  double allnet = 0;
  double alllastnet = 0;
  int allq = 0;
  DateTime? _datetime = DateTime.now();
  DateTime? _datetime2 = DateTime.now();
  List Lst_branch = [];
  double _page = 0;
  int _countpage = 1;

  List Lst_netsale = [
    {
      'net_sale00': '0',
      'net_sale02': '0',
      'net_sale04': '0',
      'net_salePD': '0',
    },
  ];

  List Lst_Lastnetsale = [
    {
      'net_sale00': '0',
      'net_sale02': '0',
      'net_sale04': '0',
      'net_salePD': '0',
    },
  ];

  List Lst_q = [
    {'q_00': '0', 'q_02': '0', 'q_04': '0', 'q_PD': '0'},
  ];

  List<String> branchnetsale = ['0.00', '0.00', '0.00', '0.00'];

  List<String> branchlastnetsale = ['0.00', '0.00', '0.00', '0.00'];

  List<String> branchq = ['0', '0', '0', '0'];

  void initState() {
    super.initState();

    _loadbranch();
    _loadNetSale();

    _loadLastNetSale();
    _loadQ();

    _pageController.addListener(() {
      if (_pageController.page != null) {
        _page = _pageController.page!;
        setState(() {});
      }
    });

    glo_netsale = Lst_netsale;
  }

  void refreshchart() {
    _loadNetSale();
    _loadLastNetSale();
    _loadQ();
  }

  String checkfebury() {
    if ((_datetime2!.month == 2) && (_datetime2!.day == 29)) {
      return '${_datetime2!.year - 1}-${_datetime2!.month}-28';
    } else {
      return '${_datetime2!.year - 1}-${_datetime2!.month}-${_datetime2!.day}';
    }
  }

  Future<void> _loadbranch() async {
    String url = "${root_url}selectbranch.php";

    final Response = await http.get(Uri.parse(url));
    if (Response.statusCode == 200) {
      setState(() {
        Lst_branch = json.decode(Response.body);
      });
    }
  }

  void getDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2040),
    ).then((value) {
      setState(() {
        _datetime = value!;
        glo_datetime = _datetime!;
        _loadNetSale();
        _loadLastNetSale();

        _loadQ();
        glo_netsale = Lst_netsale;
      });
    });
  }

  void getDatePicker2() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015),
      lastDate: DateTime(2040),
    ).then((value) {
      setState(() {
        _datetime2 = value!;
        glo_datetime2 = _datetime2!;
        _loadNetSale();
        _loadLastNetSale();
        _loadQ();
        glo_netsale = Lst_netsale;
      });
    });
  }

  Future<void> _loadNetSale() async {
    String url = "${root_url}selectnetsale.php";

    final Response = await http.get(
      Uri.parse(url).replace(
        queryParameters: {
          'sale_date':
              '${_datetime!.year}-${_datetime!.month}-${_datetime!.day}',
          'sale_date2':
              '${_datetime2!.year}-${_datetime2!.month}-${_datetime2!.day}',
          'username': glo_username,
        },
      ),
    );
    if (Response.statusCode == 200) {
      setState(() {
        if (json.decode(Response.body) != '') {
          Lst_netsale = json.decode(Response.body);
          glo_netsale = Lst_netsale;
          branchnetsale.clear();
          branchnetsale.add(Lst_netsale[0]["net_sale00"]);
          branchnetsale.add(Lst_netsale[0]["net_sale02"]);
          branchnetsale.add(Lst_netsale[0]["net_sale04"]);

          branchnetsale.add(Lst_netsale[0]["net_salePD"]);

          allnet =
              double.parse(Lst_netsale[0]["net_sale00"]) +
              double.parse(Lst_netsale[0]["net_sale02"]) +
              double.parse(Lst_netsale[0]["net_sale04"]) +
              double.parse(Lst_netsale[0]["net_salePD"]);
        } else {
          Lst_netsale = [
            {
              'net_sale00': '0',
              'net_sale02': '0',
              'net_sale04': '0',
              'net_salePD': '0',
            },
          ];

          branchnetsale.clear();
          branchnetsale.add('0.00');
          branchnetsale.add('0.00');
          branchnetsale.add('0.00');
          branchnetsale.add('0.00');

          allnet = 0;
        }
      });
    }
  }

  Future<void> _loadLastNetSale() async {
    String url = "${root_url}selectlastnetsale.php";

    final Response = await http.get(
      Uri.parse(url).replace(
        queryParameters: {
          'sale_date':
              '${_datetime!.year - 1}-${_datetime!.month}-${_datetime!.day}',
          'sale_date2': checkfebury(),
          //          '${_datetime2!.year - 1}-${_datetime2!.month}-${_datetime2!.day}',
          'username': glo_username,
        },
      ),
    );

    if (Response.statusCode == 200) {
      setState(() {
        if (json.decode(Response.body) != '') {
          Lst_Lastnetsale = json.decode(Response.body);
          //  glo_netsale = Lst_netsale;
          branchlastnetsale.clear();
          branchlastnetsale.add(Lst_Lastnetsale[0]["net_sale00"]);
          branchlastnetsale.add(Lst_Lastnetsale[0]["net_sale02"]);
          branchlastnetsale.add(Lst_Lastnetsale[0]["net_sale04"]);

          branchlastnetsale.add(Lst_Lastnetsale[0]["net_salePD"]);

          alllastnet =
              double.parse(Lst_Lastnetsale[0]["net_sale00"]) +
              double.parse(Lst_Lastnetsale[0]["net_sale02"]) +
              double.parse(Lst_Lastnetsale[0]["net_sale04"]) +
              double.parse(Lst_Lastnetsale[0]["net_salePD"]);
        } else {
          Lst_Lastnetsale = [
            {
              'net_sale00': '0',
              'net_sale02': '0',
              'net_sale04': '0',

              'net_salePD': '0',
            },
          ];

          branchlastnetsale.clear();
          branchlastnetsale.add('0.00');
          branchlastnetsale.add('0.00');
          branchlastnetsale.add('0.00');

          branchlastnetsale.add('0.00');

          alllastnet = 0;
        }
      });
    }
  }

  Future<void> _loadQ() async {
    String url = "${root_url}selectq.php";

    final Response = await http.get(
      Uri.parse(url).replace(
        queryParameters: {
          'sale_date':
              '${_datetime!.year}-${_datetime!.month}-${_datetime!.day}',
          'sale_date2':
              '${_datetime2!.year}-${_datetime2!.month}-${_datetime2!.day}',
          'username': glo_username,
        },
      ),
    );
    if (Response.statusCode == 200) {
      setState(() {
        if (json.decode(Response.body) != '') {
          Lst_q = json.decode(Response.body);
          //    glo_netsale = Lst_netsale;
          branchq.clear();
          branchq.add(Lst_q[0]["q_00"]);
          branchq.add(Lst_q[0]["q_02"]);
          branchq.add(Lst_q[0]["q_04"]);
          branchq.add(Lst_q[0]["q_PD"]);

          allq =
              int.parse(Lst_q[0]["q_00"]) +
              int.parse(Lst_q[0]["q_02"]) +
              int.parse(Lst_q[0]["q_04"]) +
              int.parse(Lst_q[0]["q_PD"]);
        } else {
          Lst_q = [
            {'q_00': '0', 'q_02': '0', 'q_04': '0', 'q_PD': '0'},
          ];

          branchq.clear();
          branchq.add('0');
          branchq.add('0');
          branchq.add('0');

          branchq.add('0');

          allq = 0;
        }
      });
    }
  }

  Widget _geticonupdown(int branchindex) {
    if (double.parse(branchnetsale[branchindex]) >
        double.parse(branchlastnetsale[branchindex])) {
      return Icon(Icons.arrow_upward_rounded, color: Colors.green);
    } else if (double.parse(branchnetsale[branchindex]) <
        double.parse(branchlastnetsale[branchindex])) {
      return Icon(Icons.arrow_downward_rounded, color: Colors.red);
    } else {
      return Icon(Icons.compare_arrows, color: Colors.blue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          "Sales Charts",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              refreshchart();
            },
          ),
        ],
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
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('DATE'),
                    const SizedBox(width: 4),

                    Container(
                      width: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          width: 1,
                          color: Colors.blueAccent,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              getDatePicker();
                            },
                            icon: const Icon(
                              Icons.calendar_month,
                              color: Color.fromARGB(255, 46, 212, 241),
                              size: 28,
                            ),
                          ),
                          Text(
                            '${_datetime!.day}/${_datetime!.month}/${_datetime!.year}  ',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 4),
                    Text('TO'),
                    const SizedBox(width: 4),

                    Container(
                      width: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          width: 1,
                          color: Colors.blueAccent,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              getDatePicker2();
                            },
                            icon: const Icon(
                              Icons.calendar_month,
                              color: Color.fromARGB(255, 46, 212, 241),
                              size: 28,
                            ),
                          ),
                          Text(
                            '${_datetime2!.day}/${_datetime2!.month}/${_datetime2!.year}  ',
                            style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),

            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 400,
              child: PageView.builder(
                controller: _pageController,
                itemCount: _countpage,
                itemBuilder: (context, index) {
                  return SizedBox(
                    child: Row(
                      children: [
                        Expanded(
                          child: (index + 1 == 1)
                              ? chartsview1()
                              : (index + 1 == 2)
                              ? chartsview2()
                              : (index + 1 == 3)
                              ? chartsview3()
                              : (index + 1 == 4)
                              ? chartsview4()
                              : (index + 1 == 5)
                              ? chartsview5()
                              : const SizedBox(),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                for (int i = 0; i < _countpage; i++)
                  Container(
                    margin: const EdgeInsets.all(2),
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey, width: 1.5),
                      color: _page - i > 1 || _page - i < -1
                          ? Colors.transparent
                          : _page - i > 0
                          ? Colors.grey.withOpacity(1 - (_page - i))
                          : Colors.grey.withOpacity(1 - (i - _page)),
                    ),
                  ),
              ],
            ),

            Container(
              //   height: 40.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.zero,
                //  color: Colors.green,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black, // Default color
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'ALL  ',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text:
                              'Net Sales: ' +
                              glo_format_currency.format(allnet) +
                              '฿ ', //.toStringAsFixed(2)
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text:
                              '(Last Yr.:' +
                              glo_format_currency.format(
                                alllastnet,
                              ) + //.toStringAsFixed(2)
                              '฿) \n ',

                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            fontSize: 14.0,
                          ),
                        ),

                        TextSpan(
                          text: 'Q: ' + allq.toString() + '',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 5),
            Expanded(
              child: Scrollbar(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    shape: BoxShape.rectangle,
                    border: Border.all(
                      width: 1,
                      color: Colors.blueAccent,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: ListView.builder(
                    itemCount: Lst_branch.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: ListTile(
                          leading: _geticonupdown(index),
                          //  const Icon(

                          //   Icons.summarize_outlined,
                          // ),
                          // Icon on the left
                          title: Text(Lst_branch[index]["branchname"]),
                          subtitle: RichText(
                            //      textAlign: TextAlign.center,
                            text: TextSpan(
                              text:
                                  'Net Sales: ${glo_format_currency.format(double.parse(branchnetsale[index]))}฿ ',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text:
                                      '(Last Yr.:${glo_format_currency.format(double.parse(branchlastnetsale[index]))}฿) \n',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),

                                TextSpan(
                                  text: 'Q: ${branchq[index]}',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          onTap: () {
                            glo_branchid = Lst_branch[index]["branchid"];
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const sale_detail();
                                },
                              ),
                            );
                          },
                        ),
                      );
                    },
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
