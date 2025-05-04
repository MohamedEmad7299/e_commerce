import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CartItem extends StatefulWidget {

  final String itemName;
  final String imageURL;
  final double itemPrice;
  final int count;
  final VoidCallback onClickDelete;
  final VoidCallback onClickItem;

  const CartItem({
    super.key,
    required this.itemName,
    required this.imageURL,
    required this.itemPrice,
    required this.count,
    required this.onClickDelete,
    required this.onClickItem,
  });

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {

  late int counter;

  @override
  void initState() {
    super.initState();
    counter = widget.count;
  }

  @override
  Widget build(BuildContext context) {
    final priceFormatter = NumberFormat('#,###', 'en_US');

    return GestureDetector(
      onTap: widget.onClickItem,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        height: 120,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.deepPurple),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            // Image Section
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                widget.imageURL,
                width: 120,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Text(
                          widget.itemName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "EGP ${priceFormatter.format(widget.itemPrice*widget.count)}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Quantity: ${widget.count}",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),

                      ],
                    ),
                  ),
                  // Delete Button
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      onPressed: widget.onClickDelete,
                      icon: const Icon(Icons.delete, color: Color(0xFF4A148C)),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
