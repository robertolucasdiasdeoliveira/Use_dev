import 'package:flutter/material.dart';

class Produto {
  final String nome;
  final double preco;
  final String imagem;

  Produto({
    required this.nome,
    required this.preco,
    required this.imagem,
  });
}

class ItemCarrinho {
  final Produto produto;
  int quantidade;

  ItemCarrinho({
    required this.produto,
    this.quantidade = 1,
  });
}

class CarrinhoModel extends ChangeNotifier {
  // Singleton pattern
  static final CarrinhoModel _instance = CarrinhoModel._internal();
  factory CarrinhoModel() => _instance;
  CarrinhoModel._internal();

  final List<ItemCarrinho> _itens = [];

  List<ItemCarrinho> get itens => List.unmodifiable(_itens);

  double get precoTotal {
    return _itens.fold(0.0, (total, item) => total + (item.produto.preco * item.quantidade));
  }

  void adicionar(Produto produto) {
    final index = _itens.indexWhere((item) => item.produto.nome == produto.nome);
    if (index != -1) {
      _itens[index].quantidade++;
    } else {
      _itens.add(ItemCarrinho(produto: produto));
    }
    notifyListeners();
  }

  void remover(int index) {
    _itens.removeAt(index);
    notifyListeners();
  }

  void aumentarQuantidade(int index) {
    _itens[index].quantidade++;
    notifyListeners();
  }

  void diminuirQuantidade(int index) {
    if (_itens[index].quantidade > 1) {
      _itens[index].quantidade--;
    } else {
      _itens.removeAt(index);
    }
    notifyListeners();
  }

  void limpar() {
    _itens.clear();
    notifyListeners();
  }
}
