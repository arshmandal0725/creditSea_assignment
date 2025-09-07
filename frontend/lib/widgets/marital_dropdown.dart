import 'package:flutter/material.dart';
import '../helpers/size_config.dart';
import '../helpers/constants.dart';

class MaritalDropdown extends StatelessWidget {
  final String? selectedStatus;
  final ValueChanged<String?> onChanged;

  const MaritalDropdown({
    super.key,
    required this.selectedStatus,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedStatus,
      decoration: InputDecoration(
        hintText: "Select your marital status",
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
        DropdownMenuItem(value: "Single", child: Text("Single")),
        DropdownMenuItem(value: "Married", child: Text("Married")),
      ],
      onChanged: onChanged,
      style: TextStyle(
        fontFamily: 'Montserrat',
        color: Colors.grey[800],
        fontSize: SizeConfig.screenWidth * 0.035,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
