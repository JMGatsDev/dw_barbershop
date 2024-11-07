import 'package:dw_barbershop/src/core/ui/barbershop_icons.dart';
import 'package:dw_barbershop/src/core/ui/constants.dart';
import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({super.key, this.hideUploadingButton = false});
 final bool hideUploadingButton;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return SizedBox(
      height: 105,
      width: 105,
      child: Stack(
        children: [
          Container(
            width: size.width * 1,
            height: size.height * 1,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImageConstants.avatar),
              ),
            ),
          ),
          Positioned(
            bottom: 5,
            right: 5,
            child: Offstage(
              offstage: hideUploadingButton,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: ColorsConstants.brow,
                      width: 2,
                    ),
                    shape: BoxShape.circle),
                child: const Icon(
                  BarbershopIcons.addEmployee,
                  size: 30,
                  color: ColorsConstants.brow,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
