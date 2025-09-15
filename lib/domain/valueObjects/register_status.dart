enum RegisterStatusEnum { register, partial, complete, undefined }

class RegisterStatus {
  final RegisterStatusEnum value;

  const RegisterStatus._(this.value);
  RegisterStatus.empty() : value = RegisterStatusEnum.undefined;

  factory RegisterStatus.fromString(String status) {
    try {
      final enumValue = RegisterStatusEnum.values.firstWhere((e) => e.name == status);
      return RegisterStatus._(enumValue);
    } catch (_) {
      throw ArgumentError('Invalid status: $status');
    }
  }

  @override
  String toString() => value.name;

  @override
  bool operator ==(Object other) => identical(this, other) || other is RegisterStatus && value == other.value;

  @override
  int get hashCode => value.hashCode;

  bool get isComplete => value == RegisterStatusEnum.complete;
  bool get isPartial => value == RegisterStatusEnum.partial;
  bool get isRegister => value == RegisterStatusEnum.register;
  bool get isUndefined => value == RegisterStatusEnum.undefined;
}
