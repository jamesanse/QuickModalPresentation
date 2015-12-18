Pod::Spec.new do |s|
  s.name         = "QuickModalPresentation"
  s.version      = "0.0.2"
  s.summary      = "Present modal viewcontroller with ease."
  s.description  = <<-DESC

                    Present modal viewcontroller with ease
                   1 takes advantage of uipresentation controller and uiviewanimatedtransition
                   2 comes with multiple build-in animation types, easy to create more
                   3 no memory leaks
                   4 specify size of presented vc
                   5 automatically added blur effect to the presenting vc
                   DESC

  s.homepage     = "https://github.com/jamesanse/QuickModalPresentation"
  s.license      = "MIT"
  s.author             = { "jin an" => "jamesanse@gmail.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/jamesanse/QuickModalPresentation.git", :tag => "0.0.2" }
  s.source_files = "modalTransitionTest/Classes/**/*.swift"
  s.requires_arc = true
  s.dependency "EasyAnimation"," ~>1.0.1"

end
