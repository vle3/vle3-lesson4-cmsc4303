enum DocKeyItem { name, qty, createdBy, timestamp }

class Item {
  String name;
  int qty;
  String createdBy;
  String? docId;
  DateTime? timestamp;

  Item(
      {this.docId,
      this.timestamp,
      required this.createdBy,
      required this.name,
      required this.qty}) {}

  Map<String, dynamic> toFireStoreDoc() {
    return {
      DocKeyItem.name.name: name,
      DocKeyItem.qty.name: qty,
      DocKeyItem.createdBy.name: createdBy,
      DocKeyItem.timestamp.name: timestamp
    };
  }

  //deserialization
  factory Item.fromFireStoreDoc({
    required Map<String, dynamic> doc,
    required String docId,
  }) {
    return Item(
      docId: docId,
      createdBy: doc[DocKeyItem.createdBy.name] ??= '',
      name: doc[DocKeyItem.name.name] ??= '',
      qty: doc[DocKeyItem.qty.name] ??= '',
      timestamp: doc[DocKeyItem.timestamp.name] != null
          ? DateTime.fromMillisecondsSinceEpoch(
              doc[DocKeyItem.timestamp.name].millisecondsSinceEpoch,
            )
          : null,
    );
  }

  bool isValid() {
    if (createdBy.isEmpty || name.isEmpty || qty == 0 || timestamp == null) {
      return false;
    } else {
      return true;
    }
  }

  static String? validateName(String? value) {
    return (value == null || value.trim().length < 3) ? 'Name too short' : null;
  }

  static String? validateQty(int qty) {
    return (qty == null || qty <= 0) ? 'Invalid quantity' : null;
  }
}
