# MOGU设计思路

## 网络请求
首先请求应该单创建一个GCD的`queue`来处理。不仅便于管理和debug，还可以利用多线程来提高性能。

## 数据源
当前使用的方式是比较直接一点的，没有做更多的封装，就是一个请求对应一个item。
如果要封装一下的话，可以用这样的结构 `cell` <- `item` 每个item都有一个`workItem: DispatchWorkItem`的属性。
这样每次读到这个cell的时候就可以调用对应的`item.workItem`来发送请求。


请求结束后更新对应的cell。但是怎么更新cell比较好一点？我的见解是请求完成后，首先更新数据。
然后看对应的cell是不是可见的(tableView.visibleCells)，如果可见的话，就直接更新cell里的内容，而不必reloadcell。
如果cell不可见，那么当它可见时，tableview自然会reload这个cell。
Reference:
>
Reloading a row causes the table view to ask its data source for a new cell for that row. The table animates that new cell in as it animates the old row out. Call this method if you want to alert the user that the value of a cell is changing. If, however, notifying the user is not important—that is, you just want to change the value that a cell is displaying—you can get the cell for a particular row and set its new value.

## 迭代开发
如果有新增的模块，那么只要在在数据源里新增一个item，并成生对应请求的workItem即可。
