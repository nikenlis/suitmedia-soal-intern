import 'package:flutter/material.dart';
import 'package:suitmedia/core/theme.dart';
import 'package:suitmedia/core/ui/widget_snackbar.dart';


import '../../../../common/app_route.dart';
import '../widgets/filledButtonItem.dart';
import '../widgets/textFormFieldItem.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.sizeOf(context);
    final nameController = TextEditingController(text: '');
    final palindromeController = TextEditingController(text: '');


    bool isPalindrome(String text) {
      String reversedText = text.split('').reversed.join('');
      print(text == reversedText);
      return text == reversedText;
    }

    return Scaffold(
        body: Stack(
      children: [
        Image.asset(
          "assets/background.png",
          width: media.width,
          height: media.height,
          fit: BoxFit.cover,
        ),
        SafeArea(
            bottom: false,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 24),
              children: [
                SizedBox(
                  height: media.height / 5,
                ),
                Image.asset('assets/ic_photo.png',
                    width: 116, height: 116, fit: BoxFit.contain),
                SizedBox(
                  height: 45,
                ),
                TextFormFieldItem(
                  hintText: 'Name',
                  controller: nameController,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormFieldItem(
                  hintText: 'Palindrome',
                  controller: palindromeController,
                ),
                SizedBox(
                  height: 30,
                ),

                //checkButton
                FilledButtonItem(
                  title: 'CHECK',
                  onPressed: () {
                    if (palindromeController.text.isEmpty) {
                      return showCustomSnackbar(
                          context, 'Palindrome filed is required!');
                    } else {
                      if (isPalindrome(palindromeController.text)) {
                        
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.check_circle,
                                      size: 60,
                                      color: greenColor,
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      'You are right',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: semiBold,
                                        color: greyColor,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "${palindromeController.text} is Palindrom",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: medium,
                                        color: greyColor,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      style: TextButton.styleFrom(
                                        backgroundColor: greenColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 24),
                                      ),
                                      child: Text(
                                        'OK',
                                        style: TextStyle(color: whiteColor),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.cancel_rounded,
                                      size: 60,
                                      color: redColor,
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      'Oops',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: semiBold,
                                        color: greyColor,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "${palindromeController.text} is not Palindrom",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: medium,
                                        color: greyColor,
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      style: TextButton.styleFrom(
                                        backgroundColor: greenColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12, horizontal: 24),
                                      ),
                                      child: Text(
                                        'OK',
                                        style: TextStyle(color: whiteColor),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),

                //nextButton
                FilledButtonItem(title: 'NEXT', onPressed: () {
                  if (nameController.text.isEmpty) {
                      return showCustomSnackbar(
                          context, 'Name field is required!');
                    } else {
                      Navigator.pushNamed(context, AppRoute.second, arguments: {'name': nameController.text});
                    }
                },)
              ],
            ))
      ],
    ));
  }
}
