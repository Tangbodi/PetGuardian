import 'package:flutter/material.dart';
import 'utils/custom_color.dart';

class RegisterPet extends StatefulWidget {
  @override
  _RegisterPetState createState() => _RegisterPetState();
}

class _RegisterPetState extends State<RegisterPet> {
  TextEditingController dateController = TextEditingController();

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
  // Implement your widget build here
  return Scaffold(
    appBar: AppBar(
      centerTitle: true,
      title: const Text('PetGuardian',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
        ),
      ),
    ),
    body: Column(
      children: [
        // Add a container with adjusted padding for top spacing
        Container(
          padding: const EdgeInsets.only(top: 0.0), // Adjust top padding for desired spacing
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'images/regpet.png',
                height: 100,
              ),
                Text(
                'REGISTER PET',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
          Container(
            padding: const EdgeInsets.all(10.0),
            child: const CircleAvatar(
              radius: 45,
              child: Text('Photo'),
            ),
          ),
          Container(
            color: CustomColor.backGroundColor,
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Icon(Icons.local_hospital),
                      SizedBox(width: 5),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(width: 10)),
                            fillColor: CustomColor.vaccinRegColor,
                            filled: true,
                            labelText: 'Veterinary or Clinic',
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0.0, horizontal: 10.0),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: <Widget>[
                      Icon(Icons.calendar_month),
                      SizedBox(width: 5),
                      Expanded(
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
                              vertical: 0.0,
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
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: <Widget>[
                      Icon(Icons.monetization_on),
                      SizedBox(width: 5),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(width: 10)),
                            fillColor: CustomColor.vaccinRegColor,
                            filled: true,
                            labelText: 'Gender',
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0.0, horizontal: 10.0),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: <Widget>[
                      Icon(Icons.monetization_on),
                      SizedBox(width: 5),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(width: 10)),
                            fillColor: CustomColor.vaccinRegColor,
                            filled: true,
                            labelText: 'Animal',
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0.0, horizontal: 10.0),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: <Widget>[
                      Icon(Icons.monetization_on),
                      SizedBox(width: 5),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(width: 10)),
                            fillColor: CustomColor.vaccinRegColor,
                            filled: true,
                            labelText: 'Breed',
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0.0, horizontal: 10.0),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
