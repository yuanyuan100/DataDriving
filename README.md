# DataDriving
> 我
> 
> 微信:quanquan_pyy

### 背景

在MVC下，数据间的通信需要写大量的回调，例如block，delegate，导致数据的流动方向不确定性。APP中大量的bug也是因为数据的不确定性造成的，解决相应bug需要耗费精力定位数据出错的地方。使用DataDriving可以节省大量写回调的代码，以及更加容易确定数据的流动，只需要确定是什么事件导致数据发生改变，以及快速的查找与之绑定的viewModel或者UI控件。

### 原理

###### DataDriving分为两个部分

- 网络 

     给Model添加分类，分类中添加网络模块绑定的属性(数据)，当属性(数据)发生改变的时候，则调用实现了相应协议的代理，在协议方法中处理网络请求。待请求成功则返回数据给model，model则解析数据并且赋值给响应属性.在解析数据赋值model属性中，提供了默认解析方案，以及在每个model中可以重写解析方案。

- ViewModel

     数据驱动View。
        ![流程图](https://github.com/yuanyuan100/DataDriving/blob/master/1923469944.jpg)
        将viewmodel(或者View控件)与model的响应属性(数据)绑定，也就是没个model都维护一个字典，字典<KVO承载类:唯一识别>，每绑定一组，则初始化两个KVO承载类，并添加到字典中，KVO承载类观察变化，若发生变化则通过KVO给响应的属性赋值(双向)
             
### 示例

### 导入方案

### 注意事项

### License

MIT