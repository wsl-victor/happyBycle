# happyBycle

幸福单车-防摩拜单车App

##此版本是仿照摩拜单车4.4.1版本

通过git clone  下载后，运行pod  install ，然后可以直接进行调试即可。

若没有安装cocopods，可以参考此文进行安装：
[https://guides.cocoapods.org/using/getting-started.html](https://guides.cocoapods.org/using/getting-started.html)

[http://www.jianshu.com/p/b64b4fd08d3c](http://www.jianshu.com/p/b64b4fd08d3c)

###项目分析：

摩拜单车是最早进入北京的共享单车，在APP中能看到很多单车，但走到那里的时候，才发现车并不在那里。有些车不知道藏到了哪里；有些车被放到了小区里面，一墙之隔让骑车人无法获得到车，另外还有，最近的使用过程中，有时候非常的卡，特别是单车的选择有时候无法加载，还有活动的按钮，所以基于此，研究一下摩拜单车。

![./image/2017-06-06 16_36.gif](./image/2017-06-06 17_00.gif)


###用到的第三方库

pod 'MJRefresh', '~> 3.1.12'

pod 'MJExtension', '~> 3.0.13'

pod 'FDFullscreenPopGesture', '~> 1.1'

pod 'Masonry', '~> 1.0.2'

pod 'SDWebImage', '~> 4.0.0'

pod 'AFNetworking', '~> 3.1.0'

pod 'YYCache', '~> 1.0.4'

pod 'Reachability', '~> 3.2'



##目前最新版本是5.0.1，相对于之前的版本改动较大


下一步仿写最新版本的