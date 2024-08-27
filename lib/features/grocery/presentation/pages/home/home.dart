import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../../../core/Colors/colors.dart';
import '../../../../../core/Text_Style/text_style.dart';
import '../../../../../core/constant/width_height.dart';
import '../../../../../core/utility/loading_page.dart';
import '../../../../../core/utility/socket_impl.dart';
import '../../bloc/cart/cart_bloc.dart';
import '../../bloc/cart/cart_event.dart';
import '../../bloc/grocery_bloc/grocery_bloc.dart';
import '../../bloc/grocery_bloc/grocery_event.dart';
import '../../bloc/grocery_bloc/grocery_state.dart';
// import 'header.dart';
import 'product_image.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SocketService socketService =  GetIt.instance<SocketService>();
  
  List<dynamic> dataProduct = [];
  @override
  void initState() {
    

    super.initState();
    context.read<GroceryBloc>().add(const LoadAllGroceryEvent());
    context.read<CartBloc>().add(GetAllCartEvent());
    

  }

  @override
  Widget build(BuildContext context) {
    double width = WidthHeight.screenWidth(context);
    // double height = WidthHeight.screenHeight(context);
    final SocketService socketService = GetIt.instance<SocketService>();
    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: () {
            context.read<GroceryBloc>().add(const LoadAllGroceryEvent());
            context.read<CartBloc>().add(GetAllCartEvent());
            socketService.connect();
            return Future.delayed(const Duration(seconds: 1));
          },
          child: BlocConsumer<GroceryBloc, GroceryState>(
            listener: (context, state) {
              if(state is GroceryErrorState){
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.messages))
                  
                );
              }
            },
            builder: (context, state) {
              return Container(
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(15, 25, 15, 15),
                child: Column(
                  children: [
                    // Header part
                    // const HeaderPart(),
                    // Body part
                    const SizedBox(height: 20),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(top: 5),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Row(
                                                        
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  TextStyles(
                                    text: 'Available Products',
                                    fontColor: mainText,
                                    fontSizes: (width * 0.046).toInt(),
                                    fontWeight: FontWeight.w600,
                                  ),
                                  GestureDetector(
                                    key: const Key('redirectToSerch'),
                                    onTap: () =>
                                        {Navigator.pushNamed(context, '/search',
                                        
                                        )},
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color:
                                            const Color.fromARGB(255, 248, 247, 247),
                                        border: const Border(
                                          top: BorderSide(
                                            color: Color.fromARGB(255, 226, 225, 225),
                                          ),
                                          right: BorderSide(
                                            color: Color.fromARGB(255, 226, 225, 225),
                                          ),
                                          left: BorderSide(
                                            color: Color.fromARGB(255, 226, 225, 225),
                                          ),
                                          bottom: BorderSide(
                                            color: Color.fromARGB(255, 226, 225, 225),
                                          ),
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.search,
                                        size: 24,
                                        color: Color.fromARGB(255, 226, 225, 225),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Expanded(
                              child: (state is LoadedAllGroceryState)?
                              
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                                child: ListView.builder(
                                  
                                  itemCount: state.groceries.length,
                                  itemBuilder: (context, index){
                                    final product = state.groceries[index];
                                    dataProduct = state.groceries;
                                    return GroceryImage(
                                      imageUrl: product.imageUrl,
                                      price: product.price,
                                      disc: product.description,
                                      title: product.name,
                                      id: product.id,
                                      discount: product.discount,
                                      options: product.options,
                                      rating: product.rating,

                                    );
                                  }),
                              ): state is LoadingState? ListView.builder(
                                key: const Key('loading'),
                                      itemCount: 3,
                                      itemBuilder: (context, index){
                                        
                                        return const LoadingPage();
                                      })
                                    :  Center(
                                        child: Column(
                                          children:[
                                           const Text('try again'),
                                           ElevatedButton(
                                             onPressed: () => context.read<GroceryBloc>().add(const LoadAllGroceryEvent()),
                                             child: const Icon(Icons.refresh),
                                           )]),
                                          
                                       
                                      ),
                                    ),                            
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        floatingActionButton: GestureDetector(
          key: const Key('add Product page'),
          onTap: () {
            Navigator.pushNamed(context, '/add-product',
          arguments: {'id':'','imageUrl':'','price':0,'name':'','disc':'','type':0},);
          },
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(35),
              color: mainColor,
            ),
            child: const Icon(
              Icons.add,
              size: 40,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
