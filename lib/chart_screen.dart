// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// class BarChartSample1 extends StatefulWidget {
//   final Map<String, int> userCounts;
//
//   BarChartSample1({
//     super.key,
//     required this.userCounts,
//   });
//
//   @override
//   State<StatefulWidget> createState() => BarChartSample1State();
// }
//
// class BarChartSample1State extends State<BarChartSample1> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
//       height: 116,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Text(
//             "Monthly Patients",
//           style: TextStyle(fontSize: 16),
//           ),
//           AspectRatio(
//             aspectRatio: 2,
//             child: Padding(
//               padding: const EdgeInsets.all(16),
//               child: BarChart(
//                 BarChartData(
//                   titlesData: FlTitlesData(
//                     show: true,
//                     rightTitles: const AxisTitles(
//                       sideTitles: SideTitles(showTitles: false),
//                     ),
//                     topTitles: const AxisTitles(
//                       sideTitles: SideTitles(showTitles: false),
//                     ),
//                     bottomTitles: AxisTitles(
//                       sideTitles: SideTitles(
//                         showTitles: true,
//                         getTitlesWidget: getTitlesWidget,
//                         reservedSize: 38,
//                       ),
//                     ),
//                     leftTitles: AxisTitles(
//                       sideTitles: SideTitles(
//                         showTitles: false,
//                       ),
//                     ),
//                   ),
//                   borderData: FlBorderData(
//                     show: false,
//                   ),
//                   barGroups: _buildBarChartData(widget.userCounts),
//                   gridData: const FlGridData(show: false),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Build bar chart data from user counts
//   List<BarChartGroupData> _buildBarChartData(Map<String, int> counts) {
//     // Define all 12 months initialized to 0
//     Map<String, int> allMonths = {
//       'Jan': 0,
//       'Feb': 0,
//       'Mar': 0,
//       'Apr': 0,
//       'May': 0,
//       'Jun': 0,
//       'Jul': 0,
//       'Aug': 0,
//       'Sep': 0,
//       'Oct': 0,
//       'Nov': 0,
//       'Dec': 0,
//     };
//
//     counts.forEach((month, count) {
//       String monthAbbreviation = month.substring(0, 3);
//       if (allMonths.containsKey(monthAbbreviation)) {
//         allMonths[monthAbbreviation] = count;
//       }
//     });
//
//     // Create BarChartGroupData from allMonths
//     List<BarChartGroupData> barGroups = [];
//     int index = 0;
//
//     allMonths.forEach((month, count) {
//       barGroups.add(
//         BarChartGroupData(
//           x: index,
//           barRods: [
//             BarChartRodData(
//               toY: count.toDouble(),
//               color: Colors.blue, // Customize bar color
//               width: 16, // Width of the bars
//             ),
//           ],
//         ),
//       );
//       index++;
//     });
//
//     return barGroups;
//   }
//
//   Widget getTitlesWidget(double value, TitleMeta meta) {
//     const style = TextStyle(
//       color: Colors.black,
//       fontWeight: FontWeight.bold,
//       fontSize: 14,
//     );
//     final titles = [
//       'Jan',
//       'Feb',
//       'Mar',
//       'Apr',
//       'May',
//       'Jun',
//       'Jul',
//       'Aug',
//       'Sep',
//       'Oct',
//       'Nov',
//       'Dec'
//     ];
//     final text = value.toInt() < titles.length
//         ? Text(titles[value.toInt()], style: style)
//         : const Text('', style: style);
//     return SideTitleWidget(
//       axisSide: meta.axisSide,
//       space: 16,
//       child: text,
//     );
//   }
// }
//
// Future<Map<String, int>> getUserCountByMonth() async {
//   Map<String, int> userCountByMonth = {};
//
//   QuerySnapshot snapshot =
//   await FirebaseFirestore.instance.collection('users').get();
//
//   for (var doc in snapshot.docs) {
//     Timestamp joinDateTimestamp = doc['joinDate'];
//     DateTime joinDate = joinDateTimestamp.toDate();
//     String formattedDate = DateFormat('MMMM yyyy').format(joinDate);
//
//     if (userCountByMonth.containsKey(formattedDate)) {
//       userCountByMonth[formattedDate] = userCountByMonth[formattedDate]! + 1;
//     } else {
//       userCountByMonth[formattedDate] = 1;
//     }
//   }
//
//   return userCountByMonth;
// }


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:tabibinet_project/model/res/widgets/text_widget.dart';

