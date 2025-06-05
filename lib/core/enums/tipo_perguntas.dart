enum TipoPerguntasEnum {
  inputCheckBox,
  variosCheckBox;

  String get name {
    switch (this) {
      case TipoPerguntasEnum.inputCheckBox:
        return 'INPUT_CHECKBOX';
      case TipoPerguntasEnum.variosCheckBox:
        return 'MULTIPLE_CHECKBOX';
    }
  }

  factory TipoPerguntasEnum.fromString(String value) {
    return TipoPerguntasEnum.values.firstWhere(
      (tipo) => tipo.name == value,
      orElse: () => TipoPerguntasEnum.inputCheckBox,
    );
  }
}
