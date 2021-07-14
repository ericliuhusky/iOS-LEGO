Pod::Spec.new do |s|
  s.name             = 'ComponentA'
  s.version          = '1.0.0'
  s.summary          = 'A short description of ComponentA.'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'http://git.babybus.co/BMPaaS-iOS/Core/ComponentA'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'liuzihao' => 'liuzihao@babybus.com' }
  s.source           = { :git => 'http://git.babybus.co/BMPaaS-iOS/Core/ComponentA.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'
  s.requires_arc = true

  ## 工程特殊性--使用源码居多，故默认操作加载源码方式引入
  if ENV['IS_Binary_SOURCE']# 引用二进制库
    s.public_header_files = 'Pod/Products/*.framework/Headers/*'
    s.ios.vendored_frameworks = 'Pod/Products/*.framework'
  else
    s.source_files = 'Pod/Classes/**/*'
    
    s.dependency 'BBMiddlewareAPI'
    s.dependency 'BBNativeContainer'
    
  end
end
