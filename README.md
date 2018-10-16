# news-objc
Project MVVM suggestion
面向Interface Layer编程：iOSMVVM架构建议
* 文件改造目标
ViewController与Model解耦，Model对ViewController来说是透明的
ViewModel文件不含有任何UIControl类及其子类
* VM本质上是Interface Layer层
VM是专属于View层的Model，反应的是View层所需要的数据
* 最大程度发挥VM层的作用
利用VM控制将要展示的Cell
数据重组
数据重命名
* 简化文件设计
事件最终反映在VM层上
VM事件响应的单一性
减少副作用 
