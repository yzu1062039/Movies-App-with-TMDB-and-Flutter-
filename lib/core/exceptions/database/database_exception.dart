import 'package:equatable/equatable.dart';

/// A custom exception class for database errors.
///
/// This class extends the `Equatable` and `Exception` classes.
///
/// The `message` property is a string that holds the error message.
///
/// The `DatabaseException.fromSQfliteError` constructor takes an `Dynamic` object
/// and initializes the `message` property with the error message from the `IsarError`.
///
/// The `props` getter returns a list containing the `message` property.
class DatabaseException extends Equatable implements Exception {
  late final String message;

  DatabaseException.fromSQfliteError(sqfliteError) : message = sqfliteError;

  @override
  List<Object?> get props => [message];
}
