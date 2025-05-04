import 'package:e_commerce/shared/navigation_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../home/cubit/cubit.dart';
import '../home/cubit/home_states.dart';
import '../product_details/product_details.dart';
import '../widgets/product_item.dart';

class ProductsScreen extends StatefulWidget {

  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    HomeCubit.get(context).getProducts(); // Fetch products when screen loads
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        if (state is HomeErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Something went wrong, check your internet connection"),
              backgroundColor: Colors.red,
              duration: Duration(seconds: 3),
            ),
          );
        }
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);

        return Stack(
          children: [
            SafeArea(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _logo(),
                      _buildSearchBar(context),
                      _productsBuilder(cubit, state),
                    ],
                  ),
                ),
              ),
            ),
            if (state is HomeLoadingState) _buildLoadingOverlay(),
          ],
        );
      },
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: TextField(
        controller: _searchController,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: 'Search products...',
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurple),
            borderRadius: BorderRadius.circular(24.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurple),
            borderRadius: BorderRadius.circular(24.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurple, width: 2.0),
            borderRadius: BorderRadius.circular(24.0),
          ),
          prefixIcon: Icon(Icons.search),
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
        ),
        onSubmitted: (value) {
          HomeCubit.get(context).searchProducts(value.trim());
        },
      ),
    );
  }


  Widget _logo() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 16, top: 16),
      child: Row(
        children: [
          Text(
            'SaDeeM',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          SizedBox(width: 4),
          Text(
            'Store',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _productsBuilder(HomeCubit cubit, HomeState state) {

    if (state is HomeEmptySearchState) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text('No products match the search', style: TextStyle(fontSize: 16)),
        ),
      );
    } else if (cubit.productsResponseModel == null || cubit.productsResponseModel!.products == null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text('Loading ...'),
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsetsDirectional.only(start: 12, end: 12),
        child: GridView.count(
          mainAxisSpacing: 1.5,
          crossAxisSpacing: 1.5,
          childAspectRatio: MediaQuery.of(context).orientation == Orientation.portrait
              ? 1 / 1.3
              : 1 / .6,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          children: List.generate(
            cubit.productsResponseModel!.products!.length,
                (index) {
              final product = cubit.productsResponseModel!.products![index];
              return ProductItem(
                onClickItem: () {
                  navigateTo(context, ProductDetailsScreen(product: product));
                },
                onClickFavButton: () {
                  cubit.updateWishList(product);
                },
                imageUrl: product.thumbnail!,
                isFavourite: cubit.inWishList(product),
                isLoading: false,
                productName: product.title!,
                productPrice: product.price,
                productReview: product.rating,
              );
            },
          ),
        ),
      );
    }
  }

  Widget _buildLoadingOverlay() {
    return Container(
      color: Colors.black.withValues(alpha: 0.3),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
