import 'package:freezed_annotation/freezed_annotation.dart';

part 'reel_user.freezed.dart';
part 'reel_user.g.dart';

/// User information attached to a reel.
@freezed
abstract class ReelUser with _$ReelUser {
  /// Creates a [ReelUser].
  const factory ReelUser({
    required String id,
    required String username,
    String? displayName,
    String? profilePictureUrl,
    @Default(false) bool isVerified,
    @Default(false) bool isFollowing,
    @Default(0) int followersCount,
    @Default(0) int followingCount,
  }) = _ReelUser;

  /// Deserializes a [ReelUser] from JSON.
  factory ReelUser.fromJson(Map<String, Object?> json) =>
      _$ReelUserFromJson(json);
}
