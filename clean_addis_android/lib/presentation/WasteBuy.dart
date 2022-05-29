import 'package:clean_addis_android/bloc/Authentication/login_event.dart';
import 'package:clean_addis_android/bloc/Authentication/login_state.dart';
import 'package:clean_addis_android/data/repositories/user_repository.dart';
import 'package:clean_addis_android/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/Authentication/login_bloc.dart';
import '../bloc/Waste/waste_bloc.dart';
import '../data/data_providers/user_data.dart';
import '../data/data_providers/waste_data.dart';
import '../data/repositories/waste_repository.dart';

class WasteBuyPage extends StatefulWidget {
  final int? waste_id;
  final String? image;
  final int? seller;
  final String? waste_name;
  final String? waste_type;
  final String? for_waste;
  final String? quantity;
  final String? price;
  final String? unit;
  final String? post_date;
  final bool? sold;
  final String? location;
  final String? description;

  const WasteBuyPage(
      {Key? key,
      this.waste_id,
      this.image,
      this.seller,
      this.waste_name,
      this.waste_type,
      this.for_waste,
      this.quantity,
      this.price,
      this.unit,
      this.post_date,
      this.sold,
      this.location,
      this.description})
      : super(key: key);
  @override
  State<WasteBuyPage> createState() => _WasteBuyPageState();
}

class _WasteBuyPageState extends State<WasteBuyPage> {

  final wastebloc =
      AddWasteBloc(WasteRepository(dataProvider: WasteDataProvider()));
   final userBloc = LoginBloc(UserRepository(dataProvider: UserDataProvider()));

   @override
   void initState(){
     super.initState();
     userBloc..add(SellerProfileEvent(seller: widget.seller!));
   }
  
