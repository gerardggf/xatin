import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_state.freezed.dart';

@freezed
class SignInState with _$SignInState {
  factory SignInState({
    @Default(false) bool fetching,
    @Default('') String email,
    @Default('') String password,
  }) = _SignInState;
}
