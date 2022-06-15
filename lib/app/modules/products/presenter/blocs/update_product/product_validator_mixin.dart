mixin ProductValidatorMixin {
  String? validateFieldIsEmpty(String? fieldValue, {String? fieldName}) =>
      fieldValue == null || fieldValue.isEmpty
          ? '${fieldName ?? "Field"} is Empty'
          : null;

  String? validateNumberField(String? field, {String? fieldName}) {
    final emptyErrorMessage =
        validateFieldIsEmpty(field, fieldName: fieldName ?? 'Field');
    if (emptyErrorMessage != null) {
      return emptyErrorMessage;
    }

    final errorFormatMessage = '$fieldName is invalid';
    if (!RegExp(r'[.0-9]').hasMatch(field!)) {
      return errorFormatMessage;
    }
    return null;
  }
}
