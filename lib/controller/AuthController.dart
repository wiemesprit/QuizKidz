import 'package:nb_utils/nb_utils.dart';
import '../Screens/QuizSignIn.dart';
import '../data/service/AuthService.dart';
import '../data/models/Auth.dart';
import '../Screens/QuizDashboard.dart';


class AuthController {
  final AuthService authService = AuthService();
  static final instance = AuthController();

  SignupBodyReq signupBodyReq = SignupBodyReq();

  AuthController() {
    initialize();
  }

  Future<dynamic>? login({email, password}) async {
    var res = await authService
        .login(SigninBodyReq(email: email, password: password));

    if (res is SigninSuccessRes) {
      sharedPreferences.setString("user", res.user ?? "");
      push(QuizDashboard(), pageRouteAnimation: PageRouteAnimation.Slide);
    } else if (res is SigninErrorRes) {
      return SigninErrorRes();
    }
  }

  logout() {
    sharedPreferences.remove("user");
    push(QuizSignIn(), pageRouteAnimation: PageRouteAnimation.Slide);
  }

  Future<dynamic>? signup() async {
    var res = await authService.signup(this.signupBodyReq);
    if (res is SigninSuccessRes) {
      push(QuizSignIn(), pageRouteAnimation: PageRouteAnimation.Slide);
    } else if (res is SigninErrorRes) {
      return SigninErrorRes();
    }
  }
}
