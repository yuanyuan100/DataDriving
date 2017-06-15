# DataDriving
数据驱动开发尝试

``` 绑定View控件， 将view控件弱引用传递至model中，当与至绑定的数据（监听）发生改变是则赋值给UI控件。
同时监听控件响应的属性，发生变化时则赋值给与之绑定的model数据。
其中可以用viewmode的方式隔离真实的控件（不确定性）和数据
[ReactiveViewModel](https://github.com/ReactiveCocoa/ReactiveViewModel)
 
