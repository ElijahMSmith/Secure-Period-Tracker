class DataPoint {
  DateTime date;
  int? dayOfCycle; // 1, 2, ...
  Level? flow; // LOW, MEDIUM, HIGH
  int? painLevel; // 1-10

  String? dischargeColor;
  String? dischargeConsistency;
  bool? dischargeSmells;

  // TODO: Define what options from each we can have for each
  List<String>? emotions;
  List<String>? symptoms;
  String? sexualActivity;

  late int id;
  static int staticID = 0;

  DataPoint(
      {required this.date,
      this.dayOfCycle,
      this.flow,
      this.painLevel,
      this.dischargeColor,
      this.dischargeConsistency,
      this.dischargeSmells,
      this.emotions,
      this.symptoms,
      this.sexualActivity}) {
    id = DataPoint.staticID;
    DataPoint.staticID++;
  }

  bool isFilledOut() {
    return notNull(dayOfCycle) ||
        notNull(flow) ||
        notNull(painLevel) ||
        notNull(dischargeColor) ||
        notNull(dischargeConsistency) ||
        notNull(dischargeSmells);
  }

  bool hasItemsFromList() {
    return notNull(emotions) || notNull(symptoms) || notNull(sexualActivity);
  }

  bool notNull(any) {
    return any != null;
  }

  bool hasEmotions() {
    return notNull(emotions) && emotions!.isNotEmpty;
  }

  bool hasSymptoms() {
    return notNull(symptoms) && symptoms!.isNotEmpty;
  }

  bool hasSexualActivities() {
    return notNull(sexualActivity);
  }
}

enum Level { none, low, medium, high }

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

const sexualActivity = [
  "No Sexual Activity",
  "Unprotected Sex",
  "Protected Sex",
  "Masturbation",
  "High Sex Drive",
  "Low Sex Drive"
];

// TEMP

DataPoint dummyPoint1 = DataPoint(
    date: DateTime.now(),
    dayOfCycle: 5,
    flow: Level.medium,
    painLevel: 3,
    dischargeColor: dischargeColors[1],
    dischargeConsistency: dischargeConsistencies[1],
    dischargeSmells: true,
    emotions: ["Sad", "Anxious", "Angry", "Disturbed", "Perturbed", "Absurd"],
    symptoms: [
      "Bloating",
      "Abdominal Cramps",
      "Pelvic Pain",
      "Bleeding",
      "Other Shit"
    ],
    sexualActivity: "No Sexual Activity");

DataPoint dummyPoint2 = DataPoint(
    date: DateTime.now(),
    dayOfCycle: 6,
    flow: Level.low,
    painLevel: 5,
    dischargeColor: dischargeColors[2],
    dischargeConsistency: dischargeConsistencies[0],
    dischargeSmells: false,
    symptoms: [
      "Abdominal Cramps",
      "Pelvic Pain",
      "Not East Stuff To Deal With"
    ],
    sexualActivity: "Unprotected Sex");

DataPoint dummyPoint3 = DataPoint(
    date: DateTime.now(),
    dayOfCycle: 7,
    flow: Level.none,
    painLevel: 10,
    dischargeColor: dischargeColors[1],
    dischargeConsistency: dischargeConsistencies[1],
    dischargeSmells: false,
    sexualActivity: "Protected Sex");

DataPoint dummyPoint4 = DataPoint(
  date: DateTime.now(),
  dayOfCycle: 8,
  flow: Level.high,
  painLevel: 7,
  dischargeColor: dischargeColors[0],
  dischargeConsistency: dischargeConsistencies[0],
  dischargeSmells: true,
);

DataPoint? dummyPoint5;

List<DataPoint?> dummyPoints = [
  dummyPoint1,
  dummyPoint2,
  dummyPoint3,
  dummyPoint4,
  dummyPoint5
];
