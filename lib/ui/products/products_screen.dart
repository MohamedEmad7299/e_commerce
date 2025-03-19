import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/ui/widgets/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/cubit.dart';
import '../../cubit/home_states.dart';
import '../../network/models/categories_models/categories_model.dart';
import '../../network/models/home_models/HomeModel.dart';
import '../widgets/product_item.dart';

class ProductsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);

        return cubit.homeModel == null || cubit.categoriesModel == null
            ? Center(child: CircularProgressIndicator())
            : productsBuilder(cubit.homeModel!, cubit.categoriesModel!);
      },
    );
  }

  Widget productsBuilder(HomeModel homeModel , CategoriesModel categoriesModel) => SingleChildScrollView(

        physics: BouncingScrollPhysics(),
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CarouselSlider(
                  items: homeModel.data!.banners!
                      .map((banner) => Image(
                            image: NetworkImage('${banner.image}'),
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ))
                      .toList(),
                  options: CarouselOptions(
                    height: 200,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    viewportFraction: 1.0,
                    autoPlayAnimationDuration: Duration(seconds: 1),
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    scrollDirection: Axis.horizontal,
                  )),
              Container(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 130,
                child: ListView.separated(
                  itemCount: categoriesModel.data!.categories!.length,
                  separatorBuilder: (context, index) => SizedBox(width: 8),
                  itemBuilder: (context, index) => Padding(
                    padding: index == 0
                        ? EdgeInsetsDirectional.only(start: 8)
                        : index == homeModel.data!.products!.length - 1
                        ? EdgeInsetsDirectional.only(end: 8)
                        : EdgeInsets.zero,
                    child: categoryItem(
                      image: categoriesModel.data!.categories![index].image!,
                      name: categoriesModel.data!.categories![index].name!
                    ),
                  ),
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                ),
              ),
              Container(
                padding: EdgeInsets.all(16),
                child: Text(
                  'New Products',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                color: Colors.grey[200],
                child: GridView.count(
                  mainAxisSpacing: 1.5,
                  crossAxisSpacing: 1.5,
                  childAspectRatio: 1 / 1.3,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  children:
                      List.generate(homeModel.data!.products!.length, (index) {
                    return ProductItem(homeModel.data!.products![index]);
                  }),
                ),
              ),
            ],
          ),
        ),
      );

}
