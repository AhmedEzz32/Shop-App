import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/modules/shop_app/register/cubit/states.dart';
import 'package:project1/shared/network/end_points.dart';
import 'package:project1/shared/network/remote/diohelper.dart';

import '../../../../models/shop_app/shop_login.dart';

class SocialRegisterCubit extends Cubit<ShopRegisterStates>
{
  SocialRegisterCubit() : super(ShopRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  SocialLoginModel ? loginModel ; //3shan bakhod mno object 3shan a3rf atl3 data sahl
  void userRegister({
    required String? name,
    required String?  email,
    required String? password,
    required String? phone,
})
  {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
        url: REGISTER,
        data: {
          'name' : name,
          'email' : email,
          'password' : password,
          'phone' : phone,
        }
    ).then((value){
      print(value.data);
      loginModel = SocialLoginModel.fromJson(value.data);
      if (loginModel?.data != null) {
        name = loginModel!.data!.name!;
        email = loginModel!.data!.email!;
        phone = loginModel!.data!.phone!;
      }
      emit(SocialRegisterSuccessState(loginModel!));
    }).catchError((error){
      emit(ShopRegisterErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword= true;
  void changePasswordVisibility()
  {
    isPassword = !isPassword ;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopRegisterChangePasswordVisibilityState());
  }
}