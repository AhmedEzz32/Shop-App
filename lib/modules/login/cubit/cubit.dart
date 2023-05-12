import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/layout/shop_app/cubit/cubit.dart';
import 'package:project1/models/shop_app/shop_login.dart';
import 'package:project1/modules/shop_app/login/cubit/states.dart';
import 'package:project1/shared/network/end_points.dart';

import '../../../../shared/network/remote/diohelper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>
{

  ShopLoginCubit() : super(SocialLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  SocialLoginModel ? loginModel ; //3shan bakhod mno object 3shan a3rf atl3 data sahl

  SocialLoginModel? userModel;
  void userLogin({
    required String email,
    required String password,
})
  {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
        url: LOGIN,
        data: {
          'email' : email,
          'password' : password,
        }
    ).then((value){
      print(value.data);
      loginModel = SocialLoginModel.fromJson(value.data);
      emit(SocialLoginSuccessState(loginModel!));
    }).catchError((error){
      emit(SocialLoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword= true;
  void changePasswordVisibility()
  {
    isPassword = !isPassword ;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopChangePasswordVisibilityState());
  }
}