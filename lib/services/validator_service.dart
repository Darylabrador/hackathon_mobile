class ValidatorService {
  static String? validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);

    if (value!.trim().isEmpty) {
      return 'Veuillez saisir une adresse email valide';
    }

    if (!regex.hasMatch(value)) {
      return 'Veuillez saisir une adresse email valide';
    } else {
      return null;
    }
  }

  static String? validatePassword(String? value) {
    if (value!.trim().isEmpty) {
      return "Veuillez saisir le mot de passe";
    }
    if (value.length < 5) {
      return "Le mot de passe doit faire 5 caractères minimum";
    }
    return null;
  }

  static String? validateField(String? value) {
    if (value!.trim().isEmpty) {
      return "Veuillez saisir une valeur";
    }
    return null;
  }

  static String? validateAge(String? value) {
    if (value!.trim().isEmpty) {
      return 'Veuillez saisir votre age';
    }
    if (!value.contains(RegExp(r'^[0-9]{2}'))) {
      return 'Il faut que des chiffres';
    }
    return null;
  }
}
