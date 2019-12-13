
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../animation/fade_in.dart';

class PreviewImageWidget extends StatefulWidget {
  // 图片列表
  final List<String> images;
  // 背景色
  final Color color;
  // 遮罩点击
  final Function maskClick;
  // 默认展示
  final int defaultIndex;
  // 指标显示
  final bool indicators;
  final Function onLongPress;
  final Function onPageChanged;

  PreviewImageWidget({
    key,
    this.images,
    this.color,
    this.maskClick,
    this.defaultIndex,
    this.indicators,
    this.onLongPress,
    this.onPageChanged
  }) : super(key: key);

  @override
  PreviewImageWidgetState createState() => PreviewImageWidgetState();
}

class PreviewImageWidgetState extends State<PreviewImageWidget> {
  GlobalKey fadeInKey = GlobalKey();
  PageController _pageController;
  ScrollController _scrollController;
  int _index = 0;
  double _scale = 1.0;
  /// 最后一次的放大比例
  double _lastScale = 1.0;

  @override
  void dispose() { 
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _index = widget.defaultIndex;
    // PageController
    _pageController = PageController(
      initialPage: widget.defaultIndex
    );
  }

  // 反顺动画
  reverseAnimation() async {
    await (fadeInKey.currentState as FadeInState).controller.reverse();
  }

  void onChang(int index) {
    setState(() {
      _index = index;
    });
  }

  // 渲染指标
  Widget renderIndicators() {
    final List<Widget> indicators = [];
    final double size = 7.0;

    for (var i = 0; i < widget.images.length; i++) {
      indicators.add(
        Padding(
          padding: EdgeInsets.only(left: i == 0 ? 0.0 : 7.0),
          child: Opacity(
            opacity: _index == i ? 1.0 : 0.55,
            child: SizedBox(
              width: size,
              height: size,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(size)
                  )
                )
              )
            )
          )
        )
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: indicators
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget child = PageView.builder(
      onPageChanged: onChang,
      controller: _pageController,
      itemCount: widget.images.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: widget.maskClick,
          onDoubleTap: () {
            if(_scale != 1.0) {
              _scale = 1.0;
              // _scrollController?.dispose();
            } else {
              // _scrollController = ScrollController(initialScrollOffset: _lastTapX);
              _scale = 2.0;
            }
            print(_scale);
            setState(() => null);
          },
          onLongPress: widget.onLongPress,
          onScaleUpdate: (ScaleUpdateDetails details) {
            print(details);
            if (details.scale == 1.0) {
              return null;
            }
            double _x = details.localFocalPoint.dx;
            /// 按比例
            _scale = details.scale * _lastScale;
            if (_scale > 1.0) {
              if (_scrollController != null) {
                _scrollController.jumpTo(_x * _scale);
              } else {
                _scrollController = ScrollController(initialScrollOffset: _x);
              }
            } else {
              _scrollController?.dispose();
              _scrollController = null;
            }
            
            setState(() => null);
          },
          onScaleEnd: (details) {
            _lastScale = _scale;
            if (_scale < 1.0) {
              _scale = 1.0;
              setState(() => null);
            }
          },
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Colors.transparent
            ),
            child: Align(
              alignment: Alignment.center,
              child: _scale > 1
              ? SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                controller: _scrollController,
                child: Container(
                  child: CachedNetworkImage(
                    fit: BoxFit.fitWidth,
                    width: MediaQuery.of(context).size.width * _scale,
                    imageUrl: widget.images[index],
                    placeholder: (context, url) => Container(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  )
                ),
              )
              : CachedNetworkImage(
                fit: BoxFit.fitWidth,
                width: MediaQuery.of(context).size.width * _scale,
                imageUrl: widget.images[index],
                placeholder: (context, url) => Container(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              
            )
          )
        );
      }
    );

    // 判断是否显示指标
    if (widget.indicators) {
      child = Stack(
        children: [
          child,
          Positioned(
            right: 0,
            bottom: 20.0,
            left: 0,
            child: renderIndicators()
          )
        ]
      );
    }

    return FadeIn(
      key: fadeInKey,
      duration: 200,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: widget.color
        ),
        child: child
      )
    );
  }
}