import 'constant.dart';
import 'model/res/constant/app_fonts.dart';

class PatientStatusChart extends StatelessWidget {
  const PatientStatusChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75.w,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: bgColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            text: "Patient Status",
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            isTextCenter: false,
            textColor: textColor,
            fontFamily: AppFonts.semiBold,
          ),
          const SizedBox(height: 20),
          Container(
            decoration: const BoxDecoration(
              color: bgColor,
            ),
            child: FutureBuilder<List<FlSpot>>(
              future: getUserCountByMonth(), // Updated to FutureBuilder
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator()); // Loading state
                } else if (snapshot.hasError) {
                  return const Text('Error loading data');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Text('No data available');
                }

                return Column(
                  children: [
                    SizedBox(
                      height: 250,
                      child: LineChart(
                        LineChartData(
                          minX: 0,
                          maxX: 11,
                          minY: 0,
                          maxY: 200,
                          titlesData: FlTitlesData(
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 30,
                                getTitlesWidget: (value, meta) {
                                  const months = [
                                    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                                    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
                                  ];
                                  return Text(
                                    months[value.toInt()],
                                    style: const TextStyle(fontFamily: AppFonts.regular),
                                  );
                                },
                              ),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 40,
                                getTitlesWidget: (value, meta) {
                                  return Text(
                                    value.toInt().toString(),
                                    style: const TextStyle(fontFamily: AppFonts.regular),
                                  );
                                },
                              ),
                            ),
                          ),
                          gridData: const FlGridData(show: true),
                          borderData: FlBorderData(show: true),
                          lineBarsData: [
                            LineChartBarData(
                              spots: snapshot.data!, // The data is now available
                              isCurved: true,
                              color: Colors.lightBlueAccent,
                              barWidth: 4,
                              belowBarData: BarAreaData(
                                show: true,
                                color: Colors.lightBlueAccent.withOpacity(0.3),
                              ),
                            ),
                          ],
                          lineTouchData: LineTouchData(
                            touchTooltipData: LineTouchTooltipData(
                              getTooltipItems: (touchedSpots) {
                                return touchedSpots.map((LineBarSpot touchedSpot) {
                                  return LineTooltipItem(
                                    '${touchedSpot.y.toInt()} \nSep 2024',
                                    const TextStyle(color: Colors.white),
                                  );
                                }).toList();
                              },
                            ),
                            touchCallback: (FlTouchEvent event, LineTouchResponse? response) {},
                            handleBuiltInTouches: true,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 15,
                          width: 15,
                          decoration: BoxDecoration(
                              color: themeColor,
                              borderRadius: BorderRadius.circular(2)
                          ),
                        ),
                        SizedBox(width: .5.w),
                        TextWidget(
                          text: "Recovered",
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                          isTextCenter: false,
                          textColor: textColor,
                          fontFamily: AppFonts.medium,
                        ),
                        SizedBox(width: 3.w),
                        Container(
                          height: 15,
                          width: 15,
                          decoration: BoxDecoration(
                              color: Colors.lightBlueAccent,
                              borderRadius: BorderRadius.circular(2)
                          ),
                        ),
                        SizedBox(width: .5.w),
                        TextWidget(
                          text: "Death",
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                          isTextCenter: false,
                          textColor: textColor,
                          fontFamily: AppFonts.medium,
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<List<FlSpot>> getUserCountByMonth() async {
    List<FlSpot> spots = [];
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('users').get();

    Map<int, int> monthlyCounts = {}; // Use integer for month index

    for (var doc in snapshot.docs) {
      Timestamp joinDateTimestamp = doc['joinDate'];
      DateTime joinDate = joinDateTimestamp.toDate();
      int monthIndex = joinDate.month - 1; // Get the month index (0-11)

      if (monthlyCounts.containsKey(monthIndex)) {
        monthlyCounts[monthIndex] = monthlyCounts[monthIndex]! + 1;
      } else {
        monthlyCounts[monthIndex] = 1;
      }
    }

    // Convert the map into a list of FlSpot
    monthlyCounts.forEach((month, count) {
      spots.add(FlSpot(month.toDouble(), count.toDouble()));
    });

    return spots;
  }
}
