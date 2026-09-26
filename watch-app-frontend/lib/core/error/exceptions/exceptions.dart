class ServerException implements Exception {
  final String? message;
  ServerException({
    this.message,
  });
}

class ConnectionException implements Exception {}

class RegistrationException implements Exception {
  final String? message;
  RegistrationException(this.message);
}

class LoginException implements Exception {
  final String? message;
  LoginException(this.message);
}

class ProductNotFoundException implements Exception {}

class WatchNotFoundException implements Exception {
  final String? message;
  WatchNotFoundException([this.message = "Watch Not Found"]);
}

class CategoryNotFoundException implements Exception {
  final String? message;
  CategoryNotFoundException([this.message = "Category Not Found"]);
}

class UserNotFoundException implements Exception {
  final String? message;
  UserNotFoundException([this.message = "User Not Found"]);
}

class SalesNotFoundException implements Exception {
  final String? message;
  SalesNotFoundException([this.message = "Sales Not Found"]);
}

class WishlistNotFoundException implements Exception {
  final String? message;
  WishlistNotFoundException([this.message = "Wishlist Not Found"]);
}

class CartNotFoundException implements Exception {
  final String? message;
  CartNotFoundException([this.message = "Cart Not Found"]);
}

class CommandNotFoundException implements Exception {
  final String? message;
  CommandNotFoundException([this.message = "Command Not Found"]);
}

class RefreshTokenException implements Exception {}

class BadOTPException implements Exception {
  final String? message;
  BadOTPException(this.message);
}

class NotAuthorizedException implements Exception {}

class DataNotFoundException implements Exception {
  final String? message;
  DataNotFoundException(this.message);
}

class LocalStorageException implements Exception {}
