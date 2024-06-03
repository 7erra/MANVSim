import 'dart:convert';
import 'dart:math';

import 'package:manvsim/models/location.dart';
import 'package:manvsim/models/patient_action.dart';

Future<List<Location>> fetchLocations() async {
  await Future.delayed(const Duration(seconds: 1));
  String json = demoJson;
  List<dynamic> jsonList = jsonDecode(json);
  return jsonList.map((location) => Location.fromJson(location)).toList();
}

Future<List<PatientAction>> fetchActions() async {
  await Future.delayed(const Duration(seconds: 1));
  String json = demoActions;
  List<dynamic> jsonList = jsonDecode(json);
  return jsonList.map((action) => PatientAction.fromJson(action)).toList();
}

Future<String> fetchActionResult(int performedActionId) async {
  await Future.delayed(const Duration(seconds: 1));
  return "Successful result for $performedActionId";
}

Future<int> performAction(int actionId, List<int> resourceIds) async {
  await Future.delayed(const Duration(seconds: 1));
  if (Random().nextBool()) throw Error();
  return 1;
}

const String demoActions = """
[
  {
    "id": 1,
    "name": "Pflaster anbringen",
    "durationInSeconds": 10,
    "resourceNamesNeeded": [
      "Pflaster"
    ]
  },
  {
    "id": 2,
    "name": "Klamotten aufschneiden",
    "durationInSeconds": 4,
    "resourceNamesNeeded": [
      "Schere"
    ]
  },
  {
    "id": 3,
    "name": "Schmerzmittel verabreichen",
    "durationInSeconds": 20,
    "resourceNamesNeeded": [
      "Schmerzmittel"
    ]
  },
  {
    "id": 4,
    "name": "Sollte nicht zu sehen sein",
    "durationInSeconds": 20,
    "resourceNamesNeeded": [
      "Unbekannte Resource"
    ]
  }
]""";

const String demoJson = """
[
  {
    "id": 1,
    "name": "Roter Rucksack",
    "resources": [
      {
        "id": 1,
        "name": "Schere",
        "quantity": 20
      },
      {
        "id": 40,
        "name": "Pflaster",
        "quantity": 7
      }
    ],
    "locations": [
      {
        "id": 2,
        "name": "Medikamententasche",
        "resources": [
          {
            "id": 2,
            "name": "Schmerzmittel",
            "quantity": 30
          }
        ],
        "locations": [

        ]
      }
    ]
  },
  {
    "id": 3,
    "name": "RTW",
    "resources": [
      {
        "id": 3,
        "name": "EKG",
        "quantity": 120
      }
    ],
    "locations": [
      {
        "id": 4,
        "name": "Medizinschrank",
        "resources": [
          {
            "id": 4,
            "name": "Starkes Schmerzmittel",
            "quantity": 50
          }
        ],
        "locations": [

        ]
      }
    ]
  }
]""";
