// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:share/user/aplication/user_login_bloc/user_login_bloc.dart';
// import 'package:share/user/aplication/user_login_bloc/user_login_event.dart';
// import 'package:share/user/domain/functions/user_firestroe_funciton.dart';
// import 'package:share/user/domain/functions/user_function.dart';
// import 'package:share/user/presentation/pages/userLogin/user_login_page.dart';
// import 'package:share/user/presentation/widgets/styles.dart';

// class ProfileEditingPage extends StatefulWidget {
//   String name;
//   String phone;
//   String image;
//   ProfileEditingPage(
//       {required this.name,
//       required this.phone,
//       required this.image,
//       super.key});

//   @override
//   State<ProfileEditingPage> createState() => _profileEditingPageState();
// }

// class _profileEditingPageState extends State<ProfileEditingPage> {
//   final formKey = GlobalKey<FormState>();

//   final nameKey = GlobalKey<FormFieldState>();

//   final phoneKey = GlobalKey<FormFieldState>();

//   TextEditingController nameController = TextEditingController();

//   TextEditingController phoneController = TextEditingController();
//   @override
//   void initState() {
//     nameController.text = widget.name;
//     phoneController.text = widget.phone;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//       appBar: AppBar(),
//       body: Form(
//         key: formKey,
//         child: ListView(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(15),
//               child: Column(
//                 children: [
//                   Text(
//                     "Let's Edit Your profile",
//                     style: Theme.of(context).textTheme.bodyLarge,
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//               child: ClipRRect(
//                 borderRadius: const BorderRadius.all(Radius.circular(20)),
//                 child: TextFormField(
//                   key: nameKey,
//                   validator: (value) {
//                     if ((!RegExp(r'^\S+(?!\d+$)').hasMatch(value!))) {
//                       return 'enter valid name';
//                     } else {
//                       return null;
//                     }
//                   },
//                   onChanged: (value) {
//                     nameKey.currentState!.validate();
//                   },
//                   controller: nameController,
//                   decoration: Styles().formDecrationStyle(
//                       icon: const Icon(Icons.person_2_sharp),
//                       labelText: 'Name'),
//                   style: Styles().formTextStyle(context),
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//               child: ClipRRect(
//                 borderRadius: const BorderRadius.all(Radius.circular(20)),
//                 child: TextFormField(
//                   key: phoneKey,
//                   onChanged: (value) {
//                     phoneKey.currentState!.validate();
//                   },
//                   validator: (value) {
//                     if ((!RegExp(r'^[0-9]+\.?[0-9]*$').hasMatch(value!))) {
//                       return 'enter valid Phone number';
//                     } else {
//                       return null;
//                     }
//                   },
//                   controller: phoneController,
//                   decoration: Styles().formDecrationStyle(
//                       icon: const Icon(Icons.phone_in_talk_outlined),
//                       labelText: 'Phone'),
//                   style: Styles().formTextStyle(context),
//                 ),
//               ),
//             ),
//             Column(
//               children: [
//                 ElevatedButton(
//                   onPressed: () async {
//                     XFile tempImage = await UserFunction().userPickImage();
//                     widget.image = await UserFireStroreFunction()
//                         .uploadImageToFirebase(tempImage);
//                     setState(() {});
//                   },
//                   child: const Text('Add Image'),
//                 ),
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.02,
//                 ),
//                 Container(
//                   width: MediaQuery.of(context).size.width * 0.6,
//                   height: MediaQuery.of(context).size.width * 0.6,
//                   decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(
//                           MediaQuery.of(context).size.width * 0.6),
//                       image: DecorationImage(
//                           image: NetworkImage(widget.image),
//                           fit: BoxFit.cover)),
//                 ),
//                 ElevatedButton(
//                     style: Styles().elevatedButtonStyle(),
//                     onPressed: () {
//                       if (formKey.currentState!.validate()) {
//                         BlocProvider.of<UserLoginBloc>(context).add(
//                             OnEditProfileEvent(
//                                 name: nameController.text,
//                                 phone: phoneController.text,
//                                 image: widget.image));
//                         Navigator.of(context).pop();
//                       }
//                     },
//                     child: Container(
//                       height: MediaQuery.of(context).size.width * 0.1,
//                       width: MediaQuery.of(context).size.width * 0.6,
//                       decoration: Styles().elevatedButtonDecration(),
//                       child: Center(
//                         child: Text(
//                           'Submit',
//                           style: Styles().elevatedButtonTextStyle(),
//                         ),
//                       ),
//                     ))
//               ],
//             ),
//           ],
//         ),
//       ),
//     ));
//   }
// }
