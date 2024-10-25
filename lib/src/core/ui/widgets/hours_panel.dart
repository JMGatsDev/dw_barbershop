import 'package:flutter/material.dart';

class HoursPanel extends StatelessWidget {
  const HoursPanel({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        const Text(
          'Selecione os horários de atendimento',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: height * 0.02,
        ),
        Wrap(
          spacing: 8,
          runSpacing: 16,
          children: [
            TimeButton(
              width: width,
              height: height,
              text: '08:00',
            ),
            TimeButton(
              width: width,
              height: height,
              text: '09:00',
            ),
            TimeButton(
              width: width,
              height: height,
              text: '10:00',
            ),
            TimeButton(
              width: width,
              height: height,
              text: '11:00',
            ),
            TimeButton(
              width: width,
              height: height,
              text: '12:00',
            ),
            TimeButton(
              width: width,
              height: height,
              text: '13:00',
            ),
            TimeButton(
              width: width,
              height: height,
              text: '14:00',
            ),
            TimeButton(
              width: width,
              height: height,
              text: '15:00',
            ),
            TimeButton(
              width: width,
              height: height,
              text: '16:00',
            ),
            TimeButton(
              width: width,
              height: height,
              text: '17:00',
            ),
            TimeButton(
              width: width,
              height: height,
              text: '18:00',
            ),
          ],
        )
      ],
    );
  }
}

class TimeButton extends StatelessWidget {
  const TimeButton({
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
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: (){},
      child: Container(
        width: width * 0.2,
        height: height * 0.05,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          border: Border.all(color: Colors.grey),
        ),
        child: Center(
            child: Text(
          text,
          style: const TextStyle(
              fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w500),
        )),
      ),
    );
  }
}
