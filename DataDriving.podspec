#
#  Be sure to run `pod spec lint DataDriving.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "DataDriving"
  s.version      = "1.0.2"
  s.summary      = "data driving develope"
  s.description  = <<-DESC
  data driving develope, so developer can write less code, reduce errors.
                   DESC

  s.homepage     = "https://github.com/yuanyuan100/DataDriving"
  s.license      = "MIT"

  s.author       = { "pengyy" => "469092943@qq.com" }

  s.platform     = :ios, "8.0"

  # s.source       = { :git => "https://github.com/yuanyuan100/DataDriving.git", :tag => s.version}
  s.source       = { :git => "https://git.oschina.net/yuanyuan100/DataDriving.git", :tag => s.version}

  s.source_files  = "DataDrivingDemo/Source/*.{h,m}"

  s.requires_arc = true
end
