import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Domain/entity/grocery_entity.dart';
import '../bloc/grocery_bloc/grocery_bloc.dart';
import '../bloc/grocery_bloc/grocery_event.dart';
import '../bloc/grocery_bloc/grocery_state.dart';
import '../widgets/product_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    final productBloc = BlocProvider.of<GroceryBloc>(context);

    productBloc.add(const LoadAllGroceryEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Logo Image
            Image.asset(
              'assets/image/logo.png', // Path to your logo asset
              height: 40, // Adjust height as needed
            ),
            const SizedBox(width: 10), // Space between the logo and text
            // Text Widget
            const Text(
              'Burger',
              style: TextStyle(
                fontSize: 20, // Adjust text size as needed
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        centerTitle: false, // Adjust if you want to center the title
      ),
      body: BlocConsumer<GroceryBloc, GroceryState>(
        listener: (context, state) {
          if (state is GroceryErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                key: const Key('error_snackbar_home'),
                content: Text(state.messages),
              ),
            );
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Search',
                              prefixIcon:
                                  const Icon(Icons.search), // Search Icon
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none,
                              ),
                              fillColor: Colors.grey[200],
                              filled: true,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        // Filter Icon
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.filter_list,
                                color: Colors.white),
                            onPressed: () {
                              // Handle filter action
                            },
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                        child: state is LoadedAllGroceryState
                            ? GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, // Two cards per row
                                  crossAxisSpacing: 10.0,
                                  mainAxisSpacing: 10.0,
                                  childAspectRatio: 3 / 2,
                                ),
                                key: const Key('products_list'),
                                itemCount: state.groceries.length,
                                itemBuilder: (context, index) {
                                  final item = state.groceries[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, '/detail_page',
                                          arguments: GroceryEntity(
                                              discount: item.discount,
                                              options: item.options,
                                              rating: item.rating,
                                              id: item.id,
                                              description: item.description,
                                              imageUrl: item.imageUrl,
                                              name: item.name,
                                              price: item.price));
                                    },
                                    child: ProductCard(
                                      productImage: item.imageUrl,
                                      productName: item.name,
                                      productPrice: item.discount.toString(),
                                      productOldPrice: item.price.toString(),
                                      productRating: item.rating.toString(),
                                    ),
                                  );
                                },
                              )
                            : state is LoadingState
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : SizedBox(
                                    child: Center(
                                        child: reusableText('No Product Found',
                                            FontWeight.w700, 24)),
                                  ))
                  ]),
            ),
          );
        },
      ),
    );
  }
}

Text reusableText(String text, FontWeight wight, double size,
    [Color color = Colors.black]) {
  return Text(
    text,
    overflow: TextOverflow.clip,
    style: TextStyle(fontWeight: wight, fontSize: size, color: color),
  );
}
