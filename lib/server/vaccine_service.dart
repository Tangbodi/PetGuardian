import 'package:pet_guardian/model/pet_vaccine_map.dart';
import '../utils/mysql.dart';
import '../model/revaccine_reminder.dart';
class FetchPetVaccineMapData {
  final DatabaseConnection _dbConnection = DatabaseConnection();

  Future<List<PetVaccineMap>> fetchPetVaccineMapData(String petId) async {
    // int.parse(petId);
    final conn = await _dbConnection.getConnection();
    final results = await conn.execute(
        'SELECT pi.pet_id, pi.pet_name, pi.pet_age, pi.pet_weight, pi.pet_gender, pi.pet_breed, vh.vaccine_id, vh.vaccine_type, vh.created_at, vh.modified_at FROM pets_info pi JOIN pet_vaccine_history_map phm ON phm.pet_id = pi.pet_id JOIN vaccine_history vh ON vh.vaccine_id = phm.vaccine_id WHERE phm.pet_id = :petId;',{'petId':petId});
        print('${results.affectedRows}');

    await conn.close();

    List<PetVaccineMap> petVaccineMapList = [];
    if (results.rows.isEmpty) {
      print('No records found in the pets_info table.');
    } else {
      for (var row in results.rows) {
        Map data = row.assoc();
        print(data);
        PetVaccineMap petVaccineMap = PetVaccineMap(
          petId: '${data['pet_id']}',
          vaccineId: '${data['vaccine_id']}',
          petName: '${data['pet_name']}',
          vaccineType: '${data['vaccine_type']}',
          breed: '${data['pet_breed']}',
          age: '${data['pet_age']}',
          gender: '${data['pet_gender']}',
          weight: '${data['pet_weight']}',
          createdAt: '${data['created_at']}',
          modifiedAt: '${data['modified_at']}',
        );
        petVaccineMapList.add(petVaccineMap);
      }
    }
    return petVaccineMapList;
  }
}

class FetchVaccineReminderData{

  final DatabaseConnection _dbConnection = DatabaseConnection();

  Future<RevaccineReminder?> fetchVaccineReminderData(String vaccineId) async {
    RevaccineReminder? revaccineReminder;
    try {
      final conn = await _dbConnection.getConnection();
      final results = await conn.execute(
        'SELECT * FROM vaccine_reminder WHERE vaccine_id = :vaccineId;',
        {'vaccineId': vaccineId},
      );
      await conn.close();

      if (results.rows.isEmpty) {
        print('No records found in the vaccine_reminder table.');
      } else {
        var row = results.rows.first;
        Map data = row.assoc();
        print(data);
        revaccineReminder = RevaccineReminder(
          reminderId: data['reminder_id'],
          vaccineId: data['vaccine_id'],
          vaccineType: data['vaccine_type'],
          revaccineDate: data['revaccine_date'],
          createdAt: data['created_at'],
          modifiedAt: data['modified_at'],
        );
      }
    } catch (e) {
      print('Error fetching vaccine reminder data: $e');
    }
    return revaccineReminder;
  }
}

