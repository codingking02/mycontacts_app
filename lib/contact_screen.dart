import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gif/gif.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mycontacts_app/contact_item.dart';
import 'package:mycontacts_app/model/contact.dart';
import 'package:mycontacts_app/widgets/widgets.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  List<Contact> contacts = [];
  String nameText = '';
  String emailText = '';
  String phoneText = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  File? _image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          nameController.clear();
          emailController.clear();
          phoneNumberController.clear();
          nameText = '';
          emailText = '';
          phoneText = '';
        });
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        floatingActionButton: Stack(
          children: [
            Positioned(
              bottom: 0,
              right: 0,
              child: Column(
                children: [
                  contacts.isNotEmpty
                      ? Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                28,
                              ),
                            ),
                            color: Colors.transparent,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 3,
                                spreadRadius: 0,
                                offset: Offset(0, 1),
                                color: Color.fromRGBO(0, 0, 0, 0.3),
                              )
                            ],
                          ),
                          child: FloatingActionButton(
                            elevation: 10,
                            onPressed: () {
                              setState(() {
                                contacts.clear();
                              });
                            },
                            backgroundColor: const Color(0xFFF93E3E),
                            child: SvgPicture.asset(
                              'assets/delete.svg',
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                  SizedBox(
                    height: getMediaQueryHeight(0.015, context),
                  ),
                  contacts.length < 6
                      ? Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                28,
                              ),
                            ),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 3,
                                spreadRadius: 0,
                                offset: Offset(0, 1),
                                color: Color.fromRGBO(0, 0, 0, 0.3),
                              )
                            ],
                          ),
                          child: FloatingActionButton(
                            elevation: 10,
                            onPressed: () {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (context) {
                                  return StatefulBuilder(
                                    builder: (context, setState) =>
                                        SingleChildScrollView(
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            bottom: MediaQuery.of(context)
                                                .viewInsets
                                                .bottom),
                                        child: Container(
                                          height: getMediaQueryHeight(
                                              0.58, context),
                                          decoration: const BoxDecoration(
                                            color: Color(0xff29384D),
                                            borderRadius: BorderRadius.vertical(
                                              top: Radius.circular(40),
                                            ),
                                          ),
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SizedBox(
                                                height: getMediaQueryHeight(
                                                    0.2, context),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      flex: 3,
                                                      child: GestureDetector(
                                                        onTap: () async {
                                                          final ImagePicker
                                                              picker =
                                                              ImagePicker();
                                                          final XFile?
                                                              pickedFile =
                                                              await picker.pickImage(
                                                                  source: ImageSource
                                                                      .gallery);

                                                          if (pickedFile !=
                                                              null) {
                                                            setState(() {
                                                              _image = File(
                                                                  pickedFile
                                                                      .path);
                                                            });
                                                          }
                                                        },
                                                        child: Container(
                                                          height:
                                                              getMediaQueryHeight(
                                                            0.2,
                                                            context,
                                                          ),
                                                          width:
                                                              getMediaQueryWidth(
                                                            0.3,
                                                            context,
                                                          ),
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                              color: const Color(
                                                                  0xFFFFF1D4),
                                                            ),
                                                            color: Colors
                                                                .transparent,
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .all(
                                                              Radius.circular(
                                                                  28),
                                                            ),
                                                          ),
                                                          child: _image == null
                                                              ? Gif(
                                                                  image:
                                                                      const AssetImage(
                                                                    'assets/addimage.gif',
                                                                  ),
                                                                  autostart:
                                                                      Autostart
                                                                          .loop,
                                                                  fps: 30,
                                                                )
                                                              : ClipRRect(
                                                                  borderRadius:
                                                                      const BorderRadius
                                                                          .all(
                                                                    Radius
                                                                        .circular(
                                                                            28),
                                                                  ),
                                                                  child: Image
                                                                      .file(
                                                                    _image!,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: getMediaQueryWidth(
                                                          0.03, context),
                                                    ),
                                                    Expanded(
                                                      flex: 4,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          getText(
                                                            nameText.isEmpty
                                                                ? 'User Name'
                                                                : nameText,
                                                          ),
                                                          const Divider(
                                                            color: Color(
                                                                0xFFFFF1D4),
                                                          ),
                                                          getText(
                                                            emailText.isEmpty
                                                                ? 'example@email.com'
                                                                : emailText,
                                                          ),
                                                          const Divider(
                                                            color: Color(
                                                                0xFFFFF1D4),
                                                          ),
                                                          getText(
                                                            phoneText.isEmpty
                                                                ? '+200000000000'
                                                                : phoneText,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: getMediaQueryHeight(
                                                    0.02, context),
                                              ),
                                              Wrap(
                                                runSpacing: getMediaQueryHeight(
                                                    0.02, context),
                                                children: [
                                                  getTextField(
                                                    TextInputType.name,
                                                    'Enter User Name',
                                                    nameController,
                                                    (value) {
                                                      setState(() {});
                                                      nameText = value;
                                                    },
                                                  ),
                                                  getTextField(
                                                    TextInputType.emailAddress,
                                                    'Enter User Email',
                                                    emailController,
                                                    (value) {
                                                      setState(() {});
                                                      emailText = value;
                                                    },
                                                  ),
                                                  getTextField(
                                                    TextInputType.phone,
                                                    'Enter User Phone',
                                                    phoneNumberController,
                                                    (value) {
                                                      setState(() {});
                                                      phoneText = value;
                                                    },
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: getMediaQueryHeight(
                                                    0.02, context),
                                              ),
                                              getButton(
                                                context,
                                                () {
                                                  if (nameController
                                                          .text.isEmpty ||
                                                      emailController
                                                          .text.isEmpty ||
                                                      phoneNumberController
                                                          .text.isEmpty ||
                                                      _image == null) {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                          backgroundColor:
                                                              const Color(
                                                            0xFFFFF1D4,
                                                          ),
                                                          title: Text(
                                                            'Incomplete Fields',
                                                            style: GoogleFonts
                                                                .inter(
                                                              fontSize: 25,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  const Color(
                                                                0xFF29384D,
                                                              ),
                                                            ),
                                                          ),
                                                          content: Text(
                                                            'Please fill out all required fields.',
                                                            style: GoogleFonts.inter(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color: const Color(
                                                                    0xFF29384D)),
                                                          ),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop(); // Close the dialog
                                                              },
                                                              child: Text(
                                                                'OK',
                                                                style:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  fontSize: 25,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: const Color(
                                                                      0xFF29384D),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    );
                                                    return;
                                                  }

                                                  contacts.add(
                                                    Contact(
                                                      name: nameController.text,
                                                      email:
                                                          emailController.text,
                                                      phone:
                                                          phoneNumberController
                                                              .text,
                                                      image: _image,
                                                    ),
                                                  );

                                                  nameController.clear();
                                                  emailController.clear();
                                                  phoneNumberController.clear();
                                                  nameText = '';
                                                  emailText = '';
                                                  phoneText = '';
                                                  _image = null;

                                                  setState;
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            backgroundColor: const Color(0xFFFFF1D4),
                            child: const Icon(
                              Icons.add,
                              color: Color(0xFF29384D),
                              size: 30,
                            ),
                          ),
                        )
                      : const SizedBox.shrink()
                ],
              ),
            ),
          ],
        ),
        appBar: AppBar(
          backgroundColor: const Color(0xFF29384D),
          title: SvgPicture.asset(
            'assets/routesmalllogo.svg',
          ),
        ),
        backgroundColor: const Color(0xFF29384D),
        body: contacts.isEmpty
            ? Column(
                children: [
                  const Spacer(),
                  Gif(
                    image: const AssetImage('assets/contact.gif'),
                    autostart: Autostart.loop,
                    fps: 30,
                    useCache: true,
                  ),
                  Text(
                    'There is No Contacts Added Here',
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFFFFF1D4),
                    ),
                  ),
                  const Spacer(
                    flex: 5,
                  ),
                ],
              )
            : GridView.builder(
                padding: const EdgeInsets.all(15),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: getMediaQueryHeight(0.04, context),
                  crossAxisSpacing: getMediaQueryWidth(0.04, context),
                  childAspectRatio: 0.6,
                ),
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  return ContactItem(
                    name: contacts[index].name,
                    email: contacts[index].email,
                    phoneNumber: contacts[index].phone,
                    onTap: () {
                      setState(() {
                        contacts.removeAt(index);
                      });
                    },
                    image: contacts[index].image!,
                  );
                },
              ),
      ),
    );
  }
}

Widget getText(String text) {
  return Text(
    text,
    style: GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: const Color(0xffFFF1D4),
    ),
  );
}
