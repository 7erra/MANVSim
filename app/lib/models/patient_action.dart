import 'package:manv_api/api.dart';

class PatientAction {
  final int id;
  final String name;
  final int durationInSeconds;
  final List<String> resourceNamesNeeded;
  final String? pictureRef;

  PatientAction(
      {required this.id,
      required this.name,
      required this.durationInSeconds,
      required this.resourceNamesNeeded,
      this.pictureRef});

  factory PatientAction.fromApi(ActionDTO dto) {
    if ([dto.id, dto.name, dto.durationSec].contains(null)) {
      throw const FormatException('Failed to parse action from JSON.');
    }
    return PatientAction(
        id: dto.id!,
        name: dto.name!,
        durationInSeconds: dto.durationSec!,
        resourceNamesNeeded: dto.resourcesNeeded,
        pictureRef: dto.pictureRef
    );
  }
}
