import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class DailyStoryRecord extends FirestoreRecord {
  DailyStoryRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "title" field.
  String? _title;
  String get title => _title ?? '';
  bool hasTitle() => _title != null;

  // "body" field.
  String? _body;
  String get body => _body ?? '';
  bool hasBody() => _body != null;

  // "images" field.
  List<String>? _images;
  List<String> get images => _images ?? const [];
  bool hasImages() => _images != null;

  // "city" field.
  String? _city;
  String get city => _city ?? '';
  bool hasCity() => _city != null;

  // "country" field.
  String? _country;
  String get country => _country ?? '';
  bool hasCountry() => _country != null;

  // "locations" field.
  List<LatLng>? _locations;
  List<LatLng> get locations => _locations ?? const [];
  bool hasLocations() => _locations != null;

  // "user" field.
  DocumentReference? _user;
  DocumentReference? get user => _user;
  bool hasUser() => _user != null;

  // "aiProcessed" field.
  bool? _aiProcessed;
  bool get aiProcessed => _aiProcessed ?? false;
  bool hasAiProcessed() => _aiProcessed != null;

  // "dateSegment" field.
  String? _dateSegment;
  String get dateSegment => _dateSegment ?? '';
  bool hasDateSegment() => _dateSegment != null;

  // "numberOfSubNotes" field.
  int? _numberOfSubNotes;
  int get numberOfSubNotes => _numberOfSubNotes ?? 0;
  bool hasNumberOfSubNotes() => _numberOfSubNotes != null;

  // "lastUpdatedAt" field.
  DateTime? _lastUpdatedAt;
  DateTime? get lastUpdatedAt => _lastUpdatedAt;
  bool hasLastUpdatedAt() => _lastUpdatedAt != null;

  // "userId" field.
  String? _userId;
  String get userId => _userId ?? '';
  bool hasUserId() => _userId != null;

  void _initializeFields() {
    _title = snapshotData['title'] as String?;
    _body = snapshotData['body'] as String?;
    _images = getDataList(snapshotData['images']);
    _city = snapshotData['city'] as String?;
    _country = snapshotData['country'] as String?;
    _locations = getDataList(snapshotData['locations']);
    _user = snapshotData['user'] as DocumentReference?;
    _aiProcessed = snapshotData['aiProcessed'] as bool?;
    _dateSegment = snapshotData['dateSegment'] as String?;
    _numberOfSubNotes = castToType<int>(snapshotData['numberOfSubNotes']);
    _lastUpdatedAt = snapshotData['lastUpdatedAt'] as DateTime?;
    _userId = snapshotData['userId'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('DailyStory');

  static Stream<DailyStoryRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => DailyStoryRecord.fromSnapshot(s));

  static Future<DailyStoryRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => DailyStoryRecord.fromSnapshot(s));

  static DailyStoryRecord fromSnapshot(DocumentSnapshot snapshot) =>
      DailyStoryRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static DailyStoryRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      DailyStoryRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'DailyStoryRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is DailyStoryRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createDailyStoryRecordData({
  String? title,
  String? body,
  String? city,
  String? country,
  DocumentReference? user,
  bool? aiProcessed,
  String? dateSegment,
  int? numberOfSubNotes,
  DateTime? lastUpdatedAt,
  String? userId,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'title': title,
      'body': body,
      'city': city,
      'country': country,
      'user': user,
      'aiProcessed': aiProcessed,
      'dateSegment': dateSegment,
      'numberOfSubNotes': numberOfSubNotes,
      'lastUpdatedAt': lastUpdatedAt,
      'userId': userId,
    }.withoutNulls,
  );

  return firestoreData;
}

class DailyStoryRecordDocumentEquality implements Equality<DailyStoryRecord> {
  const DailyStoryRecordDocumentEquality();

  @override
  bool equals(DailyStoryRecord? e1, DailyStoryRecord? e2) {
    const listEquality = ListEquality();
    return e1?.title == e2?.title &&
        e1?.body == e2?.body &&
        listEquality.equals(e1?.images, e2?.images) &&
        e1?.city == e2?.city &&
        e1?.country == e2?.country &&
        listEquality.equals(e1?.locations, e2?.locations) &&
        e1?.user == e2?.user &&
        e1?.aiProcessed == e2?.aiProcessed &&
        e1?.dateSegment == e2?.dateSegment &&
        e1?.numberOfSubNotes == e2?.numberOfSubNotes &&
        e1?.lastUpdatedAt == e2?.lastUpdatedAt &&
        e1?.userId == e2?.userId;
  }

  @override
  int hash(DailyStoryRecord? e) => const ListEquality().hash([
        e?.title,
        e?.body,
        e?.images,
        e?.city,
        e?.country,
        e?.locations,
        e?.user,
        e?.aiProcessed,
        e?.dateSegment,
        e?.numberOfSubNotes,
        e?.lastUpdatedAt,
        e?.userId
      ]);

  @override
  bool isValidKey(Object? o) => o is DailyStoryRecord;
}
