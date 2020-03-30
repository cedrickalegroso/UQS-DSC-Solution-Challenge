class FcmToken {
  final String userUid;
  final String platform;
  final String token;
  final num createdAt;

  FcmToken(
    {this.userUid,
    this.platform,
    this.token,
    this.createdAt
    });
}