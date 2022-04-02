class Purchase {
  final int quantity;
  const Purchase({
    this.quantity,
  });

  Map toMap() {
    return {
      'quantity': quantity ?? '',
    };
  }

  factory Purchase.fromJson(Map<String, dynamic> json) {
    return Purchase(
      quantity: json['quantity'],
    );
  }
}
