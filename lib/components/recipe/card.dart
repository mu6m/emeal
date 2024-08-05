import 'package:emeal/model/recipe_model.dart';
import 'package:emeal/screens/list/detail_screen.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final dynamic item;
  const CardWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(item: item),
          ),
        );
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        margin: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              item['image'],
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['title'],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
