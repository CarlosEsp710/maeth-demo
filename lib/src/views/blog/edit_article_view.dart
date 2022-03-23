import 'dart:io';

import 'package:flutter/material.dart';

import 'package:dotted_border/dotted_border.dart';
import 'package:getwidget/getwidget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laravel_json_api/laravel_json_api.dart';
import 'package:slugify/slugify.dart';

import 'package:maeth_demo/src/common/theme.dart';
import 'package:maeth_demo/src/controllers/blog/edit_article_controller.dart';
import 'package:maeth_demo/src/controllers/blog/list_category_controller.dart';
import 'package:maeth_demo/src/helpers/helpers.dart';
import 'package:maeth_demo/src/schemas/article_schema.dart';
import 'package:maeth_demo/src/schemas/category_schema.dart';

class EditArticleView extends StatelessWidget {
  final Article? article;

  const EditArticleView({
    Key? key,
    this.article,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article == null ? 'Nuevo artículo' : 'Editar artículo'),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: _Form(article: article),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  final Article? article;

  const _Form({Key? key, this.article}) : super(key: key);

  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  EditArticleController controller = EditArticleController();
  final ListCategoriesController _categoryController =
      ListCategoriesController();

  ImagePicker? _imagePicker;

  @override
  void initState() {
    _imagePicker = ImagePicker();
    if (widget.article != null) {
      Category category =
          Category(widget.article!.categoryDoc as ResourceObject);
      controller.titleController.text = widget.article!.title;
      controller.slugController.text = widget.article!.slug;
      controller.contentController.text = widget.article!.content;
      controller.categoryName = category.name;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: controller.formKey,
        child: Column(
          children: <Widget>[
            const SizedBox(height: 30.0),
            GestureDetector(
              onTap: _setImage,
              child:
                  _ImageView(controller: controller, article: widget.article),
            ),
            const SizedBox(height: 30.0),
            TextFormField(
              controller: controller.titleController,
              autocorrect: true,
              keyboardType: TextInputType.text,
              decoration: MaethInputDecoration().textInputDecoration(
                radius: 10,
                context: context,
                lableText: 'Título',
                hintText: 'Título del post',
              ),
              validator: (value) => Validator().validateText(value!),
              onChanged: (text) {
                String slug = slugify(text, lowercase: true, delimiter: '-');

                controller.slugController.text = slug;
              },
            ),
            const SizedBox(height: 30.0),
            TextFormField(
              controller: controller.slugController,
              autocorrect: true,
              keyboardType: TextInputType.text,
              decoration: MaethInputDecoration().textInputDecoration(
                radius: 10,
                context: context,
                lableText: 'Slug',
                hintText: 'Identificador del post',
              ),
              readOnly: true,
              validator: (value) => Validator().validateText(value!),
            ),
            const SizedBox(height: 30.0),
            FutureBuilder(
              future: _categoryController.getCategoriesName(context),
              builder: (context, AsyncSnapshot snapshot) {
                return snapshot.hasData
                    ? _categories(snapshot, context)
                    : const Center(child: CircularProgressIndicator());
              },
            ),
            const SizedBox(height: 30),
            TextFormField(
              autocorrect: true,
              controller: controller.contentController,
              maxLines: 15,
              keyboardType: TextInputType.multiline,
              decoration: MaethInputDecoration().textInputDecoration(
                radius: 10,
                context: context,
                lableText: 'Contenido del artículo',
                hintText: '',
              ),
              validator: (value) => Validator().validateText(value!),
            ),
            const SizedBox(height: 30.0),
            GFButton(
              onPressed: () => controller.editArticle(
                context,
                article: (widget.article == null) ? null : widget.article,
              ),
              text: 'Publicar',
              color: const Color(0xffFF6B37),
              textColor: Colors.white,
              fullWidthButton: true,
              shape: GFButtonShape.pills,
              size: GFSize.LARGE,
            ),
            const SizedBox(height: 30.0),
          ],
        ),
      ),
    );
  }

  Widget _categories(AsyncSnapshot<dynamic> snapshot, BuildContext context) {
    return DropdownButtonFormField(
      value: controller.categoryName,
      decoration: MaethInputDecoration().textInputDecoration(
        radius: 10,
        context: context,
        lableText: 'Categoría',
        hintText: 'Asignar categoría',
      ),
      onChanged: (String? value) => setState(() {
        controller.categoryName = value!;
      }),
      items: snapshot.data
          .map<DropdownMenuItem<String>>((value) =>
              DropdownMenuItem<String>(child: Text(value), value: value))
          .toList(),
      validator: (value) => Validator()
          .validateDropdown(controller.categoryName, snapshot.data[0]),
    );
  }

  void _setImage() async {
    XFile? image = await _imagePicker!.pickImage(source: ImageSource.gallery);

    setState(() {
      controller.imageArticle = File(image!.path);
    });
  }
}

class _ImageView extends StatelessWidget {
  final Article? article;

  const _ImageView({
    Key? key,
    required this.controller,
    this.article,
  }) : super(key: key);

  final EditArticleController controller;

  @override
  Widget build(BuildContext context) {
    if (article == null) {
      return DottedBorder(
        color: Colors.grey,
        borderType: BorderType.Rect,
        dashPattern: const [10, 5, 10, 5, 10, 5],
        child: Container(
          width: double.infinity,
          height: 250,
          decoration: BoxDecoration(
            color: Colors.white,
            image: (controller.imageArticle != null)
                ? DecorationImage(
                    image: FileImage(controller.imageArticle),
                    fit: BoxFit.fill,
                  )
                : null,
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 20,
                offset: Offset(5, 5),
              ),
            ],
          ),
          child: Center(
            child: (controller.imageArticle == null)
                ? const Text(
                    'Presiona para cargar una imagen',
                    style: TextStyle(color: GFColors.DARK),
                  )
                : null,
          ),
        ),
      );
    } else {
      if (controller.imageArticle == null) {
        return GFImageOverlay(
          height: 250,
          width: double.infinity,
          child: const Center(
            child: Text(
              'Presiona para cambiar la imagen',
              style: TextStyle(color: GFColors.LIGHT),
            ),
          ),
          image: NetworkImage(article!.image),
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.3),
            BlendMode.darken,
          ),
        );
      } else {
        return DottedBorder(
          borderType: BorderType.Rect,
          dashPattern: const [10, 5, 10, 5, 10, 5],
          child: Container(
            width: double.infinity,
            height: 250,
            decoration: BoxDecoration(
              color: Colors.white,
              image: (controller.imageArticle != null)
                  ? DecorationImage(
                      image: FileImage(controller.imageArticle),
                      fit: BoxFit.fill,
                    )
                  : null,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 20,
                  offset: Offset(5, 5),
                ),
              ],
            ),
            child: Center(
              child: (controller.imageArticle == null)
                  ? const Text(
                      'Presiona para cargar una imagen',
                      style: TextStyle(color: GFColors.DARK),
                    )
                  : null,
            ),
          ),
        );
      }
    }
  }
}
