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
  SexualActivity? sexualActivity;

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

enum SexualActivity {
  none,
  protectedSex,
  unprotectedSex,
  masturbation,
  highSexDrive,
  lowSexDrive
}

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
