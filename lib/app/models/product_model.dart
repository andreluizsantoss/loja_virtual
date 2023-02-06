import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String? id;
  final String? name;
  final String? description;
  final List<String>? images;

  ProductModel({
    this.id,
    this.name,
    this.description,
    this.images,
  });

  factory ProductModel.fromDocument(DocumentSnapshot? document) {
    return ProductModel(
      id: document?.id ?? '',
      name: document!.data().toString().contains('name')
          ? document.get('name')
          : '',
      description: document.data().toString().contains('description')
          ? document.get('description')
          : '',
      images: document.data().toString().contains('images')
          ? List<String>.from(document.get('images') as List<dynamic>)
          : [],
    );
  }

  @override
  String toString() {
    return 'ProductModel(id: $id, name: $name, description: $description, images: $images)';
  }
}
