class UploadsController < ApplicationController

  def device_record
    DeviceRecordFile.read(params.require(:file)) {|device_record_file|
      @device_records = DeviceRecord.parse(device_record_file.storage_path)
    }
  rescue ActionController::ParameterMissing => e
    redirect_to root_path, alert: "invalid request"
  end
end
