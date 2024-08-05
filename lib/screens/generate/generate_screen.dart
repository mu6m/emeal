import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GenerateScreen extends StatefulWidget {
  static const String routeName = '/Forget';

  @override
  State<StatefulWidget> createState() {
    return GenerateScreenState();
  }
}

class GenerateScreenState extends State<GenerateScreen> {
  List<Map<String, dynamic>> avoidList = [
    {"title": "fish", "isChecked": false},
    {"title": "potato", "isChecked": false}
  ];

  TextEditingController calController = TextEditingController();
  @override
  void initState() {
    calController = new TextEditingController(text: '1000');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              Text(
                "Avoid List",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                itemCount: avoidList.length,
                itemBuilder: (context, index) => CheckboxListTile(
                  value: avoidList[index]["isChecked"],
                  onChanged: (value) {
                    setState(() {
                      avoidList[index]["isChecked"] = value!;
                    });
                  },
                  title: Text(
                    avoidList[index]["title"],
                    style: const TextStyle(color: Colors.black87),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Max Calories",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: TextField(
                    controller: calController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        fillColor: Colors.grey.shade200,
                        filled: true,
                        hintStyle: TextStyle(color: Colors.grey[500])),
                  )),
              const SizedBox(height: 25),
              GestureDetector(
                onTap: () async {
                  try {
                    SharedPreferences.setMockInitialValues({});
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    int maxCalories = int.tryParse(calController.text) ?? 0;
                    List<String> itemsToAvoid = avoidList
                        .where((item) => item["isChecked"] == true)
                        .map((item) => item["title"].toString().toLowerCase())
                        .toList();

                    await prefs.setInt("cals", maxCalories);
                    await prefs.setStringList("allowed", itemsToAvoid);

                    // Optionally, show a snackbar to indicate success
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Saved")),
                    );
                  } catch (e) {
                    print("Error: $e");
                    // Optionally, show a snackbar to indicate error
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Error saving preferences")),
                    );
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      "Save",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
