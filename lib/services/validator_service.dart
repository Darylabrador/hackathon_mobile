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
}
