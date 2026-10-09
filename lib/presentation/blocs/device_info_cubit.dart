import 'package:connectme_app/data/datasources/device_info_datasource.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'device_info_state.dart';

// Cubit for managing device info state
class DeviceInfoCubit extends Cubit<DeviceInfoState> {
  final DeviceInfoDataSource _dataSource;

  DeviceInfoCubit(this._dataSource) : super(const DeviceInfoState());

  // Integration with device_info_plus through data source
  Future<void> getDeviceInfo() async {
    emit(const DeviceInfoState(status: DeviceInfoStatus.loading));

    try {
      final deviceInfo = await _dataSource.getDeviceInfo();

      emit(
        DeviceInfoState(
          status: DeviceInfoStatus.success,
          deviceInfo: deviceInfo,
        ),
      );
    } catch (e) {
      emit(
        DeviceInfoState(
          status: DeviceInfoStatus.error,
          errorMessage: 'Unable to load device information.',
        ),
      );
    }
  }
}
