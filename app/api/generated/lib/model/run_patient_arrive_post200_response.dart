//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of manv_api;

class RunPatientArrivePost200Response {
  /// Returns a new [RunPatientArrivePost200Response] instance.
  RunPatientArrivePost200Response({
    this.playerLocation,
    this.patient,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  Location? playerLocation;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  Patient? patient;

  @override
  bool operator ==(Object other) => identical(this, other) || other is RunPatientArrivePost200Response &&
    other.playerLocation == playerLocation &&
    other.patient == patient;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (playerLocation == null ? 0 : playerLocation!.hashCode) +
    (patient == null ? 0 : patient!.hashCode);

  @override
  String toString() => 'RunPatientArrivePost200Response[playerLocation=$playerLocation, patient=$patient]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.playerLocation != null) {
      json[r'player_location'] = this.playerLocation;
    } else {
      json[r'player_location'] = null;
    }
    if (this.patient != null) {
      json[r'patient'] = this.patient;
    } else {
      json[r'patient'] = null;
    }
    return json;
  }

  /// Returns a new [RunPatientArrivePost200Response] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static RunPatientArrivePost200Response? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "RunPatientArrivePost200Response[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "RunPatientArrivePost200Response[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return RunPatientArrivePost200Response(
        playerLocation: Location.fromJson(json[r'player_location']),
        patient: Patient.fromJson(json[r'patient']),
      );
    }
    return null;
  }

  static List<RunPatientArrivePost200Response> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <RunPatientArrivePost200Response>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = RunPatientArrivePost200Response.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, RunPatientArrivePost200Response> mapFromJson(dynamic json) {
    final map = <String, RunPatientArrivePost200Response>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = RunPatientArrivePost200Response.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of RunPatientArrivePost200Response-objects as value to a dart map
  static Map<String, List<RunPatientArrivePost200Response>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<RunPatientArrivePost200Response>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = RunPatientArrivePost200Response.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}
