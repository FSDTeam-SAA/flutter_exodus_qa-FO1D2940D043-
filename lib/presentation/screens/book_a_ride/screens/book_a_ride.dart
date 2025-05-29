// import 'package:exodus/presentation/widgets/build_title.dart';
// import 'package:flutter/material.dart';

// import '../../../../core/constants/app/app_colors.dart';
// import '../../../../core/constants/app/app_gap.dart';
// import '../../../../core/constants/app/app_sizes.dart';
// import '../../../../core/theme/text_style.dart';
// import '../../../../core/utils/date_utils.dart';
// import '../../../theme/app_styles.dart';
// import '../../../widgets/app_scaffold.dart';
// import '../../../widgets/arrow_icon_widget.dart';

// class BookARideScreen extends StatelessWidget {
//   const BookARideScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return AppScaffold(
//       removePadding: true,
//       appBar: AppBar(
//         title: Text("Book a Ride", style: AppText.h2),
//         actions: [
//           /// [Reserve Bus] button
//           Container(
//             width: 117,
//             height: 37,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.all(Radius.circular(8)),
//               gradient: AppColors.primaryGradient,
//             ),
//             child: Center(
//               child: Text(
//                 "Reserve Bus",
//                 style: AppText.smallMedium.copyWith(
//                   color: AppColors.background,
//                 ),
//               ),
//             ),
//           ),
//           Gap.w18,
//         ],
//       ),
//       body: ListView(
//         physics: const BouncingScrollPhysics(),
//         children: [
//           _locationSelect(),
//           Gap.h24,
//           _dateSelect(),
//           Gap.h24,
//           TitleTextWidget(title: "Available Shuttles"),
//           Gap.h16,
//           _availableShuttles(),

//           Gap.bottomAppBarGap,
//         ],
//       ),
//     );
//   }

//   Widget _locationSelect() {
//     return Padding(
//       padding: AppSizes.paddingHorizontalMedium,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Icon(
//                 Icons.location_on_outlined,
//                 size: 16,
//                 color: AppColors.secondary,
//               ),
//               Gap.w8,
//               Text("From", style: AppText.bodyRegular),
//             ],
//           ),
//           Gap.h16,
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//             decoration: BoxDecoration(
//               border: Border.all(color: AppColors.secondary),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Row(
//               children: [
//                 // Icon(Icons.location_on_outlined, color: AppColors.secondary),
//                 // Gap.w8,
//                 Text("Any location", style: AppText.bodyRegular),
//               ],
//             ),
//           ),
//           Gap.h16,
//           Row(
//             children: [
//               Icon(
//                 Icons.location_on_outlined,
//                 size: 16,
//                 color: AppColors.secondary,
//               ),
//               Gap.w8,
//               Text("To", style: AppText.bodyRegular),
//             ],
//           ),
//           Gap.h8,
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
//             decoration: BoxDecoration(
//               border: Border.all(color: AppColors.secondary),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Row(
//               children: [Text("Any location", style: AppText.bodyRegular)],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _dateSelect() {
//     final dates = DateUtilsForThirtyDays.getFormattedNextDays();

//     return Padding(
//       padding: AppSizes.paddingHorizontalMedium,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Icon(
//                 Icons.calendar_today_outlined,
//                 size: 16,
//                 color: AppColors.secondary,
//               ),
//               Gap.w8,
//               Text("Select Date", style: AppText.smallRegular),
//             ],
//           ),
//           Gap.h8,
//           SizedBox(
//             height: 60,
//             child: ListView.separated(
//               scrollDirection: Axis.horizontal,
//               itemCount: dates.length,
//               separatorBuilder: (context, index) => Gap.w8,
//               itemBuilder: (context, index) {
//                 final isToday = index == 0;
//                 return Container(
//                   width: 60,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(8),
//                     color: isToday ? AppColors.secondary : AppColors.secondary,
//                   ),
//                   child: Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           dates[index]['day']!,

//                           style: AppText.smallRegular.copyWith(
//                             color: AppColors.background,
//                           ),
//                         ),
//                         Text(
//                           dates[index]['date']!,

//                           style: AppText.h2.copyWith(
//                             color: AppColors.background,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _availableShuttles() {
//     final rides = List.generate(
//       4,
//       (index) => {
//         'route': 'West Bay to Al Wakra',
//         'time': '08:30am - 09:15am',
//         'seats': '7 seats left',
//       },
//     );

//     return Padding(
//       padding: AppSizes.paddingHorizontalMedium,
//       child: Container(
//         decoration: AppDecorations.card,

//         child: Column(
//           children:
//               rides.asMap().entries.map((entry) {
//                 final index = entry.key;
//                 final ride = entry.value;
//                 final isLastItem = index == rides.length - 1;

//                 return Column(
//                   children: [
//                     Padding(
//                       padding: AppSizes.paddingAllMedium,
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 /// [Soure] to [Destination] Ticket
//                                 Wrap(
//                                   crossAxisAlignment: WrapCrossAlignment.center,
//                                   spacing: 4, // Equivalent to Gap.w4
//                                   runSpacing:
//                                       4, // Optional vertical spacing between lines
//                                   children: [
//                                     Text("West Bay", style: AppText.h3),
//                                     ArrowIcon(),
//                                     Text("Al Wakra", style: AppText.h3),
//                                   ],
//                                 ),

//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       ride['time']!,
//                                       style: const TextStyle(
//                                         color: AppColors.secondary,
//                                       ),
//                                     ),
//                                     Text(
//                                       ride['seats']!,
//                                       style: const TextStyle(
//                                         color: AppColors.secondary,
//                                       ),
//                                     ),
//                                   ],
//                                 ),

//                                 Gap.h12,

//                                 /// [Bus Name] Shuttle
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Text(
//                                       "Appple Red Bus",
//                                       style: AppText.smallRegular,
//                                     ),
//                                     _goldButton("Book"),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     if (!isLastItem) // Only add divider if not the last item
//                       Divider(
//                         color: AppColors.secondary,
//                         height: 16, // Adjust height as needed
//                         thickness: 1,
//                       ),
//                   ],
//                 );
//               }).toList(),
//         ),
//       ),
//     );
//   }

//   // Widget _availableShuttles() {
//   //   return ListView.separated(
//   //     physics: NeverScrollableScrollPhysics(),
//   //     shrinkWrap: true,
//   //     itemCount: 4,
//   //     separatorBuilder: (context, index) => Gap.h16,
//   //     itemBuilder: (context, index) {
//   //       return Container(
//   //         decoration: BoxDecoration(
//   //           border: Border.all(color: AppColors.secondary),
//   //           borderRadius: BorderRadius.circular(8),
//   //         ),
//   //         child: Padding(
//   //           padding: const EdgeInsets.all(16),
//   //           child: Column(
//   //             crossAxisAlignment: CrossAxisAlignment.start,
//   //             children: [
//   //               Text("West Bay to Al Wakra", style: AppText.smallMedium),
//   //               Gap.h8,
//   //               Text("08:30am - 09:15am", style: AppText.smallRegular),
//   //               Gap.h8,
//   //               Text("7 seats left", style: AppText.smallRegular),
//   //               Gap.h16,

//   //               /// [Source] to [Destination] Shuttle
//   //               Row(
//   //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   //                 children: [
//   //                   Row(
//   //                     children: [
//   //                       Text("West Bay", style: AppText.smallRegular),
//   //                       Icon(
//   //                         Icons.arrow_forward,
//   //                         color: AppColors.primary,
//   //                         size: 16,
//   //                       ),
//   //                       Text("Al Wakra", style: AppText.smallRegular),
//   //                     ],
//   //                   ),

//   //                   _goldButton("Book"),
//   //                 ],
//   //               ),
//   //             ],
//   //           ),
//   //         ),
//   //       );
//   //     },
//   //   );
//   // }

//   Widget _goldButton(String text) {
//     return Container(
//       height: 27,
//       padding: AppSizes.paddingHorizontalTiny,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(32),
//         gradient: AppColors.primaryGradient,
//       ),
//       child: Center(
//         child: Text(
//           text,
//           style: AppText.bodyMedium.copyWith(color: AppColors.background),
//         ),
//       ),
//     );
//   }

//   // Widget _buildBottomNavBar() {
//   //   return BottomAppBar(
//   //     child: SizedBox(
//   //       height: 60,
//   //       child: Row(
//   //         mainAxisAlignment: MainAxisAlignment.spaceAround,
//   //         children: [
//   //           IconButton(icon: Icon(Icons.home), onPressed: () {}),
//   //           IconButton(
//   //             icon: Icon(Icons.directions_bus, color: AppColors.primary),
//   //             onPressed: () {},
//   //           ),
//   //           IconButton(icon: Icon(Icons.subscriptions), onPressed: () {}),
//   //           IconButton(icon: Icon(Icons.person), onPressed: () {}),
//   //         ],
//   //       ),
//   //     ),
//   //   );
//   // }
// }
