import 'package:flutter/material.dart';
import 'constants.dart';
import 'data.dart';
import 'auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controllerEmail = TextEditingController();

  Widget _logoutButton() {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 40),
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              elevation: 5.0,
              padding: const EdgeInsets.all(15.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              backgroundColor: greenThemeDark),
          onPressed: () {
            auth.signOut();
          },
          child: Text(
            'Logout',
            style: tFTextStyle.copyWith(fontSize: 20),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: greenThemeDark,
        title: Center(
            child: Text(
          "CarbonWise Account Deletion",
          style: tFTextStyle.copyWith(fontSize: 25),
        )),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _logoutButton(),
            const SizedBox(
              height: 80,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: FittedBox(
                    child: Text(
                  'Enter the email associated with this account to delete it:',
                  style: tFlabelStyle,
                ))),
            Container(
              alignment: Alignment.centerLeft,
              decoration: tfBoxDecorationStyle,
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: TextField(
                controller: _controllerEmail,
                keyboardType: TextInputType.emailAddress,
                style: tFTextStyle,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.only(top: 15.0),
                  prefixIcon: const Icon(
                    Icons.email,
                    color: Colors.white,
                  ),
                  hintText: 'Enter your email',
                  hintStyle: hintTextStyle,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
                child: SizedBox(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(15),
                            elevation: 20,
                            backgroundColor:
                                const Color.fromARGB(255, 210, 56, 45),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30))),
                        onPressed: () => showDialog<String>(
                            context: context,
                            builder: (BuildContext context) {
                              return WillPopScope(
                                  onWillPop: () => Future.value(false),
                                  child: AlertDialog(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    title: Center(
                                        child: Text(
                                      "Are you sure you want to delete you account?",
                                      style: tFlabelStyle,
                                    )),
                                    insetPadding: const EdgeInsets.symmetric(
                                        horizontal: 40),
                                    actionsAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'No',
                                          style: tFlabelStyle,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          deleteAccount();
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          'Yes',
                                          style: tFlabelStyle,
                                        ),
                                      ),
                                    ],
                                  ));
                            },
                            barrierDismissible: false),
                        child: Text('Delete Account :(',
                            style: tFTextStyle.copyWith(fontSize: 20))))),
          ],
        ),
      ),
    );
  }
}
