import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mycontacts_app/widgets/widgets.dart';

class ContactItem extends StatelessWidget {
  const ContactItem({
    super.key,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.onTap,
    required this.image,
  });
  final String name;
  final String email;
  final String phoneNumber;
  final void Function() onTap;
  final File image;
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: const BoxDecoration(
        color: Color(0xFFFFF1D4),
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Column(
        children: [
          // Image Section
          Stack(
            children: [
              SizedBox(
                height: getMediaQueryHeight(0.2, context),
                width: double.infinity,
                child: Image.file(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 10,
                left: 10,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
                  decoration: const BoxDecoration(
                    color: Color(0xFFFFF1D4),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Text(
                    name,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF29384D),
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ),
            ],
          ),
          // Details Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    SvgPicture.asset('assets/email.svg'),
                    SizedBox(width: getMediaQueryWidth(0.02, context)),
                    Expanded(
                      child: Text(
                        email,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF29384D),
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: getMediaQueryHeight(0.01, context)),
                Row(
                  children: [
                    SvgPicture.asset('assets/phonenumber.svg'),
                    SizedBox(width: getMediaQueryWidth(0.02, context)),
                    Expanded(
                      child: Text(
                        phoneNumber,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF29384D),
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          GestureDetector(
            onTap: onTap,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 5),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: const BoxDecoration(
                color: Color(0xFFF93E3E),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/delete.svg'),
                  const SizedBox(width: 10),
                  Text(
                    'Delete',
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: getMediaQueryHeight(0.01, context),
          ),
        ],
      ),
    );
  }
}
