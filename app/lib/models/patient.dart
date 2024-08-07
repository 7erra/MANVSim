import 'package:manv_api/api.dart';
import 'package:manvsim/models/location.dart';

class Patient {
  final int id;
  final String name;
  final Location location;

  Patient({required this.id, required this.name, required this.location});

  factory Patient.fromApi(PatientDTO dto) {
    return Patient(
        id: dto.id, name: dto.name, location: Location.fromApi(dto.location));
  }
}
