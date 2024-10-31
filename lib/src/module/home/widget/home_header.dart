import 'package:dw_barbershop/src/core/ui/barbershop_icons.dart';
import 'package:dw_barbershop/src/core/ui/constants.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, this.showFilter = false});

  final bool showFilter;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(25),
      width: MediaQuery.sizeOf(context).width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(32), bottomLeft: Radius.circular(32)),
        color: Colors.black,
        image: DecorationImage(
          image: AssetImage(ImageConstants.backgroundChair),
          fit: BoxFit.cover,
          opacity: 0.6,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
                height: size.height * 0.04,
              ),
          Row(
            children: [
              const CircleAvatar(
                backgroundColor: Color(0xffbdbdbd),
                child: SizedBox.shrink(),
              ),
              SizedBox(
                width: size.width * 0.05,
              ),
              const Flexible(
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  'João Marcos Gatis Araújo Silva',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: size.width * 0.06,
              ),
              const Expanded(
                child: Text(
                  'Editar',
                  style: TextStyle(
                      color: ColorsConstants.brow,
                      fontSize: 12,
                      fontWeight: FontWeight.w500),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  BarbershopIcons.exit,
                  color: ColorsConstants.brow,
                  size: 32,
                ),
              ),
            ],
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          const Text(
            'Bem vindo',
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          const Text(
            'Agende um Cliente',
            style: TextStyle(
                color: Colors.white, fontSize: 36, fontWeight: FontWeight.w600),
          ),
          Offstage(
            offstage: !showFilter,
            child: SizedBox(
              height: size.height * 0.03,
            ),
          ),
          Offstage(
            offstage: !showFilter,
            child: TextFormField(
              decoration: const InputDecoration(
                  label: Text('Buscar Colaborador'),
                  suffixIcon: Icon(
                    BarbershopIcons.search,
                    color: ColorsConstants.brow,
                    size: 26,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
