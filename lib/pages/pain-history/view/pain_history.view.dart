// pages/pain-history/view/pain_history.view.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:trabalho_cuidador/core/app_theme.dart';
import 'package:trabalho_cuidador/pages/error-generic/view/error_generic.view.dart';
import 'package:trabalho_cuidador/pages/home/components/empty_pain_card.dart';
import 'package:trabalho_cuidador/utils/modal.dart';
import '../controller/pain_history.controller.dart';
import '../components/average_card.dart';
import '../components/filter_button.dart';

class PainHistoryView extends StatefulWidget {
  const PainHistoryView({super.key});

  @override
  State<PainHistoryView> createState() => _PainHistoryViewState();
}

class _PainHistoryViewState extends State<PainHistoryView> {
  final _controller = PainHistoryController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onControllerChange);
    _loadData();
  }

  void _onControllerChange() {
    if (_controller.hasError && mounted) {
      Modal.redirectModal(
        context,
        ErrorGenericView(
          onRetry: () {
            Navigator.pop(context);
            _loadData();
          },
          onGoHome: () {
            Navigator.popUntil(context, (route) => route.isFirst);
          },
        ),
      );
    }
  }

  Future<void> _loadData() async {
    await _controller.loadPainHistory();
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerChange);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.background,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        actionsPadding: const EdgeInsets.all(8),
        actions: [
          IconButton(
            icon: Icon(
              Icons.close,
              color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
        title: const Text(
          'Histórico de Dor',
          style: TextStyle(
            color: AppTheme.textDark,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          if (_controller.isLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
            );
          }

          if (!_controller.hasData) {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        const EmptyPainCard(),
                        const SizedBox(height: 24),
                        Text(
                          'Período',
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 12),
                        GestureDetector(
                          onTap: () => _controller.showDatePicker(context),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey[300]!),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  size: 20,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    _controller.dateRangeText,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  color: Colors.grey[600],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SafeArea(
                  minimum: const EdgeInsets.all(24),
                  child: FilterButton(
                    onPressed: () => _controller.loadPainHistory(),
                    isLoading: _controller.isLoading,
                  ),
                ),
              ],
            );
          }

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: AverageCard(
                              label: 'Média Antes',
                              value: _controller.averageBefore,
                              color: AppTheme.redDanger,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: AverageCard(
                              label: 'Média Pós',
                              value: _controller.averageAfter,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      Text(
                        'Intensidade da Dor por Dia',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildLegend(context, 'Antes', AppTheme.redDanger),
                          const SizedBox(width: 24),
                          _buildLegend(
                            context,
                            'Pós',
                            Theme.of(context).colorScheme.primary,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      _buildChart(context),
                      const SizedBox(height: 16),

                      Text(
                        'Compare a intensidade da dor antes e depois da terapia durante o período selecionado.',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),

                      Text(
                        'Período',
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: () => _controller.showDatePicker(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey[300]!),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.calendar_today,
                                size: 20,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  _controller.dateRangeText,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                              Icon(
                                Icons.arrow_drop_down,
                                color: Colors.grey[600],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SafeArea(
                minimum: const EdgeInsets.all(24),
                child: FilterButton(
                  onPressed: () => _controller.loadPainHistory(),
                  isLoading: _controller.isLoading,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLegend(BuildContext context, String label, Color color) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 4,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildChart(BuildContext context) {
    if (_controller.chartBase64 != null &&
        _controller.chartBase64!.isNotEmpty) {
      try {
        String cleanBase64 = _controller.chartBase64!;
        if (cleanBase64.contains(',')) {
          cleanBase64 = cleanBase64.split(',').last;
        }

        final bytes = base64Decode(cleanBase64);
        return InteractiveViewer(
          minScale: 0.5,
          maxScale: 4.0,
          child: Image.memory(
            bytes,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return _buildPlaceholderChart(context);
            },
          ),
        );
      } catch (e) {
        return _buildPlaceholderChart(context);
      }
    }

    return _buildPlaceholderChart(context);
  }

  Widget _buildPlaceholderChart(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.insert_chart_outlined,
              size: 48,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 8),
            Text(
              'Nenhum dado disponível',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
