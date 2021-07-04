import 'package:flutter/material.dart';

class LabeledCheckbox extends StatelessWidget {
  const LabeledCheckbox({
    Key key,
    @required this.label,
    @required this.value,
    @required this.onChanged,
  }) : super(key: key);

  final String label;
  final bool value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 30.0),
        child: Row(
          children: <Widget>[
            Checkbox(
              fillColor:
                  MaterialStateColor.resolveWith((states) => Colors.white),
              value: value,
              onChanged: (bool newValue) {
                onChanged(newValue);
              },
            ),
            Expanded(child: Text(label)),
          ],
        ),
      ),
    );
  }
}
