import 'package:flutter/material.dart';
import 'package:loanfrontend/core/theme/app_color.dart';
import 'package:loanfrontend/core/theme/text_styles.dart';
import 'package:loanfrontend/data/models/balanchsheetmodel.dart';
import 'package:loanfrontend/share/widgets/elevated_button.dart';

class BalanceSheetCard extends StatelessWidget {
  final BalanchsheetModel balanceSheet;
  final VoidCallback? onViewDetails;
  final VoidCallback? onRefresh;
  final VoidCallback? onTap;

  const BalanceSheetCard({
    Key? key,
    required this.balanceSheet,
    this.onViewDetails,
    this.onRefresh,
    this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = balanceSheet.data;
    if (data == null) return SizedBox();

    return Card(
      borderOnForeground: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20), // optional
        side: const BorderSide(
          color: TheColors.gray, // 👈 your border color
          width: 1, // optional
        ),
      ),
      color: TheColors.bgColor,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with title and date
            _buildHeader(data, context),
            SizedBox(height: 16),

            // Quick stats in row
            _buildQuickStats(data.totals, context),
            SizedBox(height: 16),

            // Asset/Liability/Equity breakdown
            _buildBreakdown(data, context),
            SizedBox(height: 20),

            // Balance status indicator
            _buildBalanceStatus(data.totals),
            SizedBox(height: 20),

            // Action buttons
            if (onViewDetails != null || onRefresh != null)
              _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(Data data, BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "សមតុល្យ",
                    style: TextStyles.siemreap(
                      context,
                      fontSize: 20,
                      color: TheColors.checked,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'គិតត្រឹម ៖ ${data.reportDate ?? 'N/A'}',
                    style: TextStyles.siemreap(
                      context,
                      fontSize: 14,
                      color: TheColors.white,
                    ),
                  ),
                  SizedBox(height: 10,),
                InkWell(
  onTap: onTap,
  child: const Icon(
    Icons.date_range_outlined,
    color: TheColors.checked,
    size: 28,
  ),
)

                ],
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: TheColors.warningColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            'របាយការណ៍គណនេយ្យ',
            style: TextStyles.siemreap(
              context,
              fontSize: 12,
              fontweight: FontWeight.w500,
              color: TheColors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickStats(Totals? totals, BuildContext context) {
    if (totals == null) return SizedBox();

    return Column(
      children: [
        // Total Assets
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                context: context,
                title: 'ទ្រព្យ',
                amount: totals.totalAssets ?? 0,
                color: TheColors.green,
                icon: Icons.account_balance_wallet,
              ),
            ),
            SizedBox(width: 8),

            // Total Liabilities
            Expanded(
              child: _buildStatCard(
                context: context,
                title: 'បំណុល',
                amount: totals.totalLiabilities ?? 0,
                color: TheColors.warningColor,
                icon: Icons.money_off,
              ),
            ),
          ],
        ),

        SizedBox(height: 12),

        // Total Equity
        _buildStatCard(
          context: context,
          title: 'ដើមទុន',
          amount: totals.totalEquity ?? 0,
          color: TheColors.cutecolo,
          icon: Icons.business,
        ),
      ],
    );
  }

  Widget _buildStatCard(
      {required String title,
      required int amount,
      required Color color,
      required IconData icon,
      required BuildContext context}) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3), width: 1),
      ),
      child: Column(
        children: [
          Center(
            child: Text(
              title,
              style: TextStyles.siemreap(
                context,
                fontSize: 15,
                fontweight: FontWeight.w500,
                color: color,
              ),
            ),
          ),
          SizedBox(height: 8),
          Center(
            child: Text(
              '${(amount)} ៛',
              style: TextStyles.siemreap(
                context,
                fontSize: 14,
                fontweight: FontWeight.bold,
                color: TheColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBreakdown(Data data, BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: TheColors.bgColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: TheColors.gray, width: 0.5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Breakdown',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: TheColors.white,
            ),
          ),
          SizedBox(height: 12),

          // Assets Breakdown
          if (data.assets?.accounts != null &&
              data.assets!.accounts!.isNotEmpty)
            _buildAccountList(
              context: context,
              title: 'ទ្រព្យ',
              accounts: data.assets!.accounts!,
              total: data.assets!.total ?? 0,
              color: Colors.green,
            ),

          // Liabilities (if accounts exist)
          if (data.liabilities != null && data.liabilities!.total != null)
            _buildSimpleItem(
              context: context,
              title: 'បំណុល',
              amount: data.liabilities!.total!,
              color: Colors.white,
            ),

          // Equity Breakdown
          if (data.equity?.accounts != null &&
              data.equity!.accounts!.isNotEmpty)
            _buildAccountList(
              context: context,
              title: 'ដើមទុន',
              accounts: data.equity!.accounts!,
              total: data.equity!.total ?? 0,
              color: Colors.purple,
            ),
        ],
      ),
    );
  }

  Widget _buildAccountList(
      {required String title,
      required List<Accounts> accounts,
      required int total,
      required Color color,
      required BuildContext context}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyles.siemreap(
                context,
                fontweight: FontWeight.w600,
                color: TheColors.white,
              ),
            ),
            Text(
              '${(total)} ៛',
              style: TextStyles.siemreap(
                context,
                fontweight: FontWeight.w600,
                color: TheColors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        ...accounts
            .take(3)
            .map((account) => _buildAccountItem(account, context))
            .toList(),
        if (accounts.length > 3)
          Text(
            '+ ${accounts.length - 3} more accounts',
            style: TextStyle(
              fontSize: 12,
              color: TheColors.white,
              fontStyle: FontStyle.italic,
            ),
          ),
        SizedBox(height: 12),
      ],
    );
  }

  Widget _buildSimpleItem(
      {required String title,
      required int amount,
      required Color color,
      required BuildContext context}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
            Text(
              '${(amount)} ៛',
              style: TextStyles.siemreap(
                context,
                fontweight: FontWeight.w600,
                color: TheColors.white,
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
      ],
    );
  }

  Widget _buildAccountItem(Accounts account, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  account.accountName ?? 'N/A',
                  style: TextStyles.siemreap(context,
                      fontSize: 13, color: TheColors.white),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  account.accountCode ?? '',
                  style: TextStyles.siemreap(
                    context,
                    fontSize: 11,
                    color: TheColors.white,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8),
          Text(
            '${(account.balance ?? 0)} ៛',
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: TheColors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceStatus(Totals? totals) {
    if (totals == null || totals.isBalanced == null) return SizedBox();

    final isBalanced = totals.isBalanced!;
    final difference = totals.difference ?? 0;

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isBalanced ? TheColors.bgColor : TheColors.red,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isBalanced ? TheColors.green : TheColors.red,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            isBalanced ? Icons.check_circle : Icons.warning,
            color: isBalanced ? Colors.green : Colors.red,
            size: 24,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isBalanced ? 'Perfectly Balanced' : 'Out of Balance',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isBalanced ? Colors.green[800] : Colors.red[800],
                  ),
                ),
                if (!isBalanced)
                  Text(
                    'Difference: Rs. ${(difference.abs())}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
              ],
            ),
          ),
          if (!isBalanced)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.red[100],
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'Needs Review',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: Colors.red[800],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        if (onViewDetails != null)
          Expanded(
            child: CustomElevatedButton(
              onPressed: onViewDetails,
              text: "មេីលលំអិត",
            ),
          ),
      ],
    );
  }

  // String _formatNumber(int number) {
  //   if (number >= 1000000) {
  //     return '${(number / 1000000).toStringAsFixed(2)}M';
  //   } else if (number >= 1000) {
  //     return '${(number / 1000).toStringAsFixed(2)}K';
  //   }
  //   return number.toString();
  // }
}
