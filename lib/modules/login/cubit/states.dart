import 'package:project1/models/shop_app/shop_login.dart';

abstract class ShopLoginStates{}

class SocialLoginInitialState extends ShopLoginStates{}

class ShopLoginLoadingState extends ShopLoginStates{}

class SocialLoginSuccessState extends ShopLoginStates
{
final SocialLoginModel loginModel;

  SocialLoginSuccessState(this.loginModel);
}

class SocialLoginErrorState extends ShopLoginStates
{
  final String error;

  SocialLoginErrorState(this.error);
}


class ShopChangePasswordVisibilityState extends ShopLoginStates{}