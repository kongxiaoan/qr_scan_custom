# qr_scan_custom

自定义二维码扫描的界面、大小以及样式、添加扫描线的样式颜色、适配尺寸等问题

> Flutter作为一个跨平台的UI框架，现在是非常成功的，在我们的开发中，已经有很多的人去实现了很多功能，比如说：动态权限申请、网络请求、图像的处理、音视频、数据存储等等，无疑是将Flutter推向了更受欢迎的时刻，因为你确实会通过很少的代码或者一份代码来运行在不同的设备上，Android、ios.并且这种往对方领域（Android和iOS相反）衍射的技术总会被对方领域好奇，迫使我们去学习

### 在众多的插件中当然也存在基于zXing的二维码扫描插件

- qrcode_reader
- barcode_scan

发现只是实现了其扫描，对于自定义的二维码界面和扫描框的大小等等是不能自定义的，所以今天封装一个既能实现扫描又能自定义二维码界面的二维码扫描插件

### qr_scan_custom 自定义界面和其他控制项(闪光灯、相册扫描等)
![image](https://github.com/kongxiaoan/qr_scan_custom/blob/master/images/QQ20190222.png)
<img src="https://github.com/kongxiaoan/qr_scan_custom/blob/master/images/QQ20190222.png"  height="600" width="350">

---
### 开发步骤
一、 开发环境

- Android studio
- Mac 
- Flutter 
- Dart
- kotlin
- swift

 开发环境搭建可以看一下[从Android到Flutter《一》](https://blog.csdn.net/qq_32648731/article/details/80007499) 
 
 二、插件开发
 
 > 关于Flutter的插件开发其实就是使Flutter比较方便的调用Native原生的API的功能，也是达成更高层次的一处开发多处运行的效果的方式
 
三、 创建插件
 
 - 利用AS File -> New -> new Flutetr project 选择Flutter plugin 一路next 选择kotlin 和swift (更具自己的需求，是否使用kotlin和swift开发) 点击finish 等待创建完成
 
---

> 项目框架介绍

1. android 编写Android 的native的代码 
2. ios 编写 IOS的native的代码
3. lib 编写与native映射的地方（调用的地方）
4. example 例子 

> 其他介绍

- 打开lib文件下的dart文件 ，可以看到
```dart
//MethodChannel就是和Android iOS进行交互的
static const MethodChannel _channel =
      const MethodChannel('qr_scan_custom');
      
//调用Android原生的代码
    final String version = await_channel.invokeMethod('getPlatformVersion');

//getPlatformVersion 再原生中判断是调用的那个原生的方法或者功能
```

- 再看一下Android 下的代码
```kotlin
//Android原生端进行注册
val channel = MethodChannel(registrar.messenger(), "qr_scan_custom")
      channel.setMethodCallHandler(QrScanCustomPlugin())

//响应flutter调用的代码
override fun onMethodCall(call: MethodCall, result: Result) {
//判断是需要那个处理 getPlatformVersion 
    if (call.method == "getPlatformVersion") {
      result.success("Android ${android.os.Build.VERSION.RELEASE}")
    } else {
      result.notImplemented()
    }
  }
```
- 同理原生注册的iOS端代码
```swift

let channel = FlutterMethodChannel(name: "qr_scan_custom", binaryMessenger: registrar.messenger())
    let instance = SwiftQrScanCustomPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
``` 


### 开始编写插件

在开始之前先梳理一下qr_scan_custom 需要做什么

1. 扫码 ---> 我们选择的是zxing
 ```
 "cn.yipianfengye.android:zxing-library:2.2"
 ```
2. 自定义扫码的界面以及相应的功能

- 需要自定义它的样式（包括大小、颜色、扫码线的样式、四角是否需要角标、（需要时角标的宽度、大小）等等）
- 需要封装好二维码所需要的基本功能和其他功能
    
    基本功能
    - 扫码（包括条形码）
    - 闪光灯
    - 
3. 将扫描二维码的载体竟可能的封装（是否需要沉浸式、appbar及状态栏的颜色，标题 ，是否需要返回等按钮等等）
4. 其他，我们需要的时候再添加

### 代码实现

---
> 我们实现的时候是先实现Android端的 然后在实现iOS的

1. 添加二维码依赖 添加至项目
```
../qr_scan_custom/android/build.gradle 项目中目录

    implementation "cn.yipianfengye.android:zxing-library:2.2"
    一般情况下我们将编写的代码用AS打开 可以同步及清理
```
2. 修改根目录下android的文件

> 开发过程就不述了

### 当我们编写完代码之后

编写完代码之后我们需要发布自己的packages 以供自己在自己的项目中使用和别人使用，在发布之前我们需要注意的几个地方

1. pubspec.yaml
```
name: 插件名
description: 描述
version: 版本号
author: 作者
homepage: 主页

```

2. README.md

> 描述自己的插件的用途以及怎么使用等等问题

3. CHANGELOG.md
> 版本更替说明

4. 使用命令检查是否存在纰漏
```
flutter packages pub publish --dry-run
```
信息会在执行命令后显示 一般我们只关心错误代码


#### 常见问题

- 问题：
```
1. * Your pubspec.yaml's "homepage" field must be an "http:" or "https:" URL, but it was "qr_code_custom".

```
> 解决：我们的主页必须使用http/https

- 问题：

```
2. * Your package is 164.8 MB. Hosted packages must be smaller than 100 MB. Your .gitignore has no effect since your project does not appear to be in version control.
```
> 首先在根目录下添加一份过滤 然后我们必须将我们的代码提交到版本控制工具中 因为这样我们的.gitignore才会生效

- 添加一份过滤名单
```
.DS_Store
.dart_tool/

.packages
.pub/
pubspec.lock

build/


.DS_Store
.atom/
.idea/
.vscode/

.packages
.pub/
.dart_tool/
pubspec.lock

Podfile
Podfile.lock
Pods/
.symlinks/
**/Flutter/App.framework/
**/Flutter/Flutter.framework/
**/Flutter/Generated.xcconfig
**/Flutter/flutter_assets/
ServiceDefinitions.json
xcuserdata/
/local.properties

.gradle/
gradlew
gradlew.bat
gradle-wrapper.jar
*.iml

GeneratedPluginRegistrant.h
GeneratedPluginRegistrant.m
GeneratedPluginRegistrant.java
build/
.flutter-plugins

//签名文件等

```
- 问题：

```
3. Author "XXXX" in pubspec.yaml should have an email address

```
> 作者名称应该名称+email

5. 中途可能会遇到警告
```
Suggestions:
* line 9, column 1 of example/test/widget_test.dart: This package doesn't depend on flutter_test.
  import 'package:flutter_test/flutter_test.dart';
  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
* line 10, column 1 of example/test/widget_test.dart: This package doesn't depend on qr_scan_custom_example.
  import 'package:qr_scan_custom_example/main.dart';

```

> 不用处理

6. 接着使用该命令发布packages
```
flutter packages pub publish

```
> 会询问你是否忽略警告 选择是

然后会出现
```
Pub needs your authorization to upload packages on your behalf.
In a web browser, go to https://accounts.google.com/o/oauth2/auth?access_type=offline&approval_prompt=force&response_type=code&client_id=818368855108-8grd2eg9tj9f38os6f1urbcvsq399u8n.apps.googleusercontent.com&redirect_uri=http%3A%2F%2Flocalhost%3A60384&scope=https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fuserinfo.email
Then click "Allow access".

```
> 需要授权 授权成功之后 等待处理

### 国内因为政策不能上传，好 那我们就在github中使用

