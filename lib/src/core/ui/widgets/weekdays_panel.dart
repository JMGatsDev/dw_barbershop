import 'package:flutter/material.dart';

class WeekdaysPanel extends StatelessWidget {
  const WeekdaysPanel({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        const Text(
          'Selecione os dias de atendimento',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: height * 0.02,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              ButtonDay(
                width: width,
                height: height,
                text: 'Seg',
              ),
              ButtonDay(
                width: width,
                height: height,
                text: 'TER',
              ),
              ButtonDay(
                width: width,
                height: height,
                text: 'QUA',
              ),
              ButtonDay(
                width: width,
                height: height,
                text: 'QUI',
              ),
              ButtonDay(
                width: width,
                height: height,
                text: 'SEX',
              ),
              ButtonDay(
                width: width,
                height: height,
                text: 'SAB',
              ),
              ButtonDay(
                width: width,
                height: height,
                text: 'DOM',
              ),
            ],
          ),
        )
      ],
    );
  }
}

class ButtonDay extends StatelessWidget {
  const ButtonDay({
    super.key,
    required this.width,
    required this.height,
    required this.text,
  });
  final String text;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {},
        child: Container(
          width: width * 0.1,
          height: height * 0.07,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            border: Border.all(color: Colors.grey),
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
      ),
    );
  }
}
