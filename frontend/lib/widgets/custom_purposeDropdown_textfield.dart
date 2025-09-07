import 'package:flutter/material.dart';
import '../helpers/size_config.dart';
import '../helpers/constants.dart';

class LoanPurposeDropdown extends StatelessWidget {
  final String? selectedPurpose;
  final ValueChanged<String?> onChanged;

  const LoanPurposeDropdown({
    super.key,
    this.selectedPurpose,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return DropdownButtonFormField<String>(
      value: selectedPurpose,
      decoration: InputDecoration(
        hintText: "Select purpose of loan",
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
        DropdownMenuItem(value: "Education", child: Text("Education")),
        DropdownMenuItem(value: "Medical", child: Text("Medical")),
        DropdownMenuItem(value: "Business", child: Text("Business")),
        DropdownMenuItem(value: "Travel", child: Text("Travel")),
        DropdownMenuItem(value: "Wedding", child: Text("Wedding")),
        DropdownMenuItem(
          value: "Home Renovation",
          child: Text("Home Renovation"),
        ),
        DropdownMenuItem(value: "Other", child: Text("Other")),
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
