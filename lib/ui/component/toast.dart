import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oktoast/oktoast.dart';

class ToastComponent {
  static toast(String message) async {
    try {
      showToastWidget(
        ClipRRect(
          child: Container(
            // width: 228.w,P
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(Radius.circular(30))),
            child: TextButton.icon(
                onPressed: () {},
                style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    alignment: Alignment.centerLeft),
                icon: const Icon(
                  Icons.check_circle_rounded,
                  color: Colors.white,
                  size: 20,
                ),
                label: Text(
                  message,
                  style: GoogleFonts.barlowSemiCondensed(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.15),
                )),
            //  Wrap(
            //   children: [

            //     Spacing.sizedBoxW_10(),

            //   ],
            // )
          ),
        ),
        duration: const Duration(seconds: 3),
        position: ToastPosition.bottom,
        onDismiss: () {},
      );
    } catch (_) {}
  }
}
