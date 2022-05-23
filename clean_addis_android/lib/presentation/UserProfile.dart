import 'package:clean_addis_android/utils.dart';
import 'package:flutter/material.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({Key? key}) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {

  Widget verticalSpace(double height) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * height,
    );
  }

  Widget horizontalSpace(double width) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * width,
    );
  }

  Widget buildText(
      {required IconData? icon,
      bool isFullWidth = true,
      String? label,
      required String text,
      required Color color}) {
    return Container(
      width: isFullWidth
          ? MediaQuery.of(context).size.width * 0.8
          : MediaQuery.of(context).size.width * 0.4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 21,
                color: color,
              ),
              horizontalSpace(0.01),
              Text(
                label!,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          verticalSpace(0.01),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
   
  Widget _profileImage() {
    return Center(
      child: Container(
        width: 130,
        height: 130,
        decoration: BoxDecoration(
            border: Border.all(
                width: 4, color: Theme.of(context).scaffoldBackgroundColor),
            boxShadow: [
              BoxShadow(
                  spreadRadius: 2,
                  blurRadius: 10,
                  color: Colors.black.withOpacity(0.1),
                  offset: Offset(0, 10))
            ],
            shape: BoxShape.circle,
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250",
                ))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightgreen,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: logogreen,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.edit,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          verticalSpace(0.02),
          _profileImage(),
          verticalSpace(0.02),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text('10',style: TextStyle(color: Colors.red,fontSize: 35),),
                    Text(
                      'Reports',
                      style: TextStyle(color: Colors.red, fontSize:15,fontWeight: FontWeight.w700),
                    ),
                  ],
                  
                  
                ),
                VerticalDivider(
                  color: Colors.black,
                  thickness: 1,
                ),
                Column(
                  children: [
                    Text(
                      '10',
                      style: TextStyle(color: Colors.red, fontSize: 35),
                    ),
                    Text(
                      'Donations',
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 15,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                VerticalDivider(
                  color: Colors.black,
                  thickness: 1,
                ),
                 Column(
                  children: [
                    Text(
                      '10',
                      style: TextStyle(color: Colors.yellow, fontSize: 35),
                    ),
                    Text(
                      'sold',
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 15,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                )
              ],
            ),
          ),
          Divider(),
          verticalSpace(0.02),
          buildText(
            icon: Icons.account_circle,
            label: 'Username',
            text: 'Yishak', 
            color: Colors.black),
          Divider(),
           verticalSpace(0.02),
          buildText(
              icon: Icons.email,
              label: 'Email',
              text: 'Yishak@gmail.com',
              color: Colors.black),
          Divider(),
          verticalSpace(0.02),
          buildText(
              icon: Icons.work,
              label: 'Role',
              text: 'Resident',
              color: Colors.black),
          Divider(),
           verticalSpace(0.02),
          buildText(
              icon: Icons.my_location,
              label: 'Address',
              text: 'Nifas Silk, Woreda 04',
              color: Colors.black),
          Divider(),
          verticalSpace(0.02),
          buildText(
              icon: Icons.phone,
              label: 'Phone Number',
              text: '09432342332',
              color: Colors.black),
          Divider(),
        ],
      ),
    );
  }
}
