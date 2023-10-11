import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class SubPieceNoteRecord extends FirestoreRecord {
  SubPieceNoteRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "photo" field.
  String? _photo;
  String get photo => _photo ?? '';
  bool hasPhoto() => _photo != null;

  // "text" field.
  String? _text;
  String get text => _text ?? '';
  bool hasText() => _text != null;

  // "user" field.
  DocumentReference? _user;
  DocumentReference? get user => _user;
  bool hasUser() => _user != null;

  // "storyId" field.
  String? _storyId;
  String get storyId => _storyId ?? '';
  bool hasStoryId() => _storyId != null;

  // "createdTime" field.
  DateTime? _createdTime;
  DateTime? get createdTime => _createdTime;
  bool hasCreatedTime() => _createdTime != null;

  // "noteTime" field.
  String? _noteTime;
  String get noteTime => _noteTime ?? '';
  bool hasNoteTime() => _noteTime != null;

  void _initializeFields() {
    _photo = snapshotData['photo'] as String?;
    _text = snapshotData['text'] as String?;
    _user = snapshotData['user'] as DocumentReference?;
    _storyId = snapshotData['storyId'] as String?;
    _createdTime = snapshotData['createdTime'] as DateTime?;
    _noteTime = snapshotData['noteTime'] as String?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('SubPieceNote');

  static Stream<SubPieceNoteRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => SubPieceNoteRecord.fromSnapshot(s));

  static Future<SubPieceNoteRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => SubPieceNoteRecord.fromSnapshot(s));

  static SubPieceNoteRecord fromSnapshot(DocumentSnapshot snapshot) =>
      SubPieceNoteRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static SubPieceNoteRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      SubPieceNoteRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'SubPieceNoteRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is SubPieceNoteRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createSubPieceNoteRecordData({
  String? photo,
  String? text,
  DocumentReference? user,
  String? storyId,
  DateTime? createdTime,
  String? noteTime,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'photo': photo,
      'text': text,
      'user': user,
      'storyId': storyId,
      'createdTime': createdTime,
      'noteTime': noteTime,
    }.withoutNulls,
  );

  return firestoreData;
}

class SubPieceNoteRecordDocumentEquality
    implements Equality<SubPieceNoteRecord> {
  const SubPieceNoteRecordDocumentEquality();

  @override
  bool equals(SubPieceNoteRecord? e1, SubPieceNoteRecord? e2) {
    return e1?.photo == e2?.photo &&
        e1?.text == e2?.text &&
        e1?.user == e2?.user &&
        e1?.storyId == e2?.storyId &&
        e1?.createdTime == e2?.createdTime &&
        e1?.noteTime == e2?.noteTime;
  }

  @override
  int hash(SubPieceNoteRecord? e) => const ListEquality().hash(
      [e?.photo, e?.text, e?.user, e?.storyId, e?.createdTime, e?.noteTime]);

  @override
  bool isValidKey(Object? o) => o is SubPieceNoteRecord;
}
