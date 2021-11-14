part of 'user_cubit.dart';

@immutable
abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => <Object?>[];
}

class UserInitial extends UserState {
  const UserInitial();
}

class UserLoading extends UserState {
  const UserLoading();
}

class UserLoaded extends UserState {
  const UserLoaded(this.user);
  final User user;

  @override
  List<Object?> get props => <Object?>[user];
}

class UserError extends UserState {
  const UserError(this.message);
  final String message;

  @override
  List<Object?> get props => <Object?>[message];
}
