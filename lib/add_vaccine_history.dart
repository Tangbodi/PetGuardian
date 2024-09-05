import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import '../utils/custom_color.dart';

class AddVaccinesHistory extends StatefulWidget {
  final String? petId;
  // Constructor
  const AddVaccinesHistory({required Key key, this.petId}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AddVaccinesHistoryState();
  }
}

class AddVaccinesHistoryState extends State<AddVaccinesHistory> {
  TextEditingController dateController = TextEditingController();
  final textEditController = TextEditingController();

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  void selectDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (selectedDate != null) {
      setState(() {
        dateController.text = "${selectedDate.toLocal()}"
            .split(' ')[0]; // Format the date as needed
      });
    }
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      centerTitle: true,
      title: const Text('PetGuardian',
      style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
      ),

      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.more_horiz),
          onPressed: () {
            // Add your notifications onPressed functionality here
          },
        ),
      ],
    ),
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
              const SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
            Text(
              'Vaccination History',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
            const SizedBox(height: 20.0),
     const Padding(
          padding: EdgeInsets.only(left: 10.0), // Adjust the padding as needed
          child: Text('REGISTER VACCINATION'),
        ),            
        Container(
              color: CustomColor.backGroundColor,
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      const Icon(Icons.local_hospital),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: Container(
                          height: 40.0, // Set the height of the TextFormField
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              fillColor: CustomColor.vaccinRegColor,
                              filled: true,
                              labelText: 'Veterinary or Clinic',
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 10.0,
                                horizontal: 10.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    children: <Widget>[
                      const Icon(Icons.calendar_month),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: Container(
                          height: 40.0, // Set the height of the TextFormField
                          child: TextFormField(
                            controller: dateController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              fillColor: CustomColor.vaccinRegColor,
                              filled: true,
                              labelText: 'Date of Vaccine Application',
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 10.0,
                                horizontal: 10.0,
                              ),
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.calendar_today),
                                onPressed: () {
                                  selectDate(context);
                                },
                              ),
                            ),
                            readOnly: true, // Make the TextFormField read-only
                            onTap: () {
                              selectDate(context);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    children: <Widget>[
                      const Icon(Icons.monetization_on),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: Container(
                          height: 40.0, // Set the height of the TextFormField
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              fillColor: CustomColor.vaccinRegColor,
                              filled: true,
                              labelText: 'Value',
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 10.0,
                                horizontal: 10.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
                const Padding(
          padding: EdgeInsets.only(left: 10.0), // Adjust the padding as needed
          child: Text('NOTES'),
        ),
            Container(
              height: 300.0,
              decoration: BoxDecoration(
                color: CustomColor.backGroundColor,
                borderRadius: BorderRadius.circular(10.0), // Optional: to give rounded corners
              ),
              child: TextFormField(
                maxLines: null,
                expands: true,
                    textAlignVertical: TextAlignVertical.top,

                decoration: const InputDecoration(
                  hintText: 'Enter your note here...',
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.all(10.0),
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