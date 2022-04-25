import 'package:clean_addis_android/bloc/Waste/user_waste_bloc.dart';
import 'package:clean_addis_android/data/data_providers/waste_data.dart';
import 'package:clean_addis_android/data/repositories/waste_repository.dart';
import 'package:clean_addis_android/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Profile.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }

  
}

class HomePageState extends State<HomePage> {
 final wastebloc =
      UserWasteBloc(WasteRepository(dataProvider: WasteDataProvider()));
  @override
  void initState() {
    super.initState();
    wastebloc..add(HomePageOpenedEvent());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: lightgreen,
          elevation: 1,
          leading: Icon(Icons.home,color:Colors.black),
          actions: [
            IconButton(
              icon: Icon(
                Icons.help,
                color: Colors.blue,
              ),
              onPressed: () => {print("yishak")},
            ),
            IconButton(
              padding: EdgeInsets.all(0),
              icon: Icon(
                Icons.settings,
                color: logogreen,
              ),
              onPressed: () => {
                Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => EditProfilePage()))
              },
            ),
            IconButton(
              icon: Icon(
                Icons.logout_rounded,
                color: Colors.red,
              ),
              onPressed: () => {print("yishak")},
            ),
          ],
        ),
        backgroundColor: lightgreen,
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Text(
                'Hello Yishak!',
                textAlign: TextAlign.left,
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(color: Colors.black),
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                ),
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: <TextSpan>[
                  TextSpan(
                    text: "Welcome to Clean",
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(color: Colors.black),
                      fontWeight: FontWeight.w400,
                      fontSize: 26,
                    ),
                  ),
                  TextSpan(
                    text: "Addis",
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(color: Color(0xff68EA26)),
                      fontWeight: FontWeight.w400,
                      fontSize: 26,
                    ),
                  ),
                ]),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Your Items For Sell',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(color: Colors.black),
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  TextButton(
                    onPressed: () => {print("njgd")},
                    child: Text(
                      'Details',
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.14,
                child: BlocBuilder(
                  
                  bloc: wastebloc,
                   builder:(context,state) {
                     print("listening");
                    if (state is WasteLoadingState){
                      return ListView(
                        children: [
                          Text('Loading')
                        ],
                      );
                    }
                    print("checking");
                    if(state is WasteLoaded){
                      print("here nebreska");
                      return ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        color: Colors.red,
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: Image(
                          image: NetworkImage(
                              'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
                          fit: BoxFit.fill,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        color: Colors.green,
                        width: MediaQuery.of(context).size.width * 0.25,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        color: Colors.yellow,
                        width: MediaQuery.of(context).size.width * 0.25,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        color: Colors.blue,
                        width: MediaQuery.of(context).size.width * 0.25,
                      ),
                    ],
                  );
                  }
                  return Center(child: CircularProgressIndicator());
                }
                   
                  
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
    
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Your Donations',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(color: Colors.black),
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  TextButton(
                    onPressed: () => {print("njgd")},
                    child: Text(
                      'Details',
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.14,
                child: BlocBuilder<UserWasteBloc,UserWasteState>(
                  builder: (context,state){
                    if (state is WasteLoaded){
                      return Text('Loaded');
                    }
                    return ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        color: Colors.red,
                        width: MediaQuery.of(context).size.width * 0.25,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        color: Colors.green,
                        width: MediaQuery.of(context).size.width * 0.25,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        color: Colors.yellow,
                        width: MediaQuery.of(context).size.width * 0.25,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        color: Colors.blue,
                        width: MediaQuery.of(context).size.width * 0.25,
                      ),
                    ],
                  );
                  },
                  
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
    
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Available Items',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(color: Colors.black),
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                  TextButton(
                    onPressed: () => {print("njgd")},
                    child: Text(
                      'Details',
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.14,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      color: Colors.red,
                      width: MediaQuery.of(context).size.width * 0.25,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      color: Colors.green,
                      width: MediaQuery.of(context).size.width * 0.25,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      color: Colors.yellow,
                      width: MediaQuery.of(context).size.width * 0.25,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      color: Colors.blue,
                      width: MediaQuery.of(context).size.width * 0.25,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
  
  }
}
