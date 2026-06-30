import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/database/app_database.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../data/datasources/template_local_datasource.dart';
import '../../data/repositories/template_repository.dart';
import '../../domain/entities/template_entity.dart';

final templateRepositoryProvider = Provider<TemplateRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return TemplateRepository(TemplateLocalDatasource(db));
});

final templatesProvider =
    StateNotifierProvider<TemplatesController, TemplatesState>((ref) {
  final repo = ref.watch(templateRepositoryProvider);
  final userId = ref.watch(currentUserProvider) ?? '';
  return TemplatesController(repo, userId);
});

class TemplatesState {
  const TemplatesState({
    required this.templates,
    this.isLoading = false,
    this.errorMessage,
  });

  TemplatesState.initial() : this(templates: const [], isLoading: true);

  final List<TemplateEntity> templates;
  final bool isLoading;
  final String? errorMessage;

  TemplatesState copyWith({
    List<TemplateEntity>? templates,
    bool? isLoading,
    String? errorMessage,
  }) {
    return TemplatesState(
      templates: templates ?? this.templates,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

class TemplatesController extends StateNotifier<TemplatesState> {
  TemplatesController(this._repo, this._userId)
      : super(TemplatesState.initial()) {
    load();
  }

  final TemplateRepository _repo;
  final String _userId;
  static const _uuid = Uuid();

  Future<void> load() async {
    state = state.copyWith(isLoading: true);
    try {
      final templates = await _repo.getAll(_userId);
      state = TemplatesState(templates: templates);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<bool> create({
    required String name,
    required int durationSeconds,
    List<String> effects = const [],
    int? autoDeleteDays,
  }) async {
    try {
      final now = DateTime.now();
      final template = TemplateEntity(
        id: _uuid.v4(),
        userId: _userId,
        name: name,
        durationSeconds: durationSeconds,
        defaultEffects: effects,
        autoDeleteDays: autoDeleteDays,
        createdAt: now,
        updatedAt: now,
      );
      await _repo.save(template);
      await load();
      return true;
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
      return false;
    }
  }

  Future<bool> update(TemplateEntity template) async {
    try {
      await _repo.save(template.copyWith(updatedAt: DateTime.now()));
      await load();
      return true;
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
      return false;
    }
  }

  Future<void> delete(String id) async {
    await _repo.delete(id);
    await load();
  }

  void clearError() => state = state.copyWith(errorMessage: null);
}
