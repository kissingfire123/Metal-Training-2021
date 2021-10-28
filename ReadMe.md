# 介绍
该项目用于在iOS设备练习Metal渲染编程，通过CMake对工程进行组织，避免了不同Xcode版本编译的一些问题

# 软件/工具配置
- 安装了Xcode的Mac
- 安装CMake3.12以上版本
- 准备一台iPhone(或Mac-M1也行，可运行iOS-App)，Metal不支持模拟器，只能真机

# 如何使用
- 在 ~/.bash_profile 或 ~/.bash_rc, ~/.zshrc等任一文件定义2个环境变量：`DEVELOPMENT_TEAM_ID` 和 `PRODUCT_BUNDLE_IDENTIFIER`
  
  或者，也可以在cmake成功后，Xcode内进行设置team-id和bundle-identifier。
- 执行 **`./generateProj.sh`** ，在`build`文件夹生成工程文件，例如`"build/MetalTrain-0x.xcodeproj"`.
- 打开工程文件编译运行即可。


