part of fab_dialer;

class FabDialer extends StatefulWidget {
  const FabDialer(this._fabMiniMenuItemList, this._fabColor, this._fabIcon,
      [this._closeFabIcon = const Icon(Icons.close), this._animationDuration = 180, this.closeOnTap = false]);

  final List<FabMiniMenuItem> _fabMiniMenuItemList;
  final Color _fabColor;
  final Icon _fabIcon;
  final Icon _closeFabIcon;
  final int _animationDuration;
  final bool closeOnTap;


  @override
  FabDialerState createState() =>
      FabDialerState(
        _fabMiniMenuItemList, 
        _animationDuration, closeOnTap);
}

class FabDialerState extends State<FabDialer> with TickerProviderStateMixin {
  FabDialerState(this._fabMiniMenuItemList, this._animationDuration, this.closeOnTap);

  bool _isRotated = false;
  final List<FabMiniMenuItem> _fabMiniMenuItemList;
  final int _animationDuration;
  final bool closeOnTap;
  late List<FabMenuMiniItemWidget> _fabMenuItems;
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: _animationDuration),
    );

    _controller.reverse();

    setFabMenu(this._fabMiniMenuItemList);
    super.initState();
  }

  void setFabMenu(List<FabMiniMenuItem> fabMenuList) {
    var fabMenuItems = <FabMenuMiniItemWidget>[];
    for (int i = 0; i < _fabMiniMenuItemList.length; i++) {
      fabMenuItems.add(FabMenuMiniItemWidget(
          tooltip: _fabMiniMenuItemList[i].tooltip,
          text: _fabMiniMenuItemList[i].text,
          elevation: _fabMiniMenuItemList[i].elevation,
          icon: widget._fabMiniMenuItemList[i].icon,
          index: i,
          onPressed: _fabMiniMenuItemList[i].onPressed,
          textColor: _fabMiniMenuItemList[i].textColor,
          fabColor: widget._fabMiniMenuItemList[i].fabColor,
          chipColor: _fabMiniMenuItemList[i].chipColor,
          controller: _controller,
          closeOnPress: closeOnTap,
          close: _rotate
      ));
    }

    this._fabMenuItems = fabMenuItems;
  }

  void _rotate() {
    if (_isRotated) {
      _isRotated = false;
      _controller.reverse();
    } else {
      _isRotated = true;
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    setFabMenu(this._fabMiniMenuItemList);

    return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: _fabMenuItems,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                AnimatedBuilder(
                  animation: _controller,
                  builder: (BuildContext _, Widget? child) {
                    return FloatingActionButton(
                        child: Transform(
                          transform: Matrix4.rotationZ(
                              (2 * Math.pi) * _controller.value),
                          alignment: Alignment.center,
                          child: _controller.value >= 0.5
                              ? widget._closeFabIcon
                              : widget._fabIcon,
                        ),
                        backgroundColor: widget._fabColor,
                        onPressed: _rotate);
                  },
                )
              ],
            ),
          ],
        ));
  }
}