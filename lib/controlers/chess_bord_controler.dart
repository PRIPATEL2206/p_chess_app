import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pchess/components/app_alert_box.dart';
import 'package:pchess/components/chess_element_input_box.dart';
import 'package:pchess/constants/element_constants.dart';
import 'package:pchess/constants/firebase_firestore_key.dart';
import 'package:pchess/models/chess_box_propertis.dart';

class ChessBordControler extends GetxController {
  late List<List<Rx<ChessBoxProperties>>> _chessBord = [];
  final List<int> _selectedElement = [-1, -1];
  bool _isElementSelected = false;
  ElementType _currentPlayingPlayer = ElementType.light;
  ElementType? _joinedPlayerAs;
  ElementType? _winner;
  final Rx<bool> _startOnlineChess = false.obs;
  String? _fireBaseBoardCollectionId;

  Rx<bool> get startOnlineChess => _startOnlineChess;
  List<List<Rx<ChessBoxProperties>>> get chessBoard => _chessBord;

  void initateChessBord({bool changeValue = false}) {
    // final bord = List.filled(8, List.filled(8, ChessBoxProperties().obs));
    final List<List<Rx<ChessBoxProperties>>> bord = [];
    for (var i = 0; i < 8; i++) {
      final List<Rx<ChessBoxProperties>> temp = [];
      for (var j = 0; j < 8; j++) {
        temp.add(ChessBoxProperties().obs);
      }
      bord.add(temp);
    }
// set Up Dark element
    bord[0][0] = ChessBoxProperties(
            element: ChessElements.darkElephent,
            hasElement: true,
            elementType: ElementType.dark,
            elementIconUrl: ChessElementsIcons.darkElephent)
        .obs;
    bord[0][7] = ChessBoxProperties(
            element: ChessElements.darkElephent,
            hasElement: true,
            elementType: ElementType.dark,
            elementIconUrl: ChessElementsIcons.darkElephent)
        .obs;
    bord[0][1] = ChessBoxProperties(
            element: ChessElements.darkHorse,
            hasElement: true,
            elementType: ElementType.dark,
            elementIconUrl: ChessElementsIcons.darkHorse)
        .obs;
    bord[0][6] = ChessBoxProperties(
            element: ChessElements.darkHorse,
            hasElement: true,
            elementType: ElementType.dark,
            elementIconUrl: ChessElementsIcons.darkHorse)
        .obs;
    bord[0][2] = ChessBoxProperties(
            element: ChessElements.darkCamel,
            hasElement: true,
            elementType: ElementType.dark,
            elementIconUrl: ChessElementsIcons.darkCamel)
        .obs;
    bord[0][5] = ChessBoxProperties(
            element: ChessElements.darkCamel,
            hasElement: true,
            elementType: ElementType.dark,
            elementIconUrl: ChessElementsIcons.darkCamel)
        .obs;
    bord[0][3] = ChessBoxProperties(
            element: ChessElements.darkKing,
            hasElement: true,
            elementType: ElementType.dark,
            elementIconUrl: ChessElementsIcons.darkKing)
        .obs;
    bord[0][4] = ChessBoxProperties(
            element: ChessElements.darkQueen,
            hasElement: true,
            elementType: ElementType.dark,
            elementIconUrl: ChessElementsIcons.darkQueen)
        .obs;

// set light element
    bord[7][0] = ChessBoxProperties(
            element: ChessElements.lightElephent,
            hasElement: true,
            elementType: ElementType.light,
            elementIconUrl: ChessElementsIcons.lightElephent)
        .obs;
    bord[7][7] = ChessBoxProperties(
            element: ChessElements.lightElephent,
            hasElement: true,
            elementType: ElementType.light,
            elementIconUrl: ChessElementsIcons.lightElephent)
        .obs;
    bord[7][1] = ChessBoxProperties(
            element: ChessElements.lightHorse,
            hasElement: true,
            elementType: ElementType.light,
            elementIconUrl: ChessElementsIcons.lightHorse)
        .obs;
    bord[7][6] = ChessBoxProperties(
            element: ChessElements.lightHorse,
            hasElement: true,
            elementType: ElementType.light,
            elementIconUrl: ChessElementsIcons.lightHorse)
        .obs;
    bord[7][2] = ChessBoxProperties(
            hasElement: true,
            element: ChessElements.lightCamel,
            elementType: ElementType.light,
            elementIconUrl: ChessElementsIcons.lightCamel)
        .obs;
    bord[7][5] = ChessBoxProperties(
            element: ChessElements.lightCamel,
            hasElement: true,
            elementType: ElementType.light,
            elementIconUrl: ChessElementsIcons.lightCamel)
        .obs;
    bord[7][3] = ChessBoxProperties(
            element: ChessElements.lightQueen,
            hasElement: true,
            elementType: ElementType.light,
            elementIconUrl: ChessElementsIcons.lightQueen)
        .obs;
    bord[7][4] = ChessBoxProperties(
            element: ChessElements.lightKing,
            hasElement: true,
            elementType: ElementType.light,
            elementIconUrl: ChessElementsIcons.lightKing)
        .obs;

// set dark and light soldures
    for (int i = 0; i < 8; i++) {
      bord[1][i] = ChessBoxProperties(
              element: ChessElements.darkSoldure,
              hasElement: true,
              elementType: ElementType.dark,
              elementIconUrl: ChessElementsIcons.darkSoldure)
          .obs;
      bord[6][i] = ChessBoxProperties(
              element: ChessElements.lightSoldure,
              hasElement: true,
              elementType: ElementType.light,
              elementIconUrl: ChessElementsIcons.lightSoldure)
          .obs;
    }

    if (changeValue) {
      for (var i = 0; i < 8; i++) {
        for (var j = 0; j < 8; j++) {
          _chessBord[i][j].value = bord[i][j].value;
        }
      }
    } else {
      _chessBord = bord;
    }
    _selectedElement[0] = -1;
    _selectedElement[1] = -1;
    _isElementSelected = false;
    _currentPlayingPlayer = ElementType.light;
  }

