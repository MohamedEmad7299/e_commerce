
import 'package:e_commerce/ui/home/cubit/cubit.dart';
import 'package:e_commerce/ui/home/cubit/home_states.dart';
import 'package:e_commerce/ui/widgets/add_minus_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../network/models/products_models/Product.dart';
import '../../shared/navigation_helper.dart';
import '../cart/cart_screen.dart';

class ProductDetailsScreen extends StatefulWidget {

  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {

  bool _isExpanded = false;

  int productCount = 1;

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is ProductDetailsErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },

      builder: (context, state) {

        final product = widget.product;
        final cubit = HomeCubit.get(context);
        final priceFormatter = NumberFormat('#,###', 'en_US');
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
            centerTitle: true,
            title: const Text("Product Details", style: TextStyle(color: Colors.black)),
            actions: [
              IconButton(
                icon: const Icon(Icons.shopping_cart, color: Colors.deepPurple),
                onPressed: () {
                  navigateTo(context, const CartScreen());
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          product.thumbnail!,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            height: 200,
                            width: double.infinity,
                            color: Colors.grey[300],
                            alignment: Alignment.center,
                            child: const Icon(Icons.broken_image, size: 40, color: Colors.grey),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.8),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: cubit.inWishList(product) ? Icon(Icons.favorite, color: Colors.deepPurple, size: 28)
                                : Icon(Icons.favorite_border, color: Colors.deepPurple, size: 28),
                            onPressed: () {
                              cubit.updateWishList(product);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 250,
                        child: Text(
                          product.title!,
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        "EGP ${priceFormatter.format(product.price)}",
                        style: const TextStyle(fontSize: 18, color: Colors.deepPurple, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Chip(
                        backgroundColor: Colors.white,
                        label: Text("${priceFormatter.format(product.price*100)} sold"),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: const BorderSide(color: Colors.deepPurple),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Row(
                        children: [
                          const Icon(Icons.star, size: 24, color: Colors.yellow),
                          Text(
                            " ${product.rating} (${priceFormatter.format(product.rating*product.price)})",
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      const Spacer(),
                      AddAndMinusButtons(
                        value: productCount,
                        onClickAdd: () {
                          setState(() {
                            productCount++;
                          });
                        },
                        onClickMinus: () {
                          setState(() {
                            if (productCount > 1) {
                              productCount--;
                            }
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Description section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Description", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      AnimatedCrossFade(
                        crossFadeState: _isExpanded
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                        duration: const Duration(milliseconds: 200),
                        firstChild: Text(
                          product.description!,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(color: Colors.grey),
                        ),
                        secondChild: Text(
                          product.description!,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),
                      if (product.description!.length > 150)
                        TextButton(
                          onPressed: () {
                            setState(() => _isExpanded = !_isExpanded);
                          },
                          child: Text(_isExpanded ? "Show less" : "Show more"),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Text("Category : ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Text(product.category!.toUpperCase(), style: const TextStyle(color: Colors.deepPurple)),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Total Price", style: TextStyle(color: Colors.deepPurple)),
                          Text(
                            "EGP ${priceFormatter.format(product.price * productCount)}",
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      ElevatedButton.icon(
                        onPressed: () => {
                          if (!cubit.inCart(product))
                          cubit.addToCart(product, productCount),
                        },
                        icon: const Icon(Icons.add_shopping_cart, color: Colors.white),
                        label: Text(
                          cubit.inCart(product) ? "Added to Cart" : "Add to Cart",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
