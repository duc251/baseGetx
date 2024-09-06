part of base_lhe;

class FloatingChatButton extends StatefulWidget {
  final Widget? background;
  final Widget child;

  const FloatingChatButton({this.background, Key? key, required this.child})
      : super(key: key);

  @override
  FloatingChatButtonState createState() => FloatingChatButtonState();
}

class FloatingChatButtonState extends State<FloatingChatButton>
    with TickerProviderStateMixin {
  bool isTop = false;
  bool isRight = true;
  Offset offset = const Offset(0, 0);
  late Animation<Offset> _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _animation = Tween<Offset>(
      begin: offset,
      end: const Offset(20, 20),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.elasticIn,
    ));
    super.initState();
  }

  void _setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  @override  
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Stack(
          children: [
            if (widget.background != null) widget.background!,
            Positioned(
              bottom: (isTop) ? null : 20,
              top: (isTop) ? 20 : null,
              right: (isRight) ? 20 : null,
              left: (isRight) ? null : 20,
              child: Draggable(
                feedback: widget.child,
                childWhenDragging: Container(),
                onDragEnd: (draggableDetails) {
                  _setStateIfMounted(
                    () {
                      isTop = (draggableDetails.offset.dy <
                          (MediaQuery.of(context).size.height) / 2);
                      isRight = (draggableDetails.offset.dx >
                          (MediaQuery.of(context).size.width) / 2);
                      offset = draggableDetails.offset;
                    },
                  );
                },
                child: widget.child,
              ),
            )
          ],
        );
      },
    );
  }
}

Widget BuildHeplDeskButton(BuildContext context, Widget child) {
  return FloatingChatButton(
    child: BubbleButton(
      onTap: () {
        showModalBottomSheet(
          backgroundColor: Colors.black26,
          context: context,
          builder: (context) => Container(
            padding: const EdgeInsets.all(sp16),
            decoration: const BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(sp8),
                topRight: Radius.circular(sp8),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Yêu cầu hỗ trợ".tr, style: p1),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(
                        Icons.close,
                        size: sp20,
                        color: blackColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: sp16),
                _SupportHelpDesk(
                  onTap: () async {
                    launchUrl(
                      Uri(
                        scheme: "tel",
                        path: _Const.LHEnumber,
                      ),
                    );
                  },
                  title: "Gửi yêu cầu hỗ trợ".tr,
                ),
                const SizedBox(height: sp16),
                _SupportHelpDesk(
                  onTap: () async {
                    launchUrl(
                      Uri(
                        scheme: "tel",
                        path: _Const.LHEnumber,
                      ),
                    );
                  },
                  title: "Gọi tới hỗ trợ của Long Hải".tr,
                ),
                const SizedBox(height: sp16),
                _SupportHelpDesk(
                  onTap: () async {
                    launchUrl(
                      Uri(
                        scheme: "tel",
                        path: _Const.LHEnumber,
                      ),
                    );
                  },
                  title: "Gọi tới bộ phận kỹ thuật ứng dụng".tr,
                ),
              ],
            ),
          ),
        );
      }, child: child,
    ),
  );
}
