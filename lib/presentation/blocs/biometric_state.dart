// State management for biometric authentication
enum BiometricStatus { initial, loading, success, failure }

class BiometricState {
  final BiometricStatus status;
  final String? errorMessage;

  const BiometricState({
    this.status = BiometricStatus.initial,
    this.errorMessage,
  });
}
