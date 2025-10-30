return {
    ["Advanced Rain Catcher"] = {
        _id = "Advanced Rain Catcher",
        _displayName = "Advanced Rain Collector",
        _description = "Can collect rainwater used for crafting and powering Rain Engines in production buildings. The type of collected rainwater depends on the season. Has a tank capacity of 100.",
        _iconFilename = "Advanced Rain Catcher_icon.png",
        _category = "Resource Acquisition",
        _categoryDisplay = "Extraction Building",
        _sizeX = 3,
        _sizeY = 2,
        _constructionTime = 20,
        _cityScore = 0,
        _isMovable = false,
        _isInitiallyEssential = false,
        _workerCapacity = 3,
        _constructionCosts = {
            {_id = "[Mat Processed] Pipe", _amount = 5},
            {_id = "[Mat Processed] Parts", _amount = 3},
            {_id = "[Mat Processed] Planks", _amount = 5}
        },
        _tags = {
            "Rainwater",
            "FoxesCooperation"
        },
        _baseTankCapacity = 100,
        _recipes = {
            ["[Water] Drizzle Water"] = {
                [2] = {
                    [4] = {
                        _buildings = {"Advanced Rain Catcher"},
                        _grade = 2,
                        _time = 20.0,
                        _productPair = {_id = "[Water] Drizzle Water", _amount = 4},
                        _isService = false,
                        _ingredients = {},
                    },
                },
            },
            ["[Water] Clearance Water"] = {
                [2] = {
                    [4] = {
                        _buildings = {"Advanced Rain Catcher"},
                        _grade = 2,
                        _time = 20.0,
                        _productPair = {_id = "[Water] Clearance Water", _amount = 4},
                        _isService = false,
                        _ingredients = {},
                    },
                },
            },
            ["[Water] Storm Water"] = {
                [2] = {
                    [4] = {
                        _buildings = {"Advanced Rain Catcher"},
                        _grade = 2,
                        _time = 20.0,
                        _productPair = {_id = "[Water] Storm Water", _amount = 4},
                        _isService = false,
                        _ingredients = {},
                    },
                },
            },
        },
    },
    ["Rain Catcher"] = {
        _id = "Rain Catcher",
        _displayName = "Rain Collector",
        _description = "Can collect rainwater used for crafting and powering Rain Engines in production buildings. The type of collected rainwater depends on the season. Has a tank capacity of 50.",
        _iconFilename = "Rain Catcher_icon.png",
        _category = "Resource Acquisition",
        _categoryDisplay = "Extraction Building",
        _sizeX = 2,
        _sizeY = 2,
        _constructionTime = 20,
        _cityScore = 0,
        _isMovable = false,
        _isInitiallyEssential = true,
        _workerCapacity = 2,
        _constructionCosts = {
            {_id = "[Mat Processed] Planks", _amount = 2},
            {_id = "[Mat Processed] Parts", _amount = 3}
        },
        _tags = {
            "Rainwater"
        },
        _baseTankCapacity = 50,
        _recipes = {
            ["[Water] Drizzle Water"] = {
                [1] = {
                    [2] = {
                        _buildings = {"Rain Catcher"},
                        _grade = 1,
                        _time = 20.0,
                        _productPair = {_id = "[Water] Drizzle Water", _amount = 2},
                        _isService = false,
                        _ingredients = {},
                    },
                },
            },
            ["[Water] Clearance Water"] = {
                [1] = {
                    [2] = {
                        _buildings = {"Rain Catcher"},
                        _grade = 1,
                        _time = 20.0,
                        _productPair = {_id = "[Water] Clearance Water", _amount = 2},
                        _isService = false,
                        _ingredients = {},
                    },
                },
            },
            ["[Water] Storm Water"] = {
                [1] = {
                    [2] = {
                        _buildings = {"Rain Catcher"},
                        _grade = 1,
                        _time = 20.0,
                        _productPair = {_id = "[Water] Storm Water", _amount = 2},
                        _isService = false,
                        _ingredients = {},
                    },
                },
            },
        },
    },
}