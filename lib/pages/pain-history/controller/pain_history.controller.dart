// pages/pain-history/controller/pain_history.controller.dart
import 'package:flutter/material.dart';
import 'package:trabalho_cuidador/providers/api_client.dart';
import 'package:trabalho_cuidador/services/pain_service.dart';

class PainHistoryController extends ChangeNotifier {
  bool _isLoading = true;
  bool _hasError = false;
  bool _hasData = true;
  String? _chartBase64;
  DateTime _startDate = DateTime.now().subtract(const Duration(days: 30));
  DateTime _endDate = DateTime.now();
  double _averageBefore = 0.0;
  double _averageAfter = 0.0;

  bool get isLoading => _isLoading;
  bool get hasError => _hasError;
  bool get hasData => _hasData;
  String? get chartBase64 => _chartBase64;
  DateTime get startDate => _startDate;
  DateTime get endDate => _endDate;
  double get averageBefore => _averageBefore;
  double get averageAfter => _averageAfter;

  String get dateRangeText {
    final startFormatted =
        '${_startDate.day.toString().padLeft(2, '0')}/${_startDate.month.toString().padLeft(2, '0')}/${_startDate.year}';
    final endFormatted =
        '${_endDate.day.toString().padLeft(2, '0')}/${_endDate.month.toString().padLeft(2, '0')}/${_endDate.year}';
    return '$startFormatted - $endFormatted';
  }

  Future<void> loadPainHistory() async {
    _isLoading = true;
    _hasError = false;
    _hasData = true;
    notifyListeners();

    try {
      // Busca o gráfico com base no período
      _chartBase64 = await PainService.getBase64GraphImage(
        endDate: endDate.toIso8601String().split('T').first,
        startDate: startDate.toIso8601String().split('T').first,
      );

      // Simula médias - você pode ajustar para vir da API
      _averageBefore = 5.0;
      _averageAfter = 4.2;

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      if (e is ApiException && e.statusCode == 404) {
        _hasData = false;
      } else {
        _hasError = true;
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> setDateRange(DateTime start, DateTime end) async {
    _startDate = start;
    _endDate = end;
    notifyListeners();
    await loadPainHistory();
  }

  Future<void> showDatePicker(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDateRange: DateTimeRange(start: _startDate, end: _endDate),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).colorScheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      await setDateRange(picked.start, picked.end);
    }
  }
}
