#
# Be sure to run `pod lib lint BBMiddlewareAPI.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#
# 版本更新说明 A.B.C.D
# 第一位是大版本重构(不向下兼容)，
# 第二位是功能新增，
# 第三位是修改Bug， 最小值是0
# 第四位是针对一个Bug多次修改 或者 用于自增  等情况，有需要的时候启用。最小值是1 (第三位+1. 第四位重置成1)

Pod::Spec.new do |s|
  s.name             = 'BBMiddlewareAPI'
  s.version          = '21.4.11.8'
  s.summary          = 'A short description of BBMiddlewareAPI.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'http://git.babybus.co/Babybus-iOS/Business/BBMiddlewareAPI'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'bba@babybus.com' => 'humin1102@126.com' }
  s.source           = { :git => 'http://git.babybus.co/Babybus-iOS/Business/BBMiddlewareAPI.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'
  # s.platform     = :ios, '9.0'
  s.requires_arc = true

  ## 工程特殊性--使用源码居多，故默认操作加载源码方式引入
  if ENV['IS_Binary_SOURCE']# 引用二进制库
    # puts '-------------------------------------------------------------------'
    # puts 'Notice:BBMiddlewareAPI is binary now'

    # framework (推荐) -- 通过pod package生成静态库
    s.public_header_files = 'Pod/Products/*.framework/Headers/*'
    s.ios.vendored_frameworks = 'Pod/Products/*.framework'
    # # lib 
    # s.public_header_files = 'Pod/Products/include/*.h'
    # s.ios.vendored_libraries = 'Pod/Products/lib/*.a'
  else
    # puts '-------------------------------------------------------------------'
    # puts 'Notice: BBMiddlewareAPI is source now'

    s.source_files = 'Pod/Classes/**/*'
    s.dependency 'BBMiddlewareKit'
    s.dependency 'BBDefinitionContainer', '>= 1.1.4'
    s.dependency 'BBNativeContainer'
  end
end
