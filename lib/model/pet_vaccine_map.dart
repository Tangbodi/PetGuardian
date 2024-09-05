class PetVaccineMap {
  String petId;
  String vaccineId;
  String petName;
  String breed;
  String weight;
  String age;
  String gender;
  String vaccineType;
  String createdAt;
  String modifiedAt;



  PetVaccineMap(
    {required this.petId, 
    required this.petName, 
    required this.vaccineId,
    required this.breed, 
    required this.age, 
    required this.gender, 
    required this.vaccineType,
    required this.weight, 
    required this.createdAt, 
    required this.modifiedAt}
    );
}