
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {


  SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Center();

    // return BlocConsumer<HomeCubit, HomeState>(
    //   builder: (context, state) {
    //
    //     var matchedProducts = [];
    //     var cubit = HomeCubit.get(context);
    //
    //     if (cubit.homeModel != null) {
    //       matchedProducts = cubit.homeModel!.data!.products!
    //           .where((element) =>
    //           element.name.toString().toLowerCase().contains(searchController.text.toLowerCase()))
    //           .toList();
    //     }
    //
    //
    //     return cubit.homeModel == null
    //         ? Center(
    //             child: CircularProgressIndicator(),
    //           )
    //         : Scaffold(
    //             body: SafeArea(
    //               child: Column(
    //                 children: [
    //                   SizedBox(height: 32,),
    //                   Padding(
    //                     padding: const EdgeInsets.all(16.0),
    //                     child: TextFormField(
    //                       controller: searchController,
    //                       keyboardType: TextInputType.text,
    //                       obscureText: false,
    //                       textAlign: TextAlign.center,
    //                       onFieldSubmitted: (value) {},
    //                       onChanged: (value) {
    //                         setState(() {
    //                           matchedProducts = cubit.homeModel!.data!.products!
    //                               .where((element) =>
    //                               element.name.toString().toLowerCase().contains(value.toLowerCase()))
    //                               .toList();
    //                         });
    //                       },
    //                       validator: (value) {
    //                         if (value!.isEmpty) {
    //                           return 'search value must not be empty';
    //                         }
    //                         return null;
    //                       },
    //                       readOnly: false,
    //                       onTap: () {},
    //                       cursorColor: Colors.black,
    //                       decoration: InputDecoration(
    //                         hintText: "Search with the product name",
    //                         border: OutlineInputBorder(),
    //                         focusedBorder: OutlineInputBorder(
    //                           borderSide: BorderSide(),
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                   Expanded(
    //                       child: ListView.separated(
    //                     physics: BouncingScrollPhysics(),
    //                     itemBuilder: (context, index) =>
    //                         FavoriteItem(product: matchedProducts[index]),
    //                     separatorBuilder: (context, index) => Divider(),
    //                     itemCount: matchedProducts.length,
    //                   ))
    //                 ],
    //               ),
    //             ));
    //   },
    //   listener: (context, state) {},
    // );
  }
}
