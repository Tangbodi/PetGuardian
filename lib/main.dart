import 'package:flutter/material.dart';
import 'package:pet_guardian/model/pets_info.dart';
import 'loading.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'home.dart';
import 'utils/custom_color.dart';
import 'register_pet.dart';
import 'server/pets_service.dart';

class MyWidget extends StatefulWidget {
  @override
  MyWidgetState createState() => MyWidgetState();
}

class MyWidgetState extends State<MyWidget> {
  List<PetInfo> petsInfoList = [];
  List<bool> isTappedList = [];
  PageController _pageController = PageController();
  List<bool> isSelected = [false, true, false];
  @override
  void initState() {
    super.initState();
    fetchPets();
  }

  Future<void> fetchPets() async {
    try {
      List<PetInfo> list = await DatabaseHelper().getAllPetsInfo();
      setState(() {
        petsInfoList = list;
        isTappedList = List<bool>.filled(petsInfoList.length, false);
      });
    } catch (e) {
      print('Error occurred while fetching pets: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Container(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  // Add your menu onPressed functionality here
                },
              ),
              const Text('PetGuardian'),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPet()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20), // Add some spacing
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(20.0),
                child: ToggleSwitch(
                  minWidth: 90.0,
                  cornerRadius: 20.0,
                  activeBgColors: const [
                    [CustomColor.toggleSwitchColor],
                    [CustomColor.toggleSwitchColor]
                  ],
                  activeFgColor: Colors.black,
                  inactiveBgColor: CustomColor.inactiveBgColor,
                  inactiveFgColor: CustomColor.inactiveFgColor,
                  initialLabelIndex: 1,
                  totalSwitches: 2,
                  labels: const ['Pet', 'Calendar'],
                  radiusStyle: true,
                  onToggle: (index) {
                    // Implement functionality based on index
                  },
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: petsInfoList.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      isTappedList[index] = true;
                    });
                    Future.delayed(
                        const Duration(milliseconds: TapDelay.delayMs), () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          if (petsInfoList[index].petId != null) {
                            return Home(
                              key: ValueKey(petsInfoList[index].petId),
                              petId: petsInfoList[index]
                                  .petId, // Pass the non-null petId
                            );
                          } else {
                            // Handle the case when petId is null
                            return Container(); // Or any other widget you want to display
                          }
                        }),
                      ).then((_) {
                        setState(() {
                          isTappedList[index] = false;
                          // Ensure the PageView shows the Vaccine page when returning
                        });
                      });
                    });
                  },
                  child: Container(
                    width: 500,
                    height: 150,
                    color: isTappedList[index]
                        ? CustomColor.backGroundColor
                        : CustomColor.inactiveBgColor,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10.0),
                    child: Row(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          child: const CircleAvatar(
                            radius: 45,
                            child: Text('photo'),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                petsInfoList[index].petName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                ),
                              ),
                              Text(petsInfoList[index].breed),
                              Text(petsInfoList[index].age),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        '/': (context) => LoadingScreen(),
        '/home': (context) => MyWidget(),
      },
    );
  }
}
