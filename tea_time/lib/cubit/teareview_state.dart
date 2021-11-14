part of 'teareview_cubit.dart';

abstract class TeaReviewState extends Equatable {
  const TeaReviewState();

  @override
  List<Object?> get props => <Object?>[];
}

class TeaReviewInitial extends TeaReviewState {
  const TeaReviewInitial();
}

class TeaReviewLoading extends TeaReviewState {
  const TeaReviewLoading();
}

class TeaReviewLoaded extends TeaReviewState {
  const TeaReviewLoaded(this.teaReview);
  final TeaReview teaReview;

  @override
  List<Object?> get props => <Object?>[teaReview];
}

class TeaReviewError extends TeaReviewState {
  const TeaReviewError(this.message);
  final String message;

  @override
  List<Object?> get props => <Object?>[message];
}