  bool _isInBord(int pos) {
    return pos > -1 && pos < 8;
  }

  void _selectPath(int row, int col) {
    if (_isInBord(row) && _isInBord(col)) {
      final box = _chessBord[row][col].value;
      _chessBord[row][col].value = ChessBoxProperties(
          element: box.element,
          elementIconUrl: box.elementIconUrl,
          elementType: box.elementType,
          hasElement: box.hasElement,
          isInSelectedPath: true);
    }
  }

  void _unselectAllPath() {
    for (var i = 0; i < 8; i++) {
      for (var j = 0; j < 8; j++) {
        final box = _chessBord[i][j].value;
        _chessBord[i][j].value = ChessBoxProperties(
            element: box.element,
            elementIconUrl: box.elementIconUrl,
            elementType: box.elementType,
            hasElement: box.hasElement,
            isInSelectedPath: false);
      }
    }
  }

  void _clearSelections() {
    _isElementSelected = false;
    _selectedElement[0] = -1;
    _selectedElement[1] = -1;
    _unselectAllPath();
  }

  void _changeCurrentPlayer() {
    print("changing palyer");
    _currentPlayingPlayer = _currentPlayingPlayer == ElementType.light
        ? ElementType.dark
        : ElementType.light;
    if (_fireBaseBoardCollectionId != null) {
      _getChessBoardCollection(_fireBaseBoardCollectionId!).update({
        FireBaseFireStoreKeyString.currentPlayerKey:
            _currentPlayingPlayer.toString()
      });
    }
  }

  List<Map<String, dynamic>> _getBoardInJson() {
    final List<Map<String, dynamic>> jsonBord = [];
    for (var i = 0; i < 8; i++) {
      jsonBord.addAll(_chessBord[i].map((e) => e.value.toJson()));
    }

    return jsonBord;
  }

