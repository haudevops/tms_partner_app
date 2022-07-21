class Apis {
  // auth
  static const String patchLogin = '/auth/api/servicer/login';

  // profile
  static const String patchGetUserInfo = '/api/servicer/profile';
  static const String patchGetAppSettings = '/api/servicer/app/settings';

  // news
  static const String patchGetNews = '/marketing/api/servicer/news';

  // orders
  static const String patchGetStatistical =
      '/order/api/servicer/order/statistical';
  static const String patchGetOrders = '/order/api/servicer/orders';
  static const String patchGetOrder = '/order/api/servicer/order';
  static const String patchArrivedInOrderGroup = '/delivery/api/servicer/order';
  static const String patchPickupOrder = '/delivery/api/servicer/order';

  static const String patchactivities = '/activity/api/servicer/activities';

  // logout
  static const String patchChangePassword = '/api/servicer/password';

  //forgot password
  static const String patchEnterPhone = '/auth/api/servicer/otp/login/generate';

  //verify otp
  static const String patchVerifyOTP = '/auth/api/servicer/login';

  // location
  static const String pushLocation = '/location/api/servicer/location';

  // upload
  static const String patchUpload = '/file/upload';
}
