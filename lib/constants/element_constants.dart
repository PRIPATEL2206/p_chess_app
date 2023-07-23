class ChessElementsIcons {
  // dark element
  static const darkKing = "assets/photos/darkKing.png";
  static const darkQueen = "assets/photos/darkQueen.png";
  static const darkElephent = "assets/photos/darkElefent.png";
  static const darkCamel = "assets/photos/darkCamal.png";
  static const darkHorse = "assets/photos/darkHours.png";
  static const darkSoldure = "assets/photos/darkSoldure.png";

// light element
  static const lightKing = "assets/photos/lightKing.png";
  static const lightQueen = "assets/photos/lightQueen.png";
  static const lightElephent = "assets/photos/lightElefent.png";
  static const lightCamel = "assets/photos/lightCamal.png";
  static const lightHorse = "assets/photos/lightHours.png";
  static const lightSoldure = "assets/photos/lightSoldure.png";

  static ChessElements elementOfIcon(String icon) {
    switch (icon) {
      case darkKing:
        return ChessElements.darkKing;
      case darkQueen:
        return ChessElements.darkQueen;
      case darkElephent:
        return ChessElements.darkElephent;
      case darkCamel:
        return ChessElements.darkCamel;
      case darkHorse:
        return ChessElements.darkHorse;
      case darkSoldure:
        return ChessElements.darkSoldure;
      case lightKing:
        return ChessElements.lightKing;
      case lightQueen:
        return ChessElements.lightQueen;
      case lightElephent:
        return ChessElements.lightElephent;
      case lightCamel:
        return ChessElements.lightCamel;
      case lightHorse:
        return ChessElements.lightHorse;
      case lightSoldure:
        return ChessElements.lightSoldure;
      default:
        return ChessElements.darkSoldure;
    }
  }

  static String iconOfElement(ChessElements icon) {
    switch (icon) {
      case ChessElements.darkKing:
        return darkKing;
      case ChessElements.darkQueen:
        return darkQueen;
      case ChessElements.darkElephent:
        return darkElephent;
      case ChessElements.darkCamel:
        return darkCamel;
      case ChessElements.darkHorse:
        return darkHorse;
      case ChessElements.darkSoldure:
        return darkSoldure;
      case ChessElements.lightKing:
        return lightKing;
      case ChessElements.lightQueen:
        return lightQueen;
      case ChessElements.lightElephent:
        return lightElephent;
      case ChessElements.lightCamel:
        return lightCamel;
      case ChessElements.lightHorse:
        return lightHorse;
      case ChessElements.lightSoldure:
        return lightSoldure;
      default:
        return darkSoldure;
    }
  }
}

ChessElements? chessElementFromString(String? element) {
  for (var chessElement in ChessElements.values) {
    if (chessElement.toString() == element) return chessElement;
  }
  return null;
}

ElementType? elementTypeFromString(String? type) {
  if (ElementType.dark.toString() == type) {
    return ElementType.dark;
  } else if (ElementType.light.toString() == type) {
    return ElementType.light;
  }
  return null;
}

enum ElementType { dark, light }

enum ChessElements {
  darkKing,
  darkQueen,
  darkElephent,
  darkCamel,
  darkHorse,
  darkSoldure,
  lightKing,
  lightQueen,
  lightElephent,
  lightCamel,
  lightHorse,
  lightSoldure,
}
