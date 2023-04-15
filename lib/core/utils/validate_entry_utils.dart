class ValidateEntryUtils {
  String? validateEmail(String value) {
    if (value.isEmpty ||
        !RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$").hasMatch(value)) {
      return "Insira um endereço de e-mail correto.";
    } else {
      return null;
    }
  }

  String? validatePassword(String value) {
    final RegExp regex =
        RegExp(r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$");
    if (value.isEmpty) {
      return "Por favor, digite a senha.";
    } else {
      if (!regex.hasMatch(value)) {
        return "Insira uma senha válida.";
      } else {
        return null;
      }
    }
  }

  String? validatePositiveValue(String value) {
    if (value.isEmpty) {
      return "Campo não pode estar vazio.";
    }

    final double convertValue = double.parse(
      value.replaceAll("R\$", "").replaceAll(".", "").replaceAll(",", "."),
    );

    if (convertValue <= 0) {
      return "Valor não pode ser igual a zero.";
    } else {
      return null;
    }
  }

  String? validateIsEmpty(String value) {
    if (value.isEmpty) {
      return "Campo não pode estar vazio.";
    } else {
      return null;
    }
  }
}
