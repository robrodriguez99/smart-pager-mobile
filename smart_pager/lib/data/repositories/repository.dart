
import 'package:flutter/material.dart';
import 'package:smart_pager/data/models/generic_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_pager/exceptions/not_found_exception.dart';


abstract class Repository<T extends GenericModel<T>> {
  final String _tag; // this is the name of the collection in firestore
  
  @protected
  late final CollectionReference<Map<String, dynamic>> collection;

  Repository(this._tag, {firestore}) {
    final firestoreInstance = firestore ?? FirebaseFirestore.instance;
      this.collection = firestoreInstance.collection(this._tag);

  }
  // Add other common repository methods here.

  @protected
  Future<T> create(T item) async {
    try {
      await collection.doc(item.id).set(item.toJson());
    } catch (e) {
      print(e);
      rethrow;
    }
    return Future.value(item);
  }

  @protected
  Future<T> getById(String id) async {
    final doc = await collection.doc(id).get();
    if (doc.exists) {
      final data = doc.data()!;
      return itemFromJson(doc.id, data);
    }
    throw NotFoundException("$_tag not found with id $id");
  }

  @protected
  Future<T> update(T item) async {
    try {
      await collection.doc(item.id).update(item.toJson());
    } catch (e) {
      print(e);
      rethrow;
    }
    return Future.value(item);
  }

  @protected
  Future<List<T>> getDocuments() async {
    final qsDocs = await collection.get();
    return qsDocs.docs.map((e) => itemFromJson(e.id, e.data())).toList();
  }

  // Factory method to create an instance of T from JSON data
  @protected
  T itemFromJson(String id, Map<String, dynamic> json);
}