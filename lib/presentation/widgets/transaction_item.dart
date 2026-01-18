import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/format_utils.dart';

class TransactionItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final double amount;
  final IconData icon;

  const TransactionItem({
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: AppColors.secondary.withValues(alpha: 0.1),
          child: Icon(
            icon,
            color: AppColors.secondary,
          ),
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: Text(
          FormatUtils.formatCurrency(amount),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: AppColors.success,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
