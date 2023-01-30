//LOGIN EXCEPTIONS
class UserNotFoundAuthException implements Exception {}

class WrongPasswordAuthException implements Exception {}

// REGISTRATION EXCEPTIONS
class WeakPasswordAuthException implements Exception {}

class EmailAlreadyInUseException implements Exception {}

class InvalidEmailException implements Exception {}

// GENERIC EXCEPTIONS
class GenericAuthException implements Exception {}

class UserNotLoggedInException implements Exception {}
