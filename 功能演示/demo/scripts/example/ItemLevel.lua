-- 记录物品等级
ItemLevel = {};
-- 物品附加属性
ItemAttr = {};

ItemCall = {
    -- 强化按钮
    levelBtn = function(unitObj) 
        local apiId = hdzui.frameTag("TEXT","qh");
        hdzui.framePoint(apiId);
        hjapi.DzFrameSetText(apiId,"强化")
        hjapi.DzFrameSetSize(apiId,0.06,0.06);

        hdzui.onMouse(apiId,MOUSE_ORDER_CLICK,function()
            print_mb("点击强化",unitObj)
            -- 模拟的单位 多玩家需要处理
            local item = cj.UnitItemInSlot(unitObj,0);
            print(item)

            if(item) then 
                ItemCall.levelUp(item,unitObj);
            else
                print_mb("物品栏第一个为空")
            end
        end)
    end,

    levelUp = function(itemObj,unitObj)
        local itemLevelAttr = ItemAttr[itemId]
        -- 读取当前等级
        local itemId = hitem.getId(itemObj);
        local currentLevel = ItemLevel[itemObj]["level"] or 1;
        -- 获取下一级附加的属性 
        local nextLevel = currentLevel + 1;
        print_mb("当前等级",currentLevel,"下个等级",nextLevel)
        local itemLevelAttr = ItemAttr[itemId]["levelAttr"];
        if(itemLevelAttr and nextLevel <= #itemLevelAttr)then
            local nextAttr = itemLevelAttr[nextLevel]
            -- 需要附加的属性
            print_mb("需要附加的属性");
            print_mbr(nextAttr);

            -- 减去当前等级级附加的属性 
            if(ItemLevel[itemObj]["levelAttr"])then
                ItemCall.attrChange(ItemLevel[itemObj]["levelAttr"],unitObj,false);
            end
            -- 添加下一级附加属性到单位
            ItemCall.attrChange(nextAttr,unitObj,true);

            -- 附加属性文本
            ItemCall.attrTip(nextAttr,itemObj)
            -- 记录强化等级
            ItemLevel[itemObj]["level"] = nextLevel;
            -- 记录强化后附加的属性
            ItemLevel[itemObj]["levelAttr"] = nextAttr;

            -- 首次强化附加丢弃回调 减去强化附加的属性
            if(currentLevel == 1)then 
                hevent.onItemDrop(unitObj,ItemCall.itemDrop);
                hevent.onItemGet(unitObj,ItemCall.itemGet);
            end
        else
            print_mb("强化达到最高等级");
        end
    end,
    -- 丢弃装备时减少属性
    itemDrop = function(evtData)
        local unit = evtData.triggerUnit;
        local item = evtData.triggerItem;
        -- 读取附加的属性并从单位扣除 
        -- ItemLevel[itemObj]["levelAttr"] 
        ItemCall.attrChange(ItemLevel[item]["levelAttr"],unit,false)
    end,
    itemGet = function(evtData)
        local unit = evtData.triggerUnit;
        local item = evtData.triggerItem;
        -- 读取附加的属性并从单位添加 
        -- ItemLevel[itemObj]["levelAttr"] 
        ItemCall.attrChange(ItemLevel[item]["levelAttr"],unit,true)
    end,
    -- 附加属性的实现
    -- flag = true 添加属性,flag = false 减去属性
    attrChange = function(attrsTable,unitObj,flag)
        hattribute.caleAttribute(CONST_DAMAGE_SRC.item, flag, unitObj, attrsTable, 1)
    end,
    -- 附加属性文本生成
    attrTip = function(attrsTable,itemObj)

    end,
    -- 套装实现
    setUp = function(itemObj)
    end,
}