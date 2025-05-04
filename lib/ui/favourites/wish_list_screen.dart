

import 'package:e_commerce/shared/navigation_helper.dart';
import 'package:e_commerce/ui/product_details/product_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cart/cart_screen.dart';
import '../home/cubit/cubit.dart';
import '../home/cubit/home_states.dart';
import '../widgets/favourite_item.dart';

class WishListScreen extends StatelessWidget {

  const WishListScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<HomeCubit, HomeState>(
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        var wishLit = cubit.wishList;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
            centerTitle: true,
            title: const Text("Wish List", style: TextStyle(color: Colors.black)),
            actions: [
              IconButton(
                icon: const Icon(Icons.shopping_cart, color: Colors.deepPurple),
                onPressed: () {
                  navigateTo(context, const CartScreen());
                },
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => FavouriteItem(
                product: wishLit[index],
                onClickFavButton: () {
                  cubit.updateWishList(wishLit[index]);
                },
                onClickItem: () {
                  navigateTo(context, ProductDetailsScreen(product: wishLit[index]));
                },
              ),
              separatorBuilder: (context, index) => SizedBox(
                height: 16,
              ),
              itemCount: wishLit.length,
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
