import 'package:excel/excel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_filex/open_filex.dart';
import 'dart:io';
import '../constants/app_constants.dart';

class ExcelGenerator {
  static Future<void> generateFinancialReportExcel({
    required String fileName,
    required Map<String, dynamic> data,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final excel = Excel.createExcel();
    excel.delete('Sheet1');
    final sheet = excel['Laporan Keuangan'];

    // Header
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0)).value =
        AppConstants.appName;
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 1)).value =
        'Periode: ${_formatDate(startDate)} - ${_formatDate(endDate)}';
    
    // Empty row
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 2)).value = '';

    // Data headers
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 3)).value = 'Keterangan';
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 3)).value = 'Jumlah';

    // Data rows
    int rowIndex = 4;
    data.forEach((key, value) {
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: rowIndex)).value = key;
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: rowIndex)).value =
          value.toString();
      rowIndex++;
    });

    // Save file
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/$fileName.xlsx';
    final file = File(filePath);
    await file.writeAsBytes(excel.encode()!);

    // Open file
    await OpenFilex.open(filePath);
  }

  static Future<void> generateInvoiceExcel({
    required String fileName,
    required String invoiceId,
    required String customerName,
    required List<Map<String, dynamic>> items,
    required double total,
    required DateTime date,
  }) async {
    final excel = Excel.createExcel();
    excel.delete('Sheet1');
    final sheet = excel['Invoice'];

    // Header
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0)).value =
        AppConstants.appName;
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 1)).value =
        'Invoice No: $invoiceId';
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 2)).value =
        'Tanggal: ${_formatDate(date)}';
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 3)).value =
        'Kepada: $customerName';

    // Empty row
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 4)).value = '';

    // Table headers
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 5)).value = 'Item';
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 5)).value = 'Qty';
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 5)).value = 'Harga';
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 5)).value = 'Total';

    // Table rows
    int rowIndex = 6;
    for (var item in items) {
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: rowIndex)).value =
          item['name'] ?? '';
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: rowIndex)).value =
          item['quantity'] ?? 0;
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: rowIndex)).value =
          item['price'] ?? 0.0;
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: rowIndex)).value =
          item['total'] ?? 0.0;
      rowIndex++;
    }

    // Total
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: rowIndex)).value = 'Total:';
    sheet.cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: rowIndex)).value = total;

    // Save file
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/$fileName.xlsx';
    final file = File(filePath);
    await file.writeAsBytes(excel.encode()!);

    // Open file
    await OpenFilex.open(filePath);
  }

  static String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
