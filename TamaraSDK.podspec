Pod::Spec.new do |spec|

  spec.name         = "TamaraSDK"
  spec.version      = "0.0.12"
  spec.summary      = "SDK for tamara.co"

  spec.description  = <<-DESC
  iOS SDK to integrate checkout with tamara.co to your app.
                   DESC

  spec.homepage     = "https://github.com/tamara-solution/ios-sdk"

  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author             = { "Tamara" => "contact@tamara.co" }
  spec.platform     = :ios, "11.0"
  spec.source       = { :git => "https://github.com/tamara-solution/ios-sdk.git", :tag => "#{spec.version}" }

  spec.source_files  = "TamaraSDK/TamaraSDK/*"
  spec.exclude_files = "TamaraSDK/TamaraSDK/*.plist"

  spec.swift_versions = "5.0"

end
