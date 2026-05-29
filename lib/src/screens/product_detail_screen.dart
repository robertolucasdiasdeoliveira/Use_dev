import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../constants/colors.dart';
import '../constants/dimens.dart';
import '../constants/strings.dart';
import '../models/models.dart';
import '../utils/format_utils.dart';

class DetalheProdutoPage extends StatelessWidget {
  final Produto produto;

  const DetalheProdutoPage({
    super.key,
    required this.produto,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: _buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppDimens.paddingXL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppDimens.paddingL),
            _buildProductImage(),
            const SizedBox(height: 25),
            _buildProductInfo(),
            const Spacer(),
            _buildAddButton(context),
          ],
        ),
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
        AppStrings.detalhesdoProduto,
        style: GoogleFonts.orbitron(
          color: AppColors.black,
          fontSize: AppDimens.fontXL,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
    );
  }

  Widget _buildProductImage() {
    return Container(
      width: double.infinity,
      height: AppDimens.productImageHeight,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(AppDimens.radiusXL),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.paddingXXL),
        child: Image.asset(produto.imagem, fit: BoxFit.contain),
      ),
    );
  }

  Widget _buildProductInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          produto.nome,
          style: GoogleFonts.orbitron(
            fontSize: AppDimens.fontXXXL,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppDimens.paddingM),
        Text(
          FormatUtils.formatCurrency(produto.preco),
          style: GoogleFonts.poppins(
            fontSize: AppDimens.fontXXL,
            color: AppColors.secondary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 25),
        Text(
          AppStrings.descricaoDoProduto,
          style: GoogleFonts.orbitron(
            fontSize: AppDimens.fontM,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: AppDimens.paddingL),
        Text(
          AppStrings.descricaoCompleta,
          style: GoogleFonts.poppins(
            fontSize: AppDimens.fontM,
            color: Colors.grey[600],
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppDimens.paddingXL),
      child: SizedBox(
        width: double.infinity,
        height: AppDimens.buttonHeightLarge,
        child: ElevatedButton(
          onPressed: () {
            context.read<CarrinhoModel>().adicionar(produto);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  "${produto.nome} ${AppStrings.produtoAdicionado}",
                ),
                duration: const Duration(seconds: 1),
                backgroundColor: AppColors.secondary,
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.secondary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDimens.radiusL),
            ),
          ),
          child: Text(
            AppStrings.adicionarAoCarrinho,
            style: GoogleFonts.poppins(
              fontSize: AppDimens.fontL,
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
