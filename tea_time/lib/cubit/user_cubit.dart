import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tea_time/model/user.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(const UserInitial());

  void getUserInfos() async {
    emit(const UserLoading());
    try {
      final User user = await fetchUser();
      emit(UserLoaded(user));
    } catch (e) {
      emit(const UserError('unexpected error'));
    }
  }
}
