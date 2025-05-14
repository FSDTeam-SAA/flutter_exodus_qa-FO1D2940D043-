import 'api_result.dart';
import 'base_response.dart';

ApiResult<T> mapBaseResponse<T>(BaseResponse<T> base) {
  if (base.success && base.data != null) {
    return ApiSuccess(base.data as T);
  } else {
    return ApiError(base.message);
  }
}
