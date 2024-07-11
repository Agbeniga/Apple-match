String? Function(String?)? get validateEmail => (value) {
      String? error;

      if (value?.trim().isNotEmpty != true) {
        error = "Email required";
      } else {
        const pattern =
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";

        final regExp = RegExp(pattern);

        if (!regExp.hasMatch(value ?? '')) {
          error = "Invalid Email";
        }
      }

      return error;
    };

String? Function(String?)? get validatePhoneNumber => (value) {
      String? error;
      if (value?.trim().isNotEmpty != true) {
        error = "Phone number required";
      }
      if (value?.isNotEmpty == true) {
        const pattern =
            r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$';

        final regExp = RegExp(pattern);

        if (!regExp.hasMatch(value!)) {
          error = "Invalid Phone Number";
        }
      }

      return error;
    };
