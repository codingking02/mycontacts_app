import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gif/gif.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mycontacts_app/model/contact.dart';
import 'package:mycontacts_app/widgets/widgets.dart';

class ModalBottomSheet extends StatefulWidget {
  ModalBottomSheet(
      {super.key, required this.contacts, required this.onUpdateContacts});
  List<Contact> contacts = [];
  final void Function(List<Contact>) onUpdateContacts;
  @override
  State<ModalBottomSheet> createState() => _ModalBottomSheetState();
}

class _ModalBottomSheetState extends State<ModalBottomSheet> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final nameFocus = FocusNode();
  final emailFocus = FocusNode();
  final phoneFocus = FocusNode();
  String nameText = '';
  String emailText = '';
  String phoneText = '';
  File? _image;

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    nameFocus.dispose();
    emailFocus.dispose();
    phoneFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          height: getMediaQueryHeight(0.58, context),
          decoration: const BoxDecoration(
            color: Color(0xff29384D),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(40),
            ),
          ),
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: getMediaQueryHeight(0.2, context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: GestureDetector(
                        onTap: () async {
                          final ImagePicker picker = ImagePicker();
                          final XFile? pickedFile = await picker.pickImage(
                              source: ImageSource.gallery);

                          if (pickedFile != null) {
                            setState(() {
                              _image = File(pickedFile.path);
                            });
                          }
                        },
                        child: Container(
                          height: getMediaQueryHeight(
                            0.2,
                            context,
                          ),
                          width: getMediaQueryWidth(
                            0.3,
                            context,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xFFFFF1D4),
                            ),
                            color: Colors.transparent,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(28),
                            ),
                          ),
                          child: _image == null
                              ? Gif(
                                  image: const AssetImage(
                                    'assets/addimage.gif',
                                  ),
                                  autostart: Autostart.loop,
                                  fps: 30,
                                )
                              : ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(28),
                                  ),
                                  child: Image.file(
                                    _image!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: getMediaQueryWidth(0.03, context),
                    ),
                    Expanded(
                      flex: 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          getText(
                            nameText.isEmpty ? 'User Name' : nameText,
                          ),
                          const Divider(
                            color: Color(0xFFFFF1D4),
                          ),
                          getText(
                            emailText.isEmpty ? 'example@email.com' : emailText,
                          ),
                          const Divider(
                            color: Color(0xFFFFF1D4),
                          ),
                          getText(
                            phoneText.isEmpty ? '+200000000000' : phoneText,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: getMediaQueryHeight(0.02, context),
              ),
              Wrap(
                runSpacing: getMediaQueryHeight(0.02, context),
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
                height: getMediaQueryHeight(0.02, context),
              ),
              getButton(
                context,
                () {
                  if (nameController.text.isEmpty ||
                      emailController.text.isEmpty ||
                      phoneNumberController.text.isEmpty ||
                      _image == null) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: const Color(
                            0xFFFFF1D4,
                          ),
                          title: Text(
                            'Incomplete Fields',
                            style: GoogleFonts.inter(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: const Color(
                                0xFF29384D,
                              ),
                            ),
                          ),
                          content: Text(
                            'Please fill out all required fields.',
                            style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF29384D)),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              child: Text(
                                'OK',
                                style: GoogleFonts.inter(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF29384D),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                    return;
                  }

                  widget.contacts.add(
                    Contact(
                      name: nameController.text,
                      email: emailController.text,
                      phone: phoneNumberController.text,
                      image: _image,
                    ),
                  );
                  widget.onUpdateContacts(widget.contacts);

                  nameController.clear();
                  emailController.clear();
                  phoneNumberController.clear();
                  nameText = '';
                  emailText = '';
                  phoneText = '';
                  _image = null;

                  Navigator.pop(context);
                },
              ),
            ],
          ),
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
