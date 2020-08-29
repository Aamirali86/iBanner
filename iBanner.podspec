#
#  Be sure to run `pod spec lint iBanner.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name         = "iBanner"
  spec.version      = "0.0.1"
  spec.summary      = "iBanner is a customizable and lightweight library that makes the task of displaying in app notification banners in iOS."

  s.homepage         = 'https://github.com/Aamirali86/iBanner'
  spec.license      = "MIT (example)"
  # spec.license      = { :type => "MIT", :file => "FILE_LICENSE" }


  spec.author             = { "Muhammad Aamir Ali" => "aamir-muhammad@hotmail.com" }
  # spec.authors            = { "Muhammad Aamir" => "" }
  spec.social_media_url   = "http://linkedin.com/in/muhammadaamirali/"

  spec.platform     = :ios
  spec.platform     = :ios, "5.0"

  #  When using multiple platforms
  # spec.ios.deployment_target = "5.0"
  # spec.osx.deployment_target = "10.7"
  # spec.watchos.deployment_target = "2.0"
  # spec.tvos.deployment_target = "9.0"

  spec.source       = { :git => "https://github.com/Aamirali86/iBanner.git", :tag => "#{spec.version}" }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  CocoaPods is smart about how it includes source code. For source files
  #  giving a folder will include any swift, h, m, mm, c & cpp files.
  #  For header files it will include any header in the folder.
  #  Not including the public_header_files will make all headers public.
  #

  spec.source_files = 'SmartToast/Classes/**/*'
  spec.source_files  = "banner/Banner/**/*"

  # spec.resource  = "icon.png"
  # spec.resources = "Resources/*.png"

  # spec.preserve_paths = "FilesToSave", "MoreFilesToSave"

end
