part of base_lhe;

typedef SearchBarItemWidgetBuilder<Type> = Widget Function(
  BuildContext context,
  Type item,
  int index,
);

class FSBar<Type> extends StatelessWidget {
  FSBar({
    required this.floatingSearchBarController,
    this.onSubmitted,
    this.onQueryChanged,
    this.onKeyEvent,
    this.onFocusChanged,
    required this.list,
    required this.goTo, //user tap on item in list
    required this.itemBuilder,
    this.body,
    this.progress = false,
    this.hint,
    this.shrinkWrap = false,
    this.noItemFoundWidget,
    super.key,
  });

  final FloatingSearchBarController floatingSearchBarController;
  final Function(String)? onSubmitted;
  final Function(String)? onQueryChanged;
  final Function(KeyEvent)? onKeyEvent;
  final Function(bool)? onFocusChanged;
  final List<Type> list;
  final Function goTo;
  final String? hint;
  bool progress;
  final Widget? body;
  final SearchBarItemWidgetBuilder<Type> itemBuilder;
  final Widget? noItemFoundWidget;
  bool shrinkWrap;

  @override
  Widget build(BuildContext context) {
    final actions = [
      FloatingSearchBarAction(
        showIfOpened: false,
        child: CircularButton(
          icon: const Icon(Icons.place),
          onPressed: () {},
        ),
      ),
      FloatingSearchBarAction.searchToClear(
        showIfClosed: false, 
      ),
    ];

    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return FloatingSearchBar(
      controller: floatingSearchBarController,
      hint: hint ?? 'Tìm kiếm...',
      hintStyle: p6.copyWith(color: greyColor),
      scrollPadding: const EdgeInsets.only(top: 16),
      transitionDuration: const Duration(milliseconds: 300),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0, //
      // leadingActions: actions,
      openAxisAlignment: 0.0,
      width: widthDevice(context),
      shadowColor: const Color.fromARGB(255, 76, 70, 70),
      debounceDelay: const Duration(milliseconds: 500),
      backdropColor: const Color.fromARGB(0, 0, 0, 0),
      elevation: 0,
      border: const BorderSide(color: borderColor_4),
      borderRadius: BorderRadius.circular(sp8),
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: sp16),
      margins: const EdgeInsets.all(0),
      iconColor: greyColor,
      automaticallyImplyBackButton: false,
      transition: CircularFloatingSearchBarTransition(spacing: 16),
      progress: progress,
      height: 50,
      onQueryChanged: (query) {
        if (onQueryChanged != null) onQueryChanged!(query);
      },
      onKeyEvent: (value) {
        if (onKeyEvent != null) onKeyEvent!(value);
      },
      onFocusChanged: (isFocused) {
        if (onFocusChanged != null) onFocusChanged!(isFocused);
      },
      onSubmitted: (query) {
        if (onSubmitted != null) onSubmitted!(query);
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      // transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(
              Icons.search,
              color: greyColor,
            ),
            onPressed: () {},
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      body: Container(
        margin: const EdgeInsets.only(top: 64),
        child: body,
      ),
      builder: (_, transition) {
        return Material(
          borderRadius: BorderRadius.circular(sp8),
          elevation: 10,
          child: list.isEmpty && floatingSearchBarController.query.isNotEmpty && !progress
              ? noItemFoundWidget ?? SizedBox(
                  height: 100,
                  child: Center(
                    child: Text(
                      'Không tìm thấy cửa hàng !',
                      style: p3.copyWith(
                        color: greyColor,
                      ),
                    ),
                  ),
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListView.separated(
                      physics: const ClampingScrollPhysics(),
                      shrinkWrap: shrinkWrap,
                      separatorBuilder: (context, index) => const Divider(height: 1),
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return itemBuilder(context, list[index], index);
                      }
                      // InkWell(
                      //   onTap: () {
                      //     controller.close();
                      //     goTo(list[index]['id']);
                      //   },
                      //   child: Container(
                      //     width: double.infinity,
                      //     padding: const EdgeInsets.all(sp16),
                      //     child: Row(
                      //       crossAxisAlignment: CrossAxisAlignment.center,
                      //       children: [
                      //         SizedBox(
                      //           width: 48,
                      //           height: 48,
                      //           child: ClipRRect(
                      //             borderRadius: BorderRadius.circular(sp8),
                      //             child: Image.network(
                      //               list[index]['image'] ??
                      //                   'https://d1nhio0ox7pgb.cloudfront.net/_img/g_collection_png/standard/256x256/store.png',
                      //               fit: BoxFit.cover,
                      //             ),
                      //           ),
                      //         ),
                      //         const SizedBox(width: sp16),
                      //         Column(
                      //           children: [
                      //             SizedBox(
                      //               width: widthDevice(context) - 160,
                      //               child: Text(
                      //                 list[index]['name'],
                      //                 style: p5,
                      //                 overflow: TextOverflow.ellipsis,
                      //               ),
                      //             ),
                      //             const SizedBox(height: sp4),
                      //             SizedBox(
                      //               width: widthDevice(context) - 160,
                      //               child: Text(
                      //                 list[index]['sub'],
                      //                 style: p6
                      //                     .copyWith(color: greyColor),
                      //                 overflow: TextOverflow.ellipsis,
                      //               ),
                      //             ),
                      //           ],
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}