#FEAudioDisplayView.podspec
Pod::Spec.new do |s|
  s.name         = "FEAudioDisplayView"
  s.version      = "0.0.1"
  s.summary      = "一个简单好用的用于显示弹幕的视图"

  s.homepage     = "https://github.com/Feelinging/FEAudiodispalyView"
  s.license      = "MIT"
  s.author       = { "Kira Yamato" => "https://github.com/kirayamato1989" }
  s.platform     = :ios, "7.0"
  s.ios.deployment_target = "7.0"
  s.source       = { :git => "https://github.com/Feelinging/FEAudioDisplayView.git", :tag => s.version}
  s.requires_arc = true
  s.source_files  = 'FEAudioDisplayView/*.{h,m}'
end

