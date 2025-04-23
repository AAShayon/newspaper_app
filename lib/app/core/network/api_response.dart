class ApiResponse<T> {
  final T? data;
  final String? errorMessage;

  ApiResponse.withSuccess(this.data) : errorMessage = null;

  ApiResponse.withError(this.errorMessage) : data = null;

  bool get isSuccess => data != null;
}
