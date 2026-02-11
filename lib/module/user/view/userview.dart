import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loanfrontend/data/models/usermodel.dart';
import 'package:loanfrontend/module/user/binding/updateuserbinding.dart';
import 'package:loanfrontend/module/user/controller/usercontroller.dart';
import 'package:loanfrontend/module/user/view/updateuserview.dart';
import 'package:loanfrontend/share/widgets/textfield.dart';
import 'package:loanfrontend/share/widgets/usercard.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:loanfrontend/core/theme/app_color.dart';
import 'package:loanfrontend/core/theme/text_styles.dart';
import 'package:loanfrontend/share/widgets/app_bar.dart';
import 'package:loanfrontend/share/widgets/floating_buttom.dart';
import 'package:loanfrontend/share/widgets/loading.dart';

class Userview extends StatefulWidget {
  const Userview({super.key});

  @override
  State<Userview> createState() => _UserviewState();
}

class _UserviewState extends State<Userview> {
  final Usercontroller usercontroller = Get.find<Usercontroller>();
  final ScrollController _scrollController = ScrollController();

  // Add search functionality
  final TextEditingController _searchController = TextEditingController();
  final RxString _searchQuery = ''.obs;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      _searchQuery.value = _searchController.text;
    });

    // Optional: Load data on init
    WidgetsBinding.instance.addPostFrameCallback((_) {
      usercontroller.getuser();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  List<Data> get _filteredUsers {
    if (_searchQuery.isEmpty) return usercontroller.data;

    return usercontroller.data.where((user) {
      return (user.name?.toLowerCase().contains(_searchQuery.toLowerCase()) ??
              false) ||
          (user.username?.toLowerCase().contains(_searchQuery.toLowerCase()) ??
              false) ||
          (user.email?.toLowerCase().contains(_searchQuery.toLowerCase()) ??
              false) ||
          (user.phone?.toLowerCase().contains(_searchQuery.toLowerCase()) ??
              false) ||
          (user.roleName?.toLowerCase().contains(_searchQuery.toLowerCase()) ??
              false);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final breakpoints = ResponsiveBreakpoints.of(context);
    final bool isMobile = breakpoints.isMobile;
    final bool isTablet = breakpoints.isTablet;
    final bool isDesktop = breakpoints.isDesktop;

    // Grid columns: mobile = 1, tablet = 2, desktop = 3
    final int gridCount = isDesktop ? 3 : (isTablet ? 2 : 1);

    // Adjust aspect ratio based on screen size
    final double childAspectRatio = isDesktop ? 1.7 : (isTablet ? 1.0 : 1.2);

    final EdgeInsetsGeometry pagePadding =
        EdgeInsets.symmetric(horizontal: isMobile ? 12 : 16, vertical: 8);

    return Scaffold(
      backgroundColor: TheColors.bgColor,
      appBar: CustomAppBar(
        title: "បញ្ជីអ្នកប្រើប្រាស់", // Changed to "User List" in Khmer
      ),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () {
          Get.toNamed('/createuser'); // Make sure this route exists
        },
      ),
      body: RefreshIndicator(
        backgroundColor: TheColors.bgColor,
        color: TheColors.primaryColor,
        onRefresh: () async {
          await usercontroller.getuser();
        },
        child: Obx(() {
          if (usercontroller.isLoading.value && usercontroller.data.isEmpty) {
            return const Center(child: CustomLoading());
          }

          return Column(
            children: [
              // Search bar for tablet/desktop
              if (!isMobile)
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: isMobile ? 12 : 20,
                    vertical: 12,
                  ),
                  child: _buildSearchBar(),
                ),

              // User statistics
              if (!isMobile && usercontroller.data.isNotEmpty)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: isMobile ? 12 : 20),
                  child: _buildUserStats(),
                ),

              Expanded(
                child: CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    // Search bar for mobile (inside scroll view)
                    if (isMobile)
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          child: _buildSearchBar(),
                        ),
                      ),

                    // User statistics for mobile
                    if (isMobile && usercontroller.data.isNotEmpty)
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: _buildUserStats(),
                        ),
                      ),

                    // Empty state
                    if (_filteredUsers.isEmpty &&
                        !usercontroller.isLoading.value)
                      SliverFillRemaining(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.people_outline,
                                size: 60,
                                color: TheColors.gray.withOpacity(0.5),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'អត់ទាន់មានទិន្ន័យ',
                                style: TextStyles.kantomruy(
                                  context,
                                  fontSize: 16,
                                  color: TheColors.gray,
                                ),
                              ),
                              if (_searchQuery.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Text(
                                    'រកមិនឃើញលទ្ធផលសម្រាប់ "${_searchQuery.value}"',
                                    style: TextStyles.kantomruy(
                                      context,
                                      fontSize: 14,
                                      color: TheColors.gray,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),

                    // List or Grid of users
                    if (_filteredUsers.isNotEmpty)
                      if (gridCount == 1)
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final data = _filteredUsers[index];
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: isMobile ? 12 : 16,
                                  vertical: 8,
                                ),
                                child: UserCard(
                                  user: data,
                                  onTap: () {
                                    Get.to(
                                        () => Updateuserview(usermodel: data),
                                        transition: Transition.rightToLeft,
                                        binding: Updateuserbinding());
                                  },
                                  onEdit: () {
                                    Get.to(
                                        () => Updateuserview(usermodel: data),
                                        transition: Transition.rightToLeft,
                                        binding: Updateuserbinding());
                                  },
                                  onDelete: () {
                                    _showDeleteConfirmation(context, data);
                                  },
                                ),
                              );
                            },
                            childCount: _filteredUsers.length,
                          ),
                        )
                      else
                        SliverPadding(
                          padding: pagePadding,
                          sliver: SliverGrid(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                final data = _filteredUsers[index];
                                return UserCard(
                                  user: data,
                                  onTap: () {
                                    Get.to(
                                        () => Updateuserview(usermodel: data),
                                        transition: Transition.rightToLeft,
                                        binding: Updateuserbinding());
                                  },
                                  onEdit: () {
                                    Get.to(
                                        () => Updateuserview(usermodel: data),
                                        transition: Transition.rightToLeft,
                                        binding: Updateuserbinding());
                                  },
                                  onDelete: () {
                                    _showDeleteConfirmation(context, data);
                                  },
                                );
                              },
                              childCount: _filteredUsers.length,
                            ),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: gridCount,
                              mainAxisSpacing: 16,
                              crossAxisSpacing: 16,
                              childAspectRatio: childAspectRatio,
                            ),
                          ),
                        ),

                    // Loading more indicator
                    if (usercontroller.isLoading.value &&
                        usercontroller.data.isNotEmpty)
                      const SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Center(child: CustomLoading()),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
        decoration: BoxDecoration(
          color: TheColors.bgColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: CustomTextField(
          controller: _searchController,
          hintText: "search...",
          prefixIcon: Icons.search,
        ));
  }

  Widget _buildUserStats() {
    final activeUsers =
        usercontroller.data.where((user) => user.isActive == true).length;
    final totalUsers = usercontroller.data.length;

    return Row(
      children: [
        _buildStatCard(
          title: 'សរុប',
          value: totalUsers.toString(),
          icon: Icons.people_outline,
          color: TheColors.primaryColor,
        ),
        const SizedBox(width: 12),
        _buildStatCard(
          title: 'សកម្ម',
          value: activeUsers.toString(),
          icon: Icons.check_circle_outline,
          color: TheColors.green,
        ),
        const SizedBox(width: 12),
        _buildStatCard(
          title: 'អសកម្ម',
          value: (totalUsers - activeUsers).toString(),
          icon: Icons.remove_circle_outline,
          color: TheColors.warningColor,
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: TheColors.checked, width: 0.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Icon(icon, size: 20, color: color),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: TheColors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  title,
                  style: TextStyles.siemreap(
                    context,
                    fontSize: 12,
                    color: TheColors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, Data user) {
    final bool isActive = user.isActive == true;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          isActive ? 'លុបអ្នកប្រើប្រាស់' : 'បើកអ្នកប្រើប្រាស់វិញ',
          style: TextStyles.siemreap(context, color: TheColors.black),
        ),
        content: Text(
          isActive
              ? 'តើអ្នកប្រាកដថាចង់លុបអ្នកប្រើប្រាស់ "${user.name}"?'
              : 'តើអ្នកប្រាកដថាចង់បើកអ្នកប្រើប្រាស់ "${user.name}" វិញ?',
          style: TextStyles.siemreap(context, color: TheColors.black),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'បោះបង់',
              style: TextStyles.siemreap(
                context,
                color: TheColors.gray,
              ),
            ),
          ),
          Obx(() {
            return ElevatedButton(
              onPressed: usercontroller.isLoading.value
                  ? null
                  : () async {
                      await usercontroller.changestatususer(id: user.id!);
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: isActive ? TheColors.errorColor : Colors.green,
              ),
              child: Text(
                usercontroller.isLoading.value
                    ? (isActive ? "កំពុងលុប" : "កំពុងបើក")
                    : (isActive ? "លុប" : "បើក"),
                style: TextStyles.siemreap(context, color: Colors.white),
              ),
            );
          }),
        ],
      ),
    );
  }
}

// Search delegate for better mobile search experience
