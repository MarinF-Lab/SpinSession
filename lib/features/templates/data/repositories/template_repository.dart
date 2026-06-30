import '../../../../core/errors/app_failure.dart';
import '../../domain/entities/template_entity.dart';
import '../datasources/template_local_datasource.dart';

class TemplateRepository {
  const TemplateRepository(this._local);

  final TemplateLocalDatasource _local;

  Future<List<TemplateEntity>> getAll(String userId) => _local.getAll(userId);

  Future<TemplateEntity?> getById(String id) => _local.getById(id);

  Future<void> save(TemplateEntity template) async {
    if (template.name.trim().isEmpty) {
      throw const AppFailure('El nombre de la plantilla es obligatorio.');
    }
    await _local.upsert(template);
  }

  Future<void> delete(String id) => _local.delete(id);
}
