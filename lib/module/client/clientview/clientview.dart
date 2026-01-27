import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loanfrontend/core/theme/app_color.dart';
import 'package:loanfrontend/core/theme/text_styles.dart';
import 'package:loanfrontend/module/client/clientbinding/updateclientbinding.dart';
import 'package:loanfrontend/module/client/clientcontroller/clientcontroller.dart';
import 'package:loanfrontend/module/client/clientview/updateclientview.dart';
import 'package:loanfrontend/share/widgets/app_bar.dart';
import 'package:loanfrontend/share/widgets/clientcard.dart';
import 'package:loanfrontend/share/widgets/common_widgets.dart';
import 'package:loanfrontend/share/widgets/floating_buttom.dart';
import 'package:loanfrontend/share/widgets/loading.dart';
import 'package:loanfrontend/share/widgets/textfield.dart';

class Clientview extends StatefulWidget {
  const Clientview({super.key});

  @override
  State<Clientview> createState() => _ClientviewState();
}

class _ClientviewState extends State<Clientview> {
  final clientcontroller = Get.find<ClientController>();
  final TextEditingController searchQuery = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // var isLoading = false.obs;
  // var isLoadingMore = false.obs;
  void _onScroll() {
    if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        clientcontroller.hasMore.value &&
        !clientcontroller.isLoadingMore.value &&
        !clientcontroller.isLoading.value) {
      _loadMore();
    }
  }

  Future<void> _loadMore() async {
    await clientcontroller.loadMore();
  }

  Future<void> refresh() async {
    searchQuery.clear();
    clientcontroller.searchQuery.value = '';
    await clientcontroller.listclient(isRefresh: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TheColors.bgColor,
      appBar: CustomAppBar(title: "បញ្ជីអតិថិជន"),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () {
          Get.toNamed('/createclient');
        },
      ),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: Obx(() {
          if (clientcontroller.isLoading.value &&
              clientcontroller.client.isEmpty) {
            return const Center(child: CustomLoading());
          }
          return CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          children: [
                            Expanded(
                              child: SizedBox(
                                height: 55,
                                child: CustomTextField(
                                  controller: searchQuery,
                                  hintText: "ស្វែងរក".tr,
                                  prefixIcon: Icons.search,
                                  onChanged: (value) {
                                    clientcontroller.searchQuery.value = value;
                                  },
                                ),
                              ),
                            ),
                            CommonWidgets.SizeBoxwidh5,
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: InkWell(
                                onTap: () {
                                  refresh();
                                },
                                child: const Icon(
                                  Icons.refresh_outlined,
                                  color: TheColors.warningColor,
                                  size: 35,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      CommonWidgets.SizeBox8,
                    ],
                  ),
                ),
              ),
              if (clientcontroller.client.isEmpty &&
                  !clientcontroller.isLoading.value)
                SliverFillRemaining(
                  child: Center(
                    child: Text(
                      'អត់ទាន់មានទិន្ន័យ',
                      style: TextStyles.kantomruy(context, fontSize: 12),
                    ),
                  ),
                ),
              if (clientcontroller.client.isNotEmpty)
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final client = clientcontroller.client[index];
                      return Padding(
                        padding: const EdgeInsets.only(right: 10, left: 10),
                        child: Clientcard(
                          name: client.name ?? '',
                          gender: client.gender ?? 0,
                          maritalStatus: client.maritalStatus ?? '',
                          dateOfBirth: client.dateOfBirth ?? '',
                          occupation: client.occupation ?? '',
                          idCardNumber: client.idCardNumber ?? '',
                          phone: client.phone ?? '',
                          latitude: client.latitude ?? 0.0,
                          longitude: client.longitude ?? 0.0,
                          imagePath: client.imagePath ?? '',
                          notes: client.notes ?? '',
                          isActive: client.isActive ?? false,
                          createdBy: client.createdBy ?? 0,
                          createByName: client.createByName ?? '',
                          provinceId: client.provinceId ?? 0,
                          provinceName: client.provinceName ?? '',
                          districtId: client.districtId ?? 0,
                          districtName: client.districtName ?? '',
                          communceId: client.communceId ?? 0,
                          communceName: client.communceName ?? '',
                          villageId: client.villageId ?? 0,
                          villageName: client.villageName ?? '',
                          onEdit: () {
                            Get.to(
                              () => Updateclientview(clientmodel: client),
                              transition: Transition.rightToLeft,
                              binding: Updateclientbinding(),
                            );
                          },
                          onDelete: () {},
                          onTap: () {
                            Get.to(
                              () => Updateclientview(clientmodel: client),
                              transition: Transition.rightToLeft,
                              binding: Updateclientbinding(),
                            );
                          },
                        ),
                      );
                    },
                    childCount: clientcontroller.client.length,
                  ),
                ),
              if (clientcontroller.isLoadingMore.value)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: CustomLoading(),
                    ),
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }
}
