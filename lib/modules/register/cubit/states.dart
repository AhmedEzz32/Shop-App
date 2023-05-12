
import 'package:project1/models/shop_app/shop_login.dart';

abstract class ShopRegisterStates {}

class ShopRegisterInitialState extends ShopRegisterStates {}

class ShopRegisterLoadingState extends ShopRegisterStates {}

class SocialRegisterSuccessState extends ShopRegisterStates
{
  final SocialLoginModel loginModel;
  SocialRegisterSuccessState(this.loginModel);
}

class ShopRegisterErrorState extends ShopRegisterStates
{
  final String error;
  ShopRegisterErrorState(this.error);
}

class ShopRegisterChangePasswordVisibilityState extends ShopRegisterStates {}
