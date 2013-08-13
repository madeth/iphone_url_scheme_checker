class DeviceRecord
  attr_accessor :plist, :id, :name, :schemes

  def self.parse(file_path)
    Plist::parse_xml(file_path)["applicationDictionaries"].map {|plist|
      self.new(plist)
    }.sort_by {|v| v.name || '' }
  end

  def initialize(plist)
    @plist = plist
  end

  def id
    self.plist["CFBundleIdentifier"]
  end

  def name
    self.plist["CFBundleDisplayName"] || self.plist["CFBundleName"] || self.plist["CFBundleExecutable"]
  end

  def schemes
    if scheme_blank?
      nil
    else
      self.plist["CFBundleURLTypes"].first["CFBundleURLSchemes"]
    end
  end

  private
    def scheme_blank?
      self.plist["CFBundleURLTypes"].nil? || self.plist["CFBundleURLTypes"].first.nil?
    end
end
