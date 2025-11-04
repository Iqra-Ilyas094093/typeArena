String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your password';
  }

  if (value.length < 6) {
    return 'Password must be at least 6 characters long';
  }

  // Optional: Add strength check (at least 1 letter & number)
  const passwordRegex = r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$';
  if (!RegExp(passwordRegex).hasMatch(value)) {
    return 'Password must contain letters and numbers';
  }
  return null;
}

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your email';
  }

  // Simple email format validation
  const emailRegex = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  if (!RegExp(emailRegex).hasMatch(value)) {
    return 'Please enter a valid email address';
  }
  return null;
}

String? validateUsername(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a username';
  }

  if (value.length < 3) {
    return 'Username must be at least 3 characters long';
  }

  // Allow only letters, numbers, underscores
  const usernameRegex = r'^[a-zA-Z0-9_]+$';
  if (!RegExp(usernameRegex).hasMatch(value)) {
    return 'Only letters, numbers, and underscores are allowed';
  }

  // Optional: Restrict max length
  if (value.length > 16) {
    return 'Username must be less than 16 characters';
  }

  return null; // ✅ Valid
}

