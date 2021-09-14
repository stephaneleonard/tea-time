part of 'user_cubit.dart';

@immutable
abstract class UserState {
  const UserState();
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
  // ignore: avoid_renaming_method_parameters
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is UserLoaded && o.user == user;
  }

  @override
  int get hashCode => user.hashCode;
}

class UserError extends UserState {
  const UserError(this.message);
  final String message;
}
