Pod::Spec.new do |s|
  s.name             = "EasyRegex"
  s.version          = "1.0.0"
  s.summary          = "一个可提供最便捷的方式生成正则表达式，且包含常用ios应用开发正则的第三方库(Objective-C)。"
  s.description      = <<-DESC
                       一个可提供最便捷的方式生成正则表达式，且包含常用ios应用开发正则的第三方库(Objective-C)。
 			DESC
  s.homepage         = "https://github.com/shionIsMyName/EasyRegex"
  # s.screenshots      = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "施勇" => "619023485@qq.com/shionIsMyName@gmail.com" }
  s.source           = { :git => "https://github.com/shionIsMyName/EasyRegex.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/NAME'

  s.platform     = :ios, '7.0'
  # s.ios.deployment_target = '5.0'
  # s.osx.deployment_target = '10.7'
  s.requires_arc = true

  s.source_files = 'EasyRegex/*'
  # s.resources = 'Assets'

  # s.ios.exclude_files = 'Classes/osx'
  # s.osx.exclude_files = 'Classes/ios'
  # s.public_header_files = 'Classes/**/*.h'
  s.frameworks = 'Foundation', 'CoreGraphics', 'UIKit'

end
