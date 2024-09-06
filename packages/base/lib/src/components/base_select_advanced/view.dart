// ignore_for_file: unnecessary_this

part of base_lhe;

class BaseSelectAdvanced extends StatefulWidget {
  const BaseSelectAdvanced({
    super.key,
    required this.label,
    this.hintSelect = '',
    this.eventSelect,
    this.pageSize = 10,
    required this.getListSelect,
  });

  final String? label;
  final String hintSelect;
  final Function? eventSelect;
  final Function(int, int, String)? getListSelect;
  final int pageSize;

  @override
  State<BaseSelectAdvanced> createState() => _BaseSelectAdvancedState();
}

class _BaseSelectAdvancedState extends State<BaseSelectAdvanced>
    with TickerProviderStateMixin {
  StatusSelect _statusSelect = StatusSelect.UNFOCUS;

  final LayerLink _layerLink = LayerLink();
  final FocusNode _focusNode = FocusNode();

  late TextEditingController _editTextController;
  late OverlayEntry _overlayEntry;

  late AnimationController _controllerDropdownAnimation;
  late Animation<double> _animationDropDown;

  late PagingController<int, SelectModel> _pagingController;

  SelectModel? selectItem;

  Timer? timer;

  void _onTap() {
    if (_statusSelect != StatusSelect.FOCUS_SEARCH) {
      _statusSelect = StatusSelect.FOCUS_SEARCH;
      FocusScope.of(context).requestFocus(_focusNode);
    }
  }

  void _handleSearch(String search) {
    if (timer != null) timer!.cancel();
    timer = Timer(const Duration(milliseconds: 500), () {
      _pagingController.refresh();
    });

    timer!;
  }

  @override
  void initState() {
    super.initState();

    _controllerDropdownAnimation = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _animationDropDown = Tween<double>(
      begin: 0,
      end: 300,
    ).animate(_controllerDropdownAnimation);

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        this._overlayEntry = this._createOverlayEntry();
        Overlay.of(context).insert(this._overlayEntry);
        _controllerDropdownAnimation.forward();
      } else {
        _controllerDropdownAnimation.reverse();
        Timer(const Duration(milliseconds: 500), () {
          this._overlayEntry.remove();
        });
        _statusSelect = StatusSelect.UNFOCUS;
        _editTextController.text = '';
      }
    });

    _editTextController = TextEditingController();

    _pagingController = PagingController<int, SelectModel>(firstPageKey: 1);

    _pagingController.addPageRequestListener((pageKey) {
      PagingEvent().fetchPage(
        pagingController: _pagingController,
        pageSize: widget.pageSize,
        fetchData: (key) async {
          var res = await widget.getListSelect?.call(
            key,
            widget.pageSize,
            _editTextController.text,
          );
          return res;
        },
        pageKey: pageKey,
      );
    });
  }

  @override
  void dispose() {
    _editTextController.dispose();
    // _controllerLoadingAnimation.dispose();
    _controllerDropdownAnimation.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(sp16),
      decoration:
          BoxDecoration(color: bg_4, borderRadius: BorderRadius.circular(sp8)),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.label != null)
                Text(
                  widget.label!,
                  style: p6,
                ),
              if (widget.label != null) const SizedBox(height: sp16),
              CompositedTransformTarget(
                link: this._layerLink,
                child: InkWell(
                  onTap: () => _onTap(),
                  child: AnimatedContainer(
                    padding: const EdgeInsets.symmetric(
                        vertical: sp8, horizontal: sp16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(sp8),
                      color: whiteColor,
                      border: Border.all(
                        color: _statusSelect != StatusSelect.UNFOCUS
                            ? mainColor
                            : borderColor_4,
                      ),
                    ),
                    duration: const Duration(milliseconds: 250),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(1000),
                              border: Border.all(color: borderColor_1)),
                          child: CircleAvatar(
                            backgroundColor: borderColor_3,
                            backgroundImage: selectItem != null
                                ? const NetworkImage(
                                    'https://www.shutterstock.com/image-vector/red-store-vector-sign-promotion-260nw-1918121837.jpg',
                                  )
                                : null,
                            radius: sp24,
                            child: const Center(
                              child: Icon(
                                Icons.account_box,
                                color: greyColor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: sp8),
                        if (selectItem != null)
                          SizedBox(
                            width: 200,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    selectItem?.label ?? '',
                                    style: p5,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: IconButton(
                                    onPressed: () {
                                      _pagingController.refresh();
                                      setState(() {
                                        selectItem = null;
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.close,
                                      size: sp16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        else
                          SizedBox(
                            width: 200,
                            child: _statusSelect == StatusSelect.FOCUS_SELECT ||
                                    _statusSelect == StatusSelect.UNFOCUS
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Chưa chọn',
                                        style: p6,
                                      ),
                                      const SizedBox(height: sp4),
                                      Text(
                                        'Nhấn để chọn',
                                        style: p6.copyWith(color: greyColor),
                                      )
                                    ],
                                  )
                                : TextField(
                                    keyboardType: TextInputType.text,
                                    focusNode: _focusNode,
                                    controller: _editTextController,
                                    onChanged: (value) {
                                      _handleSearch(value);
                                    },
                                    onSubmitted: null,
                                    decoration: const InputDecoration(
                                      hintText: 'Tìm kiếm nhà phân phối',
                                      border: InputBorder.none,
                                    ),
                                  ),
                          )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width - 32,
        child: CompositedTransformFollower(
          link: _layerLink,
          showWhenUnlinked: false,
          offset: Offset(0.0, size.height - 58),
          child: Material(
            borderRadius: BorderRadius.circular(sp8),
            elevation: 4.0,
            child: AnimatedBuilder(
              animation: _controllerDropdownAnimation,
              builder: (context, child) => SizedBox(
                height: _animationDropDown.value,
                child: RefreshIndicator(
                  onRefresh: () async {
                    _pagingController.refresh();
                  },
                  child: PagedListView<int, SelectModel>(
                    pagingController: _pagingController,
                    builderDelegate: PagedChildBuilderDelegate<SelectModel>(
                      animateTransitions: true,
                      itemBuilder: (context, item, index) => InkWell(
                        onTap: () {
                          _focusNode.unfocus();
                          setState(() {
                            selectItem = item;
                            _statusSelect = StatusSelect.UNFOCUS;
                            _editTextController.text = '';
                          });
                          if (widget.eventSelect != null) {
                            widget.eventSelect!(item);
                          }
                        },
                        child: ListTile(
                          leading: SizedBox(
                            child: Image.network(
                              item.img ??
                                  'https://www.shutterstock.com/image-vector/red-store-vector-sign-promotion-260nw-1918121837.jpg',
                            ),
                          ),
                          title: Text(item.label),
                          subtitle: item.subTitle == null
                              ? const SizedBox()
                              : Text(item.subTitle!),
                        ),
                      ),
                      noItemsFoundIndicatorBuilder: (context) => Center(
                        child: Column(
                          children: [
                            SizedBox(
                                height: 48,
                                width: 48,
                                child: Image.asset(
                                    '${AssetsPath.image}/lh_logo.png')),
                            const SizedBox(height: sp16),
                            Text(
                              'Không tìm thấy dữ liệu!',
                              style: p6.copyWith(color: greyColor),
                            )
                          ],
                        ),
                      ),
                      firstPageErrorIndicatorBuilder: (context) => Center(
                        child: MainButton(
                          title: 'Nhấn để tải lại',
                          event: () {
                            _pagingController.refresh();
                          },
                          largeButton: false,
                          icon: const Icon(
                            Icons.refresh,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
