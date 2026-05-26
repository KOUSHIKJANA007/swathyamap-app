class InstituteHelper {
   static final String CLINIC = "CLINIC";
   static final String HOSPITAL = "HOSPITAL";
   static final String DIAGNOSTIC_CENTER = "DIAGNOSTIC_CENTER";
   static final String MEDICAL_SHOP = "MEDICAL_SHOP";
   static final String DENTAL_CLINIC = "DENTAL_CLINIC";
   static final String BLOOD_BANK = "BLOOD_BANK";
   static final String NURSING_HOME = "NURSING_HOME";
   static final String REHAB_CENTER = "REHAB_CENTER";

  static List<Map<String, String>> instituteTypes = [
    {
      "value": CLINIC,
      "label": "Clinic",
    },
    {
      "value": HOSPITAL,
      "label": "Hospital",
    },
    {
      "value": DIAGNOSTIC_CENTER,
      "label": "Diagnostic Center",
    },
    {
      "value": MEDICAL_SHOP,
      "label": "Medical Shop",
    },
    {
      "value": DENTAL_CLINIC,
      "label": "Dental Clinic",
    },
    {
      "value": BLOOD_BANK,
      "label": "Blood Bank",
    },
    {
      "value": NURSING_HOME,
      "label": "Nursing Home",
    },
    {
      "value": REHAB_CENTER,
      "label": "Rehab Center",
    }
  ];

  static List<String> indianStates = [
      "Andhra Pradesh",
      "Arunachal Pradesh",
      "Assam",
      "Bihar",
      "Chhattisgarh",
      "Goa",
      "Gujarat",
      "Haryana",
      "Himachal Pradesh",
      "Jharkhand",
      "Karnataka",
      "Kerala",
      "Madhya Pradesh",
      "Maharashtra",
      "Manipur",
      "Meghalaya",
      "Mizoram",
      "Nagaland",
      "Odisha",
      "Punjab",
      "Rajasthan",
      "Sikkim",
      "Tamil Nadu",
      "Telangana",
      "Tripura",
      "Uttar Pradesh",
      "Uttarakhand",
      "West Bengal"
  ];
}