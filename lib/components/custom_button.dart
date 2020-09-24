import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BacgButton extends StatefulWidget {
  BacgButton(
      {Key key,
      this.iconName = '',
      @required this.onPressed,
      @required this.type,
      @required this.text,
      this.disabled = false});

  final GestureTapCallback onPressed;
  final ButtonType type;
  final String text;
  final bool disabled;
  String iconName;
  @override
  _BacgButtonState createState() => _BacgButtonState(
      type: type,
      onPressed: onPressed,
      text: text,
      iconName: iconName,
      disabled: disabled);
}

class _BacgButtonState extends State<BacgButton> {
  _BacgButtonState(
      {@required this.onPressed,
      @required this.type,
      @required this.text,
      this.iconName,
      this.disabled});

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        textCol = getTextColor(context);
      });
    });
  }

  final GestureTapCallback onPressed;
  final ButtonType type;
  final String text;
  final bool disabled;
  String iconName;
  bool pressed = false;
  Color textCol, fillCol, borderCol, iconCol;

  @override
  Widget build(BuildContext context) {
    return button();
  }

  Widget button() {
    return FlatButton(
      splashColor: Colors.transparent,
      onPressed: disabled ? null : onPressed,
      onHighlightChanged: (val) {
        setState(() {
          pressed = val;
          textCol = getTextColor(context);
        });
      },
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(0),
        borderSide: BorderSide(
          width: getBorderWidth(context),
          color: getBorderColor(context),
        ),
      ),
      // hoverColor: ,
      color: getFillColor(context),
      // shape: SHape,
      highlightColor: getHighlightColor(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          iconName == ''
              ? Container()
              : SvgPicture.asset(
                  'assets/$iconName.svg',
                  color: getIconColor(context),
                ),
          iconName == ''
              ? Container()
              : SizedBox(
                  width: 10,
                ),
          Text(
            text,
            //style: Theme.of(context).textTheme.bodyText2.apply(),
            style: TextStyle(color: textCol, fontFamily: 'ProximaNova'),
          ),
        ],
      ),
    );
  }

  Color getHighlightColor(BuildContext c) {
    switch (type) {
      case ButtonType.Action:
        return Theme.of(c).primaryColor;
      case ButtonType.Primary:
        return Theme.of(c).primaryColor;
      case ButtonType.Warning:
        return Colors.white;
      case ButtonType.Login:
        return Colors.white;
      default:
        return Colors.white;
    }
  }

  Color getFillColor(BuildContext c) {
    switch (type) {
      case ButtonType.Action:
        return Colors.white; //Theme.of(c).primaryColor;
      case ButtonType.Primary:
        return Colors.white;
      case ButtonType.Warning:
        return Colors.white;
      case ButtonType.Login:
        return Colors.transparent;
      default:
        return Colors.white;
    }
  }

  Color getTextColor(BuildContext c) {
    // return pressed ? Theme.of(c).primaryColor : Colors.white;
    switch (type) {
      case ButtonType.Action:
        return pressed ? Colors.white : Theme.of(c).primaryColor;
      case ButtonType.Primary:
        return pressed ? Colors.white : Colors.black;
      case ButtonType.Warning:
        return pressed ? Theme.of(c).accentColor : Colors.black;
      case ButtonType.Login:
        return pressed ? Theme.of(c).primaryColor : Colors.white;
      default:
        return Colors.white;
    }
  }

  Color getBorderColor(BuildContext c) {
    switch (type) {
      case ButtonType.Primary:
        return pressed ? Theme.of(c).primaryColor : Colors.grey;
      case ButtonType.Action:
        return Theme.of(c).primaryColor;
      case ButtonType.Warning:
        return pressed ? Theme.of(c).accentColor : Colors.grey;
      case ButtonType.Login:
        return pressed ? Theme.of(c).primaryColor : Colors.white;
      default:
        return Colors.white;
    }
  }

  Color getIconColor(BuildContext c) {
    return pressed ? Colors.white : Colors.black;
  }

  double getBorderWidth(BuildContext c) {
    return pressed ? 3 : 2;
  }
}

enum ButtonType { Primary, Action, Warning, Login }