  // fireBase Section

// get chess board collection
  DocumentReference<Map<String, dynamic>> _getChessBoardCollection(String id) {
    return FirebaseFirestore.instance
        .collection(FireBaseFireStoreKeyString.chessRoomKey)
        .doc(id);
  }

  // create new chess room
  Future<String?> createChessRoom({required ElementType joinAs}) async {
    _joinedPlayerAs = joinAs;
    final jsonChessBoard = _getBoardInJson();

    try {
      final newChessRoom = await FirebaseFirestore.instance
          .collection(FireBaseFireStoreKeyString.chessRoomKey)
          .add({
        FireBaseFireStoreKeyString.lightPlayerExistKey:
            joinAs == ElementType.light,
        FireBaseFireStoreKeyString.darkPlayerExistKey:
            joinAs == ElementType.dark,
        FireBaseFireStoreKeyString.gameStartedKey: false,
        FireBaseFireStoreKeyString.currentPlayerKey:
            _currentPlayingPlayer.toString(),
        FireBaseFireStoreKeyString.isGameFinisedKey: false,
        FireBaseFireStoreKeyString.winnerKey: null,
        FireBaseFireStoreKeyString.chessBoardKey: jsonChessBoard
      });
      _lisinOnlineChangeOn(newChessRoom);
      _fireBaseBoardCollectionId = newChessRoom.id;
      return newChessRoom.id;
    } catch (e) {
      Get.snackbar("error", e.toString());
    }
    return null;
  }

  Future<bool> joinChessBoard(String id) async {
    final chessBordCollection = _getChessBoardCollection(id);
    if (await chessBordCollection.get().then((value) =>
        value.exists &&
        !value.data()![FireBaseFireStoreKeyString.gameStartedKey])) {
      final isLightPlayerExist = await chessBordCollection.get().then((value) =>
          value.data()![FireBaseFireStoreKeyString.lightPlayerExistKey]
              as bool);

      _joinedPlayerAs =
          isLightPlayerExist ? ElementType.dark : ElementType.light;
      _fireBaseBoardCollectionId = id;

      chessBordCollection.update({
        FireBaseFireStoreKeyString.darkPlayerExistKey: true,
        FireBaseFireStoreKeyString.lightPlayerExistKey: true,
        FireBaseFireStoreKeyString.gameStartedKey: true
      });
      _lisinOnlineChangeOn(chessBordCollection);
      return true;
    }

    return false;
  }

  // lisining change online
  void _lisinOnlineChangeOn(DocumentReference<Map<String, dynamic>> doc) {
    doc.snapshots().listen((event) {
      if (event.exists) {
        final data = event.data()!;
        if (!_startOnlineChess.value) {
          _startOnlineChess.value =
              data[FireBaseFireStoreKeyString.lightPlayerExistKey] &&
                  data[FireBaseFireStoreKeyString.darkPlayerExistKey];
        }
        _currentPlayingPlayer = elementTypeFromString(
            data[FireBaseFireStoreKeyString.currentPlayerKey]);
        if (data[FireBaseFireStoreKeyString.isGameFinisedKey]) {
          _setWinner(
            elementTypeFromString(data[FireBaseFireStoreKeyString.winnerKey]),
          );
        }

        final List<Map<String, dynamic>> jsonBord = [];
        jsonBord.addAll(
            (data[FireBaseFireStoreKeyString.chessBoardKey] as List).map(
          (e) => e as Map<String, dynamic>,
        ));
        // print((jsonBord[0] as Map<String, dynamic>)["element_icon_url"]);
        // jsonBord.forEach((element) {
        //   final data = jsonDecode(element.toString());
        // });
        for (var i = 0; i < 8; i++) {
          for (var j = 0; j < 8; j++) {
            final ChessBoxProperties chessBox =
                ChessBoxProperties.fromJson(jsonBord[i * 8 + j]);
            if (_chessBord[i][j].value != chessBox) {
              _chessBord[i][j].value = chessBox;
            }
          }
        }
      }
    });
  }

