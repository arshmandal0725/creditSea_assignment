import 'package:flutter/material.dart';
import '../helpers/size_config.dart';
import '../helpers/constants.dart';

class GenderDropdown extends StatelessWidget {
  final String? selectedGender;
  final ValueChanged<String?> onChanged;

  const GenderDropdown({
    super.key,
    this.selectedGender,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return DropdownButtonFormField<String>(
      value: selectedGender,
      decoration: InputDecoration(
        hintText: "Select your gender",
        hintStyle: TextStyle(
          fontFamily: 'Montserrat',
          color: Colors.grey,
          fontSize: SizeConfig.screenWidth * 0.035,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: textFieldBorder, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: textFieldBorder, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: textFieldBorder, width: 1.5),
        ),
      ),
      icon: const Icon(Icons.arrow_drop_down),
      items: const [
        DropdownMenuItem(value: "Male", child: Text("Male")),
        DropdownMenuItem(value: "Female", child: Text("Female")),
        DropdownMenuItem(value: "Other", child: Text("Other")),
      ],
      onChanged: onChanged,
      style: TextStyle(
        fontFamily: 'Montserrat',
        color: Colors.grey,
        fontSize: SizeConfig.screenWidth * 0.035,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
