import 'package:exodus/core/utils/debug_logger.dart';

import 'api_result.dart';
import 'models/base_response.dart';
import 'models/error_response.dart';

ApiResult<T> mapBaseResponse<T>(BaseResponse<T> base) {
  dPrint('''
  Mapping BaseResponse:
  - Success: ${base.success}
  - Message: ${base.message}
  - Data: ${base.data?.toString() ?? 'null'}
  ''');
  if (base.success && base.data != null) {
    return ApiSuccess(base.data as T);
  } else {
    // If we have error details, parse them
    if (base.data is Map && (base.data as Map).containsKey('errorSources')) {
      final errorResponse = ErrorResponse.fromJson(base.data as Map<String, dynamic>);
      return ApiError(errorResponse.combinedErrorMessage);
    }
    
    return ApiError(base.message);
  }
}
