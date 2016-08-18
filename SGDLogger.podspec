Pod::Spec.new do |s|
  s.name         = "SGDLogger"
  s.version      = "0.0.3"
  s.summary      = "Color test logger"
  s.homepage     = "https://github.com/Sangen/SGDLogger"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = "Sangen"
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/Sangen/SGDLogger.git", :tag => "v#{s.version}" }
  s.source_files = "Sources", "Sources/**/*.{h,m}"
end
