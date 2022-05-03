import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SeminarListPage extends StatefulWidget {
  const SeminarListPage({Key? key}) : super(key: key);

  @override
  State<SeminarListPage> createState() => _SeminarListPageState();
}

class _SeminarListPageState extends State<SeminarListPage> {
  Widget createCard() {
    return Container(
      child: Card(
          child: Expanded(
              flex: 100,
              child: Column(
                children: [
                  Expanded(
                    flex: 75,
                    child: Image.network(
                        'https://www.cleanlink.com/resources/editorial/2021/cleaning-staff-26492.jpg'),
                  ),
                  Expanded(
                    flex: 10,
                    child: Text(
                      'How Cleaning and mental health related?',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
