import 'package:flutter/material.dart';

import '../constants.dart';

class HoursPanel extends StatefulWidget {
  const HoursPanel({
    super.key,
    required this.startTime,
    required this.endTime,
    required this.onHourPressed,
    this.enableTimes,
  }) : singleSelection = false;
  const HoursPanel.singleSelection({
    super.key,
    required this.startTime,
    required this.endTime,
    required this.onHourPressed,
    this.enableTimes,
  }) : singleSelection = true;
  final bool singleSelection;
  final int startTime;
  final int endTime;
  final ValueChanged<int> onHourPressed;
  final List<int>? enableTimes;

  @override
  State<HoursPanel> createState() => _HoursPanelState();
}

class _HoursPanelState extends State<HoursPanel> {
  int? lastSelection;
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
            for (int i = widget.startTime; i <= widget.endTime; i++)
              TimeButton(
                enableTimes: widget.enableTimes,
                onPressed: (timeSelected) {
                  widget.onHourPressed(timeSelected);
                  setState(
                    () {
                      if (widget.singleSelection) {
                        if (lastSelection == timeSelected) {
                          lastSelection = null;
                        } else {
                          lastSelection = timeSelected;
                        }
                      }
                    },
                  );
                },
                value: i,
                width: width,
                height: height,
                text: '${i.toString().padLeft(2, '0')}:00',
                singleSelection: widget.singleSelection,
                timeSelected: lastSelection,
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
    required this.singleSelection,
    required this.timeSelected,
  });
  final ValueChanged<int> onPressed;
  final int value;
  final String text;
  final double width;
  final double height;
  final List<int>? enableTimes;
  final bool singleSelection;
  final int? timeSelected;

  @override
  State<TimeButton> createState() => _TimeButtonState();
}

class _TimeButtonState extends State<TimeButton> {
  var selected = false;
  @override
  Widget build(BuildContext context) {
    final TimeButton(
      :value,
      :text,
      :enableTimes,
      :onPressed,
      :singleSelection,
      :timeSelected
    ) = widget;
    if (singleSelection) {
      if (timeSelected != null) {
        if (timeSelected == value) {
          selected = true;
        } else {
          selected = false;
        }
      }
    }

    final textColor = selected ? Colors.white : ColorsConstants.brow;
    var buttonColor = selected ? ColorsConstants.brow : Colors.white;
    final buttonBorderColor =
        selected ? ColorsConstants.brow : ColorsConstants.grey;

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
