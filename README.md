# CollectionView
&emsp;&emsp;&nbsp;这里我在iOS中使用三种不同的方式实现UICollectionView，也就是一种瀑布流视图。分别使用storyboard、nib和纯代码的方式来实现。
##1.项目说明
&emsp;&emsp;&nbsp;UICollectionView继承自UITableView，基本的实现方式同UITableView。用UICollectionView实现的视图就是所谓的瀑布流界面，很多的电商网站，图片浏览App都是采用了这种设计方式。在我的这个项目中，我分别使用三种不同的方式来实现CollectionView：storyboard、nib文件和纯代码，可以适用在多种不同的项目开发情境下。
##2.动态加载
&emsp;&emsp;&nbsp;我在第四个例子中实现了使用UICollectionView进行动态增加一个Cell或者Section，主要使用了Lazy Load懒加载进行。并在插入一个Section的时候动态编辑Header头部视图。
##3.实现效果
![Alt text](https://github.com/chenyufeng1991/CollectionView/raw/master/Screenshots/1.png)
</br>
&emsp;&emsp;&nbsp;动态增加Cell和Section的效果如下：</br>
![Alt text](https://github.com/chenyufeng1991/CollectionView/raw/master/Screenshots/2.png)
</br>
![Alt text](https://github.com/chenyufeng1991/CollectionView/raw/master/Screenshots/3.png)
</br>
![Alt text](https://github.com/chenyufeng1991/CollectionView/raw/master/Screenshots/4.png)



##4.技术博客
我的个人技术博客：[http://blog.csdn.net/chenyufeng1991](http://blog.csdn.net/chenyufeng1991) 。欢迎大家访问！