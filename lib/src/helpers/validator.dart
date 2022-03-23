part of 'helpers.dart';

class Validator {
  validateText(String value) {
    if (value.isEmpty) {
      return 'El texto es requerido';
    }
    return;
  }

  validateEmail(String value) {
    if (value.isEmpty) {
      return 'El email es requerido';
    } else {
      if (!_isValidEmail(value.toUpperCase())) {
        return 'Ingresa un correo de la UNICLA válido';
      }
      return;
    }
  }

  validatePassword(String value) {
    if (value.isEmpty) {
      return 'La contraseña es requerida';
    } else {
      if (value.length < 6) {
        return 'La contraseña debe contener mínimo 6 caracteres';
      }
      return;
    }
  }

  validateConfirmPassword(String pass, String passConfirm) {
    if (pass.isEmpty) {
      return 'La contraseña es requerida';
    } else {
      if (pass != passConfirm) {
        return 'La contraseñas deben coincidir';
      }
      return;
    }
  }

  validateUrl(String value) {
    if (value.isEmpty) {
      return 'Este campo es requerido';
    } else {
      if (!_isValidUrl(value)) {
        return 'Ingresa una url válida';
      }
      return;
    }
  }

  validateDigit(String value) {
    if (value.isEmpty) {
      return 'El campo es requerido';
    } else {
      if (!_isDecimal(value)) {
        return 'Ingresa una cantidad válida';
      }
      return;
    }
  }

  validateDropdown(String dropdownName, String dropdownValue) {
    if (dropdownName == dropdownValue) {
      return 'Es necesario especificar este campo';
    }
    return;
  }

  validateList(List<dynamic> list) {
    if (list.isEmpty) {
      return 'Es necesario agregar un elemento por lo menos';
    }
    return;
  }

  validateDate(DateTime? date) {
    if (date == null) {
      return 'Es necesario especificar la fecha';
    }
    return;
  }

  validateTime(TimeOfDay? time) {
    if (time == null) {
      return 'Es necesario especificar la hora';
    }
    return;
  }

  bool _isValidUrl(val) {
    return RegExp(
            r'(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?')
        .hasMatch(val);
  }

  bool _isValidEmail(val) {
    return RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@UNICLA.EDU.MX")
        .hasMatch(val);
  }

  bool _isDecimal(String decimal) {
    return double.tryParse(decimal) != null;
  }
}
