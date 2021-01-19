import 'package:flutter/material.dart';
import 'package:myshop/models/product.dart';
import 'package:myshop/providers/products_provider.dart';
import 'package:provider/provider.dart';

class EditProduct extends StatefulWidget {
  static const routeName = '/edit_product';
  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageFocusNode = FocusNode();
  final _imageTextControler = TextEditingController();

  bool _hasInitiated = true;
  bool _isLoading = false;

  Map<String, String> _initialValues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };

  Product _editedProduct =
      Product(id: null, title: '', price: 0, description: '', imageUrl: '');

  final _form = GlobalKey<FormState>();

  @override
  void initState() {
    _imageFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void dispose() {
    _imageFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageFocusNode.dispose();
    _imageTextControler.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (_hasInitiated) {
      final productId = ModalRoute.of(context).settings.arguments as String;
      if (productId == null) return;
      _editedProduct = Provider.of<ProductsProvider>(context, listen: false)
          .findById(productId);
      _initialValues = {
        'title': _editedProduct.title,
        'description': _editedProduct.description,
        'price': _editedProduct.price.toString(),
        'imageUrl': '',
      };
      _imageTextControler.text = _editedProduct.imageUrl;
    }
    _hasInitiated = false;
    super.didChangeDependencies();
  }

  void _updateImageUrl() {
    if (!_imageFocusNode.hasFocus) {
      if (!_isImage(_imageTextControler.text)) return;
      setState(() {});
    }
  }

  bool _isImage(String url) {
    if (!url.startsWith('http') && !url.startsWith('https')) return false;
    if (!url.endsWith('.png') &&
        !url.endsWith('.jpg') &&
        !url.endsWith('.jpeg'))
      return false;
    else
      return true;
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (isValid) {
      _form.currentState.save();
      setState(() {
        _isLoading = true;
      });
      if (_editedProduct.id == null) {
        try {
          await Provider.of<ProductsProvider>(context, listen: false)
              .addProduct(_editedProduct);
        } catch (error) {
          await showDialog(
              context: context,
              builder: (ctx) {
                return AlertDialog(
                    title: Text('An error occured'),
                    content: Text(error.toString()),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('Okay'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      )
                    ]);
              });
        } finally {
          setState(() {
            _isLoading = false;
          });
          Navigator.of(context).pop();
        }
      } else {
        await Provider.of<ProductsProvider>(context, listen: false)
            .updateProduct(_editedProduct, _editedProduct.id);
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Enter the product'),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.save), onPressed: _saveForm)
          ],
        ),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _form,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                            initialValue: _initialValues['title'],
                            decoration: InputDecoration(labelText: 'Title'),
                            textInputAction: TextInputAction.next,
                            onSaved: (value) {
                              _editedProduct = Product(
                                  id: _editedProduct.id,
                                  isFavorite: _editedProduct.isFavorite,
                                  title: value,
                                  price: _editedProduct.price,
                                  description: _editedProduct.description,
                                  imageUrl: _editedProduct.imageUrl);
                            },
                            validator: (value) {
                              if (value.isEmpty)
                                return 'Please enter a valid value';
                              return null;
                            },
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_priceFocusNode);
                            }),
                        TextFormField(
                            initialValue: _initialValues['price'],
                            decoration: InputDecoration(labelText: 'Price'),
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.number,
                            focusNode: _priceFocusNode,
                            onSaved: (value) {
                              _editedProduct = Product(
                                  id: _editedProduct.id,
                                  isFavorite: _editedProduct.isFavorite,
                                  title: _editedProduct.title,
                                  price: double.parse(value),
                                  description: _editedProduct.description,
                                  imageUrl: _editedProduct.imageUrl);
                            },
                            validator: (value) {
                              if (value.isEmpty)
                                return 'Please enter a valid value';
                              if (double.tryParse(value) == null)
                                return 'Please enter a valid number';
                              if (double.parse(value) <= 0)
                                return 'Please enter a number greater than zero!';
                              return null;
                            },
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_descriptionFocusNode);
                            }),
                        TextFormField(
                            initialValue: _initialValues['description'],
                            decoration:
                                InputDecoration(labelText: 'Description'),
                            textInputAction: TextInputAction.next,
                            focusNode: _descriptionFocusNode,
                            maxLines: 3,
                            keyboardType: TextInputType.multiline,
                            onSaved: (value) {
                              _editedProduct = Product(
                                  id: _editedProduct.id,
                                  isFavorite: _editedProduct.isFavorite,
                                  title: _editedProduct.title,
                                  price: _editedProduct.price,
                                  description: value,
                                  imageUrl: _editedProduct.imageUrl);
                            },
                            validator: (value) {
                              if (value.isEmpty)
                                return 'Please enter a valid value';
                              return null;
                            },
                            onFieldSubmitted: (_) {
                              FocusScope.of(context)
                                  .requestFocus(_imageFocusNode);
                            }),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              width: 100,
                              height: 100,
                              margin: EdgeInsets.only(top: 8, right: 10),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: Colors.grey)),
                              child: _imageTextControler.text.isEmpty
                                  ? Container(
                                      child: Text('Image here'),
                                    )
                                  : FittedBox(
                                      fit: BoxFit.cover,
                                      child: Image.network(
                                          _imageTextControler.text),
                                    ),
                            ),
                            Expanded(
                              child: TextFormField(
                                initialValue: _imageTextControler.text,
                                decoration:
                                    InputDecoration(labelText: 'Image URL'),
                                textInputAction: TextInputAction.done,
                                focusNode: _imageFocusNode,
                                keyboardType: TextInputType.url,
                                onSaved: (value) {
                                  _editedProduct = Product(
                                      id: _editedProduct.id,
                                      isFavorite: _editedProduct.isFavorite,
                                      title: _editedProduct.title,
                                      price: _editedProduct.price,
                                      description: _editedProduct.description,
                                      imageUrl: value);
                                },
                                validator: (value) {
                                  if (value.isEmpty)
                                    return 'Please enter a valid value';
                                  if (!_isImage(value))
                                    return 'Please enter a valid image URL';
                                  return null;
                                },
                                onEditingComplete: () {
                                  setState(() {});
                                },
                                onFieldSubmitted: (_) => _saveForm,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ));
  }
}
