import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/layout/shop_app/cubit/cubit.dart';
import 'package:project1/layout/shop_app/cubit/states.dart';
import 'package:project1/shared/components/components.dart';

class FavouriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavouriteState,
          builder: (BuildContext context) => ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildListProduct(
                ShopCubit.get(context).favouriteModel!.data!.data![index].product!!,
                context),
            separatorBuilder: (context, index) => const MyDivider(),
            itemCount:
                ShopCubit.get(context).favouriteModel!.data!.data!.length,
          ),
          fallback: (BuildContext context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
