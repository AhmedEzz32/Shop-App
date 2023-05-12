import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/categories_model.dart';
import '../../models/change_favourites_model.dart';
import '../../models/favourites_model.dart';
import '../../models/home_model.dart';
import '../../models/shop_login.dart';
import '../../modules/category/categories_screen.dart';
import '../../modules/favourite/favourite_screen.dart';
import '../../modules/products/products_screen.dart';
import '../../modules/settings/settings_screen.dart';
import '../../shared/components/constants.dart';
import '../../shared/network/end_points.dart';
import '../../shared/network/remote/diohelper.dart';
import 'states.dart';


class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> bottomScreen = [
    ProductsScreen(),
    CategoriesScreen(),
    FavouriteScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;
  Map<int, bool> favourite = {};
  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      // printFullText(homeModel!.data!.banners![0].image!);
      // print(homeModel!.status);

      homeModel!.data!.products!
          .forEach((element) //dy aly btkhleny ados favourite tsm3 fy favourite
              {
        favourite.addAll({
          element.id!: element.inFavorites!,
        });
      });
      // print(favourite.toString());

      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel? categoriesModel;
  void getCategories() {
    DioHelper.getData(
      url: GET_CATEGORIES,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);

      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  ChangeFavouriteModel? changeFavouriteModel;
  void changeFavourite(int productId) {
    favourite[productId] = !favourite[productId]!;
    emit(ShopChangeFavouritesState());

    DioHelper.postData(
            url: FAVOURITE,
            data: {
              'product_id': productId,
            },
            token: token)
        .then((value) {
      changeFavouriteModel = ChangeFavouriteModel.fromJson(value.data);
      print(value.data);

      if (!changeFavouriteModel!.status!) {
        favourite[productId] = !favourite[productId]!;
      } else {
        getFavourite();
      }
      emit(ShopSuccessChangeFavouritesState(changeFavouriteModel!));
    }).catchError((error) {
      favourite[productId] = !favourite[productId]!;
      emit(ShopErrorChangeFavouritesState());
    });
  }

  FavouriteModel? favouriteModel;
  void getFavourite() {
    emit(ShopLoadingGetFavouriteState());
    DioHelper.getData(
      url: FAVOURITE,
      token: token,
    ).then((value) {
      favouriteModel = FavouriteModel.fromJson(value.data);
      printFullText(value.data.toString());
      emit(ShopSuccessGetFavouriteState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavouriteState());
    });
  }

  SocialLoginModel? userModel;
  void getUserData() {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = SocialLoginModel.fromJson(value.data);
      // printFullText(userModel!.data!.name);

      emit(ShopSuccessUserDataState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUserDataState());
    });
  }

  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  void updateUserData({
    required String? name,
    required String? email,
    required String? phone,
  }) {
    emit(ShopLoadingUpdateUserState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      userModel = SocialLoginModel.fromJson(value.data);
      if (userModel?.data != null) {
        nameController.text = userModel!.data!.name!;
        emailController.text = userModel!.data!.email!;
        phoneController.text = userModel!.data!.phone!;
      }
      emit(ShopSuccessUpdateUserState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateUserState());
    });
  }
}
