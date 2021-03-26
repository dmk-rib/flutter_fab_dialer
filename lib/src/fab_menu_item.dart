part of fab_dialer;

typedef void OnFabMiniMenuItemPressed();

class FabMiniMenuItem {
  double elevation;
  Icon icon;
  Color fabColor;
  String tooltip;
  OnFabMiniMenuItemPressed onPressed;
  String? text;
  Icon? dynamicIcon;
  Color? chipColor;
  Color? textColor;
 
  FabMiniMenuItem.withText(this.icon,
    this.fabColor,
    this.elevation,
    this.tooltip,
    this.onPressed,
    this.text,
    this.chipColor,
    this.textColor);

  FabMiniMenuItem.noText(this.icon, this.fabColor, this.elevation,
    this.tooltip, this.onPressed) {
    this.text = null;
    this.chipColor = null;
    this.textColor = null;
  }
}

class FabMenuMiniItemWidget extends StatefulWidget {
  FabMenuMiniItemWidget({Key? key,
    this.elevation,
    required this.text,
    this.icon,
    this.fabColor,
    this.chipColor,
    this.textColor,
    this.tooltip,
    required this.index,
    required this.controller,
    required this.onPressed,
	  required this.closeOnPress,
	  required this.close
  })
    : super(key: key);

  final double? elevation;
  final String? text;
  final Icon? icon;
  final Color? fabColor;
  final Color? chipColor;
  final String? tooltip;
  final Color? textColor;
  final int index;
  final OnFabMiniMenuItemPressed onPressed;
  final AnimationController controller;
  final bool closeOnPress;
  final Function close;

  @override
  _FabMenuMiniItemWidgetState createState() => _FabMenuMiniItemWidgetState();
}

class _FabMenuMiniItemWidgetState extends State<FabMenuMiniItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 0.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
                margin: EdgeInsets.symmetric(horizontal: 0.0),
                child: ScaleTransition(
                    scale: CurvedAnimation(
                      parent: widget.controller,
                      curve: Interval(((widget.index + 1) / 100), 1.0,
                          curve: Curves.linear),
                    ),
                    child: widget.chipColor != null && widget.text != null
                      ? Chip(
                        label: Text(
                        widget.text ?? '',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: widget.textColor,
                            fontWeight: FontWeight.bold),
                        ),
                        backgroundColor: widget.chipColor, ) 
                      : null)),
            ScaleTransition(
              scale: CurvedAnimation(
                parent: widget.controller,
                curve:
                Interval(
                    ((widget.index + 1) / 100), 1.0, curve: Curves.linear),
              ),
              child: FloatingActionButton(
                  elevation: widget.elevation,
                  mini: true,
                  backgroundColor: widget.fabColor,
                  tooltip: widget.tooltip,
                  child: widget.icon,
                  heroTag: "${widget.index}",
                  onPressed: () {
                    widget.onPressed();
                    if (widget.closeOnPress) {
                      widget.close();
                    }
                  }),
            )
          ],
        ));
  }
}
