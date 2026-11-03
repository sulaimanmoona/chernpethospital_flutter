import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:ChernPetHospital/app.dart';

class chartsview2 extends StatelessWidget {
  Widget bottomTitles2(double value, TitleMeta meta) {
    String text;
    switch (value.toInt()) {
      case 0:
        text = '12';
        break;
      case 1:
        text = '13';
        break;
      case 2:
        text = '14';
        break;
      case 3:
        text = '15';
        break;
      case 4:
        text = '20';
        break;
      case 5:
        text = '21';
        break;
      case 6:
        text = '24';
        break;
      case 7:
        text = '26';
        break;
      case 8:
        text = '27';
        break;
      case 9:
        text = '28';
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

  Widget leftTitles2(double value, TitleMeta meta) {
    if (value == meta.max) {
      return Container();
    }

    return SideTitleWidget(
      meta: meta,
      child: Text(meta.formattedValue, style: const TextStyle(fontSize: 10)),
    );
  }

  List<BarChartGroupData> getData2(double barsWidth, double barsSpace) {
    return [
      BarChartGroupData(
        x: 0,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: double.parse(glo_netsale[0]["net_sale12"]),
            rodStackItems: [
              BarChartRodStackItem(
                0,
                double.parse(glo_netsale[0]["net_sale12"]),
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
            toY: double.parse(glo_netsale[0]["net_sale13"]),
            rodStackItems: [
              BarChartRodStackItem(
                0,
                double.parse(glo_netsale[0]["net_sale13"]),
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
            toY: double.parse(glo_netsale[0]["net_sale14"]),
            rodStackItems: [
              BarChartRodStackItem(
                0,
                double.parse(glo_netsale[0]["net_sale14"]),
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
            toY: double.parse(glo_netsale[0]["net_sale15"]),
            rodStackItems: [
              BarChartRodStackItem(
                0,
                double.parse(glo_netsale[0]["net_sale15"]),
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
            toY: double.parse(glo_netsale[0]["net_sale20"]),
            rodStackItems: [
              BarChartRodStackItem(
                0,
                double.parse(glo_netsale[0]["net_sale20"]),
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
            toY: double.parse(glo_netsale[0]["net_sale21"]),
            rodStackItems: [
              BarChartRodStackItem(
                0,
                double.parse(glo_netsale[0]["net_sale21"]),
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
            toY: double.parse(glo_netsale[0]["net_sale24"]),
            rodStackItems: [
              BarChartRodStackItem(
                0,
                double.parse(glo_netsale[0]["net_sale24"]),
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
            toY: double.parse(glo_netsale[0]["net_sale26"]),
            rodStackItems: [
              BarChartRodStackItem(
                0,
                double.parse(glo_netsale[0]["net_sale26"]),
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
            toY: double.parse(glo_netsale[0]["net_sale27"]),
            rodStackItems: [
              BarChartRodStackItem(
                0,
                double.parse(glo_netsale[0]["net_sale27"]),
                Colors.blue,
              ),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
        ],
      ),

      BarChartGroupData(
        x: 9,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: double.parse(glo_netsale[0]["net_sale28"]),
            rodStackItems: [
              BarChartRodStackItem(
                0,
                double.parse(glo_netsale[0]["net_sale28"]),
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

  const chartsview2({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
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
                final barsSpace = 4.0 * constraints.maxWidth / 200; //400;
                final barsWidth = 8.0 * constraints.maxWidth / 100; // 400;
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
                          getTitlesWidget: bottomTitles2,
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          getTitlesWidget: leftTitles2,
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
                      checkToShowHorizontalLine: (value) => value % 10 == 0,
                      getDrawingHorizontalLine: (value) =>
                          const FlLine(color: Colors.black, strokeWidth: 1),
                      drawVerticalLine: false,
                    ),
                    borderData: FlBorderData(show: false),
                    groupsSpace: barsSpace,
                    barGroups: getData2(barsWidth, barsSpace),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
