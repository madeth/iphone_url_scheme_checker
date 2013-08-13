class DeviceRecordFile
  attr_accessor :file, :storage_path

  include ActiveModel::ForbiddenAttributesProtection

  def self.read(file, &block)
    device_record_file = self.new
    device_record_file.file = file
    tmp_path = "#{Rails.root}/public/tmp"

    FileUtils.mkdir_p(tmp_path) unless FileTest.exist?(tmp_path)
    device_record_file.storage_path = "#{tmp_path}/#{SecureRandom.hex(10)}#{file.original_filename}"

    File.open(device_record_file.storage_path, "wb") {|f|
      f.write(file.read)
    }
    if block_given?
      yield device_record_file
      device_record_file.cleanup
    else
      device_record_file
    end
  end

  def cleanup
    File.delete(self.storage_path) unless self.storage_path.blank?
  end
end
