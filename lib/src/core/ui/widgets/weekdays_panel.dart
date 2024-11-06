import 'package:dw_barbershop/src/core/ui/constants.dart';
import 'package:flutter/material.dart';

class WeekdaysPanel extends StatelessWidget {
  const WeekdaysPanel({super.key, required this.onPressed, this.enableDays});
  final ValueChanged<String> onPressed;
  final List<String>? enableDays;

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
                  onPressed: onPressed,
                  enableDays: enableDays),
              ButtonDay(
                  width: width,
                  height: height,
                  text: 'Ter',
                  onPressed: onPressed,
                  enableDays: enableDays),
              ButtonDay(
                  width: width,
                  height: height,
                  text: 'Qua',
                  onPressed: onPressed,
                  enableDays: enableDays),
              ButtonDay(
                  width: width,
                  height: height,
                  text: 'Qui',
                  onPressed: onPressed,
                  enableDays: enableDays),
              ButtonDay(
                  width: width,
                  height: height,
                  text: 'Sex',
                  onPressed: onPressed,
                  enableDays: enableDays),
              ButtonDay(
                  width: width,
                  height: height,
                  text: 'Sab',
                  onPressed: onPressed,
                  enableDays: enableDays),
              ButtonDay(
                  width: width,
                  height: height,
                  text: 'Dom',
                  onPressed: onPressed,
                  enableDays: enableDays),
            ],
          ),
        )
      ],
    );
  }
}

class ButtonDay extends StatefulWidget {
  const ButtonDay({
    super.key,
    required this.width,
    required this.height,
    required this.text,
    required this.onPressed,
    this.enableDays,
  });
  final ValueChanged<String> onPressed;
  final String text;
  final double width;
  final double height;
  final List<String>? enableDays;

  @override
  State<ButtonDay> createState() => _ButtonDayState();
}

class _ButtonDayState extends State<ButtonDay> {
  var selected = false;

  @override
  Widget build(BuildContext context) {
    final textColor = selected ? Colors.white : ColorsConstants.brow;
    var buttonColor = selected ? ColorsConstants.brow : Colors.white;
    final buttonBorderColor =
        selected ? ColorsConstants.brow : ColorsConstants.grey;
    final ButtonDay(:enableDays, :text) = widget;
    final disableDay = enableDays != null && !enableDays.contains(text);
    if (disableDay) {
      buttonColor = Colors.grey[400]!;
    }
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: disableDay
            ? null
            : () {
                widget.onPressed(text);
                setState(() {
                  selected = !selected;
                });
              },
        child: Container(
          width: widget.width * 0.1,
          height: widget.height * 0.07,
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
            ),
          ),
        ),
      ),
    );
  }
}
