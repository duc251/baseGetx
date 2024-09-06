part of base_lhe;

abstract class BaseSelectSetup {
  void handleSelect(SelectModel? itemSelect);

  void validateSelect(SelectModel? itemSelect);
}

class BaseSelect extends StatelessWidget {
  List<SelectModel> list;
  SelectModel? select;
  Function(SelectModel?)? handleSelect;
  String? hint;
  Function(SelectModel?) validator;
  bool required;
  String? label;
  Color? backgroundColor;

  BaseSelect(
      {super.key,
      required this.list,
      required this.select,
      required this.handleSelect,
      required this.validator,
      this.hint,
      this.required = false,
      this.label,
      this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          RichText(
            text: TextSpan(
                text: label,
                style: p5.copyWith(color: blackColor),
                children: [
                  if (required)
                    TextSpan(text: " *", style: p5.copyWith(color: red_1))
                ]),
          ),
        if (label != null) const SizedBox(height: sp8),
        DropdownButtonFormField<SelectModel>(
          hint: Text(
            '$hint',
            style: p6.copyWith(color: greyColor),
          ),
          isExpanded: true,
          style: p6,
          // underline: Container(
          //   color: Color.fromARGB(0, 0, 0, 0),
          // ),
          value: select,
          decoration: InputDecoration(
            filled: backgroundColor == null ? false : true,
            fillColor: backgroundColor,
            contentPadding:
                const EdgeInsets.symmetric(vertical: sp12, horizontal: sp12),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: red_1),
              borderRadius: BorderRadius.circular(sp8),
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: borderColor_2),
                borderRadius: BorderRadius.circular(sp8)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: mainColor),
                borderRadius: BorderRadius.circular(sp8)),
            errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: red_1),
                borderRadius: BorderRadius.circular(sp8)),
          ),
          icon: const Icon(Icons.arrow_drop_down),
          elevation: 3,
          onChanged: (SelectModel? value) {
            handleSelect!(value);
          },
          validator: (value) {
            return validator(value);
          },
          items: list.map<DropdownMenuItem<SelectModel>>((item) {
            return DropdownMenuItem<SelectModel>(
              value: item,
              child: Text(
                item.label,
                style: p6.copyWith(color: blackColor),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
