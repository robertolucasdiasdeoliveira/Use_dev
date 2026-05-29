import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:usedev_uninassau/src/models/models.dart';
import 'package:usedev_uninassau/src/screens/car_screen.dart';
import 'package:usedev_uninassau/src/screens/product_detail_screen.dart';
import 'package:usedev_uninassau/src/widgets/hero_section_widget.dart';
import 'package:usedev_uninassau/src/widgets/product_card_widget.dart';
import 'package:usedev_uninassau/src/widgets/subscription_section_widget.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({super.key});

  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  final List<Produto> produtos = [
    Produto(
      nome: 'Boné Dev',
      preco: 59.90,
      imagem: 'assets/bone.png',
    ),
    Produto(
      nome: 'Caneca Code',
      preco: 35.00,
      imagem: 'assets/caneca.png',
    ),
    Produto(
      nome: 'Vaso Decorativo',
      preco: 45.00,
      imagem: 'assets/vaso.png',
    ),
    Produto(
      nome: 'Quadro Decorativo',
      preco: 89.90,
      imagem: 'assets/guadro.png',
    ),
    Produto(
      nome: 'Capivara Plush',
      preco: 120.00,
      imagem: 'assets/capibaba.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu, size: 30),
        title: Image.asset('assets/logo_usedev.png', height: 40),
        centerTitle: true,
        actions: [
          const Icon(Icons.person_outline, size: 30),
          const SizedBox(width: 10),
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart_outlined, size: 30),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CarrinhoPage()),
                  );
                },
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Consumer<CarrinhoModel>(
                  builder: (context, carrinho, child) {
                    if (carrinho.itens.isEmpty) return const SizedBox();
                    return Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        '${carrinho.itens.length}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(width: 15),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const HeroSectionWidget(),
            const SizedBox(height: 20),
            Text(
              'Promos Especiais',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                fontFamily: GoogleFonts.orbitron().fontFamily,
              ),
            ),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: produtos.length,
              itemBuilder: (context, index) {
                final produto = produtos[index];
                return ProductCardWidget(
                  produto: produto,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetalheProdutoPage(produto: produto),
                      ),
                    );
                  },
                );
              },
            ),
            const SubscriptionSectionWidget(),
          ],
        ),
      ),
    );
  }
}
