import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sqlite_flutter/controller/cubit/cubit.dart';
import 'package:sqlite_flutter/controller/cubit/states.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  Future<void> _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  double calculateFontSize(BuildContext context, double availableWidth) {
    double fontSize = availableWidth * 0.05;
    return fontSize;
  }

  void _sendEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'hariomshukla337@gmail.com', // replace with your email
      queryParameters: {
        'subject': 'Hello! I am from your Todo App !',
        'body': 'Please! Type your message here',
      },
    );

    final String uri = emailLaunchUri.toString();

    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }

  ListTile _buildListTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required double fontsize,
    required Function() onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        color: Colors.white,
      ),
      title: Text(
        title,
        textScaleFactor: 1.2,
        style: GoogleFonts.dhurjati(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double fontSize = calculateFontSize(context, screenWidth);
    return BlocConsumer<TodoCubit, TodoStates>(
      builder: (BuildContext context, Object? state) {
        var cubit = TodoCubit.get(context);
        return Drawer(
          child: Container(
            color: Colors.black,
            child: SafeArea(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Container(
                    padding: EdgeInsets.all(2),
                    height: 250,
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.black,
                              width: 3,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            "\"If Change Is Need\nMy Blood And Sweat Will Feed!\""
                                .tr(),
                            style: GoogleFonts.dhurjati(
                              fontSize: fontSize,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(128, 0, 0, 1),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.black,
                                    width:
                                        3, // Adjust the border width as needed
                                  ),
                                ),
                                child: CircleAvatar(
                                  backgroundImage:
                                      AssetImage("assets/images/profile.jpg"),
                                  maxRadius: fontSize * 2,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 3,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Align(
                                  alignment: Alignment
                                      .topLeft, // Align text to the left
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start, // Align text to start (left)
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            CupertinoIcons
                                                .profile_circled, // Use the built-in Flutter icon
                                            color: Color.fromRGBO(128, 0, 0,
                                                1), // Set the same orange color
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            "Hari Om Shukla".tr(),
                                            style: GoogleFonts.libreBaskerville(
                                              fontSize: fontSize * 0.73,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  Color.fromRGBO(128, 0, 0, 1),
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ],
                                      ),
                                      // Add spacing between the text
                                      Row(
                                        // Add a Row to display Icon and Text together
                                        children: [
                                          Icon(
                                            Icons
                                                .code, // Use the built-in Flutter icon
                                            color: Color.fromRGBO(65, 0, 147,
                                                1), // Set the same orange color
                                          ),
                                          SizedBox(
                                              width:
                                                  5), // Add some spacing between icon and text
                                          Text(
                                            "Flutter Developer".tr(),
                                            style: GoogleFonts.dhurjati(
                                              fontSize: fontSize,
                                              fontWeight: FontWeight.normal,
                                              color:
                                                  Color.fromRGBO(65, 0, 147, 1),
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        // Another Row for School icon and text
                                        children: [
                                          Icon(
                                            Icons
                                                .school, // Use the built-in School icon
                                            color: Color.fromRGBO(65, 0, 147,
                                                1), // Set a contrasting deep red color
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            "PSIT Kanpur".tr(),
                                            style: GoogleFonts.dhurjati(
                                              fontSize: fontSize,
                                              // fontWeight: FontWeight.bold,
                                              color:
                                                  Color.fromRGBO(65, 0, 147, 1),
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildListTile(
                    context,
                    icon: CupertinoIcons.home,
                    fontsize: fontSize,
                    title: "Home".tr(),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  _buildListTile(
                    context,
                    icon: CupertinoIcons.profile_circled,
                    fontsize: fontSize,
                    title: "Linkedin Profile".tr(),
                    onTap: () {
                      _launchUrl(
                          'https://www.linkedin.com/in/hariom-shukla-32ab3a24a/');
                    },
                  ),
                  _buildListTile(
                    context,
                    icon: CupertinoIcons.mail,
                    title: "Email to Developer".tr(),
                    fontsize: fontSize,
                    onTap: _sendEmail,
                  ),
                  _buildListTile(
                    context,
                    icon: CupertinoIcons.bag_fill_badge_plus,
                    title: "My Resume".tr(),
                    fontsize: fontSize,
                    onTap: () {
                      _launchUrl(
                          'https://drive.google.com/file/d/1fYq0wc9uSL3yECuaO6znWlMo_siDj_pM/view?usp=sharing');
                    },
                  ),
                  _buildListTile(
                    context,
                    icon: CupertinoIcons.collections,
                    title: "My GitHub".tr(),
                    fontsize: fontSize,
                    onTap: () {
                      _launchUrl('https://github.com/HariOm6676');
                    },
                  ),
                  _buildListTile(
                    context,
                    icon: CupertinoIcons.globe,
                    fontsize: fontSize,
                    title: "In Hindi".tr(),
                    onTap: () {
                      cubit.changeLanguageToHindi(context);
                    },
                  ),
                  _buildListTile(
                    context,
                    icon: CupertinoIcons.globe,
                    title: "In Arabic".tr(),
                    fontsize: fontSize,
                    onTap: () {
                      cubit.changeLanguageToArabic(context);
                    },
                  ),
                  _buildListTile(
                    context,
                    icon: CupertinoIcons.globe,
                    title: "In English".tr(),
                    fontsize: fontSize,
                    onTap: () {
                      cubit.changeLanguageToEnglish(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
      listener: (BuildContext context, state) {},
    );
  }
}
