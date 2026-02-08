import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loanfrontend/core/theme/app_color.dart';
import 'package:loanfrontend/core/theme/text_styles.dart';
import 'package:loanfrontend/data/models/balanchsheetmodel.dart';
import 'package:loanfrontend/module/journal/controller/journalcontroller.dart';
import 'package:loanfrontend/share/widgets/app_bar.dart';
import 'package:loanfrontend/share/widgets/balanchsheetcard.dart';
import 'package:loanfrontend/share/widgets/loading.dart';
import 'package:responsive_framework/responsive_framework.dart';

class BalanceSheetView extends GetView<Journalcontroller> {
  const BalanceSheetView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final breakpoint = ResponsiveBreakpoints.of(context);
    final isMobile = breakpoint.isMobile;
    return Scaffold(
      backgroundColor: TheColors.bgColor,
      appBar: const CustomAppBar(title: "របាយការណ៍ សមតុល្យ"),
      body: Padding(
        padding: EdgeInsets.only(
            left: isMobile ? 8 : 600,
            right: isMobile ? 8 : 600,
            top: isMobile ? 8 : 10),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomLoading(),
                  SizedBox(height: 16),
                  Text(
                    'Loading Balance Sheet...',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          final balanceSheet = controller.balanceSheetData.value;

          if (balanceSheet == null) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Center(child: Text("No Data"))],
              ),
            );
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Date Selection Card

                  SizedBox(height: 16),

                  // Main Balance Sheet Card
                  BalanceSheetCard(
                    balanceSheet: balanceSheet,
                    onViewDetails: () => _navigateToDetailedView(balanceSheet),
                    onRefresh: () {},
                  ),
                  SizedBox(height: 16),