  Widget textField({
    required String title,
    required double titleSize,
    required String body,
    required double width,
    Icon? icon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          icon!,
          horizontalSpace(width),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: titleSize,
                    color: Color.fromARGB(255, 94, 84, 84)),
              ),
              Container(
                child: Text(
                  body,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                      color: Colors.black),
                ),
              ),
            ],
          ),
        ],
      ),
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


  Widget textTile() {
    return ListTile(
      leading: Icon(Icons.recycling, size: 26, color: Colors.blue),
      title: Text(
        'Waste Name',
        style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 22,
            color: Color.fromARGB(255, 0, 0, 0)),
      ),
      subtitle: Text(
        'Grained Glass',
        style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: Color.fromARGB(255, 0, 0, 0)),
      ),
    );
  }

  Widget imageholder(String? image) {
    return Container(
      child: Container(
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.width,
          child: image == '' ? 
          Image.network(
              'https://ismwaste.co.uk/images/recycling/mixed-paper.jpg',
              fit: BoxFit.fill):
          Image.network(
              image!,
              fit: BoxFit.cover)
               
            )
    );
  }

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

  Widget _profileImage({String? image}) {
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
                  image != ''
                      ? image!
                      : "https://images.pexels.com/photos/3307758/pexels-photo-3307758.jpeg?auto=compress&cs=tinysrgb&dpr=3&h=250",
                ))),
      ),
    );
  }

  void messageDialog({
    required BuildContext context,
    IconData? icon,
    required Color color,
    required String title,
    required String body,
    required List<Widget> actions,
  }) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Container(
                color: color,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Icon(
                      icon,
                      size: 55,
                      color: Colors.white,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              titlePadding: EdgeInsets.fromLTRB(0, 0, 0, 10),
              content: Container(
                height: 80,
                child: Column(children: [
                  Text(
                    body,
                    style: TextStyle(fontSize: 20),
                  )
                ]),
              ),
              contentPadding: EdgeInsets.fromLTRB(15, 10, 15, 0),
              actions: actions);
        });
  }

  void profileDialog({
    required BuildContext context,
    String? image,
    required Color color,
    required String title,
    required String body,
    required List<Widget> actions,
  }) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return BlocBuilder(
            bloc: userBloc,
            builder: (context,state) {
               if (state is SellerLoadedState){
                        final user = state.user;
              return AlertDialog(
                  title: Container(
                    color: color,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        _profileImage(image: user.profile),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          user.username!,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  titlePadding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  content: Container(
                        height: 80,
                        child: Column(children: [
                          Row(
                            children: [
                              Icon(Icons.email),
                              Text(
                                user.email!,
                                style: TextStyle(fontSize: 20),
                              ),
                              
                            ],
                          ),
                            Row(
                        children: [
                           Icon(Icons.phone),
                          Text(
                             'No Contact',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      )
                        ]),
                      ),
                  
                  contentPadding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                  actions: actions);
            }
            return Center();}
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: TypeColor.chooseColor(widget.waste_type!),
        title : Text(
          'Details',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),),
      backgroundColor: lightgreen,
      body: SingleChildScrollView(
        child: Column(
          children: [
            imageholder(widget.image),
            verticalSpace(0.03),
             BlocBuilder(
               bloc:userBloc,
               builder: (context,state) {
                 
                   if (state is UserLoadingState){
                      return buildText(
                            icon: Icons.account_circle,
                            label: 'Seller',
                            text: 'Loading',
                            color: Colors.black);
                   }
                   if (state is SellerLoadedState){
                     final user = state.user;
                      return InkWell(
                        onTap: (){
                          profileDialog(
                            context: context,
                            title: 'Buy Waste',
                            color: Colors.deepPurple,
                            body: 'Are you sure you want to Buy this Waste?',
                            actions: [
                              Center(
                                child: Row(
                                  children: [
                                    TextButton(
                                        child: Text(
                                          "Call",
                                          style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop();
                                        }),
                                    TextButton(
                                      child: Text(
                                        "CANCEL",
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop();
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ]);
                        },
                        child: buildText(
                              icon: Icons.account_circle,
                              label: 'Seller',
                              text: user.username!,
                              color: Colors.black),
                      );
                   }

                     
                    
                  
                 return buildText(
                    icon: Icons.account_circle,
                    label: 'Seller',
                    text: 'Couldn\'t get seller',
                    color: Colors.black);
               }
             ),
            Divider(),
            verticalSpace(0.02),
             buildText(
                icon: Icons.recycling,
                label: 'Waste Name',
                text: widget.waste_name!,
                color: TypeColor.chooseColor(widget.waste_type!)),
            Divider(),
            verticalSpace(0.02),
            buildText(
                icon: Icons.category,
                label: 'Waste Type',
                text: widget.waste_type!,
                color: TypeColor.chooseColor(widget.waste_type!)),
            Divider(),
            verticalSpace(0.02),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
               horizontalSpace(0.09),
                buildText(
                    icon: Icons.price_change,
                    color: Colors.green[900]!,
                    isFullWidth: false,
                    label: 'Price',
                    text: widget.price! + ' Birr'),
                horizontalSpace(0.04),
                buildText(
                    icon: Icons.scale,
                    color: Colors.lime[900]!,
                    isFullWidth: false,
                    label: 'Quantity',
                    text: widget.quantity! +' '+ widget.unit!),
              ],
            ),
            Divider(),
            verticalSpace(0.02),
            buildText(
                icon: Icons.location_on,
                color: Colors.red,
                label: 'Location',
                text:
                    widget.location != null ? widget.location! : 'No Location'),
            Divider(),
            verticalSpace(0.02),
            buildText(
                icon: Icons.description,
                color: Colors.amberAccent,
                label: 'Description',
                text: widget.description != null
                    ? widget.description!
                    : 'No description'),
            Divider(),
            verticalSpace(0.02),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: ElevatedButton(
                onPressed: () {
                  messageDialog(
                      context: context,
                      title: 'Buy Waste',
                      color: Colors.deepPurple,
                      body: 'Are you sure you want to Buy this Waste?',
                      icon: Icons.shopping_basket,
                      actions: [
                        Center(
                          child: Row(
                            children: [
                              TextButton(
                                  child: Text(
                                    "OK",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                
                                  }),
                              TextButton(
                                child: Text(
                                  "CANCEL",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                },
                              ),
                            ],
                          ),
                        ),
                      ]);
                },
                child: Text(
                  'BUY',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w700),
                ),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(50),
                    primary: Colors.deepPurple),
              ),
            ),
            verticalSpace(0.02),
          ],
        ),
      ),
    );
  }
}
