// import 'package:flutter/material.dart';
// import 'package:frontend/helpers/size_config.dart';
// import 'package:get/get.dart';

// class OfferingScreen extends StatefulWidget {
//   const OfferingScreen({super.key});

//   @override
//   State<OfferingScreen> createState() => _OfferingScreenState();
// }

// class _OfferingScreenState extends State<OfferingScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 SizedBox(
//                   width: SizeConfig.screenWidth * 0.8,
//                   child: Image.asset('assets/images/offering_image.png'),
//                 ),
//                 SizedBox(height: SizeConfig.screenHeight * 0.1),
//                 SizedBox(
//                   height: SizeConfig.screenHeight * 0.07,
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       Get.offNamed('/loanStatus');
//                     },
//                     child: Text(
//                       'Accept Offer',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontFamily: 'Montserrat',
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: SizeConfig.screenHeight * 0.02),
//                 SizedBox(
//                   height: SizeConfig.screenHeight * 0.07,
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadiusGeometry.circular(12),
//                         side: BorderSide(
//                           color: const Color(0xFF0075FF),
//                           width: 2,
//                         ),
//                       ),
//                     ),
//                     onPressed: () {
//                       Get.offNamed('/loanStatus');
//                     },
//                     child: Text(
//                       'Extend offer',
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontFamily: 'Montserrat',
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:frontend/controllers/loan_controller.dart';
import 'package:frontend/helpers/size_config.dart';
import 'package:frontend/models/loan_model.dart';
import 'package:get/get.dart';

class OfferingScreen extends StatefulWidget {
  const OfferingScreen({super.key, required this.loan});
  final LoanModel loan;
  @override
  State<OfferingScreen> createState() => _OfferingScreenState();
}

class _OfferingScreenState extends State<OfferingScreen> {
  final LoanController loanController = Get.put(LoanController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: SizeConfig.screenWidth * 0.8,
                  child: Image.asset('assets/images/offering_image.png'),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.1),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.07,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      Get.offNamed('/loanStatus', arguments: widget.loan);
                    },
                    child: Text(
                      'Accept Offer',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                SizedBox(
                  height: SizeConfig.screenHeight * 0.07,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(12),
                        side: BorderSide(
                          color: const Color(0xFF0075FF),
                          width: 2,
                        ),
                      ),
                    ),
                    onPressed: () async {
                      Get.offNamed('/loanStatus', arguments: widget.loan);
                    },
                    child: Text(
                      'Extend offer',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
