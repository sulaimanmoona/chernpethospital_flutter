import 'package:ChernPetHospital/app.dart';
import 'package:ChernPetHospital/screens/saledetail_form.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class chart_sales extends StatefulWidget {
  const chart_sales({super.key});

  @override
  State<chart_sales> createState() => _chart_salesState();
}

class _chart_salesState extends State<chart_sales> {
  double allnet = 0;
  DateTime? _datetime = DateTime.now();
  DateTime? _datetime2 = DateTime.now();
  List Lst_branch = [];
  List Lst_netsale = [
    {
      'sale_date': '',
      'net_sale00': '0',
      'net_sale01': '0',
      'net_sale02': '0',
      'net_sale03': '0',
      'net_sale04': '0',
      'net_sale05': '0',
      'net_sale06': '0',
      'net_sale07': '0',
      'net_sale08': '0',
      'net_sale09': '0',

      'net_sale10': '0',
      'net_sale11': '0',
      'net_sale12': '0',
      'net_sale13': '0',
      'net_sale14': '0',
      'net_sale15': '0',
      'net_sale16': '0',
      'net_sale17': '0',
      'net_sale18': '0',
      'net_sale19': '0',

      'net_sale20': '0',
      'net_sale21': '0',
      'net_sale22': '0',
      'net_sale23': '0',
      'net_sale24': '0',
      'net_sale25': '0',
      'net_sale26': '0',
      'net_sale27': '0',
      'net_sale28': '0',
      'net_sale29': '0',

      'net_sale30': '0',
      'net_sale31': '0',
      'net_sale32': '0',
      'net_sale33': '0',
      'net_sale34': '0',
      'net_sale35': '0',
      'net_sale36': '0',
      'net_sale37': '0',
      'net_sale38': '0',
      'net_sale39': '0',

      'net_sale40': '0',
    },
  ];

  List<String> branchnetsale = [
    '0.00',
    '0.00',
    '0.00',
    '0.00',
    '0.00',
    '0.00',
    '0.00',
    '0.00',
    '0.00',
    '0.00',
    '0.00',
    '0.00',
    '0.00',
    '0.00',
    '0.00',
    '0.00',
    '0.00',
    '0.00',
    '0.00',
    '0.00',
    '0.00',
    '0.00',
    '0.00',
    '0.00',
    '0.00',
    '0.00',
    '0.00',
    '0.00',
    '0.00',
    '0.00',
    '0.00',
    '0.00',
    '0.00',
    '0.00',
    '0.00',
    '0.00',
    '0.00',
    '0.00',
    '0.00',
    '0.00',
    '0.00',
  ];

  @override
  void initState() {
    super.initState();
    _loadbranch();
    _loadNetSale();
  }

