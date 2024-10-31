import 'package:dw_barbershop/src/core/ui/barbershop_icons.dart';
import 'package:dw_barbershop/src/core/ui/constants.dart';
import 'package:dw_barbershop/src/module/home/adm/widgets/home_employee_tile.dart';
import 'package:dw_barbershop/src/module/home/widget/home_header.dart';
import 'package:flutter/material.dart';

class HomeAdmScreen extends StatefulWidget {
  const HomeAdmScreen({super.key});

  @override
  State<HomeAdmScreen> createState() => _HomeAdmScreenState();
}

class _HomeAdmScreenState extends State<HomeAdmScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: ColorsConstants.brow,
        onPressed: () {},
        child: const CircleAvatar(
          backgroundColor: Colors.white,
          maxRadius: 12,
        
          child: Icon(
            BarbershopIcons.addEmployee,
            color: ColorsConstants.brow,
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: HomeHeader(
              showFilter: true,
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => const HomeEmployeeTile(),
                childCount: 5),
          ),
        ],
      ),
    );
  }
}
