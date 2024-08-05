import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<dynamic>> search() async {
  try {
    // Initialize SharedPreferences (for testing purposes)
    SharedPreferences.setMockInitialValues({});
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Retrieve values from preferences
    final int cals = prefs.getInt('cals') ?? 5000;
    final List<String> allowed =
        prefs.getStringList('allowed') ?? ['fish', 'potato', 'chicken'];

    // Build Firestore query
    Query query = FirebaseFirestore.instance
        .collection('recipes')
        .where('cal', isLessThan: cals)
        .where('ing', arrayContainsAny: allowed);

    // Execute query
    QuerySnapshot querySnapshot = await query.get();

    // Convert documents to a list of dynamic values (excluding IDs)
    List<dynamic> data = querySnapshot.docs.map((doc) {
      return doc.data(); // No need for type cast since we're returning dynamic
    }).toList();

    return data;
  } catch (e) {
    print('Error searching recipes: $e');
    return [];
  }
}