  void refreshchart() {
    _loadNetSale();
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

          branchnetsale.clear();
          branchnetsale.add(Lst_netsale[0]["net_sale00"]);
          branchnetsale.add(Lst_netsale[0]["net_sale01"]);
          branchnetsale.add(Lst_netsale[0]["net_sale02"]);
          branchnetsale.add(Lst_netsale[0]["net_sale03"]);
          branchnetsale.add(Lst_netsale[0]["net_sale04"]);
          branchnetsale.add(Lst_netsale[0]["net_sale05"]);
          branchnetsale.add(Lst_netsale[0]["net_sale06"]);
          branchnetsale.add(Lst_netsale[0]["net_sale07"]);
          branchnetsale.add(Lst_netsale[0]["net_sale08"]);

          allnet =
              double.parse(Lst_netsale[0]["net_sale00"]) +
              double.parse(Lst_netsale[0]["net_sale01"]) +
              double.parse(Lst_netsale[0]["net_sale02"]) +
              double.parse(Lst_netsale[0]["net_sale03"]) +
              double.parse(Lst_netsale[0]["net_sale04"]) +
              double.parse(Lst_netsale[0]["net_sale05"]) +
              double.parse(Lst_netsale[0]["net_sale06"]) +
              double.parse(Lst_netsale[0]["net_sale07"]) +
              double.parse(Lst_netsale[0]["net_sale08"]);
        } else {
          Lst_netsale = [
            {
              'sale_date': '',
              'net_sale00': '0',
              'net_sale01': '0',
              'net_sale02': '0',
              'net_sale03': '0',
              'net_sale04': '0',
              'net_sale05': '0',
              'net_sale06': '0',
              'net_sale07': '0',
              'net_sale08': '0',
            },
          ];

          branchnetsale.clear();
          branchnetsale.add('0.00');
          branchnetsale.add('0.00');
          branchnetsale.add('0.00');
          branchnetsale.add('0.00');
          branchnetsale.add('0.00');
          branchnetsale.add('0.00');
          branchnetsale.add('0.00');
          branchnetsale.add('0.00');
          branchnetsale.add('0.00');

          allnet = 0;
        }
      });
    }
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    String text;
    switch (value.toInt()) {
      case 0:
        text = '00';
        break;
      case 1:
        text = '01';
        break;
      case 2:
        text = '02';
        break;
      case 3:
        text = '03';
        break;
      case 4:
        text = '04';
        break;
      case 5:
        text = '05';
        break;
      case 6:
        text = '06';
        break;
      case 7:
        text = '07';
        break;
      case 8:
        text = '08';
        break;

      default:
        text = '';
        break;
    }

    return SideTitleWidget(
      meta: meta,
      child: Text(text, style: const TextStyle(fontSize: 10)),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    if (value == meta.max) {
      return Container();
    }

    return SideTitleWidget(
      meta: meta,
      child: Text(meta.formattedValue, style: const TextStyle(fontSize: 10)),
    );
  }

  List<BarChartGroupData> getData(double barsWidth, double barsSpace) {
    return [
      BarChartGroupData(
        x: 0,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: double.parse(Lst_netsale[0]["net_sale00"]),
            rodStackItems: [
              BarChartRodStackItem(
                0,
                double.parse(Lst_netsale[0]["net_sale00"]),
                Colors.blue,
              ),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
        ],
      ),
      BarChartGroupData(
        x: 1,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: double.parse(Lst_netsale[0]["net_sale01"]),
            rodStackItems: [
              BarChartRodStackItem(
                0,
                double.parse(Lst_netsale[0]["net_sale01"]),
                Colors.blue,
              ),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
        ],
      ),
      BarChartGroupData(
        x: 2,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: double.parse(Lst_netsale[0]["net_sale02"]),
            rodStackItems: [
              BarChartRodStackItem(
                0,
                double.parse(Lst_netsale[0]["net_sale02"]),
                Colors.blue,
              ),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
        ],
      ),
      BarChartGroupData(
        x: 3,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: double.parse(Lst_netsale[0]["net_sale03"]),
            rodStackItems: [
              BarChartRodStackItem(
                0,
                double.parse(Lst_netsale[0]["net_sale03"]),
                Colors.blue,
              ),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
        ],
      ),
      BarChartGroupData(
        x: 4,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: double.parse(Lst_netsale[0]["net_sale04"]),
            rodStackItems: [
              BarChartRodStackItem(
                0,
                double.parse(Lst_netsale[0]["net_sale04"]),
                Colors.blue,
              ),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
        ],
      ),
      BarChartGroupData(
        x: 5,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: double.parse(Lst_netsale[0]["net_sale05"]),
            rodStackItems: [
              BarChartRodStackItem(
                0,
                double.parse(Lst_netsale[0]["net_sale05"]),
                Colors.blue,
              ),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
        ],
      ),
      BarChartGroupData(
        x: 6,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: double.parse(Lst_netsale[0]["net_sale06"]),
            rodStackItems: [
              BarChartRodStackItem(
                0,
                double.parse(Lst_netsale[0]["net_sale06"]),
                Colors.blue,
              ),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
        ],
      ),
      BarChartGroupData(
        x: 7,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: double.parse(Lst_netsale[0]["net_sale07"]),
            rodStackItems: [
              BarChartRodStackItem(
                0,
                double.parse(Lst_netsale[0]["net_sale07"]),
                Colors.blue,
              ),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
        ],
      ),
      BarChartGroupData(
        x: 8,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: double.parse(Lst_netsale[0]["net_sale08"]),
            rodStackItems: [
              BarChartRodStackItem(
                0,
                double.parse(Lst_netsale[0]["net_sale08"]),
                Colors.blue,
              ),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
        ],
      ),
    ];
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
          // IconButton(
          //   icon: const Icon(Icons.refresh),
          //   onPressed: () {
          //     refreshchart();
          //   },
          // ),
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
                    const SizedBox(width: 5),
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
                              color: Colors.black,
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

                    const SizedBox(width: 5),
                    Text('TO'),
                    const SizedBox(width: 5),

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
                              color: Colors.black,
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

              child: Center(
                child: AspectRatio(
                  aspectRatio: 1, // 1.66,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final barsSpace =
                            4.0 * constraints.maxWidth / 200; //400;
                        final barsWidth =
                            8.0 * constraints.maxWidth / 100; // 400;
                        return BarChart(
                          BarChartData(
                            alignment: BarChartAlignment.center,
                            barTouchData: const BarTouchData(enabled: false),
                            titlesData: FlTitlesData(
                              show: true,
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 20,
                                  getTitlesWidget: bottomTitles,
                                ),
                              ),
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  reservedSize: 40,
                                  getTitlesWidget: leftTitles,
                                ),
                              ),
                              topTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              rightTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                            ),
                            gridData: FlGridData(
                              show: true,
                              checkToShowHorizontalLine: (value) =>
                                  value % 10 == 0,
                              getDrawingHorizontalLine: (value) => const FlLine(
                                color: Colors.black,
                                strokeWidth: 1,
                              ),
                              drawVerticalLine: false,
                            ),
                            borderData: FlBorderData(show: false),
                            groupsSpace: barsSpace,
                            barGroups: getData(barsWidth, barsSpace),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
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
                  Text(
                    '  NET ALL : ' + allnet.toString() + '฿',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
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
                          leading: const Icon(
                            Icons.summarize_outlined,
                          ), // Icon on the left
                          title: Text(Lst_branch[index]["branchname"]),
                          subtitle: Text(
                            'Net Sales : ${branchnetsale[index]}฿',
                            style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
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
