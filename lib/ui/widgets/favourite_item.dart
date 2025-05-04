import 'package:e_commerce/network/models/products_models/Product.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FavouriteItem extends StatelessWidget {

  final Product product;
  final VoidCallback onClickFavButton;
  final VoidCallback onClickItem;

  const FavouriteItem({
    super.key,
    required this.product,
    required this.onClickFavButton,
    required this.onClickItem,
  });

  @override
  Widget build(BuildContext context) {


    final formattedPrice = NumberFormat.decimalPattern('en_US').format(product.price);
    final formattedOldPrice = NumberFormat.decimalPattern('en_US').format(product.price + (product.price/3));

    return InkWell(
      onTap: onClickItem,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Colors.deepPurple),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: SizedBox(
          height: 140,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: 140,
                  height: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.deepPurple),
                  ),
                  child: Image.network(
                    product.thumbnail != null
                        ? product.thumbnail!
                        : '',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 150,
                            child: Text(
                              product.title != null ? product.title! : 'No Name',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.deepPurple,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'EGP $formattedPrice',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.deepPurple,
                            ),
                          ),
                          Text(
                            'EGP $formattedOldPrice',
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.deepPurple,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: IconButton(
                          onPressed: onClickFavButton,
                          icon: const Icon(Icons.favorite),
                          color: Colors.deepPurple,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
