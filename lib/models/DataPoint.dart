class DataPoint {
  DateTime date = DateTime.now();
  int? dayOfCycle; // 1, 2, ...
  Severity flow = Severity.unset; // LOW, MEDIUM, HIGH
  int painLevel = 0; // 0-10

  String? dischargeColor;
  String? dischargeConsistency;
  bool dischargeSmell = false;

  // TODO: Define what options from each we can have
  List<String> emotions = [];
  List<String> symptoms = [];
  List<String> sexualActivity = [];
}

enum Severity { unset, low, medium, high }

const dischargeColors = [
  "Clear",
  "White",
  "Yellow",
  "Green",
  "Gray",
  "Pink",
  "Red",
  "Brown"
];
const dischargeConsistencies = ["Normal", "Thick", "Frothy", "Cloudy"];

const emotions = [];
const symptoms = [];
const sexualActivities = [];
