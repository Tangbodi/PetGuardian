import 'package:flutter/material.dart';
import './model/pets_info.dart';

class PetDetailsScreen extends StatelessWidget {
  final PetInfo pet;

  const PetDetailsScreen({Key? key, required this.pet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(pet.petName),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Name: ${pet.petName}'),
            Text('Breed: ${pet.breed}'),
            Text('Age: ${pet.age}'),
            Text('Weight: ${pet.weight}'),
            Text('Gender: ${pet.gender}'),
          ],
        ),
      ),
    );
  }
}
