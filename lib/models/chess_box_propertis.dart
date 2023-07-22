import 'package:pchess/constants/element_constants.dart';
import 'package:pchess/constants/firebase_firestore_key.dart';

class ChessBoxProperties {
  final ChessElements? element;
  final String? elementIconUrl;
  final ElementType? elementType;
  final bool hasElement;
  final bool isInSelectedPath;
  bool isSoldureTwoStap;

  ChessBoxProperties(
      {this.element,
      this.elementIconUrl,
      this.elementType,
      this.hasElement = false,
      this.isInSelectedPath = false,
      this.isSoldureTwoStap = false});

  ChessBoxProperties.fromJson(Map<String, dynamic> json)
      : element =
            chessElementFromString(json[FireBaseFireStoreKeyString.elementKey]),
        elementIconUrl = json[FireBaseFireStoreKeyString.elementIconUrlKey],
        elementType = elementTypeFromString(
            json[FireBaseFireStoreKeyString.elementTypeKey]),
        hasElement = json[FireBaseFireStoreKeyString.hasElementKey],
        isSoldureTwoStap = json[FireBaseFireStoreKeyString.isSoldureTwoStapKey],
        isInSelectedPath = false;

  Map<String, dynamic> toJson() => {
        FireBaseFireStoreKeyString.elementKey: element.toString(),
        FireBaseFireStoreKeyString.elementIconUrlKey: elementIconUrl,
        FireBaseFireStoreKeyString.elementTypeKey: elementType.toString(),
        FireBaseFireStoreKeyString.hasElementKey: hasElement,
        FireBaseFireStoreKeyString.isSoldureTwoStapKey: isSoldureTwoStap,
      };
}
