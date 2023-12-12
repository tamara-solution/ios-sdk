#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint TamaraSDK.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = "TamaraSDK"
  s.version          = "1.0.6"
  s.summary       = "SDK for tamara.co"
  s.description      = "iOS sdk for tamara.co"
  s.homepage         = "https://tamara.co"
  s.license          = { :type => "MIT", :file => "LICENSE" }
  s.author           = { "Tamara" => "contact@tamara.co" }
  s.source           = { :git => "https://github.com/tamara-solution/ios-sdk.git", :tag => "#{s.version}"  }
  s.source_files = "TamaraSDK/TamaraSDK/**/*"
  s.dependency 'Moya'
  s.exclude_files = "TamaraSDK/TamaraSDK/*.plist"
  s.platform = :ios, "11.0"
  s.swift_version = "5.0"
  s.readme = "https://github.com/tamara-solution/ios-sdk/blob/master/README.md"
end
