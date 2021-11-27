## UI简单封装
- [代码实现](../scripts/example/DiyUI.lua)

## api
```lua
-- 代码创建UI
_U.tag(fdfType, fdfName, parent, tag, id)
-- 基于FDF创建UI
_U.mount(fdfName,parent,id)
-- 重置id到特定Frame
_U.frame(id)

-- 设置大小
_U.size(x,y)
-- 设置文本
_U.text(text)
-- 绝对定位
_U.point(x,y,alignPoint)
-- 相对定位
_U.relative(
    target,
    alignPoint,
    tagertPoint,
    xOffset,yOffset
)

-- 隐藏与显示Frame
_U.show(player)
_U.hide(player)

-- 注册事件回调
_U.on(event,callback)
```

## demo
```lua
_U.tag("TEXT",'txt1')
    .text("测试文本")
    .size(0.1,0.1)
    .point(0.2,0.3);

local txt1Id = _U.id;

_U.tag("TEXT","txt2")
    .text("文本2")
    .size(0.1,0.1)
    .relative(txt1Id,
    FRAME_ALIGN_RIGHT,
    FRAME_ALIGN_LEFT,
    -0.1,-0.1
);
```
```lua
_U.tag("BACKDROP","bg_bar")
    .size(0.2,0.2)
    .point(0.5,0.3)

local bg1Id = _U.id;
_U.tag("BACKDROP","bg_bar")
    .size(0.1,0.1)
    .relative(
        bg1Id,
        FRAME_ALIGN_RIGHT_TOP,
        FRAME_ALIGN_LEFT,
        -0.1,-0.1
    )
```

```lua
hdzui.loadToc("UI\\frame.toc");

_U.mount("txt_12l")
    .text("mount")
    .size(0.06,0.06)
    .point(0,0.3,FRAME_ALIGN_LEFT);

```

```lua
hdzui.loadToc("UI\\frame.toc");

_U.tag("BUTTON","test_btn")
     .size(0.06,0.06)
    .point(0.4,0.3)
    .on(MOUSE_ORDER_ENTER,function ()
        echo("ddd");
        _U.frame(txt1Id).text("ddd");
    end)
    .show();


_U.mount("btn_more_e_attack")
    .size(0.06,0.06)
    .point(0.4,0.3)
    .on(MOUSE_ORDER_ENTER,function ()
        print("ddd");
        _U.frame(txt1Id).text("进入");
    end)
    .on(MOUSE_ORDER_LEAVE,function ()
        print("ccc");
        _U.frame(txt1Id).text("离开");
    end)
    .show();
```