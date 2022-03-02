part of 'shop_app_cubit.dart';

@immutable
abstract class ShopAppState {}

class ShopAppInitial extends ShopAppState {}
class ShopBottomNavState extends ShopAppState {}
class ShopHomeLoadingState extends ShopAppState {}
class ShopHomeSuccessState extends ShopAppState {
  HomeModel homeModel;
  ShopHomeSuccessState(this.homeModel);
}
class ShopHomeErrorState extends ShopAppState {}
class ShopCategoriesErrorState extends ShopAppState {}
class ShopHomeCategoriesState extends ShopAppState {}
class ShopCategoriesSuccessState extends ShopAppState {
CategoryModel categoriesModel;
  ShopCategoriesSuccessState(this.categoriesModel);
}
class ChangeFavouratesState extends ShopAppState {}
class ChangeFavouratesSuccessState extends ShopAppState {
  ChangeFavourateModel changeFavourateModel;
  ChangeFavouratesSuccessState(this.changeFavourateModel);
}
class ChangeFavouratesErrorState extends ShopAppState {}
class GetFavouratesSuccessState extends ShopAppState {
}
class GetFavouratesLoadingState extends ShopAppState {
}
class GetFavouratesErrorState extends ShopAppState {}
class GetProfileSuccessState extends ShopAppState {
  loginModel profileModel;
  GetProfileSuccessState(this.profileModel);
}
class GetProfileLoadingState extends ShopAppState {
}
class GetProfileErrorState extends ShopAppState {}
class UpdateProfileSuccessState extends ShopAppState {
  loginModel profileModel;
  UpdateProfileSuccessState(this.profileModel);
}
class UpdateProfileLoadingState extends ShopAppState {
}
class UpdateProfileErrorState extends ShopAppState {}