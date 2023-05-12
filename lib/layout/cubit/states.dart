

import '../../models/change_favourites_model.dart';
import '../../models/shop_login.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {}

class ShopSuccessCategoriesState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates {}

class ShopChangeFavouritesState extends ShopStates {}

class ShopSuccessChangeFavouritesState extends ShopStates
{
  final ChangeFavouriteModel model;
  ShopSuccessChangeFavouritesState(this.model);
}

class ShopErrorChangeFavouritesState extends ShopStates {}

class ShopLoadingGetFavouriteState extends ShopStates {}

class ShopSuccessGetFavouriteState extends ShopStates {}

class ShopErrorGetFavouriteState extends ShopStates {}

class ShopLoadingUserDataState extends ShopStates {}

class ShopSuccessUserDataState extends ShopStates
{
  final SocialLoginModel loginModel;
  ShopSuccessUserDataState(this.loginModel);
}

class ShopErrorUserDataState extends ShopStates {}

class ShopLoadingUpdateUserState extends ShopStates {}

class ShopSuccessUpdateUserState extends ShopStates
{
  final SocialLoginModel loginModel;
  ShopSuccessUpdateUserState(this.loginModel);
}

class ShopErrorUpdateUserState extends ShopStates {}