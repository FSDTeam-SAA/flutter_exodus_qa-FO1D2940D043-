import 'package:exodus/core/utils/debug_logger.dart';

import 'api_result.dart';
import 'base_response.dart';

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
    return ApiError(base.message);
  }
}
