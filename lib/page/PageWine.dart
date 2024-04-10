import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Wine extends StatefulWidget {
  const Wine({super.key});

  @override
  State<Wine> createState() => _WineState();
}

class _WineState extends State<Wine> {
  List<dynamic> Wines = [];

  @override
  void initState() {
    super.initState();

    fetchBeers();
  }

  Future<void> fetchBeers() async {
    final response =
        await http.get(Uri.parse('https://api.sampleapis.com/wines/reds'));

    if (response.statusCode == 200) {
      setState(() {
        Wines = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load beers');
    }
  }

  void _showBeerReview(String? winery, Map<String, dynamic>? rating,
      String? imageUrl, String? Location) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Wine Review",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 157, 64, 64))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("winery: ${winery ?? 'N/A'}",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black)),
              Text(
                  "Rating: ${rating?['average'] ?? 'N/A'} (${rating?['reviews'] ?? 'N/A'} reviews)",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black)),
              Text("Location:${Location ?? 'N/A'} ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black)),
              SizedBox(
                height: 30,
              ),
              if (imageUrl != null && imageUrl.isNotEmpty)
                Image.network(
                  imageUrl,
                  height: 200,
                  width: 200,
                  fit: BoxFit.cover,
                ),
              SizedBox(height: 30),
              Center(
                child: Icon(
                  Icons.wine_bar,
                  size: 60,
                  color: Colors.red,
                ),
              )
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wine List',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        backgroundColor: Colors.blueGrey,
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.grey),
        child: ListView.separated(
          itemCount: Wines.length,
          separatorBuilder: (BuildContext context, int index) => Divider(),
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(Wines[index]['wine'] ?? '',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.indigo)),
              onTap: () {
                _showBeerReview(Wines[index]['winery'], Wines[index]['rating'],
                    Wines[index]['image'], Wines[index]['location']);
              },
            );
          },
        ),
      ),
    );
  }
}
