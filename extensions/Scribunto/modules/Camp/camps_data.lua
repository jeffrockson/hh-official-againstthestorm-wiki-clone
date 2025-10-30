return {
    ["Woodcutters Camp"] = {
        _id = "Woodcutters Camp",
        _displayName = "Woodcutters' Camp",
        _description = "Starting point for woodcutters going out into the wild to cut down trees.",
        _iconFilename = "Woodcutters Camp_icon.png",
        _category = "Resource Acquisition",
        _categoryDisplay = "Gathering Camp",
        _sizeX = 2,
        _sizeY = 2,
        _constructionTime = 15,
        _cityScore = 1,
        _isMovable = true,
        _isInitiallyEssential = false,
        _workerCapacity = 3,
        _constructionCosts = {
            {_id = "[Mat Processed] Parts", _amount = 2}
        },
        _tags = {
            "Wood",
            "FoxesCooperation"
        },
        _area = 8.0,
        _storage = 8,
        _recipes = {
            ["[Mat Raw] Wood"] = {
                [0] = {
                    [1] = {
                        _buildings = {"Woodcutters Camp"},
                        _grade = 0,
                        _time = 9.0,
                        _productPair = {_id = "[Mat Raw] Wood", _amount = 1},
                        _isService = false,
                        _ingredients = {},
                    },
                },
            },
        },
    },
}