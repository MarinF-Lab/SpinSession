// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $EventTemplatesTableTable extends EventTemplatesTable
    with TableInfo<$EventTemplatesTableTable, EventTemplatesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EventTemplatesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationSecondsMeta = const VerificationMeta(
    'durationSeconds',
  );
  @override
  late final GeneratedColumn<int> durationSeconds = GeneratedColumn<int>(
    'duration_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(30),
  );
  static const VerificationMeta _defaultEffectsMeta = const VerificationMeta(
    'defaultEffects',
  );
  @override
  late final GeneratedColumn<String> defaultEffects = GeneratedColumn<String>(
    'default_effects',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _autoDeleteDaysMeta = const VerificationMeta(
    'autoDeleteDays',
  );
  @override
  late final GeneratedColumn<int> autoDeleteDays = GeneratedColumn<int>(
    'auto_delete_days',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    name,
    durationSeconds,
    defaultEffects,
    autoDeleteDays,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'event_templates';
  @override
  VerificationContext validateIntegrity(
    Insertable<EventTemplatesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('duration_seconds')) {
      context.handle(
        _durationSecondsMeta,
        durationSeconds.isAcceptableOrUnknown(
          data['duration_seconds']!,
          _durationSecondsMeta,
        ),
      );
    }
    if (data.containsKey('default_effects')) {
      context.handle(
        _defaultEffectsMeta,
        defaultEffects.isAcceptableOrUnknown(
          data['default_effects']!,
          _defaultEffectsMeta,
        ),
      );
    }
    if (data.containsKey('auto_delete_days')) {
      context.handle(
        _autoDeleteDaysMeta,
        autoDeleteDays.isAcceptableOrUnknown(
          data['auto_delete_days']!,
          _autoDeleteDaysMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EventTemplatesTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EventTemplatesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      durationSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_seconds'],
      )!,
      defaultEffects: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}default_effects'],
      )!,
      autoDeleteDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}auto_delete_days'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $EventTemplatesTableTable createAlias(String alias) {
    return $EventTemplatesTableTable(attachedDatabase, alias);
  }
}

