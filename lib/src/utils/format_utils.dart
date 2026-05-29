class FormatUtils {
  static String formatCurrency(double value) {
    return 'R\$ ${value.toStringAsFixed(2).replaceAll('.', ',')}';
  }

  static String formatCurrencyFromProduct(double price, int quantity) {
    return formatCurrency(price * quantity);
  }
}
