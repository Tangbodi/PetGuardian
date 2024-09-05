import '../utils/mysql.dart';
import '../model/pets_info.dart';

class DatabaseHelper {
  final DatabaseConnection _dbConnection = DatabaseConnection();

  Future<List<PetInfo>> getAllPetsInfo() async {
    final conn = await _dbConnection.getConnection();
    final results = await conn.execute('SELECT * FROM pets_info;');
    await conn.close();

    List<PetInfo> petsList = [];
    if (results.rows.isEmpty) {
      print('No records found in the pets_info table.');
    } else {
      for (var row in results.rows) {
         Map data = row.assoc();
         print(data);
        PetInfo petInfo = PetInfo(
          //${data['id']}
          petId: '${data['pet_id']}',
          petName: '${data['pet_name']}',
          breed: '${data['pet_breed']}',
          age: '${data['pet_age']}',
          gender: '${data['pet_gender']}',
          weight: '${data['pet_weight']}',
        );
        petsList.add(petInfo);
      }
    }
    return petsList;
  }

  Future<PetInfo> getOnePetInfo(String petId) async {
    final conn = await _dbConnection.getConnection();
    final results = await conn.execute('SELECT * FROM pets_info WHERE pet_id = :petId;',{'petId':petId});
    await conn.close();

    PetInfo petInfo = new PetInfo(petId: petId, petName: 'petName', breed: 'breed', age: 'age', gender: 'gender', weight: 'weight');
  //  late PetInfo petInfo;
    if (results.rows.isEmpty) {
      print('No records found in the pets_info table.');
    } else {
      for (var row in results.rows) {
         Map data = row.assoc();
         print(data);
        PetInfo info = PetInfo(
          //${data['id']}
          petId: '${data['pet_id']}',
          petName: '${data['pet_name']}',
          breed: '${data['pet_breed']}',
          age: '${data['pet_age']}',
          gender: '${data['pet_gender']}',
          weight: '${data['pet_weight']}',
        );
        petInfo = info;
      }
    }
    return petInfo;
  }

}