                  // Additional Stats Card
                  if (balanceSheet.data?.totals != null)
                    _buildAdditionalStats(balanceSheet.data!.totals!, context),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildAdditionalStats(Totals totals, BuildContext context) {
    return Card(
      color: TheColors.bgColor,
      borderOnForeground: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // optional
        side: const BorderSide(
          color: TheColors.gray, // 👈 your border color
          width: 1, // optional
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'សង្ខែបរបាយការណ៍គណនេយ្យ',
              style: TextStyles.siemreap(
                context,
                fontSize: 18,
                fontweight: FontWeight.bold,
                color: TheColors.checked,
              ),
            ),
            SizedBox(height: 12),
            Divider(
              color: TheColors.gray,
              height: 0.5,
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildSummaryItem(
                    context: context,
                    label: 'ទ្រព្យ',
                    value: totals.totalAssets ?? 0,
                    color: Colors.green,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: _buildSummaryItem(
                    context: context,
                    label: 'បំណុល',
                    value: totals.totalLiabilities ?? 0,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildSummaryItem(
                    context: context,
                    label: 'ដើមទុន',
                    value: totals.totalEquity ?? 0,
                    color: Colors.purple,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: (totals.isBalanced ?? false)
                          ? Colors.green[50]
                          : Colors.red[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: (totals.isBalanced ?? false)
                            ? TheColors.green
                            : TheColors.red,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Balance Status',
                          style: TextStyle(
                            fontSize: 12,
                            color: TheColors.black,
                          ),
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(
                              (totals.isBalanced ?? false)
                                  ? Icons.check_circle
                                  : Icons.warning,
                              size: 16,
                              color: (totals.isBalanced ?? false)
                                  ? Colors.green
                                  : Colors.red,
                            ),
                            SizedBox(width: 4),
                            Text(
                              (totals.isBalanced ?? false)
                                  ? 'Balanced'
                                  : 'Unbalanced',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: (totals.isBalanced ?? false)
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (totals.difference != null && totals.difference != 0)
              Column(
                children: [
                  SizedBox(height: 12),
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.amber[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: TheColors.cutecolo),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.info_outline, color: Colors.amber[700]),
                        SizedBox(width: 8),
                        Text(
                          'Balance Difference: Rs. ${totals.difference!.abs()}',
                          style: TextStyle(
                            color: Colors.amber[800],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryItem(
      {required String label,
      required int value,
      required Color color,
      required BuildContext context}) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyles.siemreap(
              context,
              fontSize: 12,
              color: TheColors.white,
            ),
          ),
          SizedBox(height: 4),
          Text(
            '${_formatNumber(value)} ៛',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(2)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(2)}K';
    }
    return number.toString();
  }

  Future<void> _showDatePicker(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      // Format date as YYYY-MM-DD
      final formattedDate =
          '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';

      // Update selected date in controller
      controller.selectedDate.value = formattedDate;

      // Fetch balance sheet for selected date
      await controller.getBalanceSheet(endate: formattedDate);
    }
  }

  void _navigateToDetailedView(BalanchsheetModel balanceSheet) {
    Get.to(
      () => BalanceSheetDetailedView(balanceSheet: balanceSheet),
      transition: Transition.rightToLeft,
    );
  }
}

// Optional detailed view page
class BalanceSheetDetailedView extends StatelessWidget {
  final BalanchsheetModel balanceSheet;

  const BalanceSheetDetailedView({Key? key, required this.balanceSheet})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final breakpoint = ResponsiveBreakpoints.of(context);
    final isMobile = breakpoint.isMobile;
    final smallfont = isMobile ? 14.0 : 23.0;
    final data = balanceSheet.data;
    if (data == null) return Container();

    return Scaffold(
      backgroundColor: TheColors.bgColor,
      appBar: const CustomAppBar(title: "ប្រតិបិត្តការណ៍លំអិត"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          padding: EdgeInsets.only(
              left: isMobile ? 8 : 600,
              right: isMobile ? 8 : 600,
              top: isMobile ? 8 : 10),
          children: [
            Card(
              color: TheColors.bgColor,
              borderOnForeground: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20), // optional
                side: const BorderSide(
                  color: TheColors.gray, // 👈 your border color
                  width: 1, // optional
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('បាយការណ៍ សមតុល្យ',
                        style: TextStyles.siemreap(context,
                            color: TheColors.white, fontSize: smallfont)),
                    SizedBox(height: 4),
                    Text('គិតត្រឹមថ្ងៃទី ${data.reportDate ?? 'N/A'}',
                        style: TextStyles.siemreap(context,
                            color: TheColors.white)),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),

            // Assets Section
            if (data.assets != null)
              _buildDetailedSection(data.assets!, 'ទ្រព្យ', context),
            SizedBox(height: 16),

            // Liabilities Section
            if (data.liabilities != null)
              _buildDetailedLiabilities(data.liabilities!, context),
            SizedBox(height: 16),

            // Equity Section
            if (data.equity != null)
              _buildDetailedSection(data.equity!, 'ដើមទុន', context),
            SizedBox(height: 16),

            // Totals Section
            if (data.totals != null) _buildTotalsSection(data.totals!, context),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailedSection(
      Assets assets, String title, BuildContext context) {
    return Card(
      color: TheColors.bgColor,
      borderOnForeground: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // optional
        side: const BorderSide(
          color: TheColors.gray, // 👈 your border color
          width: 1, // optional
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyles.siemreap(context,
                  fontSize: 18,
                  fontweight: FontWeight.bold,
                  color: TheColors.warningColor),
            ),
            SizedBox(height: 12),
            ...assets.accounts?.map((account) => ListTile(
                      title: Text(
                        account.accountName ?? '',
                        style: TextStyles.siemreap(context,
                            color: TheColors.white),
                      ),
                      subtitle: Text(
                        account.accountCode ?? '',
                        style: TextStyles.siemreap(context,
                            color: TheColors.white),
                      ),
                      trailing: Text(
                        '${account.balance ?? 0} ៛',
                        style: TextStyles.siemreap(
                          context,
                          color: TheColors.white,
                        ),
                      ),
                      contentPadding: EdgeInsets.zero,
                    )) ??
                [],
            Divider(
              height: 0.5,
              color: TheColors.gray,
            ),
            ListTile(
              title: Text('សរុប $title',
                  style: TextStyles.siemreap(context,
                      fontweight: FontWeight.bold, color: TheColors.white)),
              trailing: Text('${assets.total ?? 0} ៛',
                  style: TextStyles.siemreap(context,
                      fontweight: FontWeight.bold, color: TheColors.green)),
              contentPadding: EdgeInsets.zero,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailedLiabilities(
      Liabilities liabilities, BuildContext context) {
    return Card(
      color: TheColors.bgColor,
      borderOnForeground: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // optional
        side: const BorderSide(
          color: TheColors.gray, // 👈 your border color
          width: 1, // optional
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'បំណុល',
              style: TextStyles.siemreap(context,
                  fontSize: 18,
                  fontweight: FontWeight.bold,
                  color: TheColors.white),
            ),
            SizedBox(height: 12),
            ListTile(
              title: Text(
                'បំណុល សរុប',
                style: TextStyles.siemreap(context, color: TheColors.white),
              ),
              trailing: Text(
                '${liabilities.total ?? 0} ៛',
                style: TextStyles.siemreap(context, color: TheColors.white),
              ),
              contentPadding: EdgeInsets.zero,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalsSection(Totals totals, BuildContext context) {
    return Card(
      color: TheColors.bgColor,
      borderOnForeground: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // optional
        side: const BorderSide(
          color: TheColors.gray, // 👈 your border color
          width: 1, // optional
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'សង្ខែប',
              style: TextStyles.siemreap(context,
                  fontSize: 18,
                  fontweight: FontWeight.bold,
                  color: TheColors.white),
            ),
            SizedBox(height: 12),
            _buildTotalRow('ទ្រព្យសរុប', totals.totalAssets ?? 0, context,
                isBold: true),
            _buildTotalRow('បំណុលសរុប', totals.totalLiabilities ?? 0, context,
                isBold: true),
            _buildTotalRow('ដេីមទុនសរុប', totals.totalEquity ?? 0, context,
                isBold: true),
            Divider(thickness: 2),
            _buildTotalRow(
              'សរុបបំណុលនិងដេីមទុន',
              totals.totalLiabilitiesEquity ?? 0,
              isBold: true,
              context,
            ),
            SizedBox(height: 12),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: (totals.isBalanced ?? false)
                    ? TheColors.bgColor
                    : TheColors.red,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    (totals.isBalanced ?? false)
                        ? Icons.check_circle
                        : Icons.error,
                    color: (totals.isBalanced ?? false)
                        ? Colors.green
                        : Colors.red,
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      (totals.isBalanced ?? false)
                          ? 'Balance Sheet is Balanced'
                          : 'Balance Sheet is not Balanced',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: (totals.isBalanced ?? false)
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                  ),
                  if (totals.difference != null && totals.difference != 0)
                    Text(
                      'Diff: Rs. ${totals.difference!.abs()}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: (totals.isBalanced ?? false)
                            ? Colors.green
                            : Colors.red,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalRow(
    String label,
    int amount,
    BuildContext context, {
    bool isBold = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: isBold
                  ? TextStyles.siemreap(context,
                      fontweight: FontWeight.bold, color: TheColors.white)
                  : null),
          Text('$amount ៛',
              style: isBold
                  ? TextStyles.siemreap(context,
                      fontweight: FontWeight.bold, color: TheColors.white)
                  : null),
        ],
      ),
    );
  }
}
