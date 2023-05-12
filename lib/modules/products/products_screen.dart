import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/layout/shop_app/cubit/cubit.dart';
import 'package:project1/layout/shop_app/cubit/states.dart';
import 'package:project1/models/shop_app/categories_model.dart';
import 'package:project1/models/shop_app/home_model.dart';
import 'package:project1/shared/components/components.dart';
import 'package:project1/shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state)
      {
        if(state is ShopSuccessChangeFavouritesState)
          {
            if(!state.model.status!)
              {
                showToast(
                  text : state.model.message!,
                  state: ToastStates.error,
                );
              }
          }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeModel != null && ShopCubit.get(context).categoriesModel != null,
          builder: (context) =>
            productsBuilder(
                ShopCubit.get(context).homeModel! ,
                ShopCubit.get(context).categoriesModel!,
                context,
            ),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget productsBuilder(HomeModel model,CategoriesModel categoriesModel, context) => SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model.data!.banners!
                  .map(
                    (e) => Image(
                      image: NetworkImage('${e.image}'),
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                  )
                  .toList(), //kda return list of image dy (e dy m3naha banner banner)
              options: CarouselOptions(
                height: 250,
                initialPage: 0, //hnbd2 mn awl page 1
                viewportFraction: 1, //3shan n3dl sora w takhod msa7a kamla
                enableInfiniteScroll: true, //hyfdl ylf 7walen nafso 3ltool
                reverse: false, //sora msln mtt2lbsh
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 100,
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                        itemBuilder: (context , index) => buildCategoryItem(categoriesModel.data!.data![index]),
                        separatorBuilder: (context , index) => const SizedBox(
                          width: 10,
                        ),
                        itemCount: categoriesModel.data!.data!.length,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'New Products',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.grey[300],
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                childAspectRatio: 1 / 1.58,
                children: List.generate(model.data!.products!.length,
                    (index) => buildGridProduct(model.data!.products![index], context)),
              ),
            ),
          ],
        ),
      );

  Widget buildCategoryItem(DataModel model) =>  Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
       Image(
        image: NetworkImage(
          model.image!,
        ),
        height: 100,
        width: 100,
        fit: BoxFit.cover,
      ),
      Container(
        color: Colors.black.withOpacity(.8,),
        width: 100,
        child: Text(
          model.name!,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    ],
  );

  Widget buildGridProduct(ProductModel model, context) => Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image!),
                  width: double.infinity,
                  height: 200,
                ),
                if (model.discount != 0)
                  Container(
                    color: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: const Text(
                      'DISCOUNT',
                      style: TextStyle(
                          fontSize: 8.5,
                          color: Colors.white,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      height: 1.3,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '${model.price.round()}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: defaultColor,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      if (model.discount != 0)
                        Text(
                          '${model.oldPrice.round()}',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changeFavourite(model.id!);
                          print(model.id);
                        },
                        icon:  CircleAvatar(
                          radius: 15,
                          backgroundColor:
             ShopCubit.get(context).favourite[model.id!]! ? defaultColor : Colors.grey,
                          child: const Icon(
                            Icons.favorite_border,
                            size: 13,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
