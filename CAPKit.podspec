Pod::Spec.new do |s|
  s.name         = "CAPKit"
  s.version      = "0.4.5"
  s.summary      = "CAPKit Framework."
  s.description  = <<-DESC
                   CAPKit Framework, Cloud Application Platform.
                   DESC
  s.homepage     = "https://github.com/successinfo-org/CAPKit"
  s.license      = "MIT"
  s.author       = { "samchang" => "sam.chang@me.com" }
  s.platform     = :ios, "8.0.0"
  s.source       = { :git => "https://github.com/successinfo-org/CAPKit.git", :tag => "v#{s.version}" }
  s.frameworks   = 'AssetsLibrary', 'MessageUI', 'AddressBookUI', 'AddressBook', 'Accelerate', 'MapKit', 'AudioToolbox', 'CoreTelephony', 'QuickLook', 'Social', 'CoreLocation'
  s.weak_framework = 'WebKit'
  s.libraries = 'resolv', 'iconv'

  s.resource = 'Debug/builtin'
  s.ios.vendored_frameworks = 'Debug/CAPKit.framework'

  s.dependency 'DTCoreText'
  s.dependency 'TouchJSON'
  s.dependency 'FMDB/FTS'
  s.dependency 'Reachability'
  s.dependency 'ZipArchive'
  s.dependency 'UIDevice-Hardware'
  s.dependency 'NSData+Base64'
  s.dependency 'GZIP'
  s.dependency 'SAMKeychain'
  s.dependency 'YLGIFImage'
  s.dependency 'RSSwizzle'

  s.dependency 'iOS-WebP'
  s.dependency 'CAPKit-lua53'
  s.dependency 'CAPKit-3rdparty-libs'
  s.dependency 'CAPKit-sqlcipher'
  s.dependency 'CAPKit-OpenCV24x'
  s.dependency 'CAPKit-Box2D'

  s.dependency 'luafan'
end
