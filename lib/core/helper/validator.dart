// Validation helpers for authentication forms
// Implements the validation rules specified in the task requirements
class AuthValidators {
  // Full name validation: required and must start with capital letter
  static String? fullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Full name is required';
    }

    final trimmedValue = value.trim();
    if (trimmedValue[0] != trimmedValue[0].toUpperCase()) {
      return 'First letter must be capital';
    }

    return null;
  }

  // Email validation: required and must contain @ symbol
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }

    if (!value.contains('@')) {
      return 'Enter a valid email';
    }

    return null;
  }

  // Password validation: required and minimum 6 characters
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }

    return null;
  }

  // Confirm password validation: required and must match password
  static String? confirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Confirm password is required';
    }

    if (value != password) {
      return 'Passwords do not match';
    }

    return null;
  }
}
