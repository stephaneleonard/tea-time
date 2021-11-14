import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tea_time/domain/entities/tea_review.dart';
import 'package:tea_time/domain/repository/tea_review_repository.dart';

part 'teareview_state.dart';

class TeaReviewCubit extends Cubit<TeaReviewState> {
  TeaReviewCubit(this.teaReviewrepository) : super(const TeaReviewInitial());

  final TeaReviewrepository teaReviewrepository;

  Future<void> getTeaReviewById(String id) async {
    try {
      emit(const TeaReviewLoading());
      final TeaReview teaReview = await teaReviewrepository.fetchTeaReview(id);
      emit(TeaReviewLoaded(teaReview));
    } catch (e) {
      emit(TeaReviewError(e.toString()));
    }
  }
}
