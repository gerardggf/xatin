import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:xatin/app/core/const/firestore_collections.dart';
import 'package:xatin/app/domain/models/message_model.dart';
import 'package:xatin/app/domain/models/room_model.dart';
import 'package:xatin/app/domain/repositories/chats_repository.dart';

class ChatsRepositoryImpl implements ChatsRepository {
  ChatsRepositoryImpl(this.firestore);

  final FirebaseFirestore firestore;

  String? get room => _room;

  String? _room;

  @override
  Future<bool> sendMessage(String roomId, MessageModel message) async {
    if (room == null) return false;
    try {
      final collection = firestore
          .collection(FirestoreCollections.rooms)
          .doc(room)
          .collection(FirestoreCollections.messages);
      final newMessageDoc = await collection.add(
        message.toJson(),
      );
      await collection.doc(newMessageDoc.id).update(
        {"id": newMessageDoc.id},
      );
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(
          e.toString(),
        );
      }
      return false;
    }
  }

  @override
  Future<bool> createRoom(String roomName) async {
    try {
      final collection = firestore.collection(FirestoreCollections.rooms);
      final newRoomDoc = await collection.add(
        RoomModel(
          name: roomName,
          creationDate: DateTime.now(),
          id: '',
          users: [],
        ).toJson(),
      );
      await newRoomDoc
          .collection(FirestoreCollections.messages)
          .doc('init')
          .set(
            MessageModel(
              user: '',
              creationDate: DateTime.now(),
              content: roomName,
              id: 'init',
            ).toJson(),
          );
      await collection.doc(newRoomDoc.id).update(
        {"id": newRoomDoc.id},
      );
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(
          e.toString(),
        );
      }
      return false;
    }
  }

  @override
  Future<bool> deleteRoom(String roomId) async {
    try {
      final collection = firestore.collection(FirestoreCollections.rooms);
      await collection.doc(roomId).delete();
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(
          e.toString(),
        );
      }
      return false;
    }
  }

  @override
  Stream<List<MessageModel>> subscribeToRoom(String roomId) async* {
    _room = roomId;
    try {
      final collection = firestore
          .collection(FirestoreCollections.rooms)
          .doc(roomId)
          .collection(FirestoreCollections.messages);
      yield* collection.orderBy('creationDate').snapshots().map(
            (e) => e.docs.map(
              (e) {
                return MessageModel.fromJson(e.data());
              },
            ).toList(),
          );
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      yield [];
    }
  }

  @override
  Stream<List<RoomModel>> subscribeToRoomsList() async* {
    try {
      final collection = firestore.collection(FirestoreCollections.rooms);
      yield* collection.snapshots().map(
            (e) => e.docs.map(
              (e) {
                return RoomModel.fromJson(e.data());
              },
            ).toList(),
          );
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      yield [];
    }
  }
}
