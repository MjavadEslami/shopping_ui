// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shop_app/data/product.dart';

class DetailScreen extends StatelessWidget {
  final Product product;

  const DetailScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: product.color,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset(
            'assets/icons/back.svg',
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              'assets/icons/search.svg',
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              'assets/icons/cart.svg',
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.30),
                  padding: EdgeInsets.only(
                      right: 20,
                      left: 20,
                      top: MediaQuery.of(context).size.height * 0.12),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                  ),
                  child: Column(children: [
                    _ColorsAndSize(
                      product: product,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    _ProductDescription(product: product),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        _CartCounter(),
                        _HeartIcon(),
                      ],
                    )
                  ]),
                ),
                _ProductInfo(product: product)
              ],
            ),
          )
        ],
      )),
    );
  }
}

class _ProductInfo extends StatelessWidget {
  final Product product;
  const _ProductInfo({
    required this.product,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Iranian Hand Bag',
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            product.title,
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: Colors.white,
                  fontSize: 30,
                ),
          ),
          const SizedBox(
            height: 70,
          ),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('price', style: TextStyle(color: Colors.white)),
                  Text(
                    '\$' + product.price.toString(),
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              const Spacer(),
              Expanded(
                child: Hero(
                  tag: product.id,
                  child: Image.asset(
                    product.image,
                    fit: BoxFit.fill,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class _CartCounter extends StatefulWidget {
  const _CartCounter({
    Key? key,
  }) : super(key: key);

  @override
  State<_CartCounter> createState() => _CartCounterState();
}

class _CartCounterState extends State<_CartCounter> {
  int counter = 1;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              counter++;
            });
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: 40,
            height: 30,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.add),
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          counter.toString().padLeft(2, '0'),
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(
          width: 8,
        ),
        InkWell(
          onTap: () {
            setState(() {
              if (counter >= 2) {
                counter--;
              }
            });
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            width: 40,
            height: 30,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.remove),
          ),
        ),
      ],
    );
  }
}

class _HeartIcon extends StatelessWidget {
  const _HeartIcon({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(16),
      ),
      child: SvgPicture.asset('assets/icons/heart.svg'),
    );
  }
}

class _ProductDescription extends StatelessWidget {
  const _ProductDescription({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Text(
      product.description,
      textAlign: TextAlign.justify,
    );
  }
}

class _ColorsAndSize extends StatelessWidget {
  final Product product;
  const _ColorsAndSize({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const _Colors(),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('size'),
              Text(
                product.size.toString() + ' cm',
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
        )
      ],
    );
  }
}

class _Colors extends StatefulWidget {
  const _Colors({
    Key? key,
  }) : super(key: key);

  @override
  State<_Colors> createState() => _ColorsState();
}

enum colors { red, yellow, blue }

class _ColorsState extends State<_Colors> {
  var selectedColor = colors.red;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('color'),
          Row(
            children: [
              _Color(
                color: Colors.red,
                isSeletdet: selectedColor == colors.red ? true : false,
                onTap: () {
                  setState(() {
                    selectedColor = colors.red;
                  });
                },
              ),
              _Color(
                color: Colors.yellow,
                isSeletdet: selectedColor == colors.yellow ? true : false,
                onTap: () {
                  setState(() {
                    selectedColor = colors.yellow;
                  });
                },
              ),
              _Color(
                color: Colors.blue,
                isSeletdet: selectedColor == colors.blue ? true : false,
                onTap: () {
                  setState(() {
                    selectedColor = colors.blue;
                  });
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _Color extends StatelessWidget {
  final Color color;
  final bool isSeletdet;
  final Function() onTap;
  const _Color(
      {Key? key,
      required this.color,
      required this.isSeletdet,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isSeletdet
        ? Container(
            margin: const EdgeInsets.only(right: 10, top: 5),
            padding: const EdgeInsets.all(1),
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: color,
            ),
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          )
        : InkWell(
            onTap: onTap,
            child: Container(
              margin: const EdgeInsets.only(right: 10, top: 5),
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: color,
              ),
            ),
          );
  }
}
