

_REQUIRE("pbHelper")
_REQUIRE("pb.pbCommon")
local ctlBase = _REQUIRE("controller.request.ctlBase")
local model_user = _REQUIRE("model/model_user.lua");
local model_monsterStorage = _REQUIRE("model/model_monsterStorage.lua");

local ctlMonstersQualityUpRequest = class("ctlMonstersQualityUpRequest", ctlBase)

function ctlMonstersQualityUpRequest:name()
    return "ctlMonstersQualityUpRequest";
end

function ctlMonstersQualityUpRequest:onSendRequest(_monsterId)

    local pbInData = {
        api = pbCommon.struct_apiRequest(),
        monsterId = _monsterId,

    }

    local requestType = "MonstersQualityUpRequest";
    local httpData = pbHelper.getEncodePB(requestType, pbInData)

    _REQUIRE("SanGuoLib").sendHttp(
        httpData,
        string.len(httpData),
        self:urlBase() .. "monsters.pb?_a=qualityUp&" .. self:snid(),
        self.name());


end

function ctlMonstersQualityUpRequest:onDecodePb(pb)
    local requestType = "MonstersQualityUpResponse";
    local httpData = pbHelper.getDecodePB(requestType, pb);
--    pbHelper.printPB(httpData);
    return httpData;
end


function ctlMonstersQualityUpRequest:onSuccess(data)
    model_monsterStorage:updateMonster(data.monster);
    
    model_user.selectMonsterUpgradeResult = data;
end


return ctlMonstersQualityUpRequest;




