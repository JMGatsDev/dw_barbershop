import 'package:flutter/material.dart';

import '../constants.dart';

class HoursPanel extends StatelessWidget {
  const HoursPanel({
    super.key,
    required this.startTime,
    required this.endTime,
    required this.onHourPressed,
  });
  final int startTime;
  final int endTime;
  final ValueChanged<int> onHourPressed;

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
            for (int i = startTime; i <= endTime; i++)
              TimeButton(
                onPressed: onHourPressed,
                value: i,
                width: width,
                height: height,
                text: '${i.toString().padLeft(2, '0')}:00',
              ),
          ],
        )
      ],
    );
  }
}

class TimeButton extends StatefulWidget {
  const TimeButton({
    super.key,
    required this.width,
    required this.height,
    required this.text,
    required this.onPressed,
    required this.value,
  });
  final ValueChanged<int> onPressed;
  final int value;
  final String text;
  final double width;
  final double height;

  @override
  State<TimeButton> createState() => _TimeButtonState();
}

class _TimeButtonState extends State<TimeButton> {
  var selected = false;
  @override
  Widget build(BuildContext context) {
    final textColor = selected ? Colors.white : ColorsConstants.brow;
    var buttonColor = selected ? ColorsConstants.brow : Colors.white;
    final buttonBorderColor =
        selected ? ColorsConstants.brow : ColorsConstants.grey;
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        setState(() {
          widget.onPressed(widget.value);
          selected = !selected;
        });
      },
      child: Container(
        width: widget.width * 0.2,
        height: widget.height * 0.05,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: buttonColor,
          border: Border.all(color: buttonBorderColor),
        ),
        child: Center(
            child: Text(
          widget.text,
          style: TextStyle(
              fontSize: 12, color: textColor, fontWeight: FontWeight.w500),
        )),
      ),
    );
  }
}
