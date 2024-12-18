import 'package:dw_barbershop/src/core/providers/application_provider.dart';
import 'package:dw_barbershop/src/core/ui/barbershop_icons.dart';
import 'package:dw_barbershop/src/core/ui/constants.dart';
import 'package:dw_barbershop/src/core/ui/widgets/barbershop_loader.dart';
import 'package:dw_barbershop/src/module/home/adm/home_adm_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeHeader extends ConsumerWidget {
  const HomeHeader({super.key, this.showFilter = false});

  final bool showFilter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final barbershop = ref.watch(getMyBarbershopProvider);
    Size size = MediaQuery.sizeOf(context);
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
          barbershop.maybeWhen(data: (barbershopData) {
            return Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Color(0xffbdbdbd),
                  child: SizedBox.shrink(),
                ),
                SizedBox(
                  width: size.width * 0.05,
                ),
                Flexible(
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    barbershop.value!.name,
                    style: const TextStyle(
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
                  onPressed: () {
                    ref.read(homeAdmVmProvider.notifier).logout();
                  },
                  icon: const Icon(
                    BarbershopIcons.exit,
                    color: ColorsConstants.brow,
                    size: 32,
                  ),
                ),
              ],
            );
          }, orElse: () {
            return const Center(
              child: BarbershopLoader(),
            );
          }),
          SizedBox(
            height: size.height * 0.04,
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
