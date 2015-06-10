Pod::Spec.new do |s|
  s.name         = "GJCommonFoundation"
  s.version      = "1.0.0"
  s.summary      = "赶集网通用功能组件库"
  s.homepage     = "http://www.ganji.com"
  s.license      = 'MIT'
  s.author       = { "李祎" => "liyi1@ganji.com"}
  s.source       = { :git => "ssh://git@192.168.2.215:9999/ios-pods/gjcommonfunction.git", :branch => "1.1.0" }

  ########  资源文件和framework要求 ###########

  s.framework    = 'CoreTelephony' ,'Foundation' ,'CoreGraphics','AssetsLibrary' ,'Security','AVFoundation','CoreText','CoreImage'
  
  ####### 依赖库 ##################

  s.dependency 'Reachability', '~> 3.1.1'

  s.dependency 'AFNetworking', '~> 1.3.0'
  
  s.dependency 'GJAudioVideoCoder', '2.0.0'

  ####### subModule ################

  ########## 地理位置管理 ###########

  s.subspec 'GJCFLocationManager' do |ss|

    ss.source_files = 'GJCommonFoundation/GJCommonFoundation/GJCFLocationManager/*.*'
    ss.dependency 'GJBaiduMap', '2.5.0'
  end


  ########## TVGDebug ###########
  s.subspec 'GJCFDebug' do |ss|

    ss.source_files = 'GJCommonFoundation/GJCommonFoundation/Debug/*.*'

  end

  ########## 通用头文件集合 ###########
  s.subspec 'GJCFCommonHeaders' do |ss|

  ss.source_files = 'GJCommonFoundation/GJCommonFoundation/GJCommonFoundation.h'

  end

  ########## 文件持久化工具###########

    s.subspec 'GJCFCacheManager' do |ss|

      ss.source_files = 'GJCommonFoundation/GJCommonFoundation/GJCFCacheManager/*.*'

    end

  ########## 通用辅助工具 ##########
  s.subspec 'GJCFUitils' do |ss|

    ss.source_files = 'GJCommonFoundation/GJCommonFoundation/GJCFUitils/GJCFUitils.h'

    ss.subspec 'DateUitil' do |sss|

        sss.source_files = 'GJCommonFoundation/GJCommonFoundation/GJCFUitils/DateUitil/*.*'

    end

    ss.subspec 'QuickUIUitil' do |sss|

        sss.source_files = 'GJCommonFoundation/GJCommonFoundation/GJCFUitils/QuickUIUitil/*.*'

    end

    ss.subspec 'StringUitil' do |sss|

       sss.source_files = 'GJCommonFoundation/GJCommonFoundation/GJCFUitils/StringUitil/*.*'

    end

    ss.subspec 'DispatchCenterUitil' do |sss|

       sss.source_files = 'GJCommonFoundation/GJCommonFoundation/GJCFUitils/DispatchCenterUitil/*.*'

    end

    ss.subspec 'QuickCacheUitil' do |sss|

       sss.source_files = 'GJCommonFoundation/GJCommonFoundation/GJCFUitils/QuickCacheUitil/*.*'

    end

    ss.subspec 'SystemUitil' do |sss|

       sss.source_files = 'GJCommonFoundation/GJCommonFoundation/GJCFUitils/SystemUitil/*.*'

    end

  end

  ########## 多态字符串绘制组件 ##########
  s.subspec 'GJCFCoreText' do |ss|
  
    ss.subspec 'ParagraphStyle' do |sss|

       sss.source_files = 'GJCommonFoundation/GJCommonFoundation/GJCFCoreText/ParagraphStyle/*.*'

    end
    
    ss.subspec 'StringStyle' do |sss|

       sss.source_files = 'GJCommonFoundation/GJCommonFoundation/GJCFCoreText/StringStyle/*.*'

    end
    
    ss.subspec 'Base' do |sss|

       sss.source_files = 'GJCommonFoundation/GJCommonFoundation/GJCFCoreText/Base/*.*'

    end
  
  end

  ####### 赶集服务器环境设置 ##########
  s.subspec 'GJCFServerBase' do |ss|
  
    ss.subspec 'BusinessBase' do |sss|

       sss.source_files = 'GJCommonFoundation/GJCommonFoundation/Base/BusinessBase/*.*'

    end
    
    ss.subspec 'ConstantManager' do |sss|

       sss.source_files = 'GJCommonFoundation/GJCommonFoundation/Base/ConstantManager/*.*'

    end
    
    ss.subspec 'HttpHelper' do |sss|

       sss.source_files = 'GJCommonFoundation/GJCommonFoundation/Base/HttpHelper/*.*'

    end


  end
  
  s.subspec 'GJCFAudioManager' do |ss|

    ss.subspec 'Manager' do |sss|

       sss.source_files = 'GJCommonFoundation/GJCommonFoundation/GJCFAudioManager/Manager/*.*'

    end
    
    ss.subspec 'ThirdPartLibrary' do |sss|

       sss.source_files = 'GJCommonFoundation/GJCommonFoundation/GJCFAudioManager/ThirdPartLibrary/*.*'

    end
    
    ss.subspec 'Model' do |sss|

       sss.source_files = 'GJCommonFoundation/GJCommonFoundation/GJCFAudioManager/Model/*.*'

    end
    
    ss.subspec 'Encode&Decode' do |sss|

       sss.source_files = 'GJCommonFoundation/GJCommonFoundation/GJCFAudioManager/Encode&Decode/*.*'

    end
    
    ss.subspec 'FileUitil' do |sss|

       sss.source_files = 'GJCommonFoundation/GJCommonFoundation/GJCFAudioManager/FileUitil/*.*'

    end
    
    ss.subspec 'Network' do |sss|

       sss.source_files = 'GJCommonFoundation/GJCommonFoundation/GJCFAudioManager/Network/*.*'

    end
    
    ss.subspec 'Play' do |sss|

       sss.source_files = 'GJCommonFoundation/GJCommonFoundation/GJCFAudioManager/Play/*.*'

    end
    
    ss.subspec 'Record' do |sss|

       sss.source_files = 'GJCommonFoundation/GJCommonFoundation/GJCFAudioManager/Record/*.*'

    end

  end

  ### 图片选择组件 ########
  s.subspec 'GJCFAssetsPicker' do |ss|

    ss.resources     = 'GJCommonFoundation/GJCommonFoundation/GJCFAssetsPicker/GJCFAssetsPickerResourceBundle.bundle'
    
    ss.subspec 'Uitil' do |sss|

      sss.source_files = 'GJCommonFoundation/GJCommonFoundation/GJCFAssetsPicker/Uitil/*.*'

    end
    
    ss.subspec 'View' do |sss|

      sss.source_files = 'GJCommonFoundation/GJCommonFoundation/GJCFAssetsPicker/View/*.*'

    end
    
    ss.subspec 'ViewController' do |sss|

      sss.source_files = 'GJCommonFoundation/GJCommonFoundation/GJCFAssetsPicker/ViewController/*.*'

    end

  end

  ### 文件上传组件 ########
  s.subspec 'GJCFFileUploadManager' do |ss|
  
    ss.subspec 'FileUploadManager' do |sss|

      sss.source_files = 'GJCommonFoundation/GJCommonFoundation/GJCFFileUploadManager/FileUploadManager/*.*'

    end
    
    ### 文件下载组件 ######
    ss.subspec 'DownloadManager' do |sss|

      sss.source_files = 'GJCommonFoundation/GJCommonFoundation/GJCFFileUploadManager/DownloadManager/*.*'

    end
  
  end

  ####### ARC 编译要求 ############

  s.requires_arc = true
  s.platform =:ios, "5.0"
  

end
