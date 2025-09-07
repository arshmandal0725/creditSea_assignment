import 'package:flutter/material.dart';
import 'package:frontend/helpers/constants.dart';
import 'package:frontend/helpers/size_config.dart';

class DatePickerTextField extends StatefulWidget {
  final TextEditingController? controller;

  const DatePickerTextField({super.key, this.controller});

  @override
  State<DatePickerTextField> createState() => _DatePickerTextFieldState();
}

class _DatePickerTextFieldState extends State<DatePickerTextField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    _controller = widget.controller ?? TextEditingController();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _controller.text =
            "${pickedDate.day.toString().padLeft(2, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.year}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return TextField(
      controller: _controller,
      readOnly: true,
      decoration: InputDecoration(
        hintText: 'DD - MM - YYYY',
        hintStyle: TextStyle(
          fontFamily: 'Montserrat',
          color: Colors.grey,
          fontSize: SizeConfig.screenWidth * 0.035,
        ),
        suffixIcon: IconButton(
          onPressed: () => _selectDate(context),
          icon: Image.asset(
            'assets/icons/calender_icon.png',
            width: 22,
            height: 22,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: textFieldBorder, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: textFieldBorder, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: textFieldBorder, width: 1),
        ),
      ),
      onTap: () => _selectDate(context),
    );
  }
}
