import 'package:dw_barbershop/src/core/ui/barbershop_icons.dart';
import 'package:dw_barbershop/src/core/ui/constants.dart';
import 'package:flutter/material.dart';

class HomeEmployeeTile extends StatelessWidget {
  const HomeEmployeeTile({super.key});

  @override
  Widget build(BuildContext context) {
    final bool imageNetwork = false;
    Size size = MediaQuery.sizeOf(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      padding: const EdgeInsets.all(10),
      height: size.height * 0.11,
      width: size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: ColorsConstants.grey)),
      child: Row(
        children: [
          Container(
            height: size.height * 0.15,
            width: size.width * 0.15,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: switch (imageNetwork) {
                  true => const NetworkImage('url'),
                  false => const AssetImage(ImageConstants.avatar)
                },
              ),
            ),
          ),
          SizedBox(
            width: size.width * 0.02,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Nome e sobre nome',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 12)),
                      child: const Text("AGENDAR"),
                    ),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 12)),
                      child: const Text('VER AGENDAR'),
                    ),
                    const Icon(
                      BarbershopIcons.penEdit,
                      size: 16,
                      color: ColorsConstants.brow,
                    ),
                    const Icon(
                      BarbershopIcons.trash,
                      size: 16,
                      color: ColorsConstants.red,
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
