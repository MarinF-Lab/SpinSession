import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../../app/router/app_routes.dart';
import '../../../../../shared/widgets/app_bottom_nav.dart';
import '../../../../../shared/widgets/empty_state.dart';
import '../../../../../shared/widgets/event_card.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../domain/entities/event_entity.dart';
import '../providers/event_providers.dart';

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  late DateTime _focusedMonth;
  late DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _focusedMonth = DateTime(now.year, now.month);
    _selectedDay = DateTime(now.year, now.month, now.day);
    _syncFromRemote();
  }

  Future<void> _syncFromRemote() async {
    final userId = ref.read(currentUserProvider);
    if (userId == null) return;
    final repo = ref.read(eventRepositoryProvider);
    await repo.syncPending();
    await repo.pullFromRemote(userId);
    if (mounted) ref.invalidate(eventsForDateProvider);
  }

  void _prevMonth() => setState(() {
        _focusedMonth =
            DateTime(_focusedMonth.year, _focusedMonth.month - 1);
      });

  void _nextMonth() => setState(() {
        _focusedMonth =
            DateTime(_focusedMonth.year, _focusedMonth.month + 1);
      });

  @override
  Widget build(BuildContext context) {
    final eventsAsync = ref.watch(eventsForDateProvider(_selectedDay));
    final monthLabel =
        DateFormat('MMMM yyyy', 'es').format(_focusedMonth);
    final dayLabel = DateFormat('d MMMM', 'es').format(_selectedDay);
    final isToday = DateUtils.isSameDay(_selectedDay, DateTime.now());

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu_outlined),
        title: const Text('Calendario'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: null,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 8, 4),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: _prevMonth,
                ),
                Expanded(
                  child: Text(
                    monthLabel[0].toUpperCase() + monthLabel.substring(1),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  onPressed: _nextMonth,
                ),
                IconButton(
                  icon: const Icon(Icons.calendar_today_outlined, size: 20),
                  tooltip: 'Hoy',
                  onPressed: () {
                    final now = DateTime.now();
                    setState(() {
                      _focusedMonth = DateTime(now.year, now.month);
                      _selectedDay = DateTime(now.year, now.month, now.day);
                    });
                  },
                ),
              ],
            ),
          ),
          _MonthGrid(
            focusedMonth: _focusedMonth,
            selectedDay: _selectedDay,
            onDayTap: (day) => setState(() => _selectedDay = day),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                isToday ? 'Hoy · $dayLabel' : dayLabel,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ),
          Expanded(
            child: eventsAsync.when(
              data: (events) => _EventList(events: events),
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text(e.toString())),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(AppRoutes.eventCreate),
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const AppBottomNav(current: AppTab.calendario),
    );
  }
}

class _MonthGrid extends StatelessWidget {
  const _MonthGrid({
    required this.focusedMonth,
    required this.selectedDay,
    required this.onDayTap,
  });

  final DateTime focusedMonth;
  final DateTime selectedDay;
  final ValueChanged<DateTime> onDayTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final today = DateTime.now();
    final firstWeekday = DateTime(focusedMonth.year, focusedMonth.month, 1).weekday % 7;
    final daysInMonth =
        DateUtils.getDaysInMonth(focusedMonth.year, focusedMonth.month);
    final cells = firstWeekday + daysInMonth;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const ['Do', 'Lu', 'Ma', 'Mi', 'Ju', 'Vi', 'Sá']
                .map((d) => SizedBox(
                      width: 36,
                      child: Center(
                        child: Text(d,
                            style: const TextStyle(
                                fontSize: 11, fontWeight: FontWeight.w600)),
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 4),
          GridView.count(
            crossAxisCount: 7,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(cells, (i) {
              if (i < firstWeekday) return const SizedBox.shrink();
              final day = i - firstWeekday + 1;
              final date =
                  DateTime(focusedMonth.year, focusedMonth.month, day);
              final isSelected = DateUtils.isSameDay(date, selectedDay);
              final isToday = DateUtils.isSameDay(date, today);

              return GestureDetector(
                onTap: () => onDayTap(date),
                child: Container(
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? cs.primary
                        : isToday
                            ? cs.primaryContainer
                            : null,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '$day',
                      style: TextStyle(
                        fontSize: 13,
                        color: isSelected
                            ? cs.onPrimary
                            : isToday
                                ? cs.onPrimaryContainer
                                : null,
                        fontWeight: isSelected || isToday
                            ? FontWeight.w600
                            : null,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _EventList extends StatelessWidget {
  const _EventList({required this.events});

  final List<EventEntity> events;

  @override
  Widget build(BuildContext context) {
    if (events.isEmpty) {
      return const EmptyState(
        icon: Icons.event_outlined,
        message: 'Sin eventos para este día',
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: events.length,
      itemBuilder: (_, i) => EventCard(
        event: events[i],
        onTap: () => context.push(AppRoutes.eventDetail(events[i].id)),
      ),
    );
  }
}
