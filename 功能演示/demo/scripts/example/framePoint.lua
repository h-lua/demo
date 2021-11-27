-- Coord()     坐标轴演示
-- FramePont() 相对定位演示

local hLine = function (h)
    -- 水平线 
    local lineId = hdzui.frameTag("BACKDROP","h_line_"..h);
    hjapi.DzFrameSetAbsolutePoint(lineId,FRAME_ALIGN_LEFT,0,h)
    hjapi.DzFrameSetSize(lineId,0.8,0.001);
    hjapi.DzFrameShow(lineId,true);

    -- 坐标说明
    local labelId = hdzui.frameTag("TEXT","h_label"..h);
    hjapi.DzFrameSetAbsolutePoint(labelId,FRAME_ALIGN_LEFT,0,h)
    hjapi.DzFrameSetText(labelId,h.."");
    hjapi.DzFrameSetSize(labelId,0.3,0.01);
    hjapi.DzFrameShow(labelId,true);
end

local vLine = function(w)
     -- 水平线 
     local lineId = hdzui.frameTag("BACKDROP","h_line_"..w);
     hjapi.DzFrameSetAbsolutePoint(lineId,FRAME_ALIGN_LEFT_TOP,w,0.6)
     hjapi.DzFrameSetSize(lineId,0.001,0.6);
     hjapi.DzFrameShow(lineId,true);
     
     -- 坐标说明
     local labelId = hdzui.frameTag("TEXT","h_label"..w);
     hjapi.DzFrameSetAbsolutePoint(labelId,FRAME_ALIGN_LEFT_TOP,w,0.6)
     hjapi.DzFrameSetText(labelId,w.."");
     hjapi.DzFrameSetSize(labelId,0.3,0.01);
     hjapi.DzFrameShow(labelId,true);
end

Coord = function(xNum,yNUm)
    hdzui.hideInterface();
    local width = 0.8;
    local height = 0.6;

    local xStep = 0;
    local xLineNum = xNum or 10
    local xInterval = height / xLineNum;
    for i = 1, xLineNum do
        hLine(xStep);
        xStep = xStep + xInterval;
    end

    local yStep = 0;
    local yLineNum = yNUm or 10 
    local yInterval = width / yLineNum;
    for i = 1, yLineNum do
        vLine(yStep);
        yStep = yStep + yInterval;
    end
end


FramePont = function()
    hdzui.hideInterface();

    local bgId = hdzui.frameTag("BACKDROP","bg");
    hdzui.framePoint(bgId);
    hjapi.DzFrameSetSize(bgId,0.4,0.3);
    hjapi.DzFrameSetTexture(bgId,"ReplaceableTextures\\b.blp",1)
    hjapi.DzFrameShow(bgId,true);

    -- 对齐方式
    -- FRAME_ALIGN_LEFT_TOP = 0
    -- FRAME_ALIGN_TOP = 1
    -- FRAME_ALIGN_RIGHT_TOP = 2
    -- FRAME_ALIGN_LEFT = 3
    -- FRAME_ALIGN_CENTER = 4
    -- FRAME_ALIGN_RIGHT = 5
    -- FRAME_ALIGN_LEFT_BOTTOM = 6
    -- FRAME_ALIGN_BOTTOM = 7
    -- FRAME_ALIGN_RIGHT_BOTTOM = 8

    local frameType = {
        "lt",
        "t",
        "rt",
        "l",
        "c",
        "r",
        "lb",
        "b",
        "rb"
    }
    
    for j = 1, #frameType do
        local tj = j - 1;
        for i = 1, #frameType do
            -- body
            local ti = i - 1;
            local id1 = hdzui.frameTag("TEXT","id1"..ti..tj);
            hdzui.framePoint(id1,bgId,ti,tj);
            hjapi.DzFrameSetText(id1,"[".."f-"..frameType[i]..",".."p-"..frameType[j].."]")
            hjapi.DzFrameSetTextAlignment(id1,TEXT_ALIGN_CENTER)
            hjapi.DzFrameSetSize(id1,0.1,0.06);
        end

         -- 坐标点
         local cId = hdzui.frameTag("BACKDROP","circle"..j);
         hdzui.framePoint(cId,bgId,FRAME_ALIGN_CENTER,tj);
         hjapi.DzFrameSetSize(cId,0.005,0.005);
    end

    local apiInfo = {
        "锚点类型",
        "",
        "FRAME_ALIGN_LEFT_TOP",
        "FRAME_ALIGN_TOP",
        "FRAME_ALIGN_RIGHT_TOP",
        "FRAME_ALIGN_LEFT",
        "FRAME_ALIGN_CENTER",
        "FRAME_ALIGN_RIGHT",
        "FRAME_ALIGN_LEFT_BOTTOM",
        "FRAME_ALIGN_BOTTOM",
        "FRAME_ALIGN_RIGHT_BOTTOM"
    }
    local info = {
        "简写的内容",
        "",
        "f   framePoint",
        "p   relativePoint",
        "",
        "lt  LEFT-TOP",
        "t   TOP",
        "rt  RIGHT-TOP",
        "l   LEFT",
        "c   CENTER",
        "r   RIGHT",
        "lb  LEFT-BOTTOM",
        "b   BOTTOM",
        "rb  RIGHT_BOTTOM"
    };
    local dzInfo = {
        "Frame设置锚点相对位置api",
        "",
        "DzFrameSetPoint(frameId,framePoint,relativeFrameId,relativePoint)",
        "",
        "",
    };
    local apiText = string.implode("|n",apiInfo);
    local infoText = string.implode("|n",info);
    local dzInfoText = string.implode("|n",dzInfo);

    local apiId = hdzui.frameTag("TEXT","apiId");
    hjapi.DzFrameSetAbsolutePoint(apiId,FRAME_ALIGN_LEFT_TOP,0.008,0.52)
    hjapi.DzFrameSetText(apiId,apiText)
    hjapi.DzFrameSetTextAlignment(apiId,TEXT_ALIGN_LEFT)
    hjapi.DzFrameSetSize(apiId,0.12,0.3);

    local infoId = hdzui.frameTag("TEXT","infoId");
    hjapi.DzFrameSetAbsolutePoint(infoId,FRAME_ALIGN_RIGHT_TOP,0.8,0.52)
    hjapi.DzFrameSetText(infoId,infoText)
    hjapi.DzFrameSetTextAlignment(infoId,TEXT_ALIGN_LEFT)
    hjapi.DzFrameSetSize(infoId,0.1,0.3);

    local dzId = hdzui.frameTag("TEXT","dzId");
    hjapi.DzFrameSetAbsolutePoint(dzId,FRAME_ALIGN_BOTTOM,0.4,0.45)
    hjapi.DzFrameSetText(dzId,dzInfoText)
    hjapi.DzFrameSetTextAlignment(dzId,TEXT_ALIGN_LEFT)
    hjapi.DzFrameSetSize(dzId,0.31,0.12);
end

