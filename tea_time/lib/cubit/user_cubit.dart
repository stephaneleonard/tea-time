import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tea_time/domain/entities/user.dart';
import 'package:tea_time/domain/repository/user_repository.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this.userRepository) : super(const UserInitial());

  final UserRepository userRepository;

  Future<void> getUserInfos() async {
    emit(const UserLoading());
    try {
      final User user = await userRepository.fetchUser();
      emit(UserLoaded(user));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
}
