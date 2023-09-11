import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

import '../Model/ProductModel.dart';
import '../bloc/cart_bloc.dart';
import '../bloc/product_bloc.dart';

class ProductDetailsScreen extends StatefulWidget {
  final Product product;

  ProductDetailsScreen({required this.product});

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();
  final CartBloc cartBloc = CartBloc();

  @override
  void initState() {
    super.initState();
    _assetsAudioPlayer.open(
      Audio("assets/song1.mp3"),
      autoStart: false,
      showNotification: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 18.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  height: 200,
                  child: Image.network(
                    widget.product.image,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: MediaQuery.of(context).size.height - 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.purple[100],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50.0),
                      topRight: Radius.circular(50.0),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Text(
                                widget.product.title,
                                style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.purple[700],
                                    fontWeight: FontWeight.bold)),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  '\$ ${widget.product.price.toString()}',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color:Colors.purple[700])
                              ),
                              Row(
                                children: [
                                  Icon(Icons.star,
                                      color: Colors.purple,
                                      size:
                                      30), // You can repeat this for multiple stars// You can use Icons.star_half for half stars
                                  Text(
                                    widget.product.rating.rate.toString(),
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.purple[700]),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(widget.product.description,
                              style: TextStyle(fontSize: 15)),
                          SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              cartBloc.add(AddToCart(widget.product));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        '${widget.product.title} added to cart')),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.purple[700],
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              width: MediaQuery.of(context).size.width-40,
                              height: 45,
                              child: Center(
                                  child: Text('Add to Cart',
                                    style: TextStyle(color: Colors.white,fontSize: 20),
                                  )
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _assetsAudioPlayer.playOrPause();
          setState(() {});
        },
        child: Icon(_assetsAudioPlayer.isPlaying.value
            ? Icons.pause
            : Icons.play_arrow),
      ),
    );
  }
}
