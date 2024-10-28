import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants.dart';

class CustomHomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomHomeAppBar({super.key});

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // actions: [
      //   IconButton(
      //       onPressed: () {
      //         logOut(context);
      //       },
      //       icon: const Icon(Icons.logout))
      // ],
      backgroundColor: Colors.white,
      title: Text('Trendista',
          style: GoogleFonts.almendra(
            textStyle: Theme.of(context).textTheme.displayLarge,
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: kPrimaryColor,
            //fontStyle: FontStyle.italic,
          )),
    );
  }
}
