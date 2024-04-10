import 'package:flutter/material.dart';
import 'package:project/page/PageBeer.dart';
import 'package:project/page/PageWine.dart';

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text('Choose Drink to view Review',
                style: TextStyle(
                    color: Colors.amber,
                    fontSize: 50,
                    fontWeight: FontWeight.bold))),
        backgroundColor: Color.fromARGB(255, 7, 100, 16),
      ),
      body: Container(
        decoration: BoxDecoration(color: Color.fromARGB(255, 11, 131, 23)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 200,
                width: 1000,
                child: Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Beer()),
                      );
                    },
                    child: Center(
                        child: Text('Beer',
                            style: TextStyle(
                                color: Colors.amber,
                                fontSize: 100,
                                fontWeight: FontWeight.bold))),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 1000,
                height: 200,
                child: Expanded(
                  flex: 1,
                  child: SizedBox(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Wine()),
                        );
                      },
                      child: Center(
                          child: Text('Wine',
                              style: TextStyle(
                                  color: Colors.amber,
                                  fontSize: 100,
                                  fontWeight: FontWeight.bold))),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
