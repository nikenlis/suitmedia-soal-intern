
import 'package:flutter/material.dart';
import 'package:suitmedia/core/theme.dart';
import 'package:suitmedia/core/ui/widget_button.dart';


import '../../../../common/app_route.dart';
import '../first_page/presentation/pages/first_page.dart';

class SecondPage extends StatelessWidget {
  final String? name;
  final String user;

  const SecondPage({super.key, this.name, this.user = 'csc'});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (bool didPop, dynamic) async {
        if (didPop) {
         Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => FirstPage()),
        (route) => false,
      );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text("Select a User"), leading: IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => FirstPage()),
        (route) => false,
      );
      },
        ),),
        
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24),
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Welcome',
                  style:
                      blackTextStyle.copyWith(fontSize: 12, fontWeight: regular),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(name!,
                    style: blackTextStyle.copyWith(
                        fontSize: 18, fontWeight: semiBold))
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 3,
            ),
            Center(
                child: Text(user,
                    style: blackTextStyle.copyWith(
                        fontSize: 24, fontWeight: semiBold))),
            SizedBox(
              height: MediaQuery.of(context).size.height / 3,
            ),
            CustomFilledButton(
                title: 'Choose a User',
                onPressed: () {
                  Navigator.pushNamed(context, AppRoute.third, arguments: name);
                }),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
