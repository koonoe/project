import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Beer extends StatefulWidget {
  const Beer({super.key});

  @override
  State<Beer> createState() => _BeerState();
}

class _BeerState extends State<Beer> {
  List<dynamic> beers = [];

  @override
  void initState() {
    super.initState();

    fetchBeers();
  }

  Future<void> fetchBeers() async {
    final response =
        await http.get(Uri.parse('https://api.sampleapis.com/beers/ale'));

    if (response.statusCode == 200) {
      setState(() {
        beers = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load beers');
    }
  }

  void _showBeerReview(
      String? price, Map<String, dynamic>? rating, String? imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Beer Review",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 2, 153, 37))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Price: ${price ?? 'N/A'}",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text(
                "Rating: ${rating?['average'] ?? 'N/A'} (${rating?['reviews'] ?? 'N/A'} reviews)",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
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
                  Icons.nightlife,
                  size: 60,
                  color: Color.fromARGB(255, 2, 153, 37),
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
        title: Text(
          'Beer List',
          style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromARGB(255, 43, 83, 102),
      ),
      body: Container(
        decoration: BoxDecoration(color: Color.fromARGB(255, 84, 94, 101)),
        child: ListView.separated(
          itemCount: beers.length,
          separatorBuilder: (BuildContext context, int index) => Divider(),
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(
                beers[index]['name'] ?? '',
                style:
                    TextStyle(color: Colors.amber, fontWeight: FontWeight.bold),
              ),
              onTap: () {
                _showBeerReview(beers[index]['price'], beers[index]['rating'],
                    beers[index]['image']);
              },
            );
          },
        ),
      ),
    );
  }
}
