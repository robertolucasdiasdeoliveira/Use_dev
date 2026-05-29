import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../constants/colors.dart';
import '../constants/dimens.dart';
import '../constants/strings.dart';
import '../models/models.dart';
import '../utils/format_utils.dart';
import '../widgets/cart_item_tile.dart';

class CarrinhoPage extends StatelessWidget {
  const CarrinhoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final carrinho = context.watch<CarrinhoModel>();

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: _buildAppBar(context),
      body: carrinho.itens.isEmpty
          ? _buildEmptyCart()
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: carrinho.itens.length,
              itemBuilder: (context, index) {
                final item = carrinho.itens[index];
                return CartItemTile(
                  item: item,
                  index: index,
                  onDecrease: () => carrinho.diminuirQuantidade(index),
                  onIncrease: () => carrinho.aumentarQuantidade(index),
                  onRemove: () => carrinho.remover(index),
                );
              },
            ),
          ),
          _buildCheckoutPanel(context, carrinho),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      elevation: AppDimens.elevation,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: AppColors.black,
          size: AppDimens.iconS,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        AppStrings.meuCarrinho,
        style: GoogleFonts.orbitron(
          color: AppColors.black,
          fontSize: AppDimens.fontXL,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Text(
        AppStrings.carrinhoVazio,
        style: GoogleFonts.poppins(
          fontSize: AppDimens.fontL,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildCheckoutPanel(BuildContext context, CarrinhoModel carrinho) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.paddingXL),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: AppDimens.shadowBlurCart,
            offset: const Offset(0, -AppDimens.shadowOffsetCart),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.total,
                  style: GoogleFonts.orbitron(
                    fontSize: AppDimens.fontXL,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  FormatUtils.formatCurrency(carrinho.precoTotal),
                  style: GoogleFonts.poppins(
                    fontSize: AppDimens.fontXXL,
                    color: AppColors.secondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppDimens.paddingL),
            SizedBox(
              width: double.infinity,
              height: AppDimens.buttonHeight,
              child: ElevatedButton(
                onPressed: () {
                  carrinho.limpar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(AppStrings.compraFinalizadaSucesso),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppDimens.radiusM),
                  ),
                ),
                child: Text(
                  AppStrings.finalizarCompra,
                  style: GoogleFonts.poppins(
                    fontSize: AppDimens.fontL,
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
