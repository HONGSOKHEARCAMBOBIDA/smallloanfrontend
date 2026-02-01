import 'package:flutter/material.dart';
import 'package:loanfrontend/core/theme/app_color.dart';
import 'package:loanfrontend/core/theme/text_styles.dart';
import 'package:loanfrontend/share/widgets/app_bar.dart';
import 'package:get/get.dart';
import 'package:loanfrontend/share/widgets/common_widgets.dart';

class Loan extends StatelessWidget {
  const Loan({super.key});
  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    return Scaffold(
      backgroundColor: TheColors.bgColor,
      appBar: const CustomAppBar(title: "គ្រប់គ្រងប្រាក់កម្ចី"),
      drawer: isMobile ? _buildDrawer() : null,
      body: isMobile ? _buildBody(context) : _buildWebLayout(context),
    );
  }

  Widget _buildWebLayout(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 200,
          color: TheColors.bgColor,
          child: _buildDrawer(permanent: true),
        ),
        const VerticalDivider(width: 0.5),
        Expanded(child: _buildBody(context)),
      ],
    );
  }

  Widget _buildDrawer({bool permanent = false}) {
    return Drawer(
      elevation: permanent ? 0 : 12,
      backgroundColor: TheColors.bgColor,
      child: Column(
        children: [
          Container(
            height: 60,
            color: permanent ? TheColors.bgColor : TheColors.bgColor,
            child: Center(
              child: Builder(
                builder: (context) => Text(
                  'ផ្នែកកម្ចី',
                  style: TextStyles.moul(
                    context,
                    fontSize: CommonWidgets.fontsize20,
                    color: permanent
                        ? TheColors.errorColor
                        : TheColors.warningColor,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem(Icons.dashboard, "សង្ខែបទិន្ន័យ", () {}),
                _buildDrawerItem(Icons.group, "អតិថិជន", () {
                  Get.toNamed('/listclient');
                }),
                _buildDrawerItem(Icons.add_circle_outline, "ស្នើកម្ចី", () {
                  Get.toNamed('/creatloan');
                }),
                _buildDrawerItem(Icons.task_alt, "កម្ចីត្រូវត្រួតពិនិត្យ", () {
                  Get.toNamed('/checkloan');
                }),
                _buildDrawerItem(Icons.verified, "កម្ចីត្រូវអនុម័ត", () {}),
                _buildDrawerItem(Icons.list_alt, "បញ្ជីកម្ចីទាំងអស់", () {}),
                _buildDrawerItem(
                    Icons.request_quote, "បញ្ជីកម្ចីត្រូវប្រមូល", () {}),
                _buildDrawerItem(Icons.attach_money, "លទ្ធផលប្រមូលបាន", () {}),
                _buildDrawerItem(
                    Icons.account_balance_wallet, "ផ្ទៀងលុយ", () {}),
                _buildDrawerItem(Icons.settings, "ការកំណត់", () {}),
              ],
            ),
          ),
          // Logout button at bottom
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildDrawerItem(Icons.logout, "ចាកចេញ", () {},
                color: Colors.red),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap,
      {Color? color}) {
    return Builder(
      builder: (context) => ListTile(
        leading: Icon(icon, color: color ?? TheColors.errorColor),
        title: Text(
          title,
          style: TextStyles.kantomruy(
            context,
            fontSize: CommonWidgets.fontsize15,
            color: color ?? TheColors.white,
          ),
        ),
        onTap: onTap,
        hoverColor: TheColors.errorColor.withOpacity(0.1),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Center(
      child: Text(
        '',
        style: TextStyles.siemreap(
          context,
          fontSize: 18,
          fontweight: FontWeight.bold,
        ),
      ),
    );
  }
}
