
-- 写个简单的封装UI
_U = {
    id = 0
};

-- 需要在fdf定义好frame,然后挂载
-- 类似Vue的将模板挂载到页面
-- fdf文件类似div语法 设置frame样式
-- parent和页面已有dom节点一样
function _U.mount(fdfName,parent,id)
    _U.id = hdzui.frame(fdfName,parent,id)
    return _U
end
-- 与上面的frame()不同 纯代码生成ui
function _U.tag(fdfType, fdfName, parent, tag, id)
    _U.id =  hdzui.frameTag(fdfType, fdfName, parent, tag, id);
    return _U;
end

function _U.frame(id)
    _U.id = id;
    return _U;
end

function _U.size(x,y)
    if(_U.id)then
        hjapi.DzFrameSetSize(_U.id,x,y)
    end
    return _U;
end

function _U.text(text)
    if(_U.id)then
        hjapi.DzFrameSetText(_U.id,text)
    end
    return _U;
end


function _U.point(x,y,alignPoint)
    if(_U.id > 0)then 
        hjapi.DzFrameSetAbsolutePoint(
            _U.id,
            alignPoint,
            x,y
        )
    end
    return _U;
end

-- 将新的frame按照特定位置放置，
function _U.relative(
    target,
    alignPoint,
    tagertPoint,
    xOffset,yOffset
)
    if(_U.id > 0)then 
        hdzui.framePoint(
            _U.id,
            target,
            alignPoint,
            tagertPoint,
            xOffset,yOffset
        );
    end
    return _U;
end

function _U.show(player)
    if(_U.id > 0)then 
        hjapi.DzFrameShow(_U.id,true,player)
    end
    return _U;
end

function _U.hide(player)
    if(_U.id > 0)then 
        hjapi.DzFrameShow(_U.id,false,player)
    end
    return _U;
end

function _U.on(event,callback)
    if(_U.id > 0)then 
        hdzui.onMouse(_U.id,event,callback)
    end
    return _U;
end

 
function TestUi()
    hdzui.hideInterface();
    
    _U.tag("TEXT",'txt1')
    .text("测试文本")
    .size(0.1,0.1)
    .point(0.2,0.3)
    .on(1,function()
        print_mb("点击");
    end);

    local txt1Id = _U.id;

    _U.tag("TEXT","txt2")
        .text("文本2")
        .size(0.1,0.1)
        .relative(txt1Id,
        FRAME_ALIGN_RIGHT,
        FRAME_ALIGN_LEFT,
        0.02,0.1
    );

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

-- 加载已定义的fdf
-- 脚本默认位置就是.j文件
-- 加载路径就是.j的UI\frame.toc
-- hdzui.loadToc("UI\\frame.toc");

-- point指定的第三个参数表示将特定点放置到x,y 默认中间
-- _U.mount("txt_12l")
--     .text("mount")
--     .size(0.06,0.06)
--     .point(0,0.3,FRAME_ALIGN_LEFT);

-- _U.frame(topId).hide();

-- _U.tag("BUTTON","test_btn")
--      .size(0.06,0.06)
--     .point(0.4,0.3)
--     .on(MOUSE_ORDER_ENTER,function ()
--         echo("ddd");
--         _U.frame(txt1Id).text("ddd");
--     end)
--     .show();


-- _U.mount("btn_more_e_attack")
--     .size(0.06,0.06)
--     .point(0.4,0.3)
--     .on(MOUSE_ORDER_ENTER,function ()
--         print("ddd");
--         _U.frame(txt1Id).text("进入");
--     end)
--     .on(MOUSE_ORDER_LEAVE,function ()
--         print("ccc");
--         _U.frame(txt1Id).text("离开");
--     end)
--     .show();
end