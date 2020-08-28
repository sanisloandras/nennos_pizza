import 'package:flutter/cupertino.dart';

class PizzaImageWidget extends StatelessWidget {
  final String imageUrl;

  const PizzaImageWidget({Key key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1,
          child: Image.asset("images/bg_wood.png", fit: BoxFit.fill,),
        ),
        Positioned(
          left: MediaQuery.of(context).size.width * 0.05,
          top: MediaQuery.of(context).size.width * 0.05,
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.width * 0.9,
          child: buildPizzaImage(),
        )
      ],
    );
  }

  Image buildPizzaImage() {
    var placeholder = Image.asset("images/custom.png", fit: BoxFit.fill,);
    var pizzaImage = imageUrl == null ? placeholder : Image.network(
        imageUrl,
        fit: BoxFit.cover,
        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent loadingProgress) {
          if (loadingProgress == null) {
            return child;
          } else {
            return placeholder;
          }
        }
    );
    return pizzaImage;
  }

}