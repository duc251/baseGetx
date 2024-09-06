import 'package:base_lhe/base_lhe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lhe_ctv/features/customer_manager/widgets/avatar_border.dart';
import 'package:lhe_ctv/features/customer_manager/widgets/customer_infor/customer_infor_page.dart';

import '../../../common/widgets/debouncer.dart';
import '../../common/base/base_loading.dart';
import '../../common/constants/app_typography.dart';
import '../../common/widgets/base_textfield.dart';
import '../../common/widgets/categories_empty.dart';
import '../../data/models/customer_model/customer_model.dart';
import 'data/Customer_controller.dart';

class CustomerManager extends StatefulWidget {
  const CustomerManager({Key? key}) : super(key: key);

  @override
  State<CustomerManager> createState() => _CustomerManagerState();
}

class _CustomerManagerState extends State<CustomerManager> {
  late FocusNode _focusNode;
  late ScrollController _scrollController;
  late InfiniteListController<CustomerModel> _infiniteListController;
  late Debouncer _debouncer;
  final controller = Get.put(CustomerController());
  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _debouncer = Debouncer();
    _infiniteListController = InfiniteListController.init();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      appBar: const CustomAppBar(
        hasBack: true,
        title: "Quản lý khách hàng",
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: sp16),
        child: RefreshIndicator(
          onRefresh: () async {
            _infiniteListController.onRefresh();
          },
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: sp24),
                ValidateTextField(
                  focusNode: _focusNode,
                  backgroundColor: whiteColor,
                  onClear: () {
                    controller.search = '';
                    _infiniteListController.onRefresh();
                  },
                  hintText: "Tìm kiếm khách hàng".tr,
                  hintStyle: p6.copyWith(color: greyColor),
                  emptySuffixIcon:
                      const Icon(Icons.search, color: greyColor, size: sp20),
                  onChanged: (value) {
                    controller.search = value;
                    _debouncer.run(() {
                      _infiniteListController.onRefresh();
                    });
                  },
                ),
                const SizedBox(height: 24),
                InfiniteList<CustomerModel>(
                  scrollController: _scrollController,
                  infiniteListController: _infiniteListController,
                  shrinkWrap: true,
                  circularProgressIndicator: const BaseLoading(),
                  noItemFoundWidget: CategoriesEmpty(
                    title: "Không tìm thấy khách hàng nào!".tr,
                  ),
                  itemBuilder: (context, item, index) {
                    return CustomerItemRow(
                      infiniteListController: _infiniteListController,
                      customerModel: item,
                      onDelete: () {
                        controller.deleteCustomer(
                            item.id!, _infiniteListController);
                      },
                    );
                  },
                  getData: (page) {
                    return controller.fetchAllCustomer(page + 1);
                  },
                ),
                const SizedBox(
                  height: 120,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomerItemRow extends StatelessWidget {
  const CustomerItemRow({
    super.key,
    required this.customerModel,
    required this.onDelete,
    required this.infiniteListController,
  });
  final CustomerModel customerModel;
  final VoidCallback onDelete;
  final InfiniteListController infiniteListController;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => CustomerInforPage(
              infiniteListController: infiniteListController,
              customerModel: customerModel,
              ondelete: onDelete,
            ));
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(sp8),
          color: whiteColor,
        ),
        child: Row(
          children: [
            AvatarBorder(
              pathAvatar: customerModel.getProfileValue(),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    customerModel.fullname ?? "Nguyễn Văn C",
                    style: AppTypography.p4,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset("assets/icons/ic_phone2.svg"),
                      Text(
                        " ${customerModel.username}",
                        style: AppTypography.p4.copyWith(color: greyColor),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            InkWell(
                onTap: onDelete,
                child: SvgPicture.asset("assets/icons/ic_trash.svg")),
          ],
        ),
      ),
    );
  }
}
