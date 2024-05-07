import 'package:cerrado_vivo/components/product_card.dart';
import 'package:cerrado_vivo/core/services/trade/trade_service.dart';
import 'package:flutter/material.dart';

class TradePage extends StatelessWidget {
  const TradePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF53AC3C),
        title: const Text(
          "Sementes",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            height: 50,
            margin: const EdgeInsets.only(bottom: 7),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                )
              ],
              border: const Border(
                left: BorderSide(color: Colors.grey, width: 1),
                right: BorderSide(color: Colors.grey, width: 1),
              )
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: const Row(
                            children: [
                              Text(
                                "Anunciar",
                                style: TextStyle(color: Color(0xFF53AC3C))
                              ),
                              SizedBox(width: 7,),
                              Icon(
                                Icons.add_circle_outline,
                                color: Color(0xFF53AC3C),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  height: double.maxFinite,
                  color: Colors.grey,
                ),
                Expanded(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: const Row(
                            children: [
                              Text(
                                "Filtrar",
                                style: TextStyle(color: Color(0xFF53AC3C)),
                              ),
                              SizedBox(width: 7,),
                              Icon(
                                Icons.tune,
                                color: Color(0xFF53AC3C), 
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ),
          Expanded(
            child: SingleChildScrollView(
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: TradeService.getProducts().length,
                itemBuilder: (context, index) {
                  final product = TradeService.getProducts()[index];
                  return ProductCard(product: product);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

    