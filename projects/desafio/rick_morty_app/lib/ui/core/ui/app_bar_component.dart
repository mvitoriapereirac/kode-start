import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarComponent extends StatelessWidget implements PreferredSizeWidget {
  final Function()? returnToList;
  const AppBarComponent({super.key, this.returnToList});

  @override
  Size get preferredSize => const Size.fromHeight(130.92);
  final _leadingAssetList = 'lib/assets/icons/leading_icon.svg';
  final _leadingAsseDetails = 'lib/assets/icons/leading_icon_2.svg';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      color: const Color(0xFF1C1B1F),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: SvgPicture.asset(returnToList != null ? _leadingAsseDetails : _leadingAssetList), 
            onPressed: returnToList, 
            iconSize: 20.97 , 
            padding: const EdgeInsets.symmetric(
            horizontal: 13.48,
            vertical: 17.48),
            color: Colors.white,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10,),
                Image.asset(
                'lib/assets/images/app_bar_image_3x.png',
                width: 115,
                height: 76.99
                ),
                const SizedBox(height: 6),
                SizedBox(
                  width: 194,
                  height: 16,
                  child: Text(
                    "RICK AND MORTY API",
                    style: GoogleFonts.lato(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 14.5 * 0.16,
                      color: Colors.white,
                      fontStyle: FontStyle.normal,
                        ), 
                      ),
                    ),
                const SizedBox(height: 21),
              ],
            ),
            IconButton(
              icon: SvgPicture.asset('lib/assets/icons/trailing_icon.svg'),
              onPressed: (){},
              iconSize: 31.46,
              padding: const EdgeInsets.symmetric(
                horizontal: 13.48,
                vertical: 17.48),
              color: Colors.white
            ),
      ])
    );
  } 
}