import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';
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
    clientcontroller.listclient();
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    searchQuery.dispose();
    super.dispose();
  }

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
    final breakpoints = ResponsiveBreakpoints.of(context);
    final bool isMobile = breakpoints.isMobile;
    final bool isTablet = breakpoints.isTablet;
    final bool isDesktop = breakpoints.isDesktop;

    // grid columns: mobile = 1, tablet = 2, desktop = 3
    final int gridCount = isDesktop ? 3 : (isTablet ? 2 : 1);

    final double searchHeight = isMobile ? 50 : (isTablet ? 56 : 64);
    final double refreshIconSize = isMobile ? 30 : (isTablet ? 34 : 38);
    final EdgeInsetsGeometry pagePadding =
        EdgeInsets.symmetric(horizontal: isMobile ? 8 : 12, vertical: 8);

    return Scaffold(
      backgroundColor: TheColors.bgColor,
      appBar: const CustomAppBar(title: "បញ្ជីអតិថិជន"),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () {
          Get.toNamed('/createclient');
        },
      ),
      body: RefreshIndicator(
        backgroundColor: TheColors.cutecolo,
        color: TheColors.warningColor,
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
                  padding: pagePadding,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: 8, right: 8, top: isMobile ? 0 : 30),
                        child: Row(
                          children: [
                            isMobile
                                ? Expanded(
                                    child: SizedBox(
                                      height: searchHeight,
                                      child: CustomTextField(
                                        controller: searchQuery,
                                        hintText: "ស្វែងរក".tr,
                                        prefixIcon: Icons.search,
                                        onChanged: (value) {
                                          clientcontroller.searchQuery.value =
                                              value;
                                        },
                                      ),
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: SizedBox(
                                      width: 500,
                                      height: searchHeight,
                                      child: CustomTextField(
                                        controller: searchQuery,
                                        hintText: "ស្វែងរក".tr,
                                        prefixIcon: Icons.search,
                                        onChanged: (value) {
                                          clientcontroller.searchQuery.value =
                                              value;
                                        },
                                      ),
                                    ),
                                  ),
                            CommonWidgets.SizeBoxwidh5,
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 8, bottom: isMobile ? 0.0 : 10),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: TheColors.cutecolo,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: InkWell(
                                    onTap: () {
                                      refresh();
                                    },
                                    child: Icon(
                                      Icons.refresh_outlined,
                                      color: TheColors.white,
                                      size: refreshIconSize,
                                    ),
                                  ),
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

              // Empty state
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

              // List or Grid of clients
              if (clientcontroller.client.isNotEmpty)
                if (gridCount == 1)
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final client = clientcontroller.client[index];
                        return Padding(
                          padding: const EdgeInsets.only(
                              right: 10, left: 10, bottom: 8),
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
                  )
                else
                  SliverPadding(
                    padding: pagePadding,
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final client = clientcontroller.client[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
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
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: gridCount,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        childAspectRatio: isDesktop ? 3.2 : 2.6,
                      ),
                    ),
                  ),

              // Loading more indicator
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