  // show winner on change
  Future<void> _setWinner(
    ElementType winner,
  ) async {
    _winner = winner;
    if (_fireBaseBoardCollectionId != null) {
      _getChessBoardCollection(_fireBaseBoardCollectionId!).update({
        FireBaseFireStoreKeyString.winnerKey: winner.toString(),
        FireBaseFireStoreKeyString.isGameFinisedKey: true
      });
      Future.delayed(const Duration(seconds: 1)).then((value) {
        _getChessBoardCollection(_fireBaseBoardCollectionId!).delete();
        _fireBaseBoardCollectionId = null;
      });
    }
    final isPlayAgain = await showAppAlertBox(
      Get.context!,
      alertText: winner == ElementType.light ? "Light Wins" : "Dark Wins",
      agreeText: "Play Again",
      dissagreeText: "Go Back",
      height: 200,
      image: const AssetImage(ChessElementsIcons.lightKing),
    );
    if (isPlayAgain) {
      initateChessBord(changeValue: true);
    } else {
      print("go back");
    }
  }

  Future<void> _updateBoardOnline(String id) async {
    _getChessBoardCollection(id)
        .update({FireBaseFireStoreKeyString.chessBoardKey: _getBoardInJson()});
  }

// Handel click
  Future<void> handelClickOn(
      {required ChessBoxProperties element,
      required int row,
      required int col}) async {
    if (_winner != null ||
        (_fireBaseBoardCollectionId != null &&
            _joinedPlayerAs != _currentPlayingPlayer)) {
      print(_winner);
      print(_fireBaseBoardCollectionId);
      print(_joinedPlayerAs != _currentPlayingPlayer);
      print("game is finised");
      return;
    }

    // attack
    if (_isElementSelected &&
        element.isInSelectedPath &&
        element.hasElement &&
        element.elementType !=
            _chessBord[_selectedElement[0]][_selectedElement[1]]
                .value
                .elementType) {
      final selectedNode =
          _chessBord[_selectedElement[0]][_selectedElement[1]].value;
      _chessBord[row][col].value = selectedNode;
      _chessBord[_selectedElement[0]][_selectedElement[1]].value =
          ChessBoxProperties();
      if (_fireBaseBoardCollectionId != null) {
        _updateBoardOnline(_fireBaseBoardCollectionId!);
      }
      _changeCurrentPlayer();
      // wining condition check
      if (element.element == ChessElements.darkKing ||
          element.element == ChessElements.lightKing) {
        _setWinner(element.elementType == ElementType.dark
            ? ElementType.light
            : ElementType.dark);
        return;
      }

      // soldure reach at gole
      if ((selectedNode.element == ChessElements.darkSoldure && row == 7) ||
          (selectedNode.element == ChessElements.lightSoldure && row == 0)) {
        final selectedFromDialog = await showChessElementSelectore(
            context: Get.context!, elementType: selectedNode.elementType!);
        _chessBord[row][col].value = ChessBoxProperties(
          element: selectedFromDialog,
          elementIconUrl: ChessElementsIcons.iconOfElement(selectedFromDialog),
          elementType: selectedNode.elementType,
          hasElement: true,
        );
        if (_fireBaseBoardCollectionId != null) {
          _updateBoardOnline(_fireBaseBoardCollectionId!);
        }
      }
      _clearSelections();
      // show actions
    }
    // go there
    else if (_isElementSelected && element.isInSelectedPath) {
      print("go");
      final selectedNode =
          _chessBord[_selectedElement[0]][_selectedElement[1]].value;
      _chessBord[row][col].value = selectedNode;
      _chessBord[_selectedElement[0]][_selectedElement[1]].value =
          ChessBoxProperties();
      if (_fireBaseBoardCollectionId != null) {
        _updateBoardOnline(_fireBaseBoardCollectionId!);
      }
      _clearSelections();
      if ((selectedNode.element == ChessElements.darkSoldure && row == 7) ||
          (selectedNode.element == ChessElements.lightSoldure && row == 0)) {
        final selectedFromDialog = await showChessElementSelectore(
            context: Get.context!, elementType: selectedNode.elementType!);
        _chessBord[row][col].value = ChessBoxProperties(
          element: selectedFromDialog,
          elementIconUrl: ChessElementsIcons.iconOfElement(selectedFromDialog),
          elementType: selectedNode.elementType,
          hasElement: true,
        );
        if (_fireBaseBoardCollectionId != null) {
          _updateBoardOnline(_fireBaseBoardCollectionId!);
        }
      }
      _changeCurrentPlayer();
    }
    // select
    else if (element.hasElement &&
        element.elementType == _currentPlayingPlayer) {
      print("select");
      _clearSelections();
      _isElementSelected = true;
      _selectedElement[0] = row;
      _selectedElement[1] = col;

      switch (element.element!) {
        case ChessElements.darkElephent || ChessElements.lightElephent:
          _selectElephentPath(
              elepthentType: element.elementType!, row: row, col: col);
          break;
        case ChessElements.darkHorse || ChessElements.lightHorse:
          _selectHoursePath(
              hourseType: element.elementType!, row: row, col: col);
          break;
        case ChessElements.darkCamel || ChessElements.lightCamel:
          _selectCemalPath(camelType: element.elementType!, row: row, col: col);
          break;
        case ChessElements.darkQueen || ChessElements.lightQueen:
          _selectQueenPath(queenType: element.elementType!, row: row, col: col);
          break;
        case ChessElements.darkKing || ChessElements.lightKing:
          _selectKingPath(kingType: element.elementType!, row: row, col: col);
          break;
        case ChessElements.darkSoldure || ChessElements.lightSoldure:
          _selectSoldurePath(
              soldureType: element.elementType!, row: row, col: col);
          break;
        default:
      }
    } else {
      print("null");
      _clearSelections();
    }
  }

// select hourse path
  void _selectHoursePath(
      {required ElementType hourseType, required int row, required int col}) {
    final posiblePath = [
      [-2, -1],
      [-2, 1],
      [-1, 2],
      [1, 2],
      [2, 1],
      [2, -1],
      [1, -2],
      [-1, -2]
    ];
    for (var path in posiblePath) {
      if (_isInBord(row + path[0]) &&
          _isInBord(col + path[1]) &&
          _chessBord[row + path[0]][col + path[1]].value.elementType !=
              hourseType) {
        _selectPath(row + path[0], col + path[1]);
      }
    }
  }

// select hourse path
  void _selectCemalPath(
      {required ElementType camelType, required int row, required int col}) {
    // i++ j++
    for (var i = 1; i < 8 && _isInBord(row + i) && _isInBord(col + i); i++) {
      if (_chessBord[row + i][col + i].value.hasElement) {
        if (_chessBord[row + i][col + i].value.elementType != camelType) {
          _selectPath(row + i, col + i);
        }
        break;
      }
      _selectPath(row + i, col + i);
    }

    // i-- j++
    for (var i = 1; i < 8 && _isInBord(row - i) && _isInBord(col + i); i++) {
      if (_chessBord[row - i][col + i].value.hasElement) {
        if (_chessBord[row - i][col + i].value.elementType != camelType) {
          _selectPath(row - i, col + i);
        }
        break;
      }
      _selectPath(row - i, col + i);
    }

    // i++ j--
    for (var i = 1; i < 8 && _isInBord(row + i) && _isInBord(col - i); i++) {
      if (_chessBord[row + i][col - i].value.hasElement) {
        if (_chessBord[row + i][col - i].value.elementType != camelType) {
          _selectPath(row + i, col - i);
        }
        break;
      }
      _selectPath(row + i, col - i);
    }

    // i-- j--
    for (var i = 1; i < 8 && _isInBord(row - i) && _isInBord(col - i); i++) {
      if (_chessBord[row - i][col - i].value.hasElement) {
        if (_chessBord[row - i][col - i].value.elementType != camelType) {
          _selectPath(row - i, col - i);
        }
        break;
      }
      _selectPath(row - i, col - i);
    }
  }

// select hourse path
  void _selectQueenPath(
      {required ElementType queenType, required int row, required int col}) {
    _selectCemalPath(camelType: queenType, row: row, col: col);
    _selectElephentPath(elepthentType: queenType, row: row, col: col);
  }

// select hourse path
  void _selectKingPath(
      {required ElementType kingType, required int row, required int col}) {
    final posiblePath = [
      [-1, -1],
      [-1, 0],
      [-1, 1],
      [0, -1],
      [0, 1],
      [1, -1],
      [1, 0],
      [1, 1]
    ];

    for (var path in posiblePath) {
      if (_isInBord(row + path[0]) &&
          _isInBord(col + path[1]) &&
          _chessBord[row + path[0]][col + path[1]].value.elementType !=
              kingType) {
        _selectPath(row + path[0], col + path[1]);
      }
    }
  }

// select hourse path
  void _selectSoldurePath(
      {required ElementType soldureType, required int row, required int col}) {
    if (soldureType == ElementType.dark) {
      // down
      if (_isInBord(row + 1) && !_chessBord[row + 1][col].value.hasElement) {
        _selectPath(row + 1, col);
        if (row == 1 && !_chessBord[row + 2][col].value.hasElement) {
          _selectPath(row + 2, col);
          _chessBord[row + 2][col].value.isSoldureTwoStap = true;
        }
      }
      // attack
      if (_isInBord(col - 1) &&
          _isInBord(row + 1) &&
          _chessBord[row + 1][col - 1].value.elementType == ElementType.light) {
        _selectPath(row + 1, col - 1);
      }
      // Attack
      if (_isInBord(col + 1) &&
          _isInBord(row + 1) &&
          _chessBord[row + 1][col + 1].value.elementType == ElementType.light) {
        _selectPath(row + 1, col + 1);
      }
    } else {
      // up
      if (_isInBord(row - 1) && !_chessBord[row - 1][col].value.hasElement) {
        _selectPath(row - 1, col);
        if (row == 6 && !_chessBord[row - 2][col].value.hasElement) {
          _selectPath(row - 2, col);
          _chessBord[row - 2][col].value.isSoldureTwoStap = true;
        }
      }
      // attack
      if (_isInBord(col - 1) &&
          _isInBord(row - 1) &&
          _chessBord[row - 1][col - 1].value.elementType == ElementType.dark) {
        _selectPath(row - 1, col - 1);
      }
      // attack
      if (_isInBord(col + 1) &&
          _isInBord(row - 1) &&
          _chessBord[row - 1][col + 1].value.elementType == ElementType.dark) {
        _selectPath(row - 1, col + 1);
      }
    }
  }

// select elephent path
  void _selectElephentPath(
      {required ElementType elepthentType,
      required int row,
      required int col}) {
    // i++ j
    for (var i = 1; i < 8 && _isInBord(row + i); i++) {
      if (_chessBord[row + i][col].value.hasElement) {
        if (_chessBord[row + i][col].value.elementType != elepthentType) {
          _selectPath(row + i, col);
        }
        break;
      }
      _selectPath(row + i, col);
    }

    // i-- j
    for (var i = 1; i < 8 && _isInBord(row - i); i++) {
      if (_chessBord[row - i][col].value.hasElement) {
        if (_chessBord[row - i][col].value.elementType != elepthentType) {
          _selectPath(row - i, col);
        }
        break;
      }
      _selectPath(row - i, col);
    }

    // i j--
    for (var i = 1; i < 8 && _isInBord(col - i); i++) {
      if (_chessBord[row][col - i].value.hasElement) {
        if (_chessBord[row][col - i].value.elementType != elepthentType) {
          _selectPath(row, col - i);
        }
        break;
      }
      _selectPath(row, col - i);
    }

    // i j++
    for (var i = 1; i < 8 && _isInBord(col + i); i++) {
      if (_chessBord[row][col + i].value.hasElement) {
        if (_chessBord[row][col + i].value.elementType != elepthentType) {
          _selectPath(row, col + i);
        }
        break;
      }
      _selectPath(row, col + i);
    }
  }
}
