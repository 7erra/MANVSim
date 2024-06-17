//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of manv_api;

class Patient {
  /// Returns a new [Patient] instance.
  Patient({
    this.id,
    this.name,
    this.injuries,
    this.treatingUsers = const [],
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? id;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? name;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? injuries;

  List<String> treatingUsers;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Patient &&
    other.id == id &&
    other.name == name &&
    other.injuries == injuries &&
    _deepEquality.equals(other.treatingUsers, treatingUsers);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id == null ? 0 : id!.hashCode) +
    (name == null ? 0 : name!.hashCode) +
    (injuries == null ? 0 : injuries!.hashCode) +
    (treatingUsers.hashCode);

  @override
  String toString() => 'Patient[id=$id, name=$name, injuries=$injuries, treatingUsers=$treatingUsers]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.id != null) {
      json[r'id'] = this.id;
    } else {
      json[r'id'] = null;
    }
    if (this.name != null) {
      json[r'name'] = this.name;
    } else {
      json[r'name'] = null;
    }
    if (this.injuries != null) {
      json[r'injuries'] = this.injuries;
    } else {
      json[r'injuries'] = null;
    }
      json[r'treatingUsers'] = this.treatingUsers;
    return json;
  }

  /// Returns a new [Patient] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Patient? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "Patient[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "Patient[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Patient(
        id: mapValueOfType<int>(json, r'id'),
        name: mapValueOfType<String>(json, r'name'),
        injuries: mapValueOfType<String>(json, r'injuries'),
        treatingUsers: json[r'treatingUsers'] is Iterable
            ? (json[r'treatingUsers'] as Iterable).cast<String>().toList(growable: false)
            : const [],
      );
    }
    return null;
  }

  static List<Patient> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Patient>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Patient.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Patient> mapFromJson(dynamic json) {
    final map = <String, Patient>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Patient.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Patient-objects as value to a dart map
  static Map<String, List<Patient>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Patient>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Patient.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}
