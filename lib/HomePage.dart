import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moboom1/functions/GetProduct.dart';
import 'package:moboom1/model/ParticularProductModel.dart';
import 'package:moboom1/model/ProductModel.dart';
import 'package:moboom1/styles/colors.dart';
import 'package:moboom1/styles/resposiveWebMobil.dart';
import 'package:moboom1/styles/spaceWidget.dart';
import 'package:moboom1/styles/textStyle.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controller = TextEditingController();
  List<String> categoryList = ["All category"];
  ProductModel model = ProductModel();
  GetProduct _getProduct = GetProduct();
  late String category;
  int finalproduct = 0;
  int productlength = 0;

  @override
  void initState() {
    category = categoryList.first;
    // getLimitedProduct();
    controller.addListener(
      () {
        if (controller.text.isEmpty && category == "All category") {
          getproduct();
        }
      },
    );

    getproduct();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: isDesktop(context)
            ? null
            : AppBar(
                backgroundColor: colorWhite,
                title: SizedBox(
                  width: dSize.width,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 16, right: 16, top: 8, bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.dashboard_outlined,
                          color: Colors.black,
                        ),
                        gapW12,
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "M",
                                style: txtPurpleAccent20,
                              ),
                              Text("oBoo", style: txtBlackBold20),
                              Text("M", style: txtPurpleAccent20)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
        body: SingleChildScrollView(
          child: Container(
            color: colorWhite,
            child: Column(
              children: [
                isDesktop(context)
                    ? Padding(
                        padding: const EdgeInsets.only(
                          left: 32,
                          top: 16,
                          bottom: 16,
                          right: 32,
                        ),
                        child: Container(
                          width: dSize.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "M",
                                    style: txtPurpleAccent20,
                                  ),
                                  Text("oBoo", style: txtBlackBold20),
                                  Text("M", style: txtPurpleAccent20)
                                ],
                              ),
                              gapW64,
                              Flexible(
                                child: SizedBox(
                                    width: dSize.width / 2,
                                    child: searchProductTextfield()),
                              ),
                              gapW64,
                              Flexible(
                                child: FittedBox(
                                  child: Row(
                                    children: [
                                      Text(
                                        "Store",
                                        style: txtBlackBold14,
                                      ),
                                      gapW20,
                                      Text(
                                        "Account",
                                        style: txtBlackBold14,
                                      ),
                                      gapW20,
                                      Text(
                                        "Wise List",
                                        style: txtBlackBold14,
                                      ),
                                      gapW20,
                                      Text(
                                        "Baske",
                                        style: txtBlackBold14,
                                      ),
                                      gapW20,
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 32, right: 32, top: 12, bottom: 12),
                  child: Column(
                    children: [
                      isDesktop(context)
                          ? Container()
                          : searchProductTextfield(),
                      gapH12,
                      isDesktop(context)
                          ? Container()
                          : Row(
                              children: [
                                Text(
                                  "Select Category",
                                  style: txtBlackBold16,
                                ),
                                gapW16,
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border:
                                            Border.all(color: colorBlack45)),
                                    child: DropdownButton<String>(
                                      value: category,
                                      style: txtBlack14,
                                      isExpanded: true,
                                      underline: Container(),
                                      items: categoryList.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                value,
                                                style: txtBlack14,
                                              ),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (_) {
                                        setState(() {
                                          category = _!;
                                          if (category == "All category") {
                                            getproduct();
                                          } else {
                                            _getProduct
                                                .getProduct(
                                                    url:
                                                        "https://dummyjson.com/products/category/$_")
                                                .then((value) {
                                              setState(() {
                                                model.products!.clear();
                                                model.fromJson(value.data);
                                              });
                                            });
                                          }
                                        });
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                      gapH12,
                      Container(
                        // height: 100,
                        width: dSize.width,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade900,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              gapH12,
                              Text(
                                "Title text",
                                style: txtWhiteBold16,
                              ),
                              gapH12,
                              Text(
                                "slash sales in june. Get up 80% discount on all products.",
                                style: txtWhite14,
                              ),
                              gapH12,
                            ],
                          ),
                        ),
                      ),
                      gapH12,
                      isDesktop(context)
                          ? Row(
                              children: [
                                Container(
                                  width: dSize.width / 4,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: colorBlack45)),
                                  child: DropdownButton<String>(
                                    value: category,
                                    style: txtBlack14,
                                    isExpanded: true,
                                    underline: Container(),
                                    items: categoryList.map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              value,
                                              style: txtBlack14,
                                            ),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (_) {
                                      setState(() {
                                        controller.clear();
                                        category = _!;
                                        if (category == "All category") {
                                          getproduct();
                                        } else {
                                          _getProduct
                                              .getProduct(
                                                  url:
                                                      "https://dummyjson.com/products/category/$_")
                                              .then((value) {
                                            setState(() {
                                              model.products!.clear();
                                              model.fromJson(value.data);
                                            });
                                          });
                                        }
                                      });
                                    },
                                  ),
                                ),
                              ],
                            )
                          : Container(),
                      isDesktop(context) ? gapH12 : Container(),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 20,
                            crossAxisSpacing: 20,
                            crossAxisCount: isMobile(context) ? 2 : 4),
                        itemBuilder: (_, index) {
                          int i = productlength + index;
                          finalproduct = i;
                          try {
                            return model.products != null
                                ? productContainer(
                                    heading: model.products![i].title,
                                    description: model.products![i].description
                                        .toString(),
                                    price: model.products![i].price.toString(),
                                    image:
                                        model.products![i].thumbnail.toString(),
                                    rating:
                                        model.products![i].rating!.toDouble())
                                : Container();
                          } catch (e) {
                            return Container();
                          }
                        },
                        itemCount: isDesktop(context) ? 12 : 6,
                      ),
                      gapH12,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (productlength != 0) {
                                  productlength = productlength - 6;
                                }
                              });
                            },
                            child: Container(
                              height: 25,
                              width: 25,
                              alignment: Alignment.center,
                              color: Colors.grey.shade500,
                              child: const Padding(
                                padding: EdgeInsets.all(4.0),
                                child: FittedBox(
                                    child: Icon(Icons.arrow_back_ios_new)),
                              ),
                            ),
                          ),
                          gapW16,
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (finalproduct < model.products!.length - 1) {
                                  productlength = productlength + 6;
                                }
                              });
                            },
                            child: Container(
                              height: 25,
                              width: 25,
                              alignment: Alignment.center,
                              color: Colors.grey.shade200,
                              child: const Padding(
                                padding: EdgeInsets.all(4.0),
                                child: FittedBox(
                                    child: Icon(Icons.arrow_forward_ios)),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                gapH12,
                Container(
                  // height: 200,
                  width: dSize.width,
                  color: Colors.grey.shade200,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 32, right: 32, top: 12, bottom: 12),
                    child: Row(
                      children: [
                        isDesktop(context)
                            ? Flexible(
                                flex: 1,
                                child: Container(
                                  width: dSize.width / 2,
                                  color: Colors.grey.shade500,
                                  child: Column(),
                                ),
                              )
                            : Container(),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "SIGN UP",
                                style: txtBlackBold16,
                              ),
                              gapH12,
                              Row(
                                children: [
                                  Flexible(
                                    child: TextField(
                                      decoration: InputDecoration(
                                        hintText: "Your email",
                                        counter: null,
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: colorBlack45, width: 1.0),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: colorBlack45, width: 1.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                              color: colorBlack45, width: 1.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                  gapW12,
                                  isDesktop(context)
                                      ? Flexible(
                                          child: Container(
                                              width: dSize.width,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey.shade900,
                                                  borderRadius:
                                                      BorderRadius.circular(0)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Text(
                                                  "SUBSCRIBE",
                                                  style: txtWhite14,
                                                ),
                                              )),
                                        )
                                      : Container()
                                ],
                              ),
                              gapH12,
                              isMobile(context)
                                  ? Container(
                                      width: dSize.width,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: Colors.grey.shade900,
                                          borderRadius:
                                              BorderRadius.circular(0)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "SUBSCRIBE",
                                          style: txtWhite14,
                                        ),
                                      ))
                                  : Container(),
                              gapH12,
                              Center(
                                child: FittedBox(
                                  child: Text(
                                    "By clicking the SUBSCRIBE button, You are agreeing to our",
                                    style: GoogleFonts.inter(
                                        textStyle: const TextStyle(
                                            color: Colors.grey, fontSize: 12)),
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  "Privacy & cookie Policy",
                                  style: GoogleFonts.inter(
                                      textStyle: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: Colors.blue.shade900,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                              gapH12
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextField searchProductTextfield() {
    return TextField(
      controller: controller,
      onSubmitted: (e) {
        if (controller.text.isNotEmpty) {
          _getProduct
              .getProduct(
                  url:
                      "https://dummyjson.com/products/search?q=${controller.text.toString()}")
              .then((value) {
            setState(() {
              model.products!.clear();
              model.fromJson(value.data);
            });
          });
        }
      },
      decoration: InputDecoration(
        hintText: "What do you want to buy today ?",
        counter: null,
        suffixIcon: InkWell(
          onTap: () {
            if (controller.text.isNotEmpty) {
              _getProduct
                  .getProduct(
                      url:
                          "https://dummyjson.com/products/search?q=${controller.text.toString()}")
                  .then((value) {
                setState(() {
                  model.products!.clear();
                  model.fromJson(value.data);
                });
              });
            }
          },
          child: const Icon(
            Icons.search,
            color: colorBlack,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: colorBlack45, width: 1.0),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: colorBlack45, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: colorBlack45, width: 1.0),
        ),
      ),
    );
  }

  FittedBox productContainer(
      {required String image,
      heading,
      description,
      price,
      required double rating}) {
    return FittedBox(
      child: Container(
        width: 300,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade300)),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: Image.network(
                    image,
                    fit: BoxFit.fill,
                    height: 200,
                  ),
                ),
                gapH4,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        heading.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: txtBlackBold12,
                      ),
                      gapH4,
                      Text(
                        description.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: txtBlack10,
                      ),
                      gapH4,
                      Text(
                        "\$ $price",
                        style: txtBlackBold14,
                      ),
                      gapH4,
                      RatingBar.builder(
                        initialRating: rating,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 10,
                        glow: false,
                        ignoreGestures: true,
                        itemBuilder: (context, _) => const SizedBox(
                          height: 8,
                          child: Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 8,
                          ),
                        ),
                        onRatingUpdate: (rating) {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  alignment: Alignment.center,
                  height: 35,
                  width: 35,
                  color: Colors.grey.shade700,
                  child: const Icon(
                    Icons.heart_broken,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void getproduct() {
    _getProduct.getProduct(url: "https://dummyjson.com/products").then((value) {
      setState(() {
        // model.products!.clear();
        if (value.data != null) {
          model.fromJson(value.data);

          if (model.products != null) {
            model.products!.forEach((element) {
              setState(() {
                if (!categoryList.contains(element.category)) {
                  categoryList.add(element.category.toString());
                }
              });
            });
          }
        }
      });
    }).catchError((e) {
      print("product get error : $e");
    });
  }

  // void getLimitedProduct() async {
  //   ParticularProductModel products = ParticularProductModel();
  //   List t = [];

  //   for (int i = 1; i < 7; i++) {
  //     await _getProduct
  //         .getProduct(url: "https://dummyjson.com/products/$i")
  //         .then((value) {

  //     }).catchError((e) {});
  //   }

  //   // Products products = Products();
  //   // products.fromJson()
  // }
}
