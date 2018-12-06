
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, ’8.0’

inhibit_all_warnings!
use_frameworks!

target “Axc Secretary” do

# 基础框架
   pod 'Masonry'
   pod 'MJRefresh'
   pod 'AFNetworking', '~> 3.1.0'
   pod 'SDWebImage', '~> 4.4.2'

   pod 'MBProgressHUD'
   pod 'SVProgressHUD'
   pod 'IQKeyboardManager'
   pod 'JWNetAutoCache'
   pod 'WHC_Model'
   pod 'FMDB'
# 可视化组件
   pod 'SDCycleScrollView'
   pod 'KSPhotoBrowser'
   pod 'ZLPhotoBrowser'
   pod 'PPNumberButton'
   pod 'FBDigitalFont'
   pod 'iCarousel'
   pod 'WMDragView'             # 拖动按钮
   pod 'JLRoutes'               # 路由跳转模式
   pod 'IQDropDownTextField'    # 弹出滚轮的文本输入框
   pod 'JCAlertController'      # alentView
   pod 'MGSwipeTableCell'       # cell左右滑动
   pod 'DZNSegmentedControl'    # 选择器
   pod 'WMPageController'       # 页面滑动选项卡
   
   # swift - 3
   pod 'NumberMorphView'        # 数字label                 swift-3
   # swift - 4
   pod 'TextFieldEffects'       # TextField 动画文本输入      swift-4.2
   pod 'RSKGrowingTextView'     # TextView 文本自适应        swift-4.2
   
   
   #   pod 'QMUIKit/QMUIComponents/QMUIMarqueeLabel'
   #   pod 'zhPopupController'
   #   pod 'PGPickerView'
   #   pod 'PSCityPickerView'
   #   pod 'SakuraKit'  # 主题管理
   #   pod 'WHC_ModelSqliteKit'   # 对象存储


# Axc套件
   pod 'AxcAE_TabBar'
   pod 'AxcDrawPath_Tool'

#开发辅助
   pod 'LLDebugTool'



end


# 设置Swift版本
post_install do |installer|
    installer.pods_project.targets.each do |target|
        if target.name == 'NumberMorphView'
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '3'
            end
        else
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '4.2'
            end
        end
        
    end
end

