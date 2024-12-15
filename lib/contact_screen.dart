import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gif/gif.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mycontacts_app/contact_item.dart';
import 'package:mycontacts_app/modal_bottom_sheet.dart';
import 'package:mycontacts_app/model/contact.dart';
import 'package:mycontacts_app/widgets/widgets.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  List<Contact> contacts = [];
  void _updateContacts(List<Contact> updatedContacts) {
    setState(() {
      contacts = updatedContacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                return ModalBottomSheet(
                                  contacts: contacts,
                                  onUpdateContacts: _updateContacts,
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
    );
  }
}
