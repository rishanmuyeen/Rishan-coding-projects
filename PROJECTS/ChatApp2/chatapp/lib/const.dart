final RegExp EMAIL_VALIDATION_REGEX =
    RegExp(r"^[\w-\.]+@gmail\.com$");

final RegExp PASSWORD_VALIDATION_REGEX =
    RegExp(r"^(?=.*[A-Z]).{8,}$");

final RegExp NAME_VALIDATION_REGEX = RegExp(r"\b([A-ZÀ-ÿ][-,a-z. ']+[ ]*)+");

final String PLACEHOLDER_PFP =
    "https://t3.ftcdn.net/jpg/05/16/27/58/360_F_516275801_f3Fsp17x6HQK0xQgDQEELoTuERO4SsWV.jpg";