import 'package:flutter/material.dart';
import 'package:pet_guardian/add_vaccine_history.dart';
import 'package:intl/intl.dart';
import 'utils/custom_color.dart';
import 'model/pet_vaccine_map.dart';
import 'server/vaccine_service.dart';
import 'update_vaccine_history.dart';
import 'model/pets_info.dart';
import 'server/pets_service.dart';
import 'utils/line_painter.dart';

class Home extends StatefulWidget {
  final String? petId;

  const Home({required Key key, this.petId}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DateTime? _selectedDate;
  bool _isTaken = false;
  List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  Map<String, String?> statuses = {};

  List<bool> isSelected = [false, true, false];
  List<PetVaccineMap> petVaccineMapList = [];
  List<bool> isTappedList = [];
  final PageController _pageController =
      PageController(initialPage: 1); // Set initial page to 1
  PetInfo petInfo = PetInfo(
      petId: 'petId',
      petName: 'petName',
      breed: 'breed',
      age: 'age',
      gender: 'gender',
      weight: 'weight');

  @override
  void initState() {
    super.initState();
    fetchPetsVaccineHistory();
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _isTaken = false;
      });
    }
  }

  void _toggleTaken() {
    setState(() {
      _isTaken = !_isTaken;
    });
  }

  void _onToggleSelected(int index) {
    setState(() {
      for (int buttonIndex = 0;
          buttonIndex < isSelected.length;
          buttonIndex++) {
        isSelected[buttonIndex] = buttonIndex == index;
      }
      _animateToPage(index);
    });
  }

  void _animateToPage(int index) {
    int currentIndex = _pageController.page!.round();
    if (currentIndex == 0 && index == isSelected.length - 1) {
      _pageController.jumpToPage(isSelected.length);
    } else if (currentIndex == isSelected.length - 1 && index == 0) {
      _pageController.jumpToPage(-1);
    } else {
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> fetchPetsVaccineHistory() async {
    try {
      if (widget.petId != null) {
        List<PetVaccineMap> list = await FetchPetVaccineMapData()
            .fetchPetVaccineMapData(widget.petId!);
        PetInfo info = await DatabaseHelper().getOnePetInfo(widget.petId!);
        setState(() {
          petVaccineMapList = list;
          petInfo = info;
          isTappedList = List<bool>.filled(petVaccineMapList.length, false);
        });
      } else {
        print('Error: petId is null');
      }
    } catch (e) {
      print('Error occurred while fetching pets: $e');
    }
  }

  void _showStatusDialog(String day) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$day Status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Taken'),
                leading: Radio<String>(
                  value: 'Taken',
                  groupValue: statuses[day],
                  onChanged: (value) {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              ListTile(
                title: Text('Skipped'),
                leading: Radio<String>(
                  value: 'Skipped',
                  groupValue: statuses[day],
                  onChanged: (value) {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('PetGuardian'),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_horiz),
            onPressed: () {
              // Add your notifications onPressed functionality here
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildPetInfo(),
          _buildToggleButtons(),
          _buildPageView(dateFormat),
        ],
      ),
    );
  }

  Widget _buildPetInfo() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 45,
          ),
          const SizedBox(height: 10.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                petInfo.petName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (petInfo.gender == 'girl')
                    const Icon(Icons.female)
                  else if (petInfo.gender == 'body')
                    const Icon(Icons.male),
                  const SizedBox(width: 10),
                  Text('${petInfo.weight} lbs'),
                  const SizedBox(width: 10),
                  Text(petInfo.breed),
                ],
              ),
              Text('${petInfo.age} years old'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButtons() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: ToggleButtons(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        isSelected: isSelected,
        selectedColor: CustomColor.inactiveBgColor,
        fillColor: CustomColor.toggleSwitchColor,
        constraints: const BoxConstraints(
          minHeight: 10.0,
          minWidth: 100.0,
        ),
        onPressed: _onToggleSelected,
        children: const [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.medical_information),
              Text('Medical', style: TextStyle(fontSize: 12)),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.vaccines),
              Text('Vaccines', style: TextStyle(fontSize: 12)),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.cut),
              Text('Groom', style: TextStyle(fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPageView(DateFormat dateFormat) {
    return Expanded(
      flex: 3,
      child: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            for (int buttonIndex = 0;
                buttonIndex < isSelected.length;
                buttonIndex++) {
              isSelected[buttonIndex] = buttonIndex == index;
            }
          });
        },
        children: [
          _buildMedicalPage(dateFormat),
          _buildVaccinePage(dateFormat),
          Center(child: const Text('Groom Page')),
        ],
      ),
    );
  }

  Widget _buildVaccinePage(DateFormat dateFormat) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left:
                            10.0), // Add space from the left of Icon(Icons.sort)
                    child: Icon(Icons.sort),
                  ),
                  const SizedBox(width: 5),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 0.0), // Add space from the left of 'due date'
                    child: Text('due date'),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        right:
                            0.0), // Add space from the right of 'new vaccine'
                    child: Text('new vaccine'),
                  ),
                  const SizedBox(width: 5),
                  Padding(
                    padding: const EdgeInsets.only(
                        right:
                            10.0), // Add space from the right of Icon(Icons.add)
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddVaccinesHistory(
                                  key: ValueKey(petInfo
                                      .petId))), // Replace NewScreen with the screen you want to navigate to
                        );
                      },
                      child: Icon(Icons.add),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: petVaccineMapList.length,
              itemBuilder: (context, index) {
                final vaccine = petVaccineMapList[index];
                DateTime createdAt =
                    DateTime.parse(petVaccineMapList[index].createdAt);
                DateTime modifiedAt =
                    DateTime.parse(petVaccineMapList[index].modifiedAt);

                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isTappedList[index] = true;
                        });
                        Future.delayed(const Duration(milliseconds: 300), () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdateVaccinesHistory(
                                key: ValueKey(
                                    '${petVaccineMapList[index].petId}_${petVaccineMapList[index].vaccineId}'),
                                petId: petVaccineMapList[index].petId,
                                vaccineId: petVaccineMapList[index].vaccineId,
                              ),
                            ),
                          ).then((_) {
                            setState(() {
                              isTappedList[index] = false;
                            });
                          });
                        });
                      },
                      child: Container(
                        color: isTappedList[index]
                            ? CustomColor.tappedColor
                            : CustomColor.backGroundColor,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        child: Row(
                          children: [
                            const Icon(Icons.vaccines),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(vaccine.vaccineType),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'last: ${dateFormat.format(createdAt)}',
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(width: 30),
                                      Expanded(
                                        child: Text(
                                          'next: ${dateFormat.format(modifiedAt)}',
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    CustomPaint(
                      painter: GradientLinePainter(),
                      child: Container(
                        height: 1.0, // Adjust height as needed
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMedicalPage(DateFormat dateFormat) {
   return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
      child: Column(
        
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _buildDayWidgets(), // Call a method to build day widgets
          ),
          // Add more widgets as needed
        ],
      ),
    );
  }
  List<Widget> _buildDayWidgets() {
    List<String> days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

    return days.map((day) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(day),
          GestureDetector(
            onTap: () => _showStatusDialog(day),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: medical_status[day] == 'Taken'
                    ? CustomColor.medicalSeletionColor
                    : medical_status[day] == 'Skipped'
                        ? Colors.grey
                        : Colors.grey,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  medical_status[day]?.isNotEmpty == true
                      ? medical_status[day]![0]
                      : '',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      );
    }).toList();
  }
   Map<String, String> medical_status = {
    'M': 'Taken',
    'T': 'Skipped',
    'W': '',
    'T': 'Taken',
    'F': '',
    'S': 'Skipped',
    'S': 'Taken',
  };
}
