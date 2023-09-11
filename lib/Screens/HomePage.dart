import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prestige_pulse/Screens/CartPage.dart';
import 'package:prestige_pulse/Screens/ProfilePage.dart';

import '../Model/ProductModel.dart';
import '../bloc/product_bloc.dart';
import 'ProductDetail.dart';

class HomePage extends StatefulWidget {

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final ProductBloc productBloc = BlocProvider.of<ProductBloc>(context);
    return Scaffold(
      backgroundColor: Colors.purple[50],
      appBar: AppBar(
        backgroundColor: Colors.purple[50],
        leading: IconButton(
          icon: Icon(
            Icons.person,
            color: Colors.purple, // Set the icon color
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Profile(),
              ),
            );
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Prestige Pulse',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.purple, // Change the color if needed
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.purple, // Set the icon color
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CartPage(),
                ),
              );
            },
          ),

        ],
      ),

      body:Center(
        child: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductInitial) {
                productBloc.add(LoadProducts()); // Trigger loading of products
                return CircularProgressIndicator();
              } else if (state is ProductLoaded) {
                final  List<Product> products = state.products;
                 return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.85,// Set the number of columns in the grid
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 200, // Set the width of the container
                      height: 300,
                      margin: EdgeInsets.all(8),
                      decoration: BoxDecoration(

                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                height: 100,
                                child: Image.network(
                                  products[index].image,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Center(
                              child: Text(
                                products[index].title,
                                style: TextStyle(
                                  color: Colors.purple,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '\$${products[index].price.toString()}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color:  Colors.purple,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.arrow_circle_right,color: Colors.purple,),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProductDetailsScreen(product: products[index]),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );

              }
              else if (state is ProductError) {
                return Text('Error: ${state.error}');
              }
              return Container();
            }
        ),
      ),
    );
  }
}