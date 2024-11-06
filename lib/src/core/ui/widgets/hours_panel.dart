import 'package:flutter/material.dart';

import '../constants.dart';

class HoursPanel extends StatelessWidget {
  const HoursPanel({
    super.key,
    required this.startTime,
    required this.endTime,
    required this.onHourPressed,
    this.enableTimes,
  });
  final int startTime;
  final int endTime;
  final ValueChanged<int> onHourPressed;
  final List<int>? enableTimes;

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
                enableTimes: enableTimes,
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
    this.enableTimes,
  });
  final ValueChanged<int> onPressed;
  final int value;
  final String text;
  final double width;
  final double height;
  final List<int>? enableTimes;

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

    final TimeButton(:value, :text, :enableTimes, :onPressed) = widget;
    final disableTime = enableTimes != null && !enableTimes.contains(value);
    if (disableTime) {
      buttonColor = Colors.grey[400]!;
    }
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: disableTime
          ? null
          : () {
              setState(() {
                widget.onPressed(value);
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
          text,
          style: TextStyle(
              fontSize: 12, color: textColor, fontWeight: FontWeight.w500),
        )),
      ),
    );
  }
}
