import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';

class ProductFormProvider extends ChangeNotifier{
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Product product;

  ProductFormProvider( this.product );

  updateAvailability(bool available){
    product.available = available;
    notifyListeners();
  }

  bool isValidForm(){
    return formKey.currentState?.validate() ??  false ;
  }

  void updateScreen() => notifyListeners();
}