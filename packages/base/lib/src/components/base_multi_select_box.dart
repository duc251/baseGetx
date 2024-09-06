part of base_lhe;

class BaseMultiSelectBox extends StatefulWidget {
  final List<SelectModel> listSelect;
  final Function(List<SelectModel>)? selectedList;
  final String title;

  const BaseMultiSelectBox(
      {super.key,
      this.listSelect = const [],
      this.selectedList,
      required this.title});

  @override
  State<BaseMultiSelectBox> createState() => _BaseMultiSelectBoxState();
}

class _BaseMultiSelectBoxState extends State<BaseMultiSelectBox> {
  List<SelectModel> listSelect = [];

  @override
  void initState() {
    super.initState();
    listSelect = widget.listSelect;
  }

  @override
  void didUpdateWidget(covariant BaseMultiSelectBox oldWidget) {
    if (oldWidget.listSelect != widget.listSelect) {
      listSelect = widget.listSelect;
      setState(() {});
    }
    super.didUpdateWidget(oldWidget);
  }

  List<SelectModel> get selectedList =>
      listSelect.where((element) => element.isSelected).toList();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => DialogMultiSelect(
            title: widget.title,
            list: listSelect,
            selectedList: (value) {
              widget.selectedList?.call(value);
            },
          ),
        );
      },
      child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(
            selectedList.isNotEmpty ? sp4 : sp12,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(sp8),
            border: Border.all(
              color: borderColor_2,
            ),
            color: whiteColor,
          ),
          child: Row(
            children: [
              Expanded(
                flex: 8,
                child: Stack(
                  children: [
                    selectedList.isNotEmpty
                        ? const SizedBox.shrink()
                        : Text(
                            "Chọn hình thức thanh toán".tr,
                            style: p6,
                          ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          selectedList.length,
                          (index) => Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: sp4,
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: sp12,
                                vertical: sp8,
                              ),
                              decoration: BoxDecoration(
                                color: borderColor_1,
                                borderRadius: BorderRadius.circular(sp8),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    selectedList[index].label,
                                    style: p6,
                                  ),
                                  const SizedBox(width: sp4),
                                  GestureDetector(
                                    onTap: () {
                                      selectedList[index].isSelected = false;
                                      setState(() {});
                                      widget.selectedList?.call(listSelect);
                                    },
                                    child: Container(
                                      color: borderColor_1,
                                      child: const Icon(
                                        Icons.close,
                                        color: greyColor,
                                        size: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: SvgPicture.asset(
                  '${AssetsPath.icon}/ic_black_arrow_down.svg',
                ),
              ),
            ],
          )),
    );
  }
}

class DialogMultiSelect extends StatefulWidget {
  final List<SelectModel> list;
  final Function(List<SelectModel>)? selectedList;
  final String title;

  const DialogMultiSelect({
    super.key,
    required this.list,
    this.selectedList,
    required this.title,
  });

  @override
  State<DialogMultiSelect> createState() => _DialogMultiSelectState();
}

class _DialogMultiSelectState extends State<DialogMultiSelect> {
  late List<SelectModel> list;

  @override
  void initState() {
    super.initState();
    list = widget.list;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Container(
          width: widthDevice(context) - sp32,
          padding: const EdgeInsets.all(sp16),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(sp8), color: whiteColor),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.title,
                style: h6,
              ),
              const SizedBox(height: sp16),
              Container(
                constraints: const BoxConstraints(maxHeight: 300),
                child: SingleChildScrollView(
                  child: ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Checkbox(
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            visualDensity: const VisualDensity(
                                horizontal: -4, vertical: -4),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(3)),
                            splashRadius: sp8,
                            checkColor: whiteColor,
                            side: const BorderSide(color: greyColor, width: 2),
                            fillColor: MaterialStateProperty.all(mainColor),
                            value: list[index].isSelected,
                            onChanged: (bool? value) {
                              list[index].isSelected = value ?? false;
                              setState(() {});
                            },
                          ),
                          const SizedBox(width: sp16),
                          Text(
                            list[index].label ?? '',
                            style: p4,
                          )
                        ],
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: sp16),
                    itemCount: list.length,
                  ),
                ),
              ),
              const SizedBox(height: sp16),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    flex: 1,
                    child: LeftButton(
                      title: "Quay lại".tr,
                      onTap: () {
                        Get.back();
                      },
                      borderColor: borderColor_4,
                      largeButton: true,
                      icon: null,
                    ),
                  ),
                  const SizedBox(width: sp16),
                  Expanded(
                    flex: 1,
                    child: RightButton(
                      title: "Xác nhận".tr,
                      onTap: () {
                        widget.selectedList?.call(list);
                        Get.back();
                      },
                      largeButton: true,
                      icon: null,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
