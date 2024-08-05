import 'dart:js_interop_unsafe';

import 'package:emeal/components/recipe/card.dart';
import 'package:emeal/model/recipe_model.dart';
import 'package:emeal/services/recipes.dart';
import 'package:emeal/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecipeList extends StatelessWidget {
  static const String routeName = '/List';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: ListWidget(),
        ));
  }
}

Widget ListWidget() {
  return FutureBuilder(
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      }

      if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      }

      if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return Center(child: Text('No data available'));
      }

      return ListView.builder(
        itemCount: snapshot.data!.length,
        itemBuilder: (context, index) {
          final dynamic obj = snapshot.data![index];
          return CardWidget(item: obj);
        },
      );
    },
    future: search(),
  );
}
