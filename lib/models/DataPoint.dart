class DataPoint {
  DateTime date = DateTime.now();
  int? dayOfCycle; // 1, 2, ...
  Severity? flow; // LOW, MEDIUM, HIGH
  int? painLevel; // 1-10

  String? dischargeColor;
  String? dischargeConsistency;
  bool? dischargeSmells;

  // TODO: Define what options from each we can have for each
  List<String>? emotions;
  List<String>? symptoms;
  List<String>? sexualActivity;

  DataPoint();
  DataPoint.withData(
      this.date,
      this.dayOfCycle,
      this.flow,
      this.painLevel,
      this.dischargeColor,
      this.dischargeConsistency,
      this.dischargeSmells,
      this.emotions,
      this.symptoms,
      this.sexualActivity);

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
    return emotions != null && emotions!.isNotEmpty;
  }

  bool hasSymptoms() {
    return emotions != null && emotions!.isNotEmpty;
  }

  bool hasSexualActivities() {
    return emotions != null && emotions!.isNotEmpty;
  }
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
