import '../models/user_model.dart';

class Session {
  static final UserModel demoUser = UserModel(
    firstName: 'Leo',
    lastName: 'Grzn',
    username: 'leo@sample.com',
    password: '@Password1',
  );

  static UserModel? currentUser; // for real registered users later
}
