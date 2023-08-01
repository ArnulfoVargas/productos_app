import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:image_picker/image_picker.dart';

import 'package:productos_app/providers/providers.dart';
import 'package:productos_app/Themes/themes.dart';
import 'package:productos_app/UI/input_decoration.dart';
import 'package:productos_app/models/models.dart';
import 'package:productos_app/services/services.dart';
import 'package:productos_app/widgets/widgets.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});
  static const String name = "product_screen";


  @override
  Widget build(BuildContext context) {

    ProductService productService = Provider.of<ProductService>(context);
    Product product = productService.selectedProduct;

    return ChangeNotifierProvider(
      create: ((context) => ProductFormProvider(product)), 
      child: _ProductScreenWidget(product: product),);
  }
}

class _ProductScreenWidget extends StatelessWidget {
  const _ProductScreenWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {

    final ProductFormProvider productFormProvider = Provider.of<ProductFormProvider>(context);
    final ProductService productService = Provider.of<ProductService>(context);

    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Stack(
              children: [
                ProductImage(url: product.picture,),

                Positioned(
                  left: 40,
                  top: 55,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(), 
                    icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 35, color: Colors.white,),
                  )
                ),

                Positioned(
                  right: 40,
                  top: 55,
                  child: IconButton(
                    onPressed: () async {
                      final picker = ImagePicker();
                      
                      // * Se puede modificar el source TODO
                      final XFile? pickFile = await picker.pickImage(source: ImageSource.gallery);
                      if (pickFile == null){
                        return;
                      }

                      productService.updateSelectedImagePath(pickFile.path);
                                 
                    }, 
                    icon: const Icon(Icons.file_upload_outlined, size: 35, color: Colors.white,),
                  )
                ),
              ],
            ),

            _ProductForm(product: product,),

            const SizedBox(height: 100,)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
                              onPressed: productService.isSaving 
                              ? null 
                              : () async {
                                if (!productFormProvider.isValidForm()) return;

                                String? url = await productService.uploadImage();

                                if (url != null){
                                  productFormProvider.product.picture = url;
                                }

                                await productService.saveOrCreateProducts(product);
                              }, 
                              child: productService.isSaving
                                    ? const CircularProgressIndicator(color: Colors.white,)
                                    : const Icon(Icons.save_outlined),),
    );
  }
}

class _ProductForm extends StatelessWidget {
  final Product product;


  const _ProductForm({
    Key? key, required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final ProductFormProvider productFormProvider = Provider.of<ProductFormProvider>(context);
    Product product = productFormProvider.product;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        decoration: _formDecoration(),
        width: double.infinity,
        child: Form(
          key: productFormProvider.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [

              const SizedBox(height: 10,),

              TextFormField(
                initialValue: product.name,
                onChanged: (value) => product.name = value,
                validator: (value) {
                  if (value == null || value.isEmpty){
                    return "El nombre es obligatorio";
                  }
                  return null;
                },
                decoration: FormInputDecorator.getInputDecoration(hintText: "Nombre del Producto", labelText: "Nombre"),
              ),

              const SizedBox(height: 30,),

              TextFormField(
                initialValue: product.price.toString(),
                inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))],
                onChanged: (value) {
                  if(double.tryParse(value) == null) {
                    product.price = 0;
                  } else{
                    product.price = double.parse(value);
                  }
                },
                decoration: FormInputDecorator.getInputDecoration(hintText: "\$150", labelText: "Precio"),
                keyboardType: TextInputType.number,
              ),

              const SizedBox(height: 30,),

              SwitchListTile.adaptive(
                value: product.available,
                title: const Text("Disponible"), 
                activeColor: CustomTheme.primaryColor,
                onChanged: (value) => productFormProvider.updateAvailability(value),),

              const SizedBox(height: 30,)
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _formDecoration() => const BoxDecoration(
    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
    boxShadow: [BoxShadow(blurRadius: 5, offset: Offset(5, 5), color: Colors.black26)],
    color: Colors.white
  );
}