import 'package:flutter/material.dart';
import 'package:pet_guardian/utils/custom_color.dart';
import 'package:pet_guardian/update_vaccine_history.dart';
// Import the constants file

class VaccinesInfo extends StatefulWidget {
  final String? petid;

  // Constructor
  const VaccinesInfo({required Key key, this.petid}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return VaccinesInfoState();
  }
}

class VaccinesInfoState extends State<VaccinesInfo> {
  TextEditingController dateController = TextEditingController();

  bool _isTapped = false;
  bool _isTapped2 = false;

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
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('PetGuardian'),
          ],
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              child: const Column(
                children: <Widget>[
                  Icon(Icons.vaccines),
                  Text('Rabies'),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                  child: const Text('VACCINE'),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: 'Enter vaccination type',
                    ),
                  ),
                ),
                Container(
                padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                  child: const Text('RE-VACCINE REMINDER'),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  child: TextFormField(
                    controller: dateController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: 'Enter vaccination date',
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
                Container(
                padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                  child: const Text('VACCINATION HISTORY'),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isTapped = true;
                    });
                    // Navigate to the new page when container is tapped
                    Future.delayed(const Duration(milliseconds: TapDelay.delayMs), () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UpdateVaccinesHistory(
                                key: ValueKey('unique_value_here'))),
                      ).then((_) {
                        setState(() {
                          _isTapped = false;
                        });
                      });
                    });
                  },
                  child: Container(
                    color: _isTapped ? CustomColor.backGroundColor : Colors.white,
                    padding: const EdgeInsets.all(20),
                    child: const Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(Icons.local_hospital),
                            SizedBox(width: 8.0),
                            Text('Vetco')
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Icon(Icons.calendar_month),
                            SizedBox(width: 8.0),
                            Text('Date'),
                            SizedBox(width: 20),
                            Icon(Icons.attach_money),
                            SizedBox(width: 8.0),
                            Text('Cost'),
                            Spacer(),
                            Icon(Icons.chevron_right_sharp)
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Icon(Icons.local_hospital),
                            SizedBox(width: 8.0),
                            Text('Vetco')
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                CustomPaint(
                  painter: GradientLinePainter(),
                  child: Container(
                    height: 0.1, // Adjust height as needed
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isTapped2 = true;
                    });
                    // Navigate to the new page when container is tapped
                    Future.delayed(const Duration(milliseconds: TapDelay.delayMs), () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UpdateVaccinesHistory(
                                key: ValueKey('unique_value_here'))),
                      ).then((_) {
                        setState(() {
                          _isTapped2 = false;
                        });
                      });
                    });
                  },
                  child: Container(
                    color: _isTapped2 ? CustomColor.backGroundColor : Colors.white,
                    padding: const EdgeInsets.all(20),
                    child: const Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(Icons.local_hospital),
                            SizedBox(width: 8.0),
                            Text('Vetco')
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Icon(Icons.calendar_month),
                            SizedBox(width: 8.0),
                            Text('Date'),
                            SizedBox(width: 20),
                            Icon(Icons.attach_money),
                            SizedBox(width: 8.0),
                            Text('Cost'),
                            Spacer(),
                            Icon(Icons.chevron_right_sharp)
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Icon(Icons.local_hospital),
                            SizedBox(width: 8.0),
                            Text('Vetco')
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                CustomPaint(
                  painter: GradientLinePainter(),
                  child: Container(
                    height: 0.1,
                     // Adjust height as needed
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class GradientLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..shader = LinearGradient(
        colors: [
          CustomColor.transDivderColor,
          CustomColor.dividerColor,
          CustomColor.transDivderColor,
        ],
        stops: [0.3, 0.5, 0.7],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..strokeWidth = 1.0 // Adjust the width of the line
      ..strokeCap = StrokeCap.butt; // Sharp ends

    canvas.drawLine(
      Offset(0, size.height / 2), // Start point
      Offset(size.width, size.height / 2), // End point
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
