import 'package:equatable/equatable.dart';

class ApiFailureHandler extends Equatable {
  final String message;

  const ApiFailureHandler({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
