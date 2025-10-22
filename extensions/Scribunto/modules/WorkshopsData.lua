---@module WorkshopsData.lua
---
---This module does not define an _actual_ derived class, but it creates an instance of one via prototyping patterns. Understand this file as a big procedure, top-to-bottom, rather than a class definition.
---
---Initializes a BaseDataModel with the data file associated with this module. Makes necessary modifications to the basic data, including schema and method overrides, to permit the exceptions associated with data in this model.



--Create instance
local BaseDataModel = require("Module:BaseDataModel")
local DATA_FILE = "Module:WorkshopsData/Workshops.json"

---@type BaseDataModel
local workshopsDataModel = BaseDataModel.new(DATA_FILE)



--Begin instance overrides
for _, building in pairs(workshopsDataModel.dataTable) do
    building[workshopsDataModel.schema.CATEGORY2] = "Production Building"
    building[workshopsDataModel.schema.IS_PROVIDING_SERVICES] = false
end



--/** Function definitions follow. **/
--Collapse the regions in the IDE to see the procedure pick up with the assignments of these functions to override the associated member methods of BaseDataModel.
--region Public building interface
--no overrides!
--endregion

--region Public building recipe query interface
--no overrides!
--endregion

--region Public recipe data retrieval interface
--no overrides!
--endregion
--/** End Function definitions. Procedure resumes. **/



return workshopsDataModel