// import 'package:flutter/material.dart';
// import 'utils/custom_color.dart';
// import 'add_vaccine_history.dart';

// class UpdateVaccinesHistory extends StatefulWidget {
//   final String? petId;

//   // Constructor
//   const UpdateVaccinesHistory({required Key key, this.petId}) : super(key: key);

//   @override
//   State<StatefulWidget> createState() {
//     return _NewVaccineState();
//   }
// }

// class _NewVaccineState extends State<UpdateVaccinesHistory> {
//   TextEditingController dateController = TextEditingController();

//   @override
//   void dispose() {
//     dateController.dispose();
//     super.dispose();
//   }

//   void selectDate(BuildContext context) async {
//     DateTime? selectedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime(2101),
//     );
//   }
//   @override
//   Widget build(BuildContext context) {
//     // Implement your widget build here
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Row(
//           children: <Widget>[
//             Expanded(
//               child: Center(
//                 child: Text(
//                   'PetGuardian',
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ),
//             IconButton(
//               iconSize: 35,
//               icon: Icon(
//                 Icons.add,
//                 color: Colors.black,
//               ),
//               onPressed: () {
//                 // Navigator.push(
//                 //   context,
//                 //   MaterialPageRoute(builder: (context) => AddVaccinesHistory()),
//                 // );
//               },
//             ),
//           ],
//         ),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Icon(Icons.vaccines, size: 30), // Adjust size as needed
//                 SizedBox(height: 10),
//                 Text(
//                   'Rabies',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(
//                         horizontal: 10.0), // Adjust the padding as needed
//                     child: Text('VACCINE', style: TextStyle(fontSize: 15)),
//                   ),
//                 ),
//                 Container(
//                   color: CustomColor.backGroundColor,
//                   padding: const EdgeInsets.all(20.0),
//                   height: 80.0, // Set the height of the TextFormField
//                   child: TextFormField(
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10.0),
//                       ),
//                       fillColor: CustomColor.vaccinRegColor,
//                       filled: true,
//                       contentPadding: const EdgeInsets.symmetric(
//                         vertical: 10.0,
//                         horizontal: 10.0,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(
//                         horizontal: 10.0), // Adjust the padding as needed
//                     child: Text('RE-VACCINE REMINDER',
//                         style: TextStyle(fontSize: 15)),
//                   ),
//                 ),
//                 Container(
//                   color: CustomColor.backGroundColor,
//                   padding: const EdgeInsets.all(20.0),
//                   height: 80.0, // Set the height of the TextFormField
//                     child: TextFormField(
//                             controller: dateController,
//                             decoration: InputDecoration(
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10.0),
//                               ),
//                               fillColor: CustomColor.vaccinRegColor,
//                               filled: true,
//                               labelText: 'Date of Vaccine Application',
//                               contentPadding: const EdgeInsets.symmetric(
//                                 vertical: 10.0,
//                                 horizontal: 10.0,
//                               ),
//                               suffixIcon: IconButton(
//                                 icon: const Icon(Icons.calendar_today),
//                                 onPressed: () {
//                                   selectDate(context);
//                                 },
//                               ),
//                             ),
//                             readOnly: true, // Make the TextFormField read-only
//                             onTap: () {
//                               selectDate(context);
//                             },
//                           ),
//                 ),
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(
//                         horizontal: 10.0), // Adjust the padding as needed
//                     child: Text('VACCINATION HISTORY',
//                         style: TextStyle(fontSize: 15)),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
