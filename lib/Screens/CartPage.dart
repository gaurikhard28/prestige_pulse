
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/cart_bloc.dart';
import '../bloc/product_bloc.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      appBar: AppBar(
        backgroundColor: Colors.purple[100],
        title: Text('Cart',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.purple),),
      ),
      body: Center(
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartUpdated) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: state.cartItems.length,
                  itemBuilder: (context, index) {
                    final cartItem = state.cartItems[index];
                    return Card(
                      elevation: 4, // Set the elevation for a shadow effect
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0), // Set border radius
                      ),
                      margin: EdgeInsets.all(8), // Add some margin around the card
                      color: Colors.white,
                      child: ListTile(
                        leading: Container(
                          height: 60,
                          width: 60,
                          child:Image.network(cartItem.product.image,fit: BoxFit.fill,),
                        ),
                        title: Text(cartItem.product.title),
                        subtitle: Text('Quantity: ${cartItem.quantity}'),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            BlocProvider.of<CartBloc>(context).add(RemoveFromCart(cartItem.product));
                          },
                        ),
                      ),
                    );
                  },
                ),
              );
            }
            else if(state is CartInitial) {
              return Center(child: CircularProgressIndicator());
            }
            else {
              return Text('Something went wrong!');
            }
          },
        ),
      ),
    );
  }
}
