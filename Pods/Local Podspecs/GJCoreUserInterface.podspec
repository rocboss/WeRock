Pod::Spec.new do |s|
  s.name         = "GJCoreUserInterface"
  s.version      = "1.0.0"
  s.summary      = "赶集网通用UI组件库"
  s.homepage     = "http://www.ganji.com"
  s.license      = 'MIT'
  s.author       = { "胡涛" => "hutao1@ganji.com"}
  s.source       = { :git => "ssh://git@192.168.2.215:9999/ios-pods/gjcoreuserinterface.git", :branch => "master" }

  ########  资源文件和framework要求 ###########

  s.framework    = 'CoreTelephony' ,'Foundation' ,'CoreGraphics','AssetsLibrary' ,'Security','AVFoundation','CoreText','CoreImage'
  
  ####### 依赖库 ##################

  #s.dependency 'GJCommonFoundation', '1.0.0'
  #s.dependency 'ZXingObjC', '3.0.3'

  ####### subModule ################


  ########## 头文件集合 ###########

  s.subspec 'CommonHeaders' do |ss|

  ss.source_files = 'GJCoreUserInterface/GJCoreUserInterface/GJCoreUserInterface.h'

  end

  ########## 多圆角背景按钮 ###########

  s.subspec 'GJCURoundCornerView' do |ss|

  ss.source_files = 'GJCoreUserInterface/GJCoreUserInterface/GJCURoundCornerView/*.*'

  end

  ########## 二维码扫描工具 ###########

#s.subspec 'GJCUBarScanner' do |ss|

#ss.source_files = 'GJCoreUserInterface/GJCoreUserInterface/GJCUBarScanner/Base/*.*'

#end

  ########## 图标右上角小数字工具 ###########

  s.subspec 'GJCUBadgeView' do |ss|

  ss.source_files = 'GJCoreUserInterface/GJCoreUserInterface/GJCUBadgeView/*.*'

  end

  ########## 异步下载图片工具 ###########

  s.subspec 'GJCUAsyncImageView' do |ss|

  ss.source_files = 'GJCoreUserInterface/GJCoreUserInterface/GJCUAsyncImageView/*.*'

  end

  ########## 自定义照相机 ###########

  s.subspec 'GJCUCapture' do |ss|

  ss.source_files = 'GJCoreUserInterface/GJCoreUserInterface/GJCUCapture/*.*'

  ss.resources     = 'GJCoreUserInterface/GJCoreUserInterface/GJCUCapture/GJCUCaptureResourceBundle.bundle'

  end

  ### 图片浏览组件 ########
  s.subspec 'GJCUImageBrowser' do |ss|

    ss.resources     = 'GJCoreUserInterface/GJCoreUserInterface/GJCUImageBrowser/GJCUImageBrowserResourceBundle.bundle'

    ss.subspec 'Uitil' do |sss|

       sss.source_files = 'GJCoreUserInterface/GJCoreUserInterface/GJCUImageBrowser/Uitils/*.*'

    end

    ss.subspec 'View' do |sss|

      sss.source_files = 'GJCoreUserInterface/GJCoreUserInterface/GJCUImageBrowser/View/*.*'

    end

    ss.subspec 'ViewController' do |sss|

      sss.source_files = 'GJCoreUserInterface/GJCoreUserInterface/GJCUImageBrowser/ViewController/*.*'

    end

   end


  ####### ARC 编译要求 ############

  s.requires_arc = true
  s.platform =:ios, "5.0"
  

end
