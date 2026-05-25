class SearchHelper {
  SearchHelper._();

  static List<String> commonDoctorSpecializationsIndia = [
    "General Physician",
    "Dentist",
    "Gynecologist",
    "Pediatrician",
    "Orthopedic",
    "Dermatologist",
    "ENT Specialist",
    "Cardiologist",
    "Neurologist",
    "Psychiatrist",
    "Ophthalmologist",
    "Diabetologist",
    "Urologist",
    "Gastroenterologist",
    "Pulmonologist",
    "Physiotherapist",
    "General Surgeon",
    "Oncologist",
    "Endocrinologist",
    "Nephrologist",
    "Sexologist",
    "Radiologist",
    "Pathologist",
    "Anesthesiologist",
    "Plastic Surgeon",
    "Rheumatologist",
    "Allergist",
    "Nutritionist",
    "Psychologist",
    "Homeopathic Doctor",
    "Ayurvedic Doctor",
  ];

  static List<double> searchRadiusKmList = [
    1.0,
    2.0,
    5.0,
    10.0,
    15.0,
    20.0,
    25.0,
    30.0,
    50.0,
    75.0,
    100.0,
  ];

  static List<String> weekDays = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday",
  ];

  static String getDayLabel(String dayName) {
    final now = DateTime.now();

    final days = {
      "MONDAY": DateTime.monday,
      "TUESDAY": DateTime.tuesday,
      "WEDNESDAY": DateTime.wednesday,
      "THURSDAY": DateTime.thursday,
      "FRIDAY": DateTime.friday,
      "SATURDAY": DateTime.saturday,
      "SUNDAY": DateTime.sunday,
    };

    final targetDay = days[dayName.toUpperCase()];

    if (targetDay == null) {
      return dayName;
    }

    if (now.weekday == targetDay) {
      return "Today";
    }

    final tomorrow = now.add(const Duration(days: 1));

    if (tomorrow.weekday == targetDay) {
      return "Tomorrow";
    }

    return dayName.substring(0, 1).toUpperCase() +
        dayName.substring(1).toLowerCase();
  }
}