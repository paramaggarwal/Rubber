Pod::Spec.new do |s|

  s.name         = "Rubber"
  s.version      = "0.1.0"
  s.summary      = "iOS Apps in JavaScript"

  s.description  = <<-DESC
                   Build iOS apps like you build web-apps.
                   Inspired by React Native.
                   DESC

  s.homepage     = "http://bitbucket.org/myntra/Rubber" 
  s.license      = "Private"
  s.author       = { "Param Aggarwal" => "paramaggarwal@gmail.com" }
  s.platform     = :ios, '7.0'
  s.requires_arc = true
  s.source       = { :git => "https://bitbucket.org/myntra/Rubber.git", :tag => "v0.1.0" }
  s.public_header_files = 'Classes/Rubber.h'
  s.source_files  = "Classes", "Classes/**/*.{h,m,c}"
  s.exclude_files = "Classes/Exclude"
  s.resources     = "Fonts/**/*.{ttf}"

  s.dependency "AFNetworking"
  s.dependency "AsyncDisplayKit"
  s.dependency "Mantle"
  s.dependency "SDWebImage"
  s.dependency "HexColors"
  s.dependency "FontAwesome+iOS"

end