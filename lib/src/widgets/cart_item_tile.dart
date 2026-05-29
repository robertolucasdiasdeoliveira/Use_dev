import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/colors.dart';
import '../constants/dimens.dart';
import '../constants/strings.dart';
import '../models/models.dart';
import '../utils/format_utils.dart';

class CartItemTile extends StatelessWidget {
  final ItemCarrinho item;
  final int index;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;
  final VoidCallback onRemove;

  const CartItemTile({
    super.key,
    required this.item,
    required this.index,
    required this.onDecrease,
    required this.onIncrease,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimens.paddingL,
        vertical: AppDimens.paddingS,
      ),
      child: Container(
        padding: const EdgeInsets.all(AppDimens.paddingM),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(AppDimens.radiusM),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Row(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppDimens.radiusS),
              ),
              child: Padding(
                padding: const EdgeInsets.all(AppDimens.paddingS),
                child: Image.asset(
                  item.produto.imagem,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(width: AppDimens.paddingL),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.produto.nome,
                    style: GoogleFonts.orbitron(
                      fontSize: AppDimens.fontM,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppDimens.paddingXS),
                  Text(
                    '${AppStrings.quantidade} ${item.quantidade}',
                    style: GoogleFonts.poppins(
                      fontSize: AppDimens.fontS,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: AppDimens.paddingXS),
                  Text(
                    FormatUtils.formatCurrencyFromProduct(
                      item.produto.preco,
                      item.quantidade,
                    ),
                    style: GoogleFonts.poppins(
                      fontSize: AppDimens.fontM,
                      color: AppColors.secondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.remove_circle_outline,
                    color: Colors.grey,
                  ),
                  onPressed: onDecrease,
                ),
                IconButton(
                  icon: const Icon(
                    Icons.add_circle_outline,
                    color: AppColors.secondary,
                  ),
                  onPressed: onIncrease,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
