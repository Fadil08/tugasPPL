// import 'dart:io';


// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';


// class Mydescriptions extends StatefulWidget {
//   const Mydescriptions({super.key});

//   @override
//   State<Mydescriptions> createState() => _MydescriptionsState();
// }

// class _MydescriptionsState extends State<Mydescriptions> {
//   DateTime selectionsDate = DateTime.now();
//   final _date = TextEditingController();
//   File? image;
//   Future getImage() async {
//     final ImagePicker _picker = ImagePicker();
//     final XFile? imagePicked =
//         await _picker.pickImage(source: ImageSource.camera);
//     image = File(imagePicked!.path);
//     setState(() {});
//   }

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('data'),
//         ),
//         body: Container(
//           child: Stack(children: <Widget>[
//             Positioned(
//               top: 190,
//               left: 0,
//               height: size.height * 0.6,
//               width: size.width * 1,
//               child: Container(
//                 width: size.width * 1,
//                 height: size.height * 0.6,
//                 decoration: BoxDecoration(
//                     color: Color.fromARGB(255, 193, 207, 193),
//                     borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(30),
//                         topRight: Radius.circular(30))),
//               ),
//             ),
//             Positioned(
//               top: 250,
//               left: 30,
//               height: size.height * 0.3,
//               width: size.width * 0.8,
//               child: Container(
//                 width: 150,
//                 height: 150,
//                 child: TextField(
//                   cursorColor: Colors.black12,
//                   readOnly: true,
//                   inputFormatters: [LengthLimitingTextInputFormatter(70)],
//                   decoration: InputDecoration(
//                     contentPadding: const EdgeInsets.symmetric(
//                         vertical: 20, horizontal: 20),
//                     hintText: "enter note",
//                     fillColor: Color.fromARGB(255, 5, 0, 0),
//                     focusedBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(color: Colors.black12),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: BorderSide(color: Colors.black),
//                     ),
//                     errorBorder: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                       borderSide: const BorderSide(color: Colors.red),
//                     ),
//                   ),
//                   minLines: 6,
//                   keyboardType: TextInputType.multiline,
//                   maxLines: null,
//                 ),
//                 decoration: BoxDecoration(
//                     color: Color.fromARGB(255, 253, 255, 253),
//                     borderRadius: BorderRadius.circular(20)),
//               ),
//             ),
//             Positioned(
//               top: 100,
//               left: 80,
//               height: size.height * 0.2,
//               width: size.width * 0.4,
//               child: Container(
//                 width: size.width * 0.3,
//                 height: size.height * 0.3,
//                 decoration: BoxDecoration(
//                     color: Color.fromARGB(255, 48, 122, 48),
//                     borderRadius: BorderRadius.circular(30)),
//               ),
//             ),
//             Positioned(
//               top: size.height * 0.8,
//               left: size.width * 0.3,
//               height: size.height * 0.05,
//               width: size.width * 0.3,
//               child: Container(
//                 child: TextButton(
//                   child: Text(
//                     'Tambah',
//                     style: TextStyle(color: Color.fromARGB(255, 2, 97, 51)),
//                   ),
//                   onPressed: () {},
//                 ),
//                 decoration: BoxDecoration(
//                     color: Color.fromARGB(255, 255, 255, 255),
//                     borderRadius: BorderRadius.circular(20)),
//               ),
//             ),
//             Positioned(
//               top: size.height * 0.55,
//               left: size.width * 0.1,
//               height: size.height * 0.05,
//               width: size.width * 0.7,
//               child: TextField(
//                 controller: _date,
//                 decoration: InputDecoration(
//                   fillColor: Colors.black,
//                   filled: true,
//                   border: OutlineInputBorder(),
//                   labelText: 'date',
//                   icon: IconButton(
//                     icon: Icon(
//                       Icons.date_range_outlined,
//                       color: Colors.black,
//                     ),
//                     onPressed: () {
//                       showDatePicker(
//                               context: context,
//                               initialDate: DateTime.now(),
//                               firstDate: DateTime(2000),
//                               lastDate: DateTime(2030),
//                               initialEntryMode: DatePickerEntryMode.input)
//                           .then((value) {
//                         if (value != null) {
//                           setState(() {
//                             _date.text = value.toString();
//                           });
//                         }
//                       });
//                     },
//                   ),
//                 ),
//               ),
//             )
//             // Container(
//             //   child: IconButton(
//             //       onPressed: () async {
//             //         await getImage();
//             //       },
//             //       icon: Icon(
//             //         Icons.upload_file_outlined,
//             //         color: Color.fromARGB(255, 0, 6, 15),
//             //       )),
//             // )
//           ]),
//         ));
//   }
// }
