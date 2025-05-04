

import 'package:e_commerce/ui/favourites/wish_list_screen.dart';
import 'package:e_commerce/ui/product_details/product_details.dart';
import 'package:e_commerce/ui/widgets/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/navigation_helper.dart';
import '../home/cubit/cubit.dart';
import '../home/cubit/home_states.dart';

class CartScreen extends StatelessWidget {

  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      builder: (context, state) {

        var cubit = HomeCubit.get(context);
        var cart = cubit.cart;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
            centerTitle: true,
            title: const Text("Cart", style: TextStyle(color: Colors.black)),
            actions: [
              IconButton(
                icon: const Icon(Icons.favorite, color: Colors.deepPurple),
                onPressed: () {
                  navigateTo(context, const WishListScreen());
                },
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => CartItem(
                  itemName: cart[index].product.title!,
                  imageURL: cart[index].product.thumbnail!,
                  itemPrice: cart[index].product.price!,
                  count: cart[index].count,
                  onClickDelete: (){
                    cubit.removeFromCart(cart[index].product);
                  },
                  onClickItem: (){
                    navigateTo(context, ProductDetailsScreen(product: cart[index].product));
                  }),
              separatorBuilder: (context, index) => SizedBox(
                height: 16,
              ),
              itemCount: cart.length,
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
