import 'package:drift/drift.dart';

import '../../../../core/database/app_database.dart';
import '../../domain/entities/template_entity.dart';
import '../models/template_model.dart';

class TemplateLocalDatasource {
  const TemplateLocalDatasource(this._db);

  final AppDatabase _db;

  Future<List<TemplateEntity>> getAll(String userId) async {
    final rows = await (_db.select(_db.eventTemplatesTable)
          ..where((t) => t.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm.asc(t.name)]))
        .get();
    return rows.map(TemplateModel.fromRow).toList();
  }

  Future<TemplateEntity?> getById(String id) async {
    final row = await (_db.select(_db.eventTemplatesTable)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    return row != null ? TemplateModel.fromRow(row) : null;
  }

  Future<void> upsert(TemplateEntity template) async {
    await _db.into(_db.eventTemplatesTable).insertOnConflictUpdate(
          TemplateModel.toCompanion(template),
        );
  }

  Future<void> delete(String id) async {
    await (_db.delete(_db.eventTemplatesTable)..where((t) => t.id.equals(id)))
        .go();
  }
}