class EventTemplatesTableData extends DataClass
    implements Insertable<EventTemplatesTableData> {
  final String id;
  final String userId;
  final String name;
  final int durationSeconds;
  final String defaultEffects;
  final int? autoDeleteDays;
  final DateTime createdAt;
  final DateTime updatedAt;
  const EventTemplatesTableData({
    required this.id,
    required this.userId,
    required this.name,
    required this.durationSeconds,
    required this.defaultEffects,
    this.autoDeleteDays,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    map['name'] = Variable<String>(name);
    map['duration_seconds'] = Variable<int>(durationSeconds);
    map['default_effects'] = Variable<String>(defaultEffects);
    if (!nullToAbsent || autoDeleteDays != null) {
      map['auto_delete_days'] = Variable<int>(autoDeleteDays);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  EventTemplatesTableCompanion toCompanion(bool nullToAbsent) {
    return EventTemplatesTableCompanion(
      id: Value(id),
      userId: Value(userId),
      name: Value(name),
      durationSeconds: Value(durationSeconds),
      defaultEffects: Value(defaultEffects),
      autoDeleteDays: autoDeleteDays == null && nullToAbsent
          ? const Value.absent()
          : Value(autoDeleteDays),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory EventTemplatesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EventTemplatesTableData(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      name: serializer.fromJson<String>(json['name']),
      durationSeconds: serializer.fromJson<int>(json['durationSeconds']),
      defaultEffects: serializer.fromJson<String>(json['defaultEffects']),
      autoDeleteDays: serializer.fromJson<int?>(json['autoDeleteDays']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'name': serializer.toJson<String>(name),
      'durationSeconds': serializer.toJson<int>(durationSeconds),
      'defaultEffects': serializer.toJson<String>(defaultEffects),
      'autoDeleteDays': serializer.toJson<int?>(autoDeleteDays),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  EventTemplatesTableData copyWith({
    String? id,
    String? userId,
    String? name,
    int? durationSeconds,
    String? defaultEffects,
    Value<int?> autoDeleteDays = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => EventTemplatesTableData(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    name: name ?? this.name,
    durationSeconds: durationSeconds ?? this.durationSeconds,
    defaultEffects: defaultEffects ?? this.defaultEffects,
    autoDeleteDays: autoDeleteDays.present
        ? autoDeleteDays.value
        : this.autoDeleteDays,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  EventTemplatesTableData copyWithCompanion(EventTemplatesTableCompanion data) {
    return EventTemplatesTableData(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      name: data.name.present ? data.name.value : this.name,
      durationSeconds: data.durationSeconds.present
          ? data.durationSeconds.value
          : this.durationSeconds,
      defaultEffects: data.defaultEffects.present
          ? data.defaultEffects.value
          : this.defaultEffects,
      autoDeleteDays: data.autoDeleteDays.present
          ? data.autoDeleteDays.value
          : this.autoDeleteDays,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EventTemplatesTableData(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('defaultEffects: $defaultEffects, ')
          ..write('autoDeleteDays: $autoDeleteDays, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    name,
    durationSeconds,
    defaultEffects,
    autoDeleteDays,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EventTemplatesTableData &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.name == this.name &&
          other.durationSeconds == this.durationSeconds &&
          other.defaultEffects == this.defaultEffects &&
          other.autoDeleteDays == this.autoDeleteDays &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class EventTemplatesTableCompanion
    extends UpdateCompanion<EventTemplatesTableData> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String> name;
  final Value<int> durationSeconds;
  final Value<String> defaultEffects;
  final Value<int?> autoDeleteDays;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const EventTemplatesTableCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.name = const Value.absent(),
    this.durationSeconds = const Value.absent(),
    this.defaultEffects = const Value.absent(),
    this.autoDeleteDays = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EventTemplatesTableCompanion.insert({
    required String id,
    required String userId,
    required String name,
    this.durationSeconds = const Value.absent(),
    this.defaultEffects = const Value.absent(),
    this.autoDeleteDays = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userId = Value(userId),
       name = Value(name),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<EventTemplatesTableData> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? name,
    Expression<int>? durationSeconds,
    Expression<String>? defaultEffects,
    Expression<int>? autoDeleteDays,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (name != null) 'name': name,
      if (durationSeconds != null) 'duration_seconds': durationSeconds,
      if (defaultEffects != null) 'default_effects': defaultEffects,
      if (autoDeleteDays != null) 'auto_delete_days': autoDeleteDays,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EventTemplatesTableCompanion copyWith({
    Value<String>? id,
    Value<String>? userId,
    Value<String>? name,
    Value<int>? durationSeconds,
    Value<String>? defaultEffects,
    Value<int?>? autoDeleteDays,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return EventTemplatesTableCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      defaultEffects: defaultEffects ?? this.defaultEffects,
      autoDeleteDays: autoDeleteDays ?? this.autoDeleteDays,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (durationSeconds.present) {
      map['duration_seconds'] = Variable<int>(durationSeconds.value);
    }
    if (defaultEffects.present) {
      map['default_effects'] = Variable<String>(defaultEffects.value);
    }
    if (autoDeleteDays.present) {
      map['auto_delete_days'] = Variable<int>(autoDeleteDays.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventTemplatesTableCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('defaultEffects: $defaultEffects, ')
          ..write('autoDeleteDays: $autoDeleteDays, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EventsTableTable extends EventsTable
    with TableInfo<$EventsTableTable, EventsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EventsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _templateIdMeta = const VerificationMeta(
    'templateId',
  );
  @override
  late final GeneratedColumn<String> templateId = GeneratedColumn<String>(
    'template_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _eventDateMeta = const VerificationMeta(
    'eventDate',
  );
  @override
  late final GeneratedColumn<DateTime> eventDate = GeneratedColumn<DateTime>(
    'event_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startDatetimeMeta = const VerificationMeta(
    'startDatetime',
  );
  @override
  late final GeneratedColumn<DateTime> startDatetime =
      GeneratedColumn<DateTime>(
        'start_datetime',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _endDatetimeMeta = const VerificationMeta(
    'endDatetime',
  );
  @override
  late final GeneratedColumn<DateTime> endDatetime = GeneratedColumn<DateTime>(
    'end_datetime',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _eventStatusMeta = const VerificationMeta(
    'eventStatus',
  );
  @override
  late final GeneratedColumn<String> eventStatus = GeneratedColumn<String>(
    'event_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('reserved'),
  );
  static const VerificationMeta _paymentStatusMeta = const VerificationMeta(
    'paymentStatus',
  );
  @override
  late final GeneratedColumn<String> paymentStatus = GeneratedColumn<String>(
    'payment_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _gallerySlugMeta = const VerificationMeta(
    'gallerySlug',
  );
  @override
  late final GeneratedColumn<String> gallerySlug = GeneratedColumn<String>(
    'gallery_slug',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncedMeta = const VerificationMeta('synced');
  @override
  late final GeneratedColumn<bool> synced = GeneratedColumn<bool>(
    'synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    templateId,
    name,
    eventDate,
    startDatetime,
    endDatetime,
    eventStatus,
    paymentStatus,
    gallerySlug,
    notes,
    synced,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'events';
  @override
  VerificationContext validateIntegrity(
    Insertable<EventsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('template_id')) {
      context.handle(
        _templateIdMeta,
        templateId.isAcceptableOrUnknown(data['template_id']!, _templateIdMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('event_date')) {
      context.handle(
        _eventDateMeta,
        eventDate.isAcceptableOrUnknown(data['event_date']!, _eventDateMeta),
      );
    } else if (isInserting) {
      context.missing(_eventDateMeta);
    }
    if (data.containsKey('start_datetime')) {
      context.handle(
        _startDatetimeMeta,
        startDatetime.isAcceptableOrUnknown(
          data['start_datetime']!,
          _startDatetimeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_startDatetimeMeta);
    }
    if (data.containsKey('end_datetime')) {
      context.handle(
        _endDatetimeMeta,
        endDatetime.isAcceptableOrUnknown(
          data['end_datetime']!,
          _endDatetimeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_endDatetimeMeta);
    }
    if (data.containsKey('event_status')) {
      context.handle(
        _eventStatusMeta,
        eventStatus.isAcceptableOrUnknown(
          data['event_status']!,
          _eventStatusMeta,
        ),
      );
    }
    if (data.containsKey('payment_status')) {
      context.handle(
        _paymentStatusMeta,
        paymentStatus.isAcceptableOrUnknown(
          data['payment_status']!,
          _paymentStatusMeta,
        ),
      );
    }
    if (data.containsKey('gallery_slug')) {
      context.handle(
        _gallerySlugMeta,
        gallerySlug.isAcceptableOrUnknown(
          data['gallery_slug']!,
          _gallerySlugMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_gallerySlugMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('synced')) {
      context.handle(
        _syncedMeta,
        synced.isAcceptableOrUnknown(data['synced']!, _syncedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EventsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EventsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      templateId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}template_id'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      eventDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}event_date'],
      )!,
      startDatetime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}start_datetime'],
      )!,
      endDatetime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}end_datetime'],
      )!,
      eventStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_status'],
      )!,
      paymentStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_status'],
      )!,
      gallerySlug: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gallery_slug'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      synced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}synced'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $EventsTableTable createAlias(String alias) {
    return $EventsTableTable(attachedDatabase, alias);
  }
}

class EventsTableData extends DataClass implements Insertable<EventsTableData> {
  final String id;
  final String userId;
  final String? templateId;
  final String name;
  final DateTime eventDate;
  final DateTime startDatetime;
  final DateTime endDatetime;
  final String eventStatus;
  final String paymentStatus;
  final String gallerySlug;
  final String? notes;
  final bool synced;
  final DateTime createdAt;
  final DateTime updatedAt;
  const EventsTableData({
    required this.id,
    required this.userId,
    this.templateId,
    required this.name,
    required this.eventDate,
    required this.startDatetime,
    required this.endDatetime,
    required this.eventStatus,
    required this.paymentStatus,
    required this.gallerySlug,
    this.notes,
    required this.synced,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['user_id'] = Variable<String>(userId);
    if (!nullToAbsent || templateId != null) {
      map['template_id'] = Variable<String>(templateId);
    }
    map['name'] = Variable<String>(name);
    map['event_date'] = Variable<DateTime>(eventDate);
    map['start_datetime'] = Variable<DateTime>(startDatetime);
    map['end_datetime'] = Variable<DateTime>(endDatetime);
    map['event_status'] = Variable<String>(eventStatus);
    map['payment_status'] = Variable<String>(paymentStatus);
    map['gallery_slug'] = Variable<String>(gallerySlug);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['synced'] = Variable<bool>(synced);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  EventsTableCompanion toCompanion(bool nullToAbsent) {
    return EventsTableCompanion(
      id: Value(id),
      userId: Value(userId),
      templateId: templateId == null && nullToAbsent
          ? const Value.absent()
          : Value(templateId),
      name: Value(name),
      eventDate: Value(eventDate),
      startDatetime: Value(startDatetime),
      endDatetime: Value(endDatetime),
      eventStatus: Value(eventStatus),
      paymentStatus: Value(paymentStatus),
      gallerySlug: Value(gallerySlug),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      synced: Value(synced),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory EventsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EventsTableData(
      id: serializer.fromJson<String>(json['id']),
      userId: serializer.fromJson<String>(json['userId']),
      templateId: serializer.fromJson<String?>(json['templateId']),
      name: serializer.fromJson<String>(json['name']),
      eventDate: serializer.fromJson<DateTime>(json['eventDate']),
      startDatetime: serializer.fromJson<DateTime>(json['startDatetime']),
      endDatetime: serializer.fromJson<DateTime>(json['endDatetime']),
      eventStatus: serializer.fromJson<String>(json['eventStatus']),
      paymentStatus: serializer.fromJson<String>(json['paymentStatus']),
      gallerySlug: serializer.fromJson<String>(json['gallerySlug']),
      notes: serializer.fromJson<String?>(json['notes']),
      synced: serializer.fromJson<bool>(json['synced']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'userId': serializer.toJson<String>(userId),
      'templateId': serializer.toJson<String?>(templateId),
      'name': serializer.toJson<String>(name),
      'eventDate': serializer.toJson<DateTime>(eventDate),
      'startDatetime': serializer.toJson<DateTime>(startDatetime),
      'endDatetime': serializer.toJson<DateTime>(endDatetime),
      'eventStatus': serializer.toJson<String>(eventStatus),
      'paymentStatus': serializer.toJson<String>(paymentStatus),
      'gallerySlug': serializer.toJson<String>(gallerySlug),
      'notes': serializer.toJson<String?>(notes),
      'synced': serializer.toJson<bool>(synced),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  EventsTableData copyWith({
    String? id,
    String? userId,
    Value<String?> templateId = const Value.absent(),
    String? name,
    DateTime? eventDate,
    DateTime? startDatetime,
    DateTime? endDatetime,
    String? eventStatus,
    String? paymentStatus,
    String? gallerySlug,
    Value<String?> notes = const Value.absent(),
    bool? synced,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => EventsTableData(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    templateId: templateId.present ? templateId.value : this.templateId,
    name: name ?? this.name,
    eventDate: eventDate ?? this.eventDate,
    startDatetime: startDatetime ?? this.startDatetime,
    endDatetime: endDatetime ?? this.endDatetime,
    eventStatus: eventStatus ?? this.eventStatus,
    paymentStatus: paymentStatus ?? this.paymentStatus,
    gallerySlug: gallerySlug ?? this.gallerySlug,
    notes: notes.present ? notes.value : this.notes,
    synced: synced ?? this.synced,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  EventsTableData copyWithCompanion(EventsTableCompanion data) {
    return EventsTableData(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      templateId: data.templateId.present
          ? data.templateId.value
          : this.templateId,
      name: data.name.present ? data.name.value : this.name,
      eventDate: data.eventDate.present ? data.eventDate.value : this.eventDate,
      startDatetime: data.startDatetime.present
          ? data.startDatetime.value
          : this.startDatetime,
      endDatetime: data.endDatetime.present
          ? data.endDatetime.value
          : this.endDatetime,
      eventStatus: data.eventStatus.present
          ? data.eventStatus.value
          : this.eventStatus,
      paymentStatus: data.paymentStatus.present
          ? data.paymentStatus.value
          : this.paymentStatus,
      gallerySlug: data.gallerySlug.present
          ? data.gallerySlug.value
          : this.gallerySlug,
      notes: data.notes.present ? data.notes.value : this.notes,
      synced: data.synced.present ? data.synced.value : this.synced,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EventsTableData(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('templateId: $templateId, ')
          ..write('name: $name, ')
          ..write('eventDate: $eventDate, ')
          ..write('startDatetime: $startDatetime, ')
          ..write('endDatetime: $endDatetime, ')
          ..write('eventStatus: $eventStatus, ')
          ..write('paymentStatus: $paymentStatus, ')
          ..write('gallerySlug: $gallerySlug, ')
          ..write('notes: $notes, ')
          ..write('synced: $synced, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    templateId,
    name,
    eventDate,
    startDatetime,
    endDatetime,
    eventStatus,
    paymentStatus,
    gallerySlug,
    notes,
    synced,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EventsTableData &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.templateId == this.templateId &&
          other.name == this.name &&
          other.eventDate == this.eventDate &&
          other.startDatetime == this.startDatetime &&
          other.endDatetime == this.endDatetime &&
          other.eventStatus == this.eventStatus &&
          other.paymentStatus == this.paymentStatus &&
          other.gallerySlug == this.gallerySlug &&
          other.notes == this.notes &&
          other.synced == this.synced &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class EventsTableCompanion extends UpdateCompanion<EventsTableData> {
  final Value<String> id;
  final Value<String> userId;
  final Value<String?> templateId;
  final Value<String> name;
  final Value<DateTime> eventDate;
  final Value<DateTime> startDatetime;
  final Value<DateTime> endDatetime;
  final Value<String> eventStatus;
  final Value<String> paymentStatus;
  final Value<String> gallerySlug;
  final Value<String?> notes;
  final Value<bool> synced;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const EventsTableCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.templateId = const Value.absent(),
    this.name = const Value.absent(),
    this.eventDate = const Value.absent(),
    this.startDatetime = const Value.absent(),
    this.endDatetime = const Value.absent(),
    this.eventStatus = const Value.absent(),
    this.paymentStatus = const Value.absent(),
    this.gallerySlug = const Value.absent(),
    this.notes = const Value.absent(),
    this.synced = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EventsTableCompanion.insert({
    required String id,
    required String userId,
    this.templateId = const Value.absent(),
    required String name,
    required DateTime eventDate,
    required DateTime startDatetime,
    required DateTime endDatetime,
    this.eventStatus = const Value.absent(),
    this.paymentStatus = const Value.absent(),
    required String gallerySlug,
    this.notes = const Value.absent(),
    this.synced = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       userId = Value(userId),
       name = Value(name),
       eventDate = Value(eventDate),
       startDatetime = Value(startDatetime),
       endDatetime = Value(endDatetime),
       gallerySlug = Value(gallerySlug),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<EventsTableData> custom({
    Expression<String>? id,
    Expression<String>? userId,
    Expression<String>? templateId,
    Expression<String>? name,
    Expression<DateTime>? eventDate,
    Expression<DateTime>? startDatetime,
    Expression<DateTime>? endDatetime,
    Expression<String>? eventStatus,
    Expression<String>? paymentStatus,
    Expression<String>? gallerySlug,
    Expression<String>? notes,
    Expression<bool>? synced,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (templateId != null) 'template_id': templateId,
      if (name != null) 'name': name,
      if (eventDate != null) 'event_date': eventDate,
      if (startDatetime != null) 'start_datetime': startDatetime,
      if (endDatetime != null) 'end_datetime': endDatetime,
      if (eventStatus != null) 'event_status': eventStatus,
      if (paymentStatus != null) 'payment_status': paymentStatus,
      if (gallerySlug != null) 'gallery_slug': gallerySlug,
      if (notes != null) 'notes': notes,
      if (synced != null) 'synced': synced,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EventsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? userId,
    Value<String?>? templateId,
    Value<String>? name,
    Value<DateTime>? eventDate,
    Value<DateTime>? startDatetime,
    Value<DateTime>? endDatetime,
    Value<String>? eventStatus,
    Value<String>? paymentStatus,
    Value<String>? gallerySlug,
    Value<String?>? notes,
    Value<bool>? synced,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return EventsTableCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      templateId: templateId ?? this.templateId,
      name: name ?? this.name,
      eventDate: eventDate ?? this.eventDate,
      startDatetime: startDatetime ?? this.startDatetime,
      endDatetime: endDatetime ?? this.endDatetime,
      eventStatus: eventStatus ?? this.eventStatus,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      gallerySlug: gallerySlug ?? this.gallerySlug,
      notes: notes ?? this.notes,
      synced: synced ?? this.synced,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (templateId.present) {
      map['template_id'] = Variable<String>(templateId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (eventDate.present) {
      map['event_date'] = Variable<DateTime>(eventDate.value);
    }
    if (startDatetime.present) {
      map['start_datetime'] = Variable<DateTime>(startDatetime.value);
    }
    if (endDatetime.present) {
      map['end_datetime'] = Variable<DateTime>(endDatetime.value);
    }
    if (eventStatus.present) {
      map['event_status'] = Variable<String>(eventStatus.value);
    }
    if (paymentStatus.present) {
      map['payment_status'] = Variable<String>(paymentStatus.value);
    }
    if (gallerySlug.present) {
      map['gallery_slug'] = Variable<String>(gallerySlug.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (synced.present) {
      map['synced'] = Variable<bool>(synced.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventsTableCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('templateId: $templateId, ')
          ..write('name: $name, ')
          ..write('eventDate: $eventDate, ')
          ..write('startDatetime: $startDatetime, ')
          ..write('endDatetime: $endDatetime, ')
          ..write('eventStatus: $eventStatus, ')
          ..write('paymentStatus: $paymentStatus, ')
          ..write('gallerySlug: $gallerySlug, ')
          ..write('notes: $notes, ')
          ..write('synced: $synced, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EventSettingsTableTable extends EventSettingsTable
    with TableInfo<$EventSettingsTableTable, EventSettingsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EventSettingsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _eventIdMeta = const VerificationMeta(
    'eventId',
  );
  @override
  late final GeneratedColumn<String> eventId = GeneratedColumn<String>(
    'event_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _defaultDurationSecondsMeta =
      const VerificationMeta('defaultDurationSeconds');
  @override
  late final GeneratedColumn<int> defaultDurationSeconds = GeneratedColumn<int>(
    'default_duration_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(30),
  );
  static const VerificationMeta _defaultEffectsMeta = const VerificationMeta(
    'defaultEffects',
  );
  @override
  late final GeneratedColumn<String> defaultEffects = GeneratedColumn<String>(
    'default_effects',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _allowMultipleSessionsMeta =
      const VerificationMeta('allowMultipleSessions');
  @override
  late final GeneratedColumn<bool> allowMultipleSessions =
      GeneratedColumn<bool>(
        'allow_multiple_sessions',
        aliasedName,
        false,
        type: DriftSqlType.bool,
        requiredDuringInsert: false,
        defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("allow_multiple_sessions" IN (0, 1))',
        ),
        defaultValue: const Constant(true),
      );
  static const VerificationMeta _autoDeleteDaysMeta = const VerificationMeta(
    'autoDeleteDays',
  );
  @override
  late final GeneratedColumn<int> autoDeleteDays = GeneratedColumn<int>(
    'auto_delete_days',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _galleryNameMeta = const VerificationMeta(
    'galleryName',
  );
  @override
  late final GeneratedColumn<String> galleryName = GeneratedColumn<String>(
    'gallery_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    eventId,
    defaultDurationSeconds,
    defaultEffects,
    allowMultipleSessions,
    autoDeleteDays,
    galleryName,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'event_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<EventSettingsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('event_id')) {
      context.handle(
        _eventIdMeta,
        eventId.isAcceptableOrUnknown(data['event_id']!, _eventIdMeta),
      );
    } else if (isInserting) {
      context.missing(_eventIdMeta);
    }
    if (data.containsKey('default_duration_seconds')) {
      context.handle(
        _defaultDurationSecondsMeta,
        defaultDurationSeconds.isAcceptableOrUnknown(
          data['default_duration_seconds']!,
          _defaultDurationSecondsMeta,
        ),
      );
    }
    if (data.containsKey('default_effects')) {
      context.handle(
        _defaultEffectsMeta,
        defaultEffects.isAcceptableOrUnknown(
          data['default_effects']!,
          _defaultEffectsMeta,
        ),
      );
    }
    if (data.containsKey('allow_multiple_sessions')) {
      context.handle(
        _allowMultipleSessionsMeta,
        allowMultipleSessions.isAcceptableOrUnknown(
          data['allow_multiple_sessions']!,
          _allowMultipleSessionsMeta,
        ),
      );
    }
    if (data.containsKey('auto_delete_days')) {
      context.handle(
        _autoDeleteDaysMeta,
        autoDeleteDays.isAcceptableOrUnknown(
          data['auto_delete_days']!,
          _autoDeleteDaysMeta,
        ),
      );
    }
    if (data.containsKey('gallery_name')) {
      context.handle(
        _galleryNameMeta,
        galleryName.isAcceptableOrUnknown(
          data['gallery_name']!,
          _galleryNameMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EventSettingsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EventSettingsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      eventId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_id'],
      )!,
      defaultDurationSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}default_duration_seconds'],
      )!,
      defaultEffects: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}default_effects'],
      )!,
      allowMultipleSessions: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}allow_multiple_sessions'],
      )!,
      autoDeleteDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}auto_delete_days'],
      ),
      galleryName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}gallery_name'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $EventSettingsTableTable createAlias(String alias) {
    return $EventSettingsTableTable(attachedDatabase, alias);
  }
}

class EventSettingsTableData extends DataClass
    implements Insertable<EventSettingsTableData> {
  final String id;
  final String eventId;
  final int defaultDurationSeconds;
  final String defaultEffects;
  final bool allowMultipleSessions;
  final int? autoDeleteDays;
  final String? galleryName;
  final DateTime updatedAt;
  const EventSettingsTableData({
    required this.id,
    required this.eventId,
    required this.defaultDurationSeconds,
    required this.defaultEffects,
    required this.allowMultipleSessions,
    this.autoDeleteDays,
    this.galleryName,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['event_id'] = Variable<String>(eventId);
    map['default_duration_seconds'] = Variable<int>(defaultDurationSeconds);
    map['default_effects'] = Variable<String>(defaultEffects);
    map['allow_multiple_sessions'] = Variable<bool>(allowMultipleSessions);
    if (!nullToAbsent || autoDeleteDays != null) {
      map['auto_delete_days'] = Variable<int>(autoDeleteDays);
    }
    if (!nullToAbsent || galleryName != null) {
      map['gallery_name'] = Variable<String>(galleryName);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  EventSettingsTableCompanion toCompanion(bool nullToAbsent) {
    return EventSettingsTableCompanion(
      id: Value(id),
      eventId: Value(eventId),
      defaultDurationSeconds: Value(defaultDurationSeconds),
      defaultEffects: Value(defaultEffects),
      allowMultipleSessions: Value(allowMultipleSessions),
      autoDeleteDays: autoDeleteDays == null && nullToAbsent
          ? const Value.absent()
          : Value(autoDeleteDays),
      galleryName: galleryName == null && nullToAbsent
          ? const Value.absent()
          : Value(galleryName),
      updatedAt: Value(updatedAt),
    );
  }

  factory EventSettingsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EventSettingsTableData(
      id: serializer.fromJson<String>(json['id']),
      eventId: serializer.fromJson<String>(json['eventId']),
      defaultDurationSeconds: serializer.fromJson<int>(
        json['defaultDurationSeconds'],
      ),
      defaultEffects: serializer.fromJson<String>(json['defaultEffects']),
      allowMultipleSessions: serializer.fromJson<bool>(
        json['allowMultipleSessions'],
      ),
      autoDeleteDays: serializer.fromJson<int?>(json['autoDeleteDays']),
      galleryName: serializer.fromJson<String?>(json['galleryName']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'eventId': serializer.toJson<String>(eventId),
      'defaultDurationSeconds': serializer.toJson<int>(defaultDurationSeconds),
      'defaultEffects': serializer.toJson<String>(defaultEffects),
      'allowMultipleSessions': serializer.toJson<bool>(allowMultipleSessions),
      'autoDeleteDays': serializer.toJson<int?>(autoDeleteDays),
      'galleryName': serializer.toJson<String?>(galleryName),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  EventSettingsTableData copyWith({
    String? id,
    String? eventId,
    int? defaultDurationSeconds,
    String? defaultEffects,
    bool? allowMultipleSessions,
    Value<int?> autoDeleteDays = const Value.absent(),
    Value<String?> galleryName = const Value.absent(),
    DateTime? updatedAt,
  }) => EventSettingsTableData(
    id: id ?? this.id,
    eventId: eventId ?? this.eventId,
    defaultDurationSeconds:
        defaultDurationSeconds ?? this.defaultDurationSeconds,
    defaultEffects: defaultEffects ?? this.defaultEffects,
    allowMultipleSessions: allowMultipleSessions ?? this.allowMultipleSessions,
    autoDeleteDays: autoDeleteDays.present
        ? autoDeleteDays.value
        : this.autoDeleteDays,
    galleryName: galleryName.present ? galleryName.value : this.galleryName,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  EventSettingsTableData copyWithCompanion(EventSettingsTableCompanion data) {
    return EventSettingsTableData(
      id: data.id.present ? data.id.value : this.id,
      eventId: data.eventId.present ? data.eventId.value : this.eventId,
      defaultDurationSeconds: data.defaultDurationSeconds.present
          ? data.defaultDurationSeconds.value
          : this.defaultDurationSeconds,
      defaultEffects: data.defaultEffects.present
          ? data.defaultEffects.value
          : this.defaultEffects,
      allowMultipleSessions: data.allowMultipleSessions.present
          ? data.allowMultipleSessions.value
          : this.allowMultipleSessions,
      autoDeleteDays: data.autoDeleteDays.present
          ? data.autoDeleteDays.value
          : this.autoDeleteDays,
      galleryName: data.galleryName.present
          ? data.galleryName.value
          : this.galleryName,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EventSettingsTableData(')
          ..write('id: $id, ')
          ..write('eventId: $eventId, ')
          ..write('defaultDurationSeconds: $defaultDurationSeconds, ')
          ..write('defaultEffects: $defaultEffects, ')
          ..write('allowMultipleSessions: $allowMultipleSessions, ')
          ..write('autoDeleteDays: $autoDeleteDays, ')
          ..write('galleryName: $galleryName, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    eventId,
    defaultDurationSeconds,
    defaultEffects,
    allowMultipleSessions,
    autoDeleteDays,
    galleryName,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EventSettingsTableData &&
          other.id == this.id &&
          other.eventId == this.eventId &&
          other.defaultDurationSeconds == this.defaultDurationSeconds &&
          other.defaultEffects == this.defaultEffects &&
          other.allowMultipleSessions == this.allowMultipleSessions &&
          other.autoDeleteDays == this.autoDeleteDays &&
          other.galleryName == this.galleryName &&
          other.updatedAt == this.updatedAt);
}

class EventSettingsTableCompanion
    extends UpdateCompanion<EventSettingsTableData> {
  final Value<String> id;
  final Value<String> eventId;
  final Value<int> defaultDurationSeconds;
  final Value<String> defaultEffects;
  final Value<bool> allowMultipleSessions;
  final Value<int?> autoDeleteDays;
  final Value<String?> galleryName;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const EventSettingsTableCompanion({
    this.id = const Value.absent(),
    this.eventId = const Value.absent(),
    this.defaultDurationSeconds = const Value.absent(),
    this.defaultEffects = const Value.absent(),
    this.allowMultipleSessions = const Value.absent(),
    this.autoDeleteDays = const Value.absent(),
    this.galleryName = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EventSettingsTableCompanion.insert({
    required String id,
    required String eventId,
    this.defaultDurationSeconds = const Value.absent(),
    this.defaultEffects = const Value.absent(),
    this.allowMultipleSessions = const Value.absent(),
    this.autoDeleteDays = const Value.absent(),
    this.galleryName = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       eventId = Value(eventId),
       updatedAt = Value(updatedAt);
  static Insertable<EventSettingsTableData> custom({
    Expression<String>? id,
    Expression<String>? eventId,
    Expression<int>? defaultDurationSeconds,
    Expression<String>? defaultEffects,
    Expression<bool>? allowMultipleSessions,
    Expression<int>? autoDeleteDays,
    Expression<String>? galleryName,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (eventId != null) 'event_id': eventId,
      if (defaultDurationSeconds != null)
        'default_duration_seconds': defaultDurationSeconds,
      if (defaultEffects != null) 'default_effects': defaultEffects,
      if (allowMultipleSessions != null)
        'allow_multiple_sessions': allowMultipleSessions,
      if (autoDeleteDays != null) 'auto_delete_days': autoDeleteDays,
      if (galleryName != null) 'gallery_name': galleryName,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EventSettingsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? eventId,
    Value<int>? defaultDurationSeconds,
    Value<String>? defaultEffects,
    Value<bool>? allowMultipleSessions,
    Value<int?>? autoDeleteDays,
    Value<String?>? galleryName,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return EventSettingsTableCompanion(
      id: id ?? this.id,
      eventId: eventId ?? this.eventId,
      defaultDurationSeconds:
          defaultDurationSeconds ?? this.defaultDurationSeconds,
      defaultEffects: defaultEffects ?? this.defaultEffects,
      allowMultipleSessions:
          allowMultipleSessions ?? this.allowMultipleSessions,
      autoDeleteDays: autoDeleteDays ?? this.autoDeleteDays,
      galleryName: galleryName ?? this.galleryName,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (eventId.present) {
      map['event_id'] = Variable<String>(eventId.value);
    }
    if (defaultDurationSeconds.present) {
      map['default_duration_seconds'] = Variable<int>(
        defaultDurationSeconds.value,
      );
    }
    if (defaultEffects.present) {
      map['default_effects'] = Variable<String>(defaultEffects.value);
    }
    if (allowMultipleSessions.present) {
      map['allow_multiple_sessions'] = Variable<bool>(
        allowMultipleSessions.value,
      );
    }
    if (autoDeleteDays.present) {
      map['auto_delete_days'] = Variable<int>(autoDeleteDays.value);
    }
    if (galleryName.present) {
      map['gallery_name'] = Variable<String>(galleryName.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventSettingsTableCompanion(')
          ..write('id: $id, ')
          ..write('eventId: $eventId, ')
          ..write('defaultDurationSeconds: $defaultDurationSeconds, ')
          ..write('defaultEffects: $defaultEffects, ')
          ..write('allowMultipleSessions: $allowMultipleSessions, ')
          ..write('autoDeleteDays: $autoDeleteDays, ')
          ..write('galleryName: $galleryName, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncJobsTableTable extends SyncJobsTable
    with TableInfo<$SyncJobsTableTable, SyncJobsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncJobsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityTypeMeta = const VerificationMeta(
    'entityType',
  );
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
    'entity_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityIdMeta = const VerificationMeta(
    'entityId',
  );
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
    'entity_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncTypeMeta = const VerificationMeta(
    'syncType',
  );
  @override
  late final GeneratedColumn<String> syncType = GeneratedColumn<String>(
    'sync_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _attemptsMeta = const VerificationMeta(
    'attempts',
  );
  @override
  late final GeneratedColumn<int> attempts = GeneratedColumn<int>(
    'attempts',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _lastErrorMeta = const VerificationMeta(
    'lastError',
  );
  @override
  late final GeneratedColumn<String> lastError = GeneratedColumn<String>(
    'last_error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    entityType,
    entityId,
    syncType,
    attempts,
    lastError,
    status,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_jobs';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncJobsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('entity_type')) {
      context.handle(
        _entityTypeMeta,
        entityType.isAcceptableOrUnknown(data['entity_type']!, _entityTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(
        _entityIdMeta,
        entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('sync_type')) {
      context.handle(
        _syncTypeMeta,
        syncType.isAcceptableOrUnknown(data['sync_type']!, _syncTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_syncTypeMeta);
    }
    if (data.containsKey('attempts')) {
      context.handle(
        _attemptsMeta,
        attempts.isAcceptableOrUnknown(data['attempts']!, _attemptsMeta),
      );
    }
    if (data.containsKey('last_error')) {
      context.handle(
        _lastErrorMeta,
        lastError.isAcceptableOrUnknown(data['last_error']!, _lastErrorMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncJobsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncJobsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      entityType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_type'],
      )!,
      entityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_id'],
      )!,
      syncType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sync_type'],
      )!,
      attempts: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}attempts'],
      )!,
      lastError: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_error'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SyncJobsTableTable createAlias(String alias) {
    return $SyncJobsTableTable(attachedDatabase, alias);
  }
}

class SyncJobsTableData extends DataClass
    implements Insertable<SyncJobsTableData> {
  final String id;
  final String entityType;
  final String entityId;
  final String syncType;
  final int attempts;
  final String? lastError;
  final String status;
  final DateTime createdAt;
  const SyncJobsTableData({
    required this.id,
    required this.entityType,
    required this.entityId,
    required this.syncType,
    required this.attempts,
    this.lastError,
    required this.status,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['entity_type'] = Variable<String>(entityType);
    map['entity_id'] = Variable<String>(entityId);
    map['sync_type'] = Variable<String>(syncType);
    map['attempts'] = Variable<int>(attempts);
    if (!nullToAbsent || lastError != null) {
      map['last_error'] = Variable<String>(lastError);
    }
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SyncJobsTableCompanion toCompanion(bool nullToAbsent) {
    return SyncJobsTableCompanion(
      id: Value(id),
      entityType: Value(entityType),
      entityId: Value(entityId),
      syncType: Value(syncType),
      attempts: Value(attempts),
      lastError: lastError == null && nullToAbsent
          ? const Value.absent()
          : Value(lastError),
      status: Value(status),
      createdAt: Value(createdAt),
    );
  }

  factory SyncJobsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncJobsTableData(
      id: serializer.fromJson<String>(json['id']),
      entityType: serializer.fromJson<String>(json['entityType']),
      entityId: serializer.fromJson<String>(json['entityId']),
      syncType: serializer.fromJson<String>(json['syncType']),
      attempts: serializer.fromJson<int>(json['attempts']),
      lastError: serializer.fromJson<String?>(json['lastError']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'entityType': serializer.toJson<String>(entityType),
      'entityId': serializer.toJson<String>(entityId),
      'syncType': serializer.toJson<String>(syncType),
      'attempts': serializer.toJson<int>(attempts),
      'lastError': serializer.toJson<String?>(lastError),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SyncJobsTableData copyWith({
    String? id,
    String? entityType,
    String? entityId,
    String? syncType,
    int? attempts,
    Value<String?> lastError = const Value.absent(),
    String? status,
    DateTime? createdAt,
  }) => SyncJobsTableData(
    id: id ?? this.id,
    entityType: entityType ?? this.entityType,
    entityId: entityId ?? this.entityId,
    syncType: syncType ?? this.syncType,
    attempts: attempts ?? this.attempts,
    lastError: lastError.present ? lastError.value : this.lastError,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
  );
  SyncJobsTableData copyWithCompanion(SyncJobsTableCompanion data) {
    return SyncJobsTableData(
      id: data.id.present ? data.id.value : this.id,
      entityType: data.entityType.present
          ? data.entityType.value
          : this.entityType,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      syncType: data.syncType.present ? data.syncType.value : this.syncType,
      attempts: data.attempts.present ? data.attempts.value : this.attempts,
      lastError: data.lastError.present ? data.lastError.value : this.lastError,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncJobsTableData(')
          ..write('id: $id, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('syncType: $syncType, ')
          ..write('attempts: $attempts, ')
          ..write('lastError: $lastError, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    entityType,
    entityId,
    syncType,
    attempts,
    lastError,
    status,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncJobsTableData &&
          other.id == this.id &&
          other.entityType == this.entityType &&
          other.entityId == this.entityId &&
          other.syncType == this.syncType &&
          other.attempts == this.attempts &&
          other.lastError == this.lastError &&
          other.status == this.status &&
          other.createdAt == this.createdAt);
}

class SyncJobsTableCompanion extends UpdateCompanion<SyncJobsTableData> {
  final Value<String> id;
  final Value<String> entityType;
  final Value<String> entityId;
  final Value<String> syncType;
  final Value<int> attempts;
  final Value<String?> lastError;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const SyncJobsTableCompanion({
    this.id = const Value.absent(),
    this.entityType = const Value.absent(),
    this.entityId = const Value.absent(),
    this.syncType = const Value.absent(),
    this.attempts = const Value.absent(),
    this.lastError = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncJobsTableCompanion.insert({
    required String id,
    required String entityType,
    required String entityId,
    required String syncType,
    this.attempts = const Value.absent(),
    this.lastError = const Value.absent(),
    this.status = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       entityType = Value(entityType),
       entityId = Value(entityId),
       syncType = Value(syncType),
       createdAt = Value(createdAt);
  static Insertable<SyncJobsTableData> custom({
    Expression<String>? id,
    Expression<String>? entityType,
    Expression<String>? entityId,
    Expression<String>? syncType,
    Expression<int>? attempts,
    Expression<String>? lastError,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (entityType != null) 'entity_type': entityType,
      if (entityId != null) 'entity_id': entityId,
      if (syncType != null) 'sync_type': syncType,
      if (attempts != null) 'attempts': attempts,
      if (lastError != null) 'last_error': lastError,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncJobsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? entityType,
    Value<String>? entityId,
    Value<String>? syncType,
    Value<int>? attempts,
    Value<String?>? lastError,
    Value<String>? status,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return SyncJobsTableCompanion(
      id: id ?? this.id,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      syncType: syncType ?? this.syncType,
      attempts: attempts ?? this.attempts,
      lastError: lastError ?? this.lastError,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (syncType.present) {
      map['sync_type'] = Variable<String>(syncType.value);
    }
    if (attempts.present) {
      map['attempts'] = Variable<int>(attempts.value);
    }
    if (lastError.present) {
      map['last_error'] = Variable<String>(lastError.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncJobsTableCompanion(')
          ..write('id: $id, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('syncType: $syncType, ')
          ..write('attempts: $attempts, ')
          ..write('lastError: $lastError, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SessionsTableTable extends SessionsTable
    with TableInfo<$SessionsTableTable, SessionsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SessionsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _eventIdMeta = const VerificationMeta(
    'eventId',
  );
  @override
  late final GeneratedColumn<String> eventId = GeneratedColumn<String>(
    'event_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _guestNameMeta = const VerificationMeta(
    'guestName',
  );
  @override
  late final GeneratedColumn<String> guestName = GeneratedColumn<String>(
    'guest_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _countryCodeMeta = const VerificationMeta(
    'countryCode',
  );
  @override
  late final GeneratedColumn<String> countryCode = GeneratedColumn<String>(
    'country_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('+56'),
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deviceIdMeta = const VerificationMeta(
    'deviceId',
  );
  @override
  late final GeneratedColumn<String> deviceId = GeneratedColumn<String>(
    'device_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('registered'),
  );
  static const VerificationMeta _durationSecondsOverrideMeta =
      const VerificationMeta('durationSecondsOverride');
  @override
  late final GeneratedColumn<int> durationSecondsOverride =
      GeneratedColumn<int>(
        'duration_seconds_override',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _effectsOverrideMeta = const VerificationMeta(
    'effectsOverride',
  );
  @override
  late final GeneratedColumn<String> effectsOverride = GeneratedColumn<String>(
    'effects_override',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _countdownSecondsOverrideMeta =
      const VerificationMeta('countdownSecondsOverride');
  @override
  late final GeneratedColumn<int> countdownSecondsOverride =
      GeneratedColumn<int>(
        'countdown_seconds_override',
        aliasedName,
        true,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _maxTakesOverrideMeta = const VerificationMeta(
    'maxTakesOverride',
  );
  @override
  late final GeneratedColumn<int> maxTakesOverride = GeneratedColumn<int>(
    'max_takes_override',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    eventId,
    guestName,
    phone,
    countryCode,
    notes,
    deviceId,
    status,
    durationSecondsOverride,
    effectsOverride,
    countdownSecondsOverride,
    maxTakesOverride,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sessions_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<SessionsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('event_id')) {
      context.handle(
        _eventIdMeta,
        eventId.isAcceptableOrUnknown(data['event_id']!, _eventIdMeta),
      );
    } else if (isInserting) {
      context.missing(_eventIdMeta);
    }
    if (data.containsKey('guest_name')) {
      context.handle(
        _guestNameMeta,
        guestName.isAcceptableOrUnknown(data['guest_name']!, _guestNameMeta),
      );
    } else if (isInserting) {
      context.missing(_guestNameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    } else if (isInserting) {
      context.missing(_phoneMeta);
    }
    if (data.containsKey('country_code')) {
      context.handle(
        _countryCodeMeta,
        countryCode.isAcceptableOrUnknown(
          data['country_code']!,
          _countryCodeMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('device_id')) {
      context.handle(
        _deviceIdMeta,
        deviceId.isAcceptableOrUnknown(data['device_id']!, _deviceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_deviceIdMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('duration_seconds_override')) {
      context.handle(
        _durationSecondsOverrideMeta,
        durationSecondsOverride.isAcceptableOrUnknown(
          data['duration_seconds_override']!,
          _durationSecondsOverrideMeta,
        ),
      );
    }
    if (data.containsKey('effects_override')) {
      context.handle(
        _effectsOverrideMeta,
        effectsOverride.isAcceptableOrUnknown(
          data['effects_override']!,
          _effectsOverrideMeta,
        ),
      );
    }
    if (data.containsKey('countdown_seconds_override')) {
      context.handle(
        _countdownSecondsOverrideMeta,
        countdownSecondsOverride.isAcceptableOrUnknown(
          data['countdown_seconds_override']!,
          _countdownSecondsOverrideMeta,
        ),
      );
    }
    if (data.containsKey('max_takes_override')) {
      context.handle(
        _maxTakesOverrideMeta,
        maxTakesOverride.isAcceptableOrUnknown(
          data['max_takes_override']!,
          _maxTakesOverrideMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SessionsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SessionsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      eventId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_id'],
      )!,
      guestName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}guest_name'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      )!,
      countryCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}country_code'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      deviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}device_id'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      durationSecondsOverride: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_seconds_override'],
      ),
      effectsOverride: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}effects_override'],
      ),
      countdownSecondsOverride: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}countdown_seconds_override'],
      ),
      maxTakesOverride: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_takes_override'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SessionsTableTable createAlias(String alias) {
    return $SessionsTableTable(attachedDatabase, alias);
  }
}

class SessionsTableData extends DataClass
    implements Insertable<SessionsTableData> {
  final String id;
  final String eventId;
  final String guestName;
  final String phone;
  final String countryCode;
  final String? notes;
  final String deviceId;
  final String status;
  final int? durationSecondsOverride;
  final String? effectsOverride;
  final int? countdownSecondsOverride;
  final int? maxTakesOverride;
  final DateTime createdAt;
  const SessionsTableData({
    required this.id,
    required this.eventId,
    required this.guestName,
    required this.phone,
    required this.countryCode,
    this.notes,
    required this.deviceId,
    required this.status,
    this.durationSecondsOverride,
    this.effectsOverride,
    this.countdownSecondsOverride,
    this.maxTakesOverride,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['event_id'] = Variable<String>(eventId);
    map['guest_name'] = Variable<String>(guestName);
    map['phone'] = Variable<String>(phone);
    map['country_code'] = Variable<String>(countryCode);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['device_id'] = Variable<String>(deviceId);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || durationSecondsOverride != null) {
      map['duration_seconds_override'] = Variable<int>(durationSecondsOverride);
    }
    if (!nullToAbsent || effectsOverride != null) {
      map['effects_override'] = Variable<String>(effectsOverride);
    }
    if (!nullToAbsent || countdownSecondsOverride != null) {
      map['countdown_seconds_override'] = Variable<int>(
        countdownSecondsOverride,
      );
    }
    if (!nullToAbsent || maxTakesOverride != null) {
      map['max_takes_override'] = Variable<int>(maxTakesOverride);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SessionsTableCompanion toCompanion(bool nullToAbsent) {
    return SessionsTableCompanion(
      id: Value(id),
      eventId: Value(eventId),
      guestName: Value(guestName),
      phone: Value(phone),
      countryCode: Value(countryCode),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      deviceId: Value(deviceId),
      status: Value(status),
      durationSecondsOverride: durationSecondsOverride == null && nullToAbsent
          ? const Value.absent()
          : Value(durationSecondsOverride),
      effectsOverride: effectsOverride == null && nullToAbsent
          ? const Value.absent()
          : Value(effectsOverride),
      countdownSecondsOverride: countdownSecondsOverride == null && nullToAbsent
          ? const Value.absent()
          : Value(countdownSecondsOverride),
      maxTakesOverride: maxTakesOverride == null && nullToAbsent
          ? const Value.absent()
          : Value(maxTakesOverride),
      createdAt: Value(createdAt),
    );
  }

  factory SessionsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SessionsTableData(
      id: serializer.fromJson<String>(json['id']),
      eventId: serializer.fromJson<String>(json['eventId']),
      guestName: serializer.fromJson<String>(json['guestName']),
      phone: serializer.fromJson<String>(json['phone']),
      countryCode: serializer.fromJson<String>(json['countryCode']),
      notes: serializer.fromJson<String?>(json['notes']),
      deviceId: serializer.fromJson<String>(json['deviceId']),
      status: serializer.fromJson<String>(json['status']),
      durationSecondsOverride: serializer.fromJson<int?>(
        json['durationSecondsOverride'],
      ),
      effectsOverride: serializer.fromJson<String?>(json['effectsOverride']),
      countdownSecondsOverride: serializer.fromJson<int?>(
        json['countdownSecondsOverride'],
      ),
      maxTakesOverride: serializer.fromJson<int?>(json['maxTakesOverride']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'eventId': serializer.toJson<String>(eventId),
      'guestName': serializer.toJson<String>(guestName),
      'phone': serializer.toJson<String>(phone),
      'countryCode': serializer.toJson<String>(countryCode),
      'notes': serializer.toJson<String?>(notes),
      'deviceId': serializer.toJson<String>(deviceId),
      'status': serializer.toJson<String>(status),
      'durationSecondsOverride': serializer.toJson<int?>(
        durationSecondsOverride,
      ),
      'effectsOverride': serializer.toJson<String?>(effectsOverride),
      'countdownSecondsOverride': serializer.toJson<int?>(
        countdownSecondsOverride,
      ),
      'maxTakesOverride': serializer.toJson<int?>(maxTakesOverride),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SessionsTableData copyWith({
    String? id,
    String? eventId,
    String? guestName,
    String? phone,
    String? countryCode,
    Value<String?> notes = const Value.absent(),
    String? deviceId,
    String? status,
    Value<int?> durationSecondsOverride = const Value.absent(),
    Value<String?> effectsOverride = const Value.absent(),
    Value<int?> countdownSecondsOverride = const Value.absent(),
    Value<int?> maxTakesOverride = const Value.absent(),
    DateTime? createdAt,
  }) => SessionsTableData(
    id: id ?? this.id,
    eventId: eventId ?? this.eventId,
    guestName: guestName ?? this.guestName,
    phone: phone ?? this.phone,
    countryCode: countryCode ?? this.countryCode,
    notes: notes.present ? notes.value : this.notes,
    deviceId: deviceId ?? this.deviceId,
    status: status ?? this.status,
    durationSecondsOverride: durationSecondsOverride.present
        ? durationSecondsOverride.value
        : this.durationSecondsOverride,
    effectsOverride: effectsOverride.present
        ? effectsOverride.value
        : this.effectsOverride,
    countdownSecondsOverride: countdownSecondsOverride.present
        ? countdownSecondsOverride.value
        : this.countdownSecondsOverride,
    maxTakesOverride: maxTakesOverride.present
        ? maxTakesOverride.value
        : this.maxTakesOverride,
    createdAt: createdAt ?? this.createdAt,
  );
  SessionsTableData copyWithCompanion(SessionsTableCompanion data) {
    return SessionsTableData(
      id: data.id.present ? data.id.value : this.id,
      eventId: data.eventId.present ? data.eventId.value : this.eventId,
      guestName: data.guestName.present ? data.guestName.value : this.guestName,
      phone: data.phone.present ? data.phone.value : this.phone,
      countryCode: data.countryCode.present
          ? data.countryCode.value
          : this.countryCode,
      notes: data.notes.present ? data.notes.value : this.notes,
      deviceId: data.deviceId.present ? data.deviceId.value : this.deviceId,
      status: data.status.present ? data.status.value : this.status,
      durationSecondsOverride: data.durationSecondsOverride.present
          ? data.durationSecondsOverride.value
          : this.durationSecondsOverride,
      effectsOverride: data.effectsOverride.present
          ? data.effectsOverride.value
          : this.effectsOverride,
      countdownSecondsOverride: data.countdownSecondsOverride.present
          ? data.countdownSecondsOverride.value
          : this.countdownSecondsOverride,
      maxTakesOverride: data.maxTakesOverride.present
          ? data.maxTakesOverride.value
          : this.maxTakesOverride,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SessionsTableData(')
          ..write('id: $id, ')
          ..write('eventId: $eventId, ')
          ..write('guestName: $guestName, ')
          ..write('phone: $phone, ')
          ..write('countryCode: $countryCode, ')
          ..write('notes: $notes, ')
          ..write('deviceId: $deviceId, ')
          ..write('status: $status, ')
          ..write('durationSecondsOverride: $durationSecondsOverride, ')
          ..write('effectsOverride: $effectsOverride, ')
          ..write('countdownSecondsOverride: $countdownSecondsOverride, ')
          ..write('maxTakesOverride: $maxTakesOverride, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    eventId,
    guestName,
    phone,
    countryCode,
    notes,
    deviceId,
    status,
    durationSecondsOverride,
    effectsOverride,
    countdownSecondsOverride,
    maxTakesOverride,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SessionsTableData &&
          other.id == this.id &&
          other.eventId == this.eventId &&
          other.guestName == this.guestName &&
          other.phone == this.phone &&
          other.countryCode == this.countryCode &&
          other.notes == this.notes &&
          other.deviceId == this.deviceId &&
          other.status == this.status &&
          other.durationSecondsOverride == this.durationSecondsOverride &&
          other.effectsOverride == this.effectsOverride &&
          other.countdownSecondsOverride == this.countdownSecondsOverride &&
          other.maxTakesOverride == this.maxTakesOverride &&
          other.createdAt == this.createdAt);
}

class SessionsTableCompanion extends UpdateCompanion<SessionsTableData> {
  final Value<String> id;
  final Value<String> eventId;
  final Value<String> guestName;
  final Value<String> phone;
  final Value<String> countryCode;
  final Value<String?> notes;
  final Value<String> deviceId;
  final Value<String> status;
  final Value<int?> durationSecondsOverride;
  final Value<String?> effectsOverride;
  final Value<int?> countdownSecondsOverride;
  final Value<int?> maxTakesOverride;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const SessionsTableCompanion({
    this.id = const Value.absent(),
    this.eventId = const Value.absent(),
    this.guestName = const Value.absent(),
    this.phone = const Value.absent(),
    this.countryCode = const Value.absent(),
    this.notes = const Value.absent(),
    this.deviceId = const Value.absent(),
    this.status = const Value.absent(),
    this.durationSecondsOverride = const Value.absent(),
    this.effectsOverride = const Value.absent(),
    this.countdownSecondsOverride = const Value.absent(),
    this.maxTakesOverride = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SessionsTableCompanion.insert({
    required String id,
    required String eventId,
    required String guestName,
    required String phone,
    this.countryCode = const Value.absent(),
    this.notes = const Value.absent(),
    required String deviceId,
    this.status = const Value.absent(),
    this.durationSecondsOverride = const Value.absent(),
    this.effectsOverride = const Value.absent(),
    this.countdownSecondsOverride = const Value.absent(),
    this.maxTakesOverride = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       eventId = Value(eventId),
       guestName = Value(guestName),
       phone = Value(phone),
       deviceId = Value(deviceId),
       createdAt = Value(createdAt);
  static Insertable<SessionsTableData> custom({
    Expression<String>? id,
    Expression<String>? eventId,
    Expression<String>? guestName,
    Expression<String>? phone,
    Expression<String>? countryCode,
    Expression<String>? notes,
    Expression<String>? deviceId,
    Expression<String>? status,
    Expression<int>? durationSecondsOverride,
    Expression<String>? effectsOverride,
    Expression<int>? countdownSecondsOverride,
    Expression<int>? maxTakesOverride,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (eventId != null) 'event_id': eventId,
      if (guestName != null) 'guest_name': guestName,
      if (phone != null) 'phone': phone,
      if (countryCode != null) 'country_code': countryCode,
      if (notes != null) 'notes': notes,
      if (deviceId != null) 'device_id': deviceId,
      if (status != null) 'status': status,
      if (durationSecondsOverride != null)
        'duration_seconds_override': durationSecondsOverride,
      if (effectsOverride != null) 'effects_override': effectsOverride,
      if (countdownSecondsOverride != null)
        'countdown_seconds_override': countdownSecondsOverride,
      if (maxTakesOverride != null) 'max_takes_override': maxTakesOverride,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SessionsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? eventId,
    Value<String>? guestName,
    Value<String>? phone,
    Value<String>? countryCode,
    Value<String?>? notes,
    Value<String>? deviceId,
    Value<String>? status,
    Value<int?>? durationSecondsOverride,
    Value<String?>? effectsOverride,
    Value<int?>? countdownSecondsOverride,
    Value<int?>? maxTakesOverride,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return SessionsTableCompanion(
      id: id ?? this.id,
      eventId: eventId ?? this.eventId,
      guestName: guestName ?? this.guestName,
      phone: phone ?? this.phone,
      countryCode: countryCode ?? this.countryCode,
      notes: notes ?? this.notes,
      deviceId: deviceId ?? this.deviceId,
      status: status ?? this.status,
      durationSecondsOverride:
          durationSecondsOverride ?? this.durationSecondsOverride,
      effectsOverride: effectsOverride ?? this.effectsOverride,
      countdownSecondsOverride:
          countdownSecondsOverride ?? this.countdownSecondsOverride,
      maxTakesOverride: maxTakesOverride ?? this.maxTakesOverride,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (eventId.present) {
      map['event_id'] = Variable<String>(eventId.value);
    }
    if (guestName.present) {
      map['guest_name'] = Variable<String>(guestName.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (countryCode.present) {
      map['country_code'] = Variable<String>(countryCode.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (deviceId.present) {
      map['device_id'] = Variable<String>(deviceId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (durationSecondsOverride.present) {
      map['duration_seconds_override'] = Variable<int>(
        durationSecondsOverride.value,
      );
    }
    if (effectsOverride.present) {
      map['effects_override'] = Variable<String>(effectsOverride.value);
    }
    if (countdownSecondsOverride.present) {
      map['countdown_seconds_override'] = Variable<int>(
        countdownSecondsOverride.value,
      );
    }
    if (maxTakesOverride.present) {
      map['max_takes_override'] = Variable<int>(maxTakesOverride.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SessionsTableCompanion(')
          ..write('id: $id, ')
          ..write('eventId: $eventId, ')
          ..write('guestName: $guestName, ')
          ..write('phone: $phone, ')
          ..write('countryCode: $countryCode, ')
          ..write('notes: $notes, ')
          ..write('deviceId: $deviceId, ')
          ..write('status: $status, ')
          ..write('durationSecondsOverride: $durationSecondsOverride, ')
          ..write('effectsOverride: $effectsOverride, ')
          ..write('countdownSecondsOverride: $countdownSecondsOverride, ')
          ..write('maxTakesOverride: $maxTakesOverride, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SessionAssetsTableTable extends SessionAssetsTable
    with TableInfo<$SessionAssetsTableTable, SessionAssetsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SessionAssetsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _localPathMeta = const VerificationMeta(
    'localPath',
  );
  @override
  late final GeneratedColumn<String> localPath = GeneratedColumn<String>(
    'local_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fileSizeBytesMeta = const VerificationMeta(
    'fileSizeBytes',
  );
  @override
  late final GeneratedColumn<int> fileSizeBytes = GeneratedColumn<int>(
    'file_size_bytes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _durationMsMeta = const VerificationMeta(
    'durationMs',
  );
  @override
  late final GeneratedColumn<int> durationMs = GeneratedColumn<int>(
    'duration_ms',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _takeNumberMeta = const VerificationMeta(
    'takeNumber',
  );
  @override
  late final GeneratedColumn<int> takeNumber = GeneratedColumn<int>(
    'take_number',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sessionId,
    localPath,
    fileSizeBytes,
    durationMs,
    takeNumber,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'session_assets_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<SessionAssetsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('local_path')) {
      context.handle(
        _localPathMeta,
        localPath.isAcceptableOrUnknown(data['local_path']!, _localPathMeta),
      );
    } else if (isInserting) {
      context.missing(_localPathMeta);
    }
    if (data.containsKey('file_size_bytes')) {
      context.handle(
        _fileSizeBytesMeta,
        fileSizeBytes.isAcceptableOrUnknown(
          data['file_size_bytes']!,
          _fileSizeBytesMeta,
        ),
      );
    }
    if (data.containsKey('duration_ms')) {
      context.handle(
        _durationMsMeta,
        durationMs.isAcceptableOrUnknown(data['duration_ms']!, _durationMsMeta),
      );
    }
    if (data.containsKey('take_number')) {
      context.handle(
        _takeNumberMeta,
        takeNumber.isAcceptableOrUnknown(data['take_number']!, _takeNumberMeta),
      );
    } else if (isInserting) {
      context.missing(_takeNumberMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SessionAssetsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SessionAssetsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_id'],
      )!,
      localPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_path'],
      )!,
      fileSizeBytes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}file_size_bytes'],
      )!,
      durationMs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_ms'],
      )!,
      takeNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}take_number'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SessionAssetsTableTable createAlias(String alias) {
    return $SessionAssetsTableTable(attachedDatabase, alias);
  }
}

class SessionAssetsTableData extends DataClass
    implements Insertable<SessionAssetsTableData> {
  final String id;
  final String sessionId;
  final String localPath;
  final int fileSizeBytes;
  final int durationMs;
  final int takeNumber;
  final DateTime createdAt;
  const SessionAssetsTableData({
    required this.id,
    required this.sessionId,
    required this.localPath,
    required this.fileSizeBytes,
    required this.durationMs,
    required this.takeNumber,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['session_id'] = Variable<String>(sessionId);
    map['local_path'] = Variable<String>(localPath);
    map['file_size_bytes'] = Variable<int>(fileSizeBytes);
    map['duration_ms'] = Variable<int>(durationMs);
    map['take_number'] = Variable<int>(takeNumber);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SessionAssetsTableCompanion toCompanion(bool nullToAbsent) {
    return SessionAssetsTableCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      localPath: Value(localPath),
      fileSizeBytes: Value(fileSizeBytes),
      durationMs: Value(durationMs),
      takeNumber: Value(takeNumber),
      createdAt: Value(createdAt),
    );
  }

  factory SessionAssetsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SessionAssetsTableData(
      id: serializer.fromJson<String>(json['id']),
      sessionId: serializer.fromJson<String>(json['sessionId']),
      localPath: serializer.fromJson<String>(json['localPath']),
      fileSizeBytes: serializer.fromJson<int>(json['fileSizeBytes']),
      durationMs: serializer.fromJson<int>(json['durationMs']),
      takeNumber: serializer.fromJson<int>(json['takeNumber']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sessionId': serializer.toJson<String>(sessionId),
      'localPath': serializer.toJson<String>(localPath),
      'fileSizeBytes': serializer.toJson<int>(fileSizeBytes),
      'durationMs': serializer.toJson<int>(durationMs),
      'takeNumber': serializer.toJson<int>(takeNumber),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SessionAssetsTableData copyWith({
    String? id,
    String? sessionId,
    String? localPath,
    int? fileSizeBytes,
    int? durationMs,
    int? takeNumber,
    DateTime? createdAt,
  }) => SessionAssetsTableData(
    id: id ?? this.id,
    sessionId: sessionId ?? this.sessionId,
    localPath: localPath ?? this.localPath,
    fileSizeBytes: fileSizeBytes ?? this.fileSizeBytes,
    durationMs: durationMs ?? this.durationMs,
    takeNumber: takeNumber ?? this.takeNumber,
    createdAt: createdAt ?? this.createdAt,
  );
  SessionAssetsTableData copyWithCompanion(SessionAssetsTableCompanion data) {
    return SessionAssetsTableData(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      localPath: data.localPath.present ? data.localPath.value : this.localPath,
      fileSizeBytes: data.fileSizeBytes.present
          ? data.fileSizeBytes.value
          : this.fileSizeBytes,
      durationMs: data.durationMs.present
          ? data.durationMs.value
          : this.durationMs,
      takeNumber: data.takeNumber.present
          ? data.takeNumber.value
          : this.takeNumber,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SessionAssetsTableData(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('localPath: $localPath, ')
          ..write('fileSizeBytes: $fileSizeBytes, ')
          ..write('durationMs: $durationMs, ')
          ..write('takeNumber: $takeNumber, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    sessionId,
    localPath,
    fileSizeBytes,
    durationMs,
    takeNumber,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SessionAssetsTableData &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.localPath == this.localPath &&
          other.fileSizeBytes == this.fileSizeBytes &&
          other.durationMs == this.durationMs &&
          other.takeNumber == this.takeNumber &&
          other.createdAt == this.createdAt);
}

class SessionAssetsTableCompanion
    extends UpdateCompanion<SessionAssetsTableData> {
  final Value<String> id;
  final Value<String> sessionId;
  final Value<String> localPath;
  final Value<int> fileSizeBytes;
  final Value<int> durationMs;
  final Value<int> takeNumber;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const SessionAssetsTableCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.localPath = const Value.absent(),
    this.fileSizeBytes = const Value.absent(),
    this.durationMs = const Value.absent(),
    this.takeNumber = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SessionAssetsTableCompanion.insert({
    required String id,
    required String sessionId,
    required String localPath,
    this.fileSizeBytes = const Value.absent(),
    this.durationMs = const Value.absent(),
    required int takeNumber,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       sessionId = Value(sessionId),
       localPath = Value(localPath),
       takeNumber = Value(takeNumber),
       createdAt = Value(createdAt);
  static Insertable<SessionAssetsTableData> custom({
    Expression<String>? id,
    Expression<String>? sessionId,
    Expression<String>? localPath,
    Expression<int>? fileSizeBytes,
    Expression<int>? durationMs,
    Expression<int>? takeNumber,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (localPath != null) 'local_path': localPath,
      if (fileSizeBytes != null) 'file_size_bytes': fileSizeBytes,
      if (durationMs != null) 'duration_ms': durationMs,
      if (takeNumber != null) 'take_number': takeNumber,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SessionAssetsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? sessionId,
    Value<String>? localPath,
    Value<int>? fileSizeBytes,
    Value<int>? durationMs,
    Value<int>? takeNumber,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return SessionAssetsTableCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      localPath: localPath ?? this.localPath,
      fileSizeBytes: fileSizeBytes ?? this.fileSizeBytes,
      durationMs: durationMs ?? this.durationMs,
      takeNumber: takeNumber ?? this.takeNumber,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (localPath.present) {
      map['local_path'] = Variable<String>(localPath.value);
    }
    if (fileSizeBytes.present) {
      map['file_size_bytes'] = Variable<int>(fileSizeBytes.value);
    }
    if (durationMs.present) {
      map['duration_ms'] = Variable<int>(durationMs.value);
    }
    if (takeNumber.present) {
      map['take_number'] = Variable<int>(takeNumber.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SessionAssetsTableCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('localPath: $localPath, ')
          ..write('fileSizeBytes: $fileSizeBytes, ')
          ..write('durationMs: $durationMs, ')
          ..write('takeNumber: $takeNumber, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RecordingConfigsTableTable extends RecordingConfigsTable
    with TableInfo<$RecordingConfigsTableTable, RecordingConfigsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecordingConfigsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _eventIdMeta = const VerificationMeta(
    'eventId',
  );
  @override
  late final GeneratedColumn<String> eventId = GeneratedColumn<String>(
    'event_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationSecondsMeta = const VerificationMeta(
    'durationSeconds',
  );
  @override
  late final GeneratedColumn<int> durationSeconds = GeneratedColumn<int>(
    'duration_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(30),
  );
  static const VerificationMeta _resolutionMeta = const VerificationMeta(
    'resolution',
  );
  @override
  late final GeneratedColumn<String> resolution = GeneratedColumn<String>(
    'resolution',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('1080p'),
  );
  static const VerificationMeta _cameraFacingMeta = const VerificationMeta(
    'cameraFacing',
  );
  @override
  late final GeneratedColumn<String> cameraFacing = GeneratedColumn<String>(
    'camera_facing',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('back'),
  );
  static const VerificationMeta _qualityMeta = const VerificationMeta(
    'quality',
  );
  @override
  late final GeneratedColumn<String> quality = GeneratedColumn<String>(
    'quality',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('high'),
  );
  static const VerificationMeta _defaultEffectsMeta = const VerificationMeta(
    'defaultEffects',
  );
  @override
  late final GeneratedColumn<String> defaultEffects = GeneratedColumn<String>(
    'default_effects',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _maxTakesPerSessionMeta =
      const VerificationMeta('maxTakesPerSession');
  @override
  late final GeneratedColumn<int> maxTakesPerSession = GeneratedColumn<int>(
    'max_takes_per_session',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(3),
  );
  static const VerificationMeta _countdownSecondsMeta = const VerificationMeta(
    'countdownSeconds',
  );
  @override
  late final GeneratedColumn<int> countdownSeconds = GeneratedColumn<int>(
    'countdown_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(3),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    eventId,
    durationSeconds,
    resolution,
    cameraFacing,
    quality,
    defaultEffects,
    maxTakesPerSession,
    countdownSeconds,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recording_configs_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<RecordingConfigsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('event_id')) {
      context.handle(
        _eventIdMeta,
        eventId.isAcceptableOrUnknown(data['event_id']!, _eventIdMeta),
      );
    } else if (isInserting) {
      context.missing(_eventIdMeta);
    }
    if (data.containsKey('duration_seconds')) {
      context.handle(
        _durationSecondsMeta,
        durationSeconds.isAcceptableOrUnknown(
          data['duration_seconds']!,
          _durationSecondsMeta,
        ),
      );
    }
    if (data.containsKey('resolution')) {
      context.handle(
        _resolutionMeta,
        resolution.isAcceptableOrUnknown(data['resolution']!, _resolutionMeta),
      );
    }
    if (data.containsKey('camera_facing')) {
      context.handle(
        _cameraFacingMeta,
        cameraFacing.isAcceptableOrUnknown(
          data['camera_facing']!,
          _cameraFacingMeta,
        ),
      );
    }
    if (data.containsKey('quality')) {
      context.handle(
        _qualityMeta,
        quality.isAcceptableOrUnknown(data['quality']!, _qualityMeta),
      );
    }
    if (data.containsKey('default_effects')) {
      context.handle(
        _defaultEffectsMeta,
        defaultEffects.isAcceptableOrUnknown(
          data['default_effects']!,
          _defaultEffectsMeta,
        ),
      );
    }
    if (data.containsKey('max_takes_per_session')) {
      context.handle(
        _maxTakesPerSessionMeta,
        maxTakesPerSession.isAcceptableOrUnknown(
          data['max_takes_per_session']!,
          _maxTakesPerSessionMeta,
        ),
      );
    }
    if (data.containsKey('countdown_seconds')) {
      context.handle(
        _countdownSecondsMeta,
        countdownSeconds.isAcceptableOrUnknown(
          data['countdown_seconds']!,
          _countdownSecondsMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {eventId},
  ];
  @override
  RecordingConfigsTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecordingConfigsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      eventId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}event_id'],
      )!,
      durationSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_seconds'],
      )!,
      resolution: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}resolution'],
      )!,
      cameraFacing: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}camera_facing'],
      )!,
      quality: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}quality'],
      )!,
      defaultEffects: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}default_effects'],
      )!,
      maxTakesPerSession: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_takes_per_session'],
      )!,
      countdownSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}countdown_seconds'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $RecordingConfigsTableTable createAlias(String alias) {
    return $RecordingConfigsTableTable(attachedDatabase, alias);
  }
}

class RecordingConfigsTableData extends DataClass
    implements Insertable<RecordingConfigsTableData> {
  final String id;
  final String eventId;
  final int durationSeconds;
  final String resolution;
  final String cameraFacing;
  final String quality;
  final String defaultEffects;
  final int maxTakesPerSession;
  final int countdownSeconds;
  final DateTime updatedAt;
  const RecordingConfigsTableData({
    required this.id,
    required this.eventId,
    required this.durationSeconds,
    required this.resolution,
    required this.cameraFacing,
    required this.quality,
    required this.defaultEffects,
    required this.maxTakesPerSession,
    required this.countdownSeconds,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['event_id'] = Variable<String>(eventId);
    map['duration_seconds'] = Variable<int>(durationSeconds);
    map['resolution'] = Variable<String>(resolution);
    map['camera_facing'] = Variable<String>(cameraFacing);
    map['quality'] = Variable<String>(quality);
    map['default_effects'] = Variable<String>(defaultEffects);
    map['max_takes_per_session'] = Variable<int>(maxTakesPerSession);
    map['countdown_seconds'] = Variable<int>(countdownSeconds);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  RecordingConfigsTableCompanion toCompanion(bool nullToAbsent) {
    return RecordingConfigsTableCompanion(
      id: Value(id),
      eventId: Value(eventId),
      durationSeconds: Value(durationSeconds),
      resolution: Value(resolution),
      cameraFacing: Value(cameraFacing),
      quality: Value(quality),
      defaultEffects: Value(defaultEffects),
      maxTakesPerSession: Value(maxTakesPerSession),
      countdownSeconds: Value(countdownSeconds),
      updatedAt: Value(updatedAt),
    );
  }

  factory RecordingConfigsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecordingConfigsTableData(
      id: serializer.fromJson<String>(json['id']),
      eventId: serializer.fromJson<String>(json['eventId']),
      durationSeconds: serializer.fromJson<int>(json['durationSeconds']),
      resolution: serializer.fromJson<String>(json['resolution']),
      cameraFacing: serializer.fromJson<String>(json['cameraFacing']),
      quality: serializer.fromJson<String>(json['quality']),
      defaultEffects: serializer.fromJson<String>(json['defaultEffects']),
      maxTakesPerSession: serializer.fromJson<int>(json['maxTakesPerSession']),
      countdownSeconds: serializer.fromJson<int>(json['countdownSeconds']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'eventId': serializer.toJson<String>(eventId),
      'durationSeconds': serializer.toJson<int>(durationSeconds),
      'resolution': serializer.toJson<String>(resolution),
      'cameraFacing': serializer.toJson<String>(cameraFacing),
      'quality': serializer.toJson<String>(quality),
      'defaultEffects': serializer.toJson<String>(defaultEffects),
      'maxTakesPerSession': serializer.toJson<int>(maxTakesPerSession),
      'countdownSeconds': serializer.toJson<int>(countdownSeconds),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  RecordingConfigsTableData copyWith({
    String? id,
    String? eventId,
    int? durationSeconds,
    String? resolution,
    String? cameraFacing,
    String? quality,
    String? defaultEffects,
    int? maxTakesPerSession,
    int? countdownSeconds,
    DateTime? updatedAt,
  }) => RecordingConfigsTableData(
    id: id ?? this.id,
    eventId: eventId ?? this.eventId,
    durationSeconds: durationSeconds ?? this.durationSeconds,
    resolution: resolution ?? this.resolution,
    cameraFacing: cameraFacing ?? this.cameraFacing,
    quality: quality ?? this.quality,
    defaultEffects: defaultEffects ?? this.defaultEffects,
    maxTakesPerSession: maxTakesPerSession ?? this.maxTakesPerSession,
    countdownSeconds: countdownSeconds ?? this.countdownSeconds,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  RecordingConfigsTableData copyWithCompanion(
    RecordingConfigsTableCompanion data,
  ) {
    return RecordingConfigsTableData(
      id: data.id.present ? data.id.value : this.id,
      eventId: data.eventId.present ? data.eventId.value : this.eventId,
      durationSeconds: data.durationSeconds.present
          ? data.durationSeconds.value
          : this.durationSeconds,
      resolution: data.resolution.present
          ? data.resolution.value
          : this.resolution,
      cameraFacing: data.cameraFacing.present
          ? data.cameraFacing.value
          : this.cameraFacing,
      quality: data.quality.present ? data.quality.value : this.quality,
      defaultEffects: data.defaultEffects.present
          ? data.defaultEffects.value
          : this.defaultEffects,
      maxTakesPerSession: data.maxTakesPerSession.present
          ? data.maxTakesPerSession.value
          : this.maxTakesPerSession,
      countdownSeconds: data.countdownSeconds.present
          ? data.countdownSeconds.value
          : this.countdownSeconds,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecordingConfigsTableData(')
          ..write('id: $id, ')
          ..write('eventId: $eventId, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('resolution: $resolution, ')
          ..write('cameraFacing: $cameraFacing, ')
          ..write('quality: $quality, ')
          ..write('defaultEffects: $defaultEffects, ')
          ..write('maxTakesPerSession: $maxTakesPerSession, ')
          ..write('countdownSeconds: $countdownSeconds, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    eventId,
    durationSeconds,
    resolution,
    cameraFacing,
    quality,
    defaultEffects,
    maxTakesPerSession,
    countdownSeconds,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecordingConfigsTableData &&
          other.id == this.id &&
          other.eventId == this.eventId &&
          other.durationSeconds == this.durationSeconds &&
          other.resolution == this.resolution &&
          other.cameraFacing == this.cameraFacing &&
          other.quality == this.quality &&
          other.defaultEffects == this.defaultEffects &&
          other.maxTakesPerSession == this.maxTakesPerSession &&
          other.countdownSeconds == this.countdownSeconds &&
          other.updatedAt == this.updatedAt);
}

class RecordingConfigsTableCompanion
    extends UpdateCompanion<RecordingConfigsTableData> {
  final Value<String> id;
  final Value<String> eventId;
  final Value<int> durationSeconds;
  final Value<String> resolution;
  final Value<String> cameraFacing;
  final Value<String> quality;
  final Value<String> defaultEffects;
  final Value<int> maxTakesPerSession;
  final Value<int> countdownSeconds;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const RecordingConfigsTableCompanion({
    this.id = const Value.absent(),
    this.eventId = const Value.absent(),
    this.durationSeconds = const Value.absent(),
    this.resolution = const Value.absent(),
    this.cameraFacing = const Value.absent(),
    this.quality = const Value.absent(),
    this.defaultEffects = const Value.absent(),
    this.maxTakesPerSession = const Value.absent(),
    this.countdownSeconds = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RecordingConfigsTableCompanion.insert({
    required String id,
    required String eventId,
    this.durationSeconds = const Value.absent(),
    this.resolution = const Value.absent(),
    this.cameraFacing = const Value.absent(),
    this.quality = const Value.absent(),
    this.defaultEffects = const Value.absent(),
    this.maxTakesPerSession = const Value.absent(),
    this.countdownSeconds = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       eventId = Value(eventId),
       updatedAt = Value(updatedAt);
  static Insertable<RecordingConfigsTableData> custom({
    Expression<String>? id,
    Expression<String>? eventId,
    Expression<int>? durationSeconds,
    Expression<String>? resolution,
    Expression<String>? cameraFacing,
    Expression<String>? quality,
    Expression<String>? defaultEffects,
    Expression<int>? maxTakesPerSession,
    Expression<int>? countdownSeconds,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (eventId != null) 'event_id': eventId,
      if (durationSeconds != null) 'duration_seconds': durationSeconds,
      if (resolution != null) 'resolution': resolution,
      if (cameraFacing != null) 'camera_facing': cameraFacing,
      if (quality != null) 'quality': quality,
      if (defaultEffects != null) 'default_effects': defaultEffects,
      if (maxTakesPerSession != null)
        'max_takes_per_session': maxTakesPerSession,
      if (countdownSeconds != null) 'countdown_seconds': countdownSeconds,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RecordingConfigsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? eventId,
    Value<int>? durationSeconds,
    Value<String>? resolution,
    Value<String>? cameraFacing,
    Value<String>? quality,
    Value<String>? defaultEffects,
    Value<int>? maxTakesPerSession,
    Value<int>? countdownSeconds,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return RecordingConfigsTableCompanion(
      id: id ?? this.id,
      eventId: eventId ?? this.eventId,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      resolution: resolution ?? this.resolution,
      cameraFacing: cameraFacing ?? this.cameraFacing,
      quality: quality ?? this.quality,
      defaultEffects: defaultEffects ?? this.defaultEffects,
      maxTakesPerSession: maxTakesPerSession ?? this.maxTakesPerSession,
      countdownSeconds: countdownSeconds ?? this.countdownSeconds,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (eventId.present) {
      map['event_id'] = Variable<String>(eventId.value);
    }
    if (durationSeconds.present) {
      map['duration_seconds'] = Variable<int>(durationSeconds.value);
    }
    if (resolution.present) {
      map['resolution'] = Variable<String>(resolution.value);
    }
    if (cameraFacing.present) {
      map['camera_facing'] = Variable<String>(cameraFacing.value);
    }
    if (quality.present) {
      map['quality'] = Variable<String>(quality.value);
    }
    if (defaultEffects.present) {
      map['default_effects'] = Variable<String>(defaultEffects.value);
    }
    if (maxTakesPerSession.present) {
      map['max_takes_per_session'] = Variable<int>(maxTakesPerSession.value);
    }
    if (countdownSeconds.present) {
      map['countdown_seconds'] = Variable<int>(countdownSeconds.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecordingConfigsTableCompanion(')
          ..write('id: $id, ')
          ..write('eventId: $eventId, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('resolution: $resolution, ')
          ..write('cameraFacing: $cameraFacing, ')
          ..write('quality: $quality, ')
          ..write('defaultEffects: $defaultEffects, ')
          ..write('maxTakesPerSession: $maxTakesPerSession, ')
          ..write('countdownSeconds: $countdownSeconds, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProcessingJobsTableTable extends ProcessingJobsTable
    with TableInfo<$ProcessingJobsTableTable, ProcessingJobsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProcessingJobsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sessionIdMeta = const VerificationMeta(
    'sessionId',
  );
  @override
  late final GeneratedColumn<String> sessionId = GeneratedColumn<String>(
    'session_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _assetIdMeta = const VerificationMeta(
    'assetId',
  );
  @override
  late final GeneratedColumn<String> assetId = GeneratedColumn<String>(
    'asset_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _jobTypeMeta = const VerificationMeta(
    'jobType',
  );
  @override
  late final GeneratedColumn<String> jobType = GeneratedColumn<String>(
    'job_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priorityMeta = const VerificationMeta(
    'priority',
  );
  @override
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
    'priority',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pending'),
  );
  static const VerificationMeta _progressMeta = const VerificationMeta(
    'progress',
  );
  @override
  late final GeneratedColumn<double> progress = GeneratedColumn<double>(
    'progress',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _attemptsMeta = const VerificationMeta(
    'attempts',
  );
  @override
  late final GeneratedColumn<int> attempts = GeneratedColumn<int>(
    'attempts',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _errorMessageMeta = const VerificationMeta(
    'errorMessage',
  );
  @override
  late final GeneratedColumn<String> errorMessage = GeneratedColumn<String>(
    'error_message',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _finishedAtMeta = const VerificationMeta(
    'finishedAt',
  );
  @override
  late final GeneratedColumn<DateTime> finishedAt = GeneratedColumn<DateTime>(
    'finished_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    sessionId,
    assetId,
    jobType,
    priority,
    payload,
    status,
    progress,
    attempts,
    errorMessage,
    createdAt,
    updatedAt,
    finishedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'processing_jobs_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProcessingJobsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('session_id')) {
      context.handle(
        _sessionIdMeta,
        sessionId.isAcceptableOrUnknown(data['session_id']!, _sessionIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sessionIdMeta);
    }
    if (data.containsKey('asset_id')) {
      context.handle(
        _assetIdMeta,
        assetId.isAcceptableOrUnknown(data['asset_id']!, _assetIdMeta),
      );
    }
    if (data.containsKey('job_type')) {
      context.handle(
        _jobTypeMeta,
        jobType.isAcceptableOrUnknown(data['job_type']!, _jobTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_jobTypeMeta);
    }
    if (data.containsKey('priority')) {
      context.handle(
        _priorityMeta,
        priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta),
      );
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('progress')) {
      context.handle(
        _progressMeta,
        progress.isAcceptableOrUnknown(data['progress']!, _progressMeta),
      );
    }
    if (data.containsKey('attempts')) {
      context.handle(
        _attemptsMeta,
        attempts.isAcceptableOrUnknown(data['attempts']!, _attemptsMeta),
      );
    }
    if (data.containsKey('error_message')) {
      context.handle(
        _errorMessageMeta,
        errorMessage.isAcceptableOrUnknown(
          data['error_message']!,
          _errorMessageMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('finished_at')) {
      context.handle(
        _finishedAtMeta,
        finishedAt.isAcceptableOrUnknown(data['finished_at']!, _finishedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProcessingJobsTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProcessingJobsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      sessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}session_id'],
      )!,
      assetId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}asset_id'],
      ),
      jobType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}job_type'],
      )!,
      priority: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}priority'],
      )!,
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      progress: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}progress'],
      )!,
      attempts: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}attempts'],
      )!,
      errorMessage: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}error_message'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      finishedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}finished_at'],
      ),
    );
  }

  @override
  $ProcessingJobsTableTable createAlias(String alias) {
    return $ProcessingJobsTableTable(attachedDatabase, alias);
  }
}

class ProcessingJobsTableData extends DataClass
    implements Insertable<ProcessingJobsTableData> {
  final String id;
  final String sessionId;
  final String? assetId;
  final String jobType;
  final int priority;
  final String payload;
  final String status;
  final double progress;
  final int attempts;
  final String? errorMessage;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? finishedAt;
  const ProcessingJobsTableData({
    required this.id,
    required this.sessionId,
    this.assetId,
    required this.jobType,
    required this.priority,
    required this.payload,
    required this.status,
    required this.progress,
    required this.attempts,
    this.errorMessage,
    required this.createdAt,
    required this.updatedAt,
    this.finishedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['session_id'] = Variable<String>(sessionId);
    if (!nullToAbsent || assetId != null) {
      map['asset_id'] = Variable<String>(assetId);
    }
    map['job_type'] = Variable<String>(jobType);
    map['priority'] = Variable<int>(priority);
    map['payload'] = Variable<String>(payload);
    map['status'] = Variable<String>(status);
    map['progress'] = Variable<double>(progress);
    map['attempts'] = Variable<int>(attempts);
    if (!nullToAbsent || errorMessage != null) {
      map['error_message'] = Variable<String>(errorMessage);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || finishedAt != null) {
      map['finished_at'] = Variable<DateTime>(finishedAt);
    }
    return map;
  }

  ProcessingJobsTableCompanion toCompanion(bool nullToAbsent) {
    return ProcessingJobsTableCompanion(
      id: Value(id),
      sessionId: Value(sessionId),
      assetId: assetId == null && nullToAbsent
          ? const Value.absent()
          : Value(assetId),
      jobType: Value(jobType),
      priority: Value(priority),
      payload: Value(payload),
      status: Value(status),
      progress: Value(progress),
      attempts: Value(attempts),
      errorMessage: errorMessage == null && nullToAbsent
          ? const Value.absent()
          : Value(errorMessage),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      finishedAt: finishedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(finishedAt),
    );
  }

  factory ProcessingJobsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProcessingJobsTableData(
      id: serializer.fromJson<String>(json['id']),
      sessionId: serializer.fromJson<String>(json['sessionId']),
      assetId: serializer.fromJson<String?>(json['assetId']),
      jobType: serializer.fromJson<String>(json['jobType']),
      priority: serializer.fromJson<int>(json['priority']),
      payload: serializer.fromJson<String>(json['payload']),
      status: serializer.fromJson<String>(json['status']),
      progress: serializer.fromJson<double>(json['progress']),
      attempts: serializer.fromJson<int>(json['attempts']),
      errorMessage: serializer.fromJson<String?>(json['errorMessage']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      finishedAt: serializer.fromJson<DateTime?>(json['finishedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'sessionId': serializer.toJson<String>(sessionId),
      'assetId': serializer.toJson<String?>(assetId),
      'jobType': serializer.toJson<String>(jobType),
      'priority': serializer.toJson<int>(priority),
      'payload': serializer.toJson<String>(payload),
      'status': serializer.toJson<String>(status),
      'progress': serializer.toJson<double>(progress),
      'attempts': serializer.toJson<int>(attempts),
      'errorMessage': serializer.toJson<String?>(errorMessage),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'finishedAt': serializer.toJson<DateTime?>(finishedAt),
    };
  }

  ProcessingJobsTableData copyWith({
    String? id,
    String? sessionId,
    Value<String?> assetId = const Value.absent(),
    String? jobType,
    int? priority,
    String? payload,
    String? status,
    double? progress,
    int? attempts,
    Value<String?> errorMessage = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> finishedAt = const Value.absent(),
  }) => ProcessingJobsTableData(
    id: id ?? this.id,
    sessionId: sessionId ?? this.sessionId,
    assetId: assetId.present ? assetId.value : this.assetId,
    jobType: jobType ?? this.jobType,
    priority: priority ?? this.priority,
    payload: payload ?? this.payload,
    status: status ?? this.status,
    progress: progress ?? this.progress,
    attempts: attempts ?? this.attempts,
    errorMessage: errorMessage.present ? errorMessage.value : this.errorMessage,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    finishedAt: finishedAt.present ? finishedAt.value : this.finishedAt,
  );
  ProcessingJobsTableData copyWithCompanion(ProcessingJobsTableCompanion data) {
    return ProcessingJobsTableData(
      id: data.id.present ? data.id.value : this.id,
      sessionId: data.sessionId.present ? data.sessionId.value : this.sessionId,
      assetId: data.assetId.present ? data.assetId.value : this.assetId,
      jobType: data.jobType.present ? data.jobType.value : this.jobType,
      priority: data.priority.present ? data.priority.value : this.priority,
      payload: data.payload.present ? data.payload.value : this.payload,
      status: data.status.present ? data.status.value : this.status,
      progress: data.progress.present ? data.progress.value : this.progress,
      attempts: data.attempts.present ? data.attempts.value : this.attempts,
      errorMessage: data.errorMessage.present
          ? data.errorMessage.value
          : this.errorMessage,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      finishedAt: data.finishedAt.present
          ? data.finishedAt.value
          : this.finishedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProcessingJobsTableData(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('assetId: $assetId, ')
          ..write('jobType: $jobType, ')
          ..write('priority: $priority, ')
          ..write('payload: $payload, ')
          ..write('status: $status, ')
          ..write('progress: $progress, ')
          ..write('attempts: $attempts, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('finishedAt: $finishedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    sessionId,
    assetId,
    jobType,
    priority,
    payload,
    status,
    progress,
    attempts,
    errorMessage,
    createdAt,
    updatedAt,
    finishedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProcessingJobsTableData &&
          other.id == this.id &&
          other.sessionId == this.sessionId &&
          other.assetId == this.assetId &&
          other.jobType == this.jobType &&
          other.priority == this.priority &&
          other.payload == this.payload &&
          other.status == this.status &&
          other.progress == this.progress &&
          other.attempts == this.attempts &&
          other.errorMessage == this.errorMessage &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.finishedAt == this.finishedAt);
}

class ProcessingJobsTableCompanion
    extends UpdateCompanion<ProcessingJobsTableData> {
  final Value<String> id;
  final Value<String> sessionId;
  final Value<String?> assetId;
  final Value<String> jobType;
  final Value<int> priority;
  final Value<String> payload;
  final Value<String> status;
  final Value<double> progress;
  final Value<int> attempts;
  final Value<String?> errorMessage;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> finishedAt;
  final Value<int> rowid;
  const ProcessingJobsTableCompanion({
    this.id = const Value.absent(),
    this.sessionId = const Value.absent(),
    this.assetId = const Value.absent(),
    this.jobType = const Value.absent(),
    this.priority = const Value.absent(),
    this.payload = const Value.absent(),
    this.status = const Value.absent(),
    this.progress = const Value.absent(),
    this.attempts = const Value.absent(),
    this.errorMessage = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.finishedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProcessingJobsTableCompanion.insert({
    required String id,
    required String sessionId,
    this.assetId = const Value.absent(),
    required String jobType,
    this.priority = const Value.absent(),
    this.payload = const Value.absent(),
    this.status = const Value.absent(),
    this.progress = const Value.absent(),
    this.attempts = const Value.absent(),
    this.errorMessage = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.finishedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       sessionId = Value(sessionId),
       jobType = Value(jobType),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<ProcessingJobsTableData> custom({
    Expression<String>? id,
    Expression<String>? sessionId,
    Expression<String>? assetId,
    Expression<String>? jobType,
    Expression<int>? priority,
    Expression<String>? payload,
    Expression<String>? status,
    Expression<double>? progress,
    Expression<int>? attempts,
    Expression<String>? errorMessage,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? finishedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sessionId != null) 'session_id': sessionId,
      if (assetId != null) 'asset_id': assetId,
      if (jobType != null) 'job_type': jobType,
      if (priority != null) 'priority': priority,
      if (payload != null) 'payload': payload,
      if (status != null) 'status': status,
      if (progress != null) 'progress': progress,
      if (attempts != null) 'attempts': attempts,
      if (errorMessage != null) 'error_message': errorMessage,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (finishedAt != null) 'finished_at': finishedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProcessingJobsTableCompanion copyWith({
    Value<String>? id,
    Value<String>? sessionId,
    Value<String?>? assetId,
    Value<String>? jobType,
    Value<int>? priority,
    Value<String>? payload,
    Value<String>? status,
    Value<double>? progress,
    Value<int>? attempts,
    Value<String?>? errorMessage,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? finishedAt,
    Value<int>? rowid,
  }) {
    return ProcessingJobsTableCompanion(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      assetId: assetId ?? this.assetId,
      jobType: jobType ?? this.jobType,
      priority: priority ?? this.priority,
      payload: payload ?? this.payload,
      status: status ?? this.status,
      progress: progress ?? this.progress,
      attempts: attempts ?? this.attempts,
      errorMessage: errorMessage ?? this.errorMessage,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      finishedAt: finishedAt ?? this.finishedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (sessionId.present) {
      map['session_id'] = Variable<String>(sessionId.value);
    }
    if (assetId.present) {
      map['asset_id'] = Variable<String>(assetId.value);
    }
    if (jobType.present) {
      map['job_type'] = Variable<String>(jobType.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (progress.present) {
      map['progress'] = Variable<double>(progress.value);
    }
    if (attempts.present) {
      map['attempts'] = Variable<int>(attempts.value);
    }
    if (errorMessage.present) {
      map['error_message'] = Variable<String>(errorMessage.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (finishedAt.present) {
      map['finished_at'] = Variable<DateTime>(finishedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProcessingJobsTableCompanion(')
          ..write('id: $id, ')
          ..write('sessionId: $sessionId, ')
          ..write('assetId: $assetId, ')
          ..write('jobType: $jobType, ')
          ..write('priority: $priority, ')
          ..write('payload: $payload, ')
          ..write('status: $status, ')
          ..write('progress: $progress, ')
          ..write('attempts: $attempts, ')
          ..write('errorMessage: $errorMessage, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('finishedAt: $finishedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $EventTemplatesTableTable eventTemplatesTable =
      $EventTemplatesTableTable(this);
  late final $EventsTableTable eventsTable = $EventsTableTable(this);
  late final $EventSettingsTableTable eventSettingsTable =
      $EventSettingsTableTable(this);
  late final $SyncJobsTableTable syncJobsTable = $SyncJobsTableTable(this);
  late final $SessionsTableTable sessionsTable = $SessionsTableTable(this);
  late final $SessionAssetsTableTable sessionAssetsTable =
      $SessionAssetsTableTable(this);
  late final $RecordingConfigsTableTable recordingConfigsTable =
      $RecordingConfigsTableTable(this);
  late final $ProcessingJobsTableTable processingJobsTable =
      $ProcessingJobsTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    eventTemplatesTable,
    eventsTable,
    eventSettingsTable,
    syncJobsTable,
    sessionsTable,
    sessionAssetsTable,
    recordingConfigsTable,
    processingJobsTable,
  ];
}

typedef $$EventTemplatesTableTableCreateCompanionBuilder =
    EventTemplatesTableCompanion Function({
      required String id,
      required String userId,
      required String name,
      Value<int> durationSeconds,
      Value<String> defaultEffects,
      Value<int?> autoDeleteDays,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$EventTemplatesTableTableUpdateCompanionBuilder =
    EventTemplatesTableCompanion Function({
      Value<String> id,
      Value<String> userId,
      Value<String> name,
      Value<int> durationSeconds,
      Value<String> defaultEffects,
      Value<int?> autoDeleteDays,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$EventTemplatesTableTableFilterComposer
    extends Composer<_$AppDatabase, $EventTemplatesTableTable> {
  $$EventTemplatesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get defaultEffects => $composableBuilder(
    column: $table.defaultEffects,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get autoDeleteDays => $composableBuilder(
    column: $table.autoDeleteDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$EventTemplatesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $EventTemplatesTableTable> {
  $$EventTemplatesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get defaultEffects => $composableBuilder(
    column: $table.defaultEffects,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get autoDeleteDays => $composableBuilder(
    column: $table.autoDeleteDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EventTemplatesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $EventTemplatesTableTable> {
  $$EventTemplatesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<String> get defaultEffects => $composableBuilder(
    column: $table.defaultEffects,
    builder: (column) => column,
  );

  GeneratedColumn<int> get autoDeleteDays => $composableBuilder(
    column: $table.autoDeleteDays,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$EventTemplatesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EventTemplatesTableTable,
          EventTemplatesTableData,
          $$EventTemplatesTableTableFilterComposer,
          $$EventTemplatesTableTableOrderingComposer,
          $$EventTemplatesTableTableAnnotationComposer,
          $$EventTemplatesTableTableCreateCompanionBuilder,
          $$EventTemplatesTableTableUpdateCompanionBuilder,
          (
            EventTemplatesTableData,
            BaseReferences<
              _$AppDatabase,
              $EventTemplatesTableTable,
              EventTemplatesTableData
            >,
          ),
          EventTemplatesTableData,
          PrefetchHooks Function()
        > {
  $$EventTemplatesTableTableTableManager(
    _$AppDatabase db,
    $EventTemplatesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EventTemplatesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EventTemplatesTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$EventTemplatesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> durationSeconds = const Value.absent(),
                Value<String> defaultEffects = const Value.absent(),
                Value<int?> autoDeleteDays = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EventTemplatesTableCompanion(
                id: id,
                userId: userId,
                name: name,
                durationSeconds: durationSeconds,
                defaultEffects: defaultEffects,
                autoDeleteDays: autoDeleteDays,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String userId,
                required String name,
                Value<int> durationSeconds = const Value.absent(),
                Value<String> defaultEffects = const Value.absent(),
                Value<int?> autoDeleteDays = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => EventTemplatesTableCompanion.insert(
                id: id,
                userId: userId,
                name: name,
                durationSeconds: durationSeconds,
                defaultEffects: defaultEffects,
                autoDeleteDays: autoDeleteDays,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$EventTemplatesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EventTemplatesTableTable,
      EventTemplatesTableData,
      $$EventTemplatesTableTableFilterComposer,
      $$EventTemplatesTableTableOrderingComposer,
      $$EventTemplatesTableTableAnnotationComposer,
      $$EventTemplatesTableTableCreateCompanionBuilder,
      $$EventTemplatesTableTableUpdateCompanionBuilder,
      (
        EventTemplatesTableData,
        BaseReferences<
          _$AppDatabase,
          $EventTemplatesTableTable,
          EventTemplatesTableData
        >,
      ),
      EventTemplatesTableData,
      PrefetchHooks Function()
    >;
typedef $$EventsTableTableCreateCompanionBuilder =
    EventsTableCompanion Function({
      required String id,
      required String userId,
      Value<String?> templateId,
      required String name,
      required DateTime eventDate,
      required DateTime startDatetime,
      required DateTime endDatetime,
      Value<String> eventStatus,
      Value<String> paymentStatus,
      required String gallerySlug,
      Value<String?> notes,
      Value<bool> synced,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$EventsTableTableUpdateCompanionBuilder =
    EventsTableCompanion Function({
      Value<String> id,
      Value<String> userId,
      Value<String?> templateId,
      Value<String> name,
      Value<DateTime> eventDate,
      Value<DateTime> startDatetime,
      Value<DateTime> endDatetime,
      Value<String> eventStatus,
      Value<String> paymentStatus,
      Value<String> gallerySlug,
      Value<String?> notes,
      Value<bool> synced,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$EventsTableTableFilterComposer
    extends Composer<_$AppDatabase, $EventsTableTable> {
  $$EventsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get templateId => $composableBuilder(
    column: $table.templateId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get eventDate => $composableBuilder(
    column: $table.eventDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get startDatetime => $composableBuilder(
    column: $table.startDatetime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get endDatetime => $composableBuilder(
    column: $table.endDatetime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get eventStatus => $composableBuilder(
    column: $table.eventStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentStatus => $composableBuilder(
    column: $table.paymentStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get gallerySlug => $composableBuilder(
    column: $table.gallerySlug,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get synced => $composableBuilder(
    column: $table.synced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$EventsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $EventsTableTable> {
  $$EventsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get templateId => $composableBuilder(
    column: $table.templateId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get eventDate => $composableBuilder(
    column: $table.eventDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get startDatetime => $composableBuilder(
    column: $table.startDatetime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get endDatetime => $composableBuilder(
    column: $table.endDatetime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get eventStatus => $composableBuilder(
    column: $table.eventStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentStatus => $composableBuilder(
    column: $table.paymentStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get gallerySlug => $composableBuilder(
    column: $table.gallerySlug,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get synced => $composableBuilder(
    column: $table.synced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EventsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $EventsTableTable> {
  $$EventsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get templateId => $composableBuilder(
    column: $table.templateId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get eventDate =>
      $composableBuilder(column: $table.eventDate, builder: (column) => column);

  GeneratedColumn<DateTime> get startDatetime => $composableBuilder(
    column: $table.startDatetime,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get endDatetime => $composableBuilder(
    column: $table.endDatetime,
    builder: (column) => column,
  );

  GeneratedColumn<String> get eventStatus => $composableBuilder(
    column: $table.eventStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get paymentStatus => $composableBuilder(
    column: $table.paymentStatus,
    builder: (column) => column,
  );

  GeneratedColumn<String> get gallerySlug => $composableBuilder(
    column: $table.gallerySlug,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get synced =>
      $composableBuilder(column: $table.synced, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$EventsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EventsTableTable,
          EventsTableData,
          $$EventsTableTableFilterComposer,
          $$EventsTableTableOrderingComposer,
          $$EventsTableTableAnnotationComposer,
          $$EventsTableTableCreateCompanionBuilder,
          $$EventsTableTableUpdateCompanionBuilder,
          (
            EventsTableData,
            BaseReferences<_$AppDatabase, $EventsTableTable, EventsTableData>,
          ),
          EventsTableData,
          PrefetchHooks Function()
        > {
  $$EventsTableTableTableManager(_$AppDatabase db, $EventsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EventsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EventsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EventsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<String?> templateId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<DateTime> eventDate = const Value.absent(),
                Value<DateTime> startDatetime = const Value.absent(),
                Value<DateTime> endDatetime = const Value.absent(),
                Value<String> eventStatus = const Value.absent(),
                Value<String> paymentStatus = const Value.absent(),
                Value<String> gallerySlug = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<bool> synced = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EventsTableCompanion(
                id: id,
                userId: userId,
                templateId: templateId,
                name: name,
                eventDate: eventDate,
                startDatetime: startDatetime,
                endDatetime: endDatetime,
                eventStatus: eventStatus,
                paymentStatus: paymentStatus,
                gallerySlug: gallerySlug,
                notes: notes,
                synced: synced,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String userId,
                Value<String?> templateId = const Value.absent(),
                required String name,
                required DateTime eventDate,
                required DateTime startDatetime,
                required DateTime endDatetime,
                Value<String> eventStatus = const Value.absent(),
                Value<String> paymentStatus = const Value.absent(),
                required String gallerySlug,
                Value<String?> notes = const Value.absent(),
                Value<bool> synced = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => EventsTableCompanion.insert(
                id: id,
                userId: userId,
                templateId: templateId,
                name: name,
                eventDate: eventDate,
                startDatetime: startDatetime,
                endDatetime: endDatetime,
                eventStatus: eventStatus,
                paymentStatus: paymentStatus,
                gallerySlug: gallerySlug,
                notes: notes,
                synced: synced,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$EventsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EventsTableTable,
      EventsTableData,
      $$EventsTableTableFilterComposer,
      $$EventsTableTableOrderingComposer,
      $$EventsTableTableAnnotationComposer,
      $$EventsTableTableCreateCompanionBuilder,
      $$EventsTableTableUpdateCompanionBuilder,
      (
        EventsTableData,
        BaseReferences<_$AppDatabase, $EventsTableTable, EventsTableData>,
      ),
      EventsTableData,
      PrefetchHooks Function()
    >;
typedef $$EventSettingsTableTableCreateCompanionBuilder =
    EventSettingsTableCompanion Function({
      required String id,
      required String eventId,
      Value<int> defaultDurationSeconds,
      Value<String> defaultEffects,
      Value<bool> allowMultipleSessions,
      Value<int?> autoDeleteDays,
      Value<String?> galleryName,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$EventSettingsTableTableUpdateCompanionBuilder =
    EventSettingsTableCompanion Function({
      Value<String> id,
      Value<String> eventId,
      Value<int> defaultDurationSeconds,
      Value<String> defaultEffects,
      Value<bool> allowMultipleSessions,
      Value<int?> autoDeleteDays,
      Value<String?> galleryName,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$EventSettingsTableTableFilterComposer
    extends Composer<_$AppDatabase, $EventSettingsTableTable> {
  $$EventSettingsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get eventId => $composableBuilder(
    column: $table.eventId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get defaultDurationSeconds => $composableBuilder(
    column: $table.defaultDurationSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get defaultEffects => $composableBuilder(
    column: $table.defaultEffects,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get allowMultipleSessions => $composableBuilder(
    column: $table.allowMultipleSessions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get autoDeleteDays => $composableBuilder(
    column: $table.autoDeleteDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get galleryName => $composableBuilder(
    column: $table.galleryName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$EventSettingsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $EventSettingsTableTable> {
  $$EventSettingsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get eventId => $composableBuilder(
    column: $table.eventId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get defaultDurationSeconds => $composableBuilder(
    column: $table.defaultDurationSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get defaultEffects => $composableBuilder(
    column: $table.defaultEffects,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get allowMultipleSessions => $composableBuilder(
    column: $table.allowMultipleSessions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get autoDeleteDays => $composableBuilder(
    column: $table.autoDeleteDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get galleryName => $composableBuilder(
    column: $table.galleryName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EventSettingsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $EventSettingsTableTable> {
  $$EventSettingsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get eventId =>
      $composableBuilder(column: $table.eventId, builder: (column) => column);

  GeneratedColumn<int> get defaultDurationSeconds => $composableBuilder(
    column: $table.defaultDurationSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<String> get defaultEffects => $composableBuilder(
    column: $table.defaultEffects,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get allowMultipleSessions => $composableBuilder(
    column: $table.allowMultipleSessions,
    builder: (column) => column,
  );

  GeneratedColumn<int> get autoDeleteDays => $composableBuilder(
    column: $table.autoDeleteDays,
    builder: (column) => column,
  );

  GeneratedColumn<String> get galleryName => $composableBuilder(
    column: $table.galleryName,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$EventSettingsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EventSettingsTableTable,
          EventSettingsTableData,
          $$EventSettingsTableTableFilterComposer,
          $$EventSettingsTableTableOrderingComposer,
          $$EventSettingsTableTableAnnotationComposer,
          $$EventSettingsTableTableCreateCompanionBuilder,
          $$EventSettingsTableTableUpdateCompanionBuilder,
          (
            EventSettingsTableData,
            BaseReferences<
              _$AppDatabase,
              $EventSettingsTableTable,
              EventSettingsTableData
            >,
          ),
          EventSettingsTableData,
          PrefetchHooks Function()
        > {
  $$EventSettingsTableTableTableManager(
    _$AppDatabase db,
    $EventSettingsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EventSettingsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EventSettingsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EventSettingsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> eventId = const Value.absent(),
                Value<int> defaultDurationSeconds = const Value.absent(),
                Value<String> defaultEffects = const Value.absent(),
                Value<bool> allowMultipleSessions = const Value.absent(),
                Value<int?> autoDeleteDays = const Value.absent(),
                Value<String?> galleryName = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EventSettingsTableCompanion(
                id: id,
                eventId: eventId,
                defaultDurationSeconds: defaultDurationSeconds,
                defaultEffects: defaultEffects,
                allowMultipleSessions: allowMultipleSessions,
                autoDeleteDays: autoDeleteDays,
                galleryName: galleryName,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String eventId,
                Value<int> defaultDurationSeconds = const Value.absent(),
                Value<String> defaultEffects = const Value.absent(),
                Value<bool> allowMultipleSessions = const Value.absent(),
                Value<int?> autoDeleteDays = const Value.absent(),
                Value<String?> galleryName = const Value.absent(),
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => EventSettingsTableCompanion.insert(
                id: id,
                eventId: eventId,
                defaultDurationSeconds: defaultDurationSeconds,
                defaultEffects: defaultEffects,
                allowMultipleSessions: allowMultipleSessions,
                autoDeleteDays: autoDeleteDays,
                galleryName: galleryName,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$EventSettingsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EventSettingsTableTable,
      EventSettingsTableData,
      $$EventSettingsTableTableFilterComposer,
      $$EventSettingsTableTableOrderingComposer,
      $$EventSettingsTableTableAnnotationComposer,
      $$EventSettingsTableTableCreateCompanionBuilder,
      $$EventSettingsTableTableUpdateCompanionBuilder,
      (
        EventSettingsTableData,
        BaseReferences<
          _$AppDatabase,
          $EventSettingsTableTable,
          EventSettingsTableData
        >,
      ),
      EventSettingsTableData,
      PrefetchHooks Function()
    >;
typedef $$SyncJobsTableTableCreateCompanionBuilder =
    SyncJobsTableCompanion Function({
      required String id,
      required String entityType,
      required String entityId,
      required String syncType,
      Value<int> attempts,
      Value<String?> lastError,
      Value<String> status,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$SyncJobsTableTableUpdateCompanionBuilder =
    SyncJobsTableCompanion Function({
      Value<String> id,
      Value<String> entityType,
      Value<String> entityId,
      Value<String> syncType,
      Value<int> attempts,
      Value<String?> lastError,
      Value<String> status,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$SyncJobsTableTableFilterComposer
    extends Composer<_$AppDatabase, $SyncJobsTableTable> {
  $$SyncJobsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get syncType => $composableBuilder(
    column: $table.syncType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get attempts => $composableBuilder(
    column: $table.attempts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncJobsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncJobsTableTable> {
  $$SyncJobsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get syncType => $composableBuilder(
    column: $table.syncType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get attempts => $composableBuilder(
    column: $table.attempts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncJobsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncJobsTableTable> {
  $$SyncJobsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<String> get syncType =>
      $composableBuilder(column: $table.syncType, builder: (column) => column);

  GeneratedColumn<int> get attempts =>
      $composableBuilder(column: $table.attempts, builder: (column) => column);

  GeneratedColumn<String> get lastError =>
      $composableBuilder(column: $table.lastError, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$SyncJobsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncJobsTableTable,
          SyncJobsTableData,
          $$SyncJobsTableTableFilterComposer,
          $$SyncJobsTableTableOrderingComposer,
          $$SyncJobsTableTableAnnotationComposer,
          $$SyncJobsTableTableCreateCompanionBuilder,
          $$SyncJobsTableTableUpdateCompanionBuilder,
          (
            SyncJobsTableData,
            BaseReferences<
              _$AppDatabase,
              $SyncJobsTableTable,
              SyncJobsTableData
            >,
          ),
          SyncJobsTableData,
          PrefetchHooks Function()
        > {
  $$SyncJobsTableTableTableManager(_$AppDatabase db, $SyncJobsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncJobsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncJobsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncJobsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> entityType = const Value.absent(),
                Value<String> entityId = const Value.absent(),
                Value<String> syncType = const Value.absent(),
                Value<int> attempts = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncJobsTableCompanion(
                id: id,
                entityType: entityType,
                entityId: entityId,
                syncType: syncType,
                attempts: attempts,
                lastError: lastError,
                status: status,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String entityType,
                required String entityId,
                required String syncType,
                Value<int> attempts = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
                Value<String> status = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => SyncJobsTableCompanion.insert(
                id: id,
                entityType: entityType,
                entityId: entityId,
                syncType: syncType,
                attempts: attempts,
                lastError: lastError,
                status: status,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncJobsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncJobsTableTable,
      SyncJobsTableData,
      $$SyncJobsTableTableFilterComposer,
      $$SyncJobsTableTableOrderingComposer,
      $$SyncJobsTableTableAnnotationComposer,
      $$SyncJobsTableTableCreateCompanionBuilder,
      $$SyncJobsTableTableUpdateCompanionBuilder,
      (
        SyncJobsTableData,
        BaseReferences<_$AppDatabase, $SyncJobsTableTable, SyncJobsTableData>,
      ),
      SyncJobsTableData,
      PrefetchHooks Function()
    >;
typedef $$SessionsTableTableCreateCompanionBuilder =
    SessionsTableCompanion Function({
      required String id,
      required String eventId,
      required String guestName,
      required String phone,
      Value<String> countryCode,
      Value<String?> notes,
      required String deviceId,
      Value<String> status,
      Value<int?> durationSecondsOverride,
      Value<String?> effectsOverride,
      Value<int?> countdownSecondsOverride,
      Value<int?> maxTakesOverride,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$SessionsTableTableUpdateCompanionBuilder =
    SessionsTableCompanion Function({
      Value<String> id,
      Value<String> eventId,
      Value<String> guestName,
      Value<String> phone,
      Value<String> countryCode,
      Value<String?> notes,
      Value<String> deviceId,
      Value<String> status,
      Value<int?> durationSecondsOverride,
      Value<String?> effectsOverride,
      Value<int?> countdownSecondsOverride,
      Value<int?> maxTakesOverride,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$SessionsTableTableFilterComposer
    extends Composer<_$AppDatabase, $SessionsTableTable> {
  $$SessionsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get eventId => $composableBuilder(
    column: $table.eventId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get guestName => $composableBuilder(
    column: $table.guestName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get countryCode => $composableBuilder(
    column: $table.countryCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationSecondsOverride => $composableBuilder(
    column: $table.durationSecondsOverride,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get effectsOverride => $composableBuilder(
    column: $table.effectsOverride,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get countdownSecondsOverride => $composableBuilder(
    column: $table.countdownSecondsOverride,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxTakesOverride => $composableBuilder(
    column: $table.maxTakesOverride,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SessionsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SessionsTableTable> {
  $$SessionsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get eventId => $composableBuilder(
    column: $table.eventId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get guestName => $composableBuilder(
    column: $table.guestName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get countryCode => $composableBuilder(
    column: $table.countryCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deviceId => $composableBuilder(
    column: $table.deviceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationSecondsOverride => $composableBuilder(
    column: $table.durationSecondsOverride,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get effectsOverride => $composableBuilder(
    column: $table.effectsOverride,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get countdownSecondsOverride => $composableBuilder(
    column: $table.countdownSecondsOverride,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxTakesOverride => $composableBuilder(
    column: $table.maxTakesOverride,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SessionsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SessionsTableTable> {
  $$SessionsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get eventId =>
      $composableBuilder(column: $table.eventId, builder: (column) => column);

  GeneratedColumn<String> get guestName =>
      $composableBuilder(column: $table.guestName, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get countryCode => $composableBuilder(
    column: $table.countryCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get deviceId =>
      $composableBuilder(column: $table.deviceId, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get durationSecondsOverride => $composableBuilder(
    column: $table.durationSecondsOverride,
    builder: (column) => column,
  );

  GeneratedColumn<String> get effectsOverride => $composableBuilder(
    column: $table.effectsOverride,
    builder: (column) => column,
  );

  GeneratedColumn<int> get countdownSecondsOverride => $composableBuilder(
    column: $table.countdownSecondsOverride,
    builder: (column) => column,
  );

  GeneratedColumn<int> get maxTakesOverride => $composableBuilder(
    column: $table.maxTakesOverride,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$SessionsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SessionsTableTable,
          SessionsTableData,
          $$SessionsTableTableFilterComposer,
          $$SessionsTableTableOrderingComposer,
          $$SessionsTableTableAnnotationComposer,
          $$SessionsTableTableCreateCompanionBuilder,
          $$SessionsTableTableUpdateCompanionBuilder,
          (
            SessionsTableData,
            BaseReferences<
              _$AppDatabase,
              $SessionsTableTable,
              SessionsTableData
            >,
          ),
          SessionsTableData,
          PrefetchHooks Function()
        > {
  $$SessionsTableTableTableManager(_$AppDatabase db, $SessionsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SessionsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SessionsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SessionsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> eventId = const Value.absent(),
                Value<String> guestName = const Value.absent(),
                Value<String> phone = const Value.absent(),
                Value<String> countryCode = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String> deviceId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int?> durationSecondsOverride = const Value.absent(),
                Value<String?> effectsOverride = const Value.absent(),
                Value<int?> countdownSecondsOverride = const Value.absent(),
                Value<int?> maxTakesOverride = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SessionsTableCompanion(
                id: id,
                eventId: eventId,
                guestName: guestName,
                phone: phone,
                countryCode: countryCode,
                notes: notes,
                deviceId: deviceId,
                status: status,
                durationSecondsOverride: durationSecondsOverride,
                effectsOverride: effectsOverride,
                countdownSecondsOverride: countdownSecondsOverride,
                maxTakesOverride: maxTakesOverride,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String eventId,
                required String guestName,
                required String phone,
                Value<String> countryCode = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required String deviceId,
                Value<String> status = const Value.absent(),
                Value<int?> durationSecondsOverride = const Value.absent(),
                Value<String?> effectsOverride = const Value.absent(),
                Value<int?> countdownSecondsOverride = const Value.absent(),
                Value<int?> maxTakesOverride = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => SessionsTableCompanion.insert(
                id: id,
                eventId: eventId,
                guestName: guestName,
                phone: phone,
                countryCode: countryCode,
                notes: notes,
                deviceId: deviceId,
                status: status,
                durationSecondsOverride: durationSecondsOverride,
                effectsOverride: effectsOverride,
                countdownSecondsOverride: countdownSecondsOverride,
                maxTakesOverride: maxTakesOverride,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SessionsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SessionsTableTable,
      SessionsTableData,
      $$SessionsTableTableFilterComposer,
      $$SessionsTableTableOrderingComposer,
      $$SessionsTableTableAnnotationComposer,
      $$SessionsTableTableCreateCompanionBuilder,
      $$SessionsTableTableUpdateCompanionBuilder,
      (
        SessionsTableData,
        BaseReferences<_$AppDatabase, $SessionsTableTable, SessionsTableData>,
      ),
      SessionsTableData,
      PrefetchHooks Function()
    >;
typedef $$SessionAssetsTableTableCreateCompanionBuilder =
    SessionAssetsTableCompanion Function({
      required String id,
      required String sessionId,
      required String localPath,
      Value<int> fileSizeBytes,
      Value<int> durationMs,
      required int takeNumber,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$SessionAssetsTableTableUpdateCompanionBuilder =
    SessionAssetsTableCompanion Function({
      Value<String> id,
      Value<String> sessionId,
      Value<String> localPath,
      Value<int> fileSizeBytes,
      Value<int> durationMs,
      Value<int> takeNumber,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$SessionAssetsTableTableFilterComposer
    extends Composer<_$AppDatabase, $SessionAssetsTableTable> {
  $$SessionAssetsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get fileSizeBytes => $composableBuilder(
    column: $table.fileSizeBytes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationMs => $composableBuilder(
    column: $table.durationMs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get takeNumber => $composableBuilder(
    column: $table.takeNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SessionAssetsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SessionAssetsTableTable> {
  $$SessionAssetsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localPath => $composableBuilder(
    column: $table.localPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get fileSizeBytes => $composableBuilder(
    column: $table.fileSizeBytes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationMs => $composableBuilder(
    column: $table.durationMs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get takeNumber => $composableBuilder(
    column: $table.takeNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SessionAssetsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SessionAssetsTableTable> {
  $$SessionAssetsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sessionId =>
      $composableBuilder(column: $table.sessionId, builder: (column) => column);

  GeneratedColumn<String> get localPath =>
      $composableBuilder(column: $table.localPath, builder: (column) => column);

  GeneratedColumn<int> get fileSizeBytes => $composableBuilder(
    column: $table.fileSizeBytes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get durationMs => $composableBuilder(
    column: $table.durationMs,
    builder: (column) => column,
  );

  GeneratedColumn<int> get takeNumber => $composableBuilder(
    column: $table.takeNumber,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$SessionAssetsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SessionAssetsTableTable,
          SessionAssetsTableData,
          $$SessionAssetsTableTableFilterComposer,
          $$SessionAssetsTableTableOrderingComposer,
          $$SessionAssetsTableTableAnnotationComposer,
          $$SessionAssetsTableTableCreateCompanionBuilder,
          $$SessionAssetsTableTableUpdateCompanionBuilder,
          (
            SessionAssetsTableData,
            BaseReferences<
              _$AppDatabase,
              $SessionAssetsTableTable,
              SessionAssetsTableData
            >,
          ),
          SessionAssetsTableData,
          PrefetchHooks Function()
        > {
  $$SessionAssetsTableTableTableManager(
    _$AppDatabase db,
    $SessionAssetsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SessionAssetsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SessionAssetsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SessionAssetsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> sessionId = const Value.absent(),
                Value<String> localPath = const Value.absent(),
                Value<int> fileSizeBytes = const Value.absent(),
                Value<int> durationMs = const Value.absent(),
                Value<int> takeNumber = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SessionAssetsTableCompanion(
                id: id,
                sessionId: sessionId,
                localPath: localPath,
                fileSizeBytes: fileSizeBytes,
                durationMs: durationMs,
                takeNumber: takeNumber,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String sessionId,
                required String localPath,
                Value<int> fileSizeBytes = const Value.absent(),
                Value<int> durationMs = const Value.absent(),
                required int takeNumber,
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => SessionAssetsTableCompanion.insert(
                id: id,
                sessionId: sessionId,
                localPath: localPath,
                fileSizeBytes: fileSizeBytes,
                durationMs: durationMs,
                takeNumber: takeNumber,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SessionAssetsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SessionAssetsTableTable,
      SessionAssetsTableData,
      $$SessionAssetsTableTableFilterComposer,
      $$SessionAssetsTableTableOrderingComposer,
      $$SessionAssetsTableTableAnnotationComposer,
      $$SessionAssetsTableTableCreateCompanionBuilder,
      $$SessionAssetsTableTableUpdateCompanionBuilder,
      (
        SessionAssetsTableData,
        BaseReferences<
          _$AppDatabase,
          $SessionAssetsTableTable,
          SessionAssetsTableData
        >,
      ),
      SessionAssetsTableData,
      PrefetchHooks Function()
    >;
typedef $$RecordingConfigsTableTableCreateCompanionBuilder =
    RecordingConfigsTableCompanion Function({
      required String id,
      required String eventId,
      Value<int> durationSeconds,
      Value<String> resolution,
      Value<String> cameraFacing,
      Value<String> quality,
      Value<String> defaultEffects,
      Value<int> maxTakesPerSession,
      Value<int> countdownSeconds,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$RecordingConfigsTableTableUpdateCompanionBuilder =
    RecordingConfigsTableCompanion Function({
      Value<String> id,
      Value<String> eventId,
      Value<int> durationSeconds,
      Value<String> resolution,
      Value<String> cameraFacing,
      Value<String> quality,
      Value<String> defaultEffects,
      Value<int> maxTakesPerSession,
      Value<int> countdownSeconds,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$RecordingConfigsTableTableFilterComposer
    extends Composer<_$AppDatabase, $RecordingConfigsTableTable> {
  $$RecordingConfigsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get eventId => $composableBuilder(
    column: $table.eventId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get resolution => $composableBuilder(
    column: $table.resolution,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cameraFacing => $composableBuilder(
    column: $table.cameraFacing,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get quality => $composableBuilder(
    column: $table.quality,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get defaultEffects => $composableBuilder(
    column: $table.defaultEffects,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxTakesPerSession => $composableBuilder(
    column: $table.maxTakesPerSession,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get countdownSeconds => $composableBuilder(
    column: $table.countdownSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RecordingConfigsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $RecordingConfigsTableTable> {
  $$RecordingConfigsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get eventId => $composableBuilder(
    column: $table.eventId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get resolution => $composableBuilder(
    column: $table.resolution,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cameraFacing => $composableBuilder(
    column: $table.cameraFacing,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get quality => $composableBuilder(
    column: $table.quality,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get defaultEffects => $composableBuilder(
    column: $table.defaultEffects,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxTakesPerSession => $composableBuilder(
    column: $table.maxTakesPerSession,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get countdownSeconds => $composableBuilder(
    column: $table.countdownSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RecordingConfigsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecordingConfigsTableTable> {
  $$RecordingConfigsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get eventId =>
      $composableBuilder(column: $table.eventId, builder: (column) => column);

  GeneratedColumn<int> get durationSeconds => $composableBuilder(
    column: $table.durationSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<String> get resolution => $composableBuilder(
    column: $table.resolution,
    builder: (column) => column,
  );

  GeneratedColumn<String> get cameraFacing => $composableBuilder(
    column: $table.cameraFacing,
    builder: (column) => column,
  );

  GeneratedColumn<String> get quality =>
      $composableBuilder(column: $table.quality, builder: (column) => column);

  GeneratedColumn<String> get defaultEffects => $composableBuilder(
    column: $table.defaultEffects,
    builder: (column) => column,
  );

  GeneratedColumn<int> get maxTakesPerSession => $composableBuilder(
    column: $table.maxTakesPerSession,
    builder: (column) => column,
  );

  GeneratedColumn<int> get countdownSeconds => $composableBuilder(
    column: $table.countdownSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$RecordingConfigsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RecordingConfigsTableTable,
          RecordingConfigsTableData,
          $$RecordingConfigsTableTableFilterComposer,
          $$RecordingConfigsTableTableOrderingComposer,
          $$RecordingConfigsTableTableAnnotationComposer,
          $$RecordingConfigsTableTableCreateCompanionBuilder,
          $$RecordingConfigsTableTableUpdateCompanionBuilder,
          (
            RecordingConfigsTableData,
            BaseReferences<
              _$AppDatabase,
              $RecordingConfigsTableTable,
              RecordingConfigsTableData
            >,
          ),
          RecordingConfigsTableData,
          PrefetchHooks Function()
        > {
  $$RecordingConfigsTableTableTableManager(
    _$AppDatabase db,
    $RecordingConfigsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecordingConfigsTableTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$RecordingConfigsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$RecordingConfigsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> eventId = const Value.absent(),
                Value<int> durationSeconds = const Value.absent(),
                Value<String> resolution = const Value.absent(),
                Value<String> cameraFacing = const Value.absent(),
                Value<String> quality = const Value.absent(),
                Value<String> defaultEffects = const Value.absent(),
                Value<int> maxTakesPerSession = const Value.absent(),
                Value<int> countdownSeconds = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RecordingConfigsTableCompanion(
                id: id,
                eventId: eventId,
                durationSeconds: durationSeconds,
                resolution: resolution,
                cameraFacing: cameraFacing,
                quality: quality,
                defaultEffects: defaultEffects,
                maxTakesPerSession: maxTakesPerSession,
                countdownSeconds: countdownSeconds,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String eventId,
                Value<int> durationSeconds = const Value.absent(),
                Value<String> resolution = const Value.absent(),
                Value<String> cameraFacing = const Value.absent(),
                Value<String> quality = const Value.absent(),
                Value<String> defaultEffects = const Value.absent(),
                Value<int> maxTakesPerSession = const Value.absent(),
                Value<int> countdownSeconds = const Value.absent(),
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => RecordingConfigsTableCompanion.insert(
                id: id,
                eventId: eventId,
                durationSeconds: durationSeconds,
                resolution: resolution,
                cameraFacing: cameraFacing,
                quality: quality,
                defaultEffects: defaultEffects,
                maxTakesPerSession: maxTakesPerSession,
                countdownSeconds: countdownSeconds,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RecordingConfigsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RecordingConfigsTableTable,
      RecordingConfigsTableData,
      $$RecordingConfigsTableTableFilterComposer,
      $$RecordingConfigsTableTableOrderingComposer,
      $$RecordingConfigsTableTableAnnotationComposer,
      $$RecordingConfigsTableTableCreateCompanionBuilder,
      $$RecordingConfigsTableTableUpdateCompanionBuilder,
      (
        RecordingConfigsTableData,
        BaseReferences<
          _$AppDatabase,
          $RecordingConfigsTableTable,
          RecordingConfigsTableData
        >,
      ),
      RecordingConfigsTableData,
      PrefetchHooks Function()
    >;
typedef $$ProcessingJobsTableTableCreateCompanionBuilder =
    ProcessingJobsTableCompanion Function({
      required String id,
      required String sessionId,
      Value<String?> assetId,
      required String jobType,
      Value<int> priority,
      Value<String> payload,
      Value<String> status,
      Value<double> progress,
      Value<int> attempts,
      Value<String?> errorMessage,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<DateTime?> finishedAt,
      Value<int> rowid,
    });
typedef $$ProcessingJobsTableTableUpdateCompanionBuilder =
    ProcessingJobsTableCompanion Function({
      Value<String> id,
      Value<String> sessionId,
      Value<String?> assetId,
      Value<String> jobType,
      Value<int> priority,
      Value<String> payload,
      Value<String> status,
      Value<double> progress,
      Value<int> attempts,
      Value<String?> errorMessage,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<DateTime?> finishedAt,
      Value<int> rowid,
    });

class $$ProcessingJobsTableTableFilterComposer
    extends Composer<_$AppDatabase, $ProcessingJobsTableTable> {
  $$ProcessingJobsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get assetId => $composableBuilder(
    column: $table.assetId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get jobType => $composableBuilder(
    column: $table.jobType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get progress => $composableBuilder(
    column: $table.progress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get attempts => $composableBuilder(
    column: $table.attempts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get finishedAt => $composableBuilder(
    column: $table.finishedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProcessingJobsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ProcessingJobsTableTable> {
  $$ProcessingJobsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sessionId => $composableBuilder(
    column: $table.sessionId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get assetId => $composableBuilder(
    column: $table.assetId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get jobType => $composableBuilder(
    column: $table.jobType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get priority => $composableBuilder(
    column: $table.priority,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get progress => $composableBuilder(
    column: $table.progress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get attempts => $composableBuilder(
    column: $table.attempts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get finishedAt => $composableBuilder(
    column: $table.finishedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProcessingJobsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProcessingJobsTableTable> {
  $$ProcessingJobsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sessionId =>
      $composableBuilder(column: $table.sessionId, builder: (column) => column);

  GeneratedColumn<String> get assetId =>
      $composableBuilder(column: $table.assetId, builder: (column) => column);

  GeneratedColumn<String> get jobType =>
      $composableBuilder(column: $table.jobType, builder: (column) => column);

  GeneratedColumn<int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<double> get progress =>
      $composableBuilder(column: $table.progress, builder: (column) => column);

  GeneratedColumn<int> get attempts =>
      $composableBuilder(column: $table.attempts, builder: (column) => column);

  GeneratedColumn<String> get errorMessage => $composableBuilder(
    column: $table.errorMessage,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get finishedAt => $composableBuilder(
    column: $table.finishedAt,
    builder: (column) => column,
  );
}

class $$ProcessingJobsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProcessingJobsTableTable,
          ProcessingJobsTableData,
          $$ProcessingJobsTableTableFilterComposer,
          $$ProcessingJobsTableTableOrderingComposer,
          $$ProcessingJobsTableTableAnnotationComposer,
          $$ProcessingJobsTableTableCreateCompanionBuilder,
          $$ProcessingJobsTableTableUpdateCompanionBuilder,
          (
            ProcessingJobsTableData,
            BaseReferences<
              _$AppDatabase,
              $ProcessingJobsTableTable,
              ProcessingJobsTableData
            >,
          ),
          ProcessingJobsTableData,
          PrefetchHooks Function()
        > {
  $$ProcessingJobsTableTableTableManager(
    _$AppDatabase db,
    $ProcessingJobsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProcessingJobsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProcessingJobsTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ProcessingJobsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> sessionId = const Value.absent(),
                Value<String?> assetId = const Value.absent(),
                Value<String> jobType = const Value.absent(),
                Value<int> priority = const Value.absent(),
                Value<String> payload = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<double> progress = const Value.absent(),
                Value<int> attempts = const Value.absent(),
                Value<String?> errorMessage = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> finishedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProcessingJobsTableCompanion(
                id: id,
                sessionId: sessionId,
                assetId: assetId,
                jobType: jobType,
                priority: priority,
                payload: payload,
                status: status,
                progress: progress,
                attempts: attempts,
                errorMessage: errorMessage,
                createdAt: createdAt,
                updatedAt: updatedAt,
                finishedAt: finishedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String sessionId,
                Value<String?> assetId = const Value.absent(),
                required String jobType,
                Value<int> priority = const Value.absent(),
                Value<String> payload = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<double> progress = const Value.absent(),
                Value<int> attempts = const Value.absent(),
                Value<String?> errorMessage = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> finishedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProcessingJobsTableCompanion.insert(
                id: id,
                sessionId: sessionId,
                assetId: assetId,
                jobType: jobType,
                priority: priority,
                payload: payload,
                status: status,
                progress: progress,
                attempts: attempts,
                errorMessage: errorMessage,
                createdAt: createdAt,
                updatedAt: updatedAt,
                finishedAt: finishedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProcessingJobsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProcessingJobsTableTable,
      ProcessingJobsTableData,
      $$ProcessingJobsTableTableFilterComposer,
      $$ProcessingJobsTableTableOrderingComposer,
      $$ProcessingJobsTableTableAnnotationComposer,
      $$ProcessingJobsTableTableCreateCompanionBuilder,
      $$ProcessingJobsTableTableUpdateCompanionBuilder,
      (
        ProcessingJobsTableData,
        BaseReferences<
          _$AppDatabase,
          $ProcessingJobsTableTable,
          ProcessingJobsTableData
        >,
      ),
      ProcessingJobsTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$EventTemplatesTableTableTableManager get eventTemplatesTable =>
      $$EventTemplatesTableTableTableManager(_db, _db.eventTemplatesTable);
  $$EventsTableTableTableManager get eventsTable =>
      $$EventsTableTableTableManager(_db, _db.eventsTable);
  $$EventSettingsTableTableTableManager get eventSettingsTable =>
      $$EventSettingsTableTableTableManager(_db, _db.eventSettingsTable);
  $$SyncJobsTableTableTableManager get syncJobsTable =>
      $$SyncJobsTableTableTableManager(_db, _db.syncJobsTable);
  $$SessionsTableTableTableManager get sessionsTable =>
      $$SessionsTableTableTableManager(_db, _db.sessionsTable);
  $$SessionAssetsTableTableTableManager get sessionAssetsTable =>
      $$SessionAssetsTableTableTableManager(_db, _db.sessionAssetsTable);
  $$RecordingConfigsTableTableTableManager get recordingConfigsTable =>
      $$RecordingConfigsTableTableTableManager(_db, _db.recordingConfigsTable);
  $$ProcessingJobsTableTableTableManager get processingJobsTable =>
      $$ProcessingJobsTableTableTableManager(_db, _db.processingJobsTable);
}
