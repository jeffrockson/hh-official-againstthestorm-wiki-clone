---@module BuildingDataProxy
local BuildingDataProxy = {}



--region Dependencies

-- Just store the strings, and we'll load lazily at runtime as needed. The order of this array controls the load order of data models.
local DATA_MODELS_NAMES_ARRAY = {
    "Module:WorkshopsData",
    "Module:InstitutionsData",
    "Module:FarmsData",
    "Module:GatheringData",
    "Module:FishingData",
    "Module:RainCollectorsData",
    "Module:CampsData",
    "Module:HearthsData",
    "Module:WarehousesData",
    "Module:FarmFieldsData",
    "Module:ExtractorsData",
    "Module:MinesData",
    "Module:BlightPostsData"
}

local DataModelsCache = {}
for _, moduleName in pairs(DATA_MODELS_NAMES_ARRAY) do
    DataModelsCache[moduleName] = nil
end

--endregion



--region Private methods

local function cacheModel(modelName)

    if DataModelsCache[modelName] == nil then
        DataModelsCache[modelName] = require(modelName)
    end

    return DataModelsCache[modelName]
end

---fetchFromFunction
---Loops through the data models, calling the provided function on each in turn using the specified parameter (name or ID) until one of them returns a result. Returns nil if no data models found the specified name or ID.
---
---@param functionName string the name of the function to call
---@param parameter1 ?
---@param parameter2 ?
---@param parameter3 ?
---@return ? whatever the function returns
local function federateFunction(functionName, parameter1, parameter2, parameter3)

    for _, modelName in ipairs(DATA_MODELS_NAMES_ARRAY) do
        local DataModel = cacheModel(modelName)
        local result = DataModel[functionName](DataModel, parameter1, parameter2, parameter3)
        -- If we found it, return, otherwise keep going
        if result then
            return result
        end
    end
    -- nil if not found
    return nil
end

--endregion



--region Public building interface

function BuildingDataProxy.getID(displayName)
    return federateFunction("getID", displayName)
end

function BuildingDataProxy.getCategory(id)
    return federateFunction("getCategory", id)
end

function BuildingDataProxy.getSecondCategory(id)
    return federateFunction("getSecondCategory", id)
end

function BuildingDataProxy.getCityScore(id)
    return federateFunction("getCityScore", id)
end

function BuildingDataProxy.getConstructionCosts(id)
    return federateFunction("getConstructionCosts", id)
end

function BuildingDataProxy.getConstructionTime(id)
    return federateFunction("getConstructionTime", id)
end

function BuildingDataProxy.getDescription(id)
    return federateFunction("getDescription", id)
end

function BuildingDataProxy.getIcon(id)
    return federateFunction("getIcon", id)
end

function BuildingDataProxy.isMovable(id)
    return federateFunction("isMovable", id)
end

function BuildingDataProxy.getName(id)
    return federateFunction("getName", id)
end

function BuildingDataProxy.getNumberOfWorkplaces(id)
    return federateFunction("getNumberOfWorkplaces", id)
end

function BuildingDataProxy.getSize(id)
    return federateFunction("getSize", id)
end

function BuildingDataProxy.getStorage(id)
    return federateFunction("getStorage", id)
end

function BuildingDataProxy.isServiceBuilding(id)
    return federateFunction("isServiceBuilding", id)
end

--endregion

return BuildingDataProxy
