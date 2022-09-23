import 'package:flutter/material.dart';

class OptionRadio extends StatefulWidget {
  final String text;
  final int index;
  final int selectedButton;
  final Function press;

  const OptionRadio({
    Key? key,
    required this.text,
    required this.index,
    required this.selectedButton,
    required this.press,
  }) : super();

  @override
  OptionRadioPage createState() => OptionRadioPage();
}

class OptionRadioPage extends State<OptionRadio> {
  // QuestionController controllerCopy =QuestionController();

  int id = 1;

  OptionRadioPage();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.press(widget.index);
      },
      child: Theme(
        data: Theme.of(context).copyWith(
            unselectedWidgetColor: Colors.grey, disabledColor: Colors.blue),
        child: Column(children: [
          RadioListTile(
            title: Text(
              "${widget.index + 1}. ${widget.text}",
              style: const TextStyle(color: Colors.black, fontSize: 16),
              softWrap: true,
            ),
            /*Here the selectedButton which is null initially takes place of value after onChanged. Now, I need to clear the selected button when other button is clicked */
            groupValue: widget.selectedButton,
            value: widget.index,
            activeColor: Colors.green,
            onChanged: (val) async {
              widget.press(widget.index);
            },
            toggleable: true,
          ),
        ]),
      ),
    );
  }
}
