return {
    ["Grove"] = {
        _id = "Grove",
        _displayName = "Forester's Hut",
        _description = "Uses nearby farm fields to grow  <sprite name=[mat raw] resin> Resin (<sprite name=grade2>), <sprite name=[metal] crystalized dew> Crystalized Dew (<sprite name=grade2>).",
        _iconFilename = "Grove_icon.png",
        _category = "Industry",
        _categoryDisplay = "Farm",
        _sizeX = 2,
        _sizeY = 2,
        _constructionTime = 20,
        _cityScore = 2,
        _isMovable = true,
        _isInitiallyEssential = false,
        _workerCapacity = 4,
        _constructionCosts = {
            {_id = "[Mat Processed] Planks", _amount = 2}
        },
        _tags = {
            "Wood",
            "FoxesCooperation"
        },
        _storage = 12,
        _area = 3,
        _recipes = {
            ["[Mat Raw] Resin"] = {
                [2] = {
                    [6] = {
                        _buildings = {"Grove"},
                        _grade = 2,
                        _time = 60.0,
                        _productPair = {_id = "[Mat Raw] Resin", _amount = 6},
                        _isService = false,
                        _ingredients = {},
                    },
                },
            },
            ["[Metal] Crystalized Dew"] = {
                [2] = {
                    [3] = {
                        _buildings = {"Grove"},
                        _grade = 2,
                        _time = 120.0,
                        _productPair = {_id = "[Metal] Crystalized Dew", _amount = 3},
                        _isService = false,
                        _ingredients = {},
                    },
                },
            },
        },
    },
    ["Hallowed Herb Garden"] = {
        _id = "Hallowed Herb Garden",
        _displayName = "Hallowed Herb Garden",
        _description = "Uses nearby farm fields to grow  <sprite name=[food raw] roots> Roots (<sprite name=grade3>), <sprite name=[food raw] herbs> Herbs (<sprite name=grade3>). Has improved efficiency and more worker slots.",
        _iconFilename = "Hallowed Herb Garden_icon.png",
        _category = "Food Production",
        _categoryDisplay = "Farm",
        _sizeX = 2,
        _sizeY = 2,
        _constructionTime = 20,
        _cityScore = 2,
        _isMovable = true,
        _isInitiallyEssential = false,
        _workerCapacity = 3,
        _constructionCosts = {
            {_id = "[Mat Processed] Planks", _amount = 2}
        },
        _tags = {
            "Farming",
            "FoxesCooperation"
        },
        _storage = 12,
        _area = 3,
        _recipes = {
            ["[Food Raw] Roots"] = {
                [3] = {
                    [9] = {
                        _buildings = {"Hallowed Herb Garden"},
                        _grade = 3,
                        _time = 60.0,
                        _productPair = {_id = "[Food Raw] Roots", _amount = 9},
                        _isService = false,
                        _ingredients = {},
                    },
                },
            },
            ["[Food Raw] Herbs"] = {
                [3] = {
                    [9] = {
                        _buildings = {"Hallowed Herb Garden"},
                        _grade = 3,
                        _time = 60.0,
                        _productPair = {_id = "[Food Raw] Herbs", _amount = 9},
                        _isService = false,
                        _ingredients = {},
                    },
                },
            },
        },
    },
    ["Hallowed SmallFarm"] = {
        _id = "Hallowed SmallFarm",
        _displayName = "Hallowed Small Farm",
        _description = "Uses nearby farm fields to grow  <sprite name=[food raw] vegetables> Vegetables (<sprite name=grade3>), <sprite name=[food raw] grain> Grain (<sprite name=grade3>). Has improved efficiency and more worker slots.",
        _iconFilename = "Hallowed SmallFarm_icon.png",
        _category = "Food Production",
        _categoryDisplay = "Farm",
        _sizeX = 2,
        _sizeY = 2,
        _constructionTime = 20,
        _cityScore = 3,
        _isMovable = true,
        _isInitiallyEssential = false,
        _workerCapacity = 3,
        _constructionCosts = {
            {_id = "[Mat Processed] Planks", _amount = 2}
        },
        _tags = {
            "Farming",
            "FoxesCooperation"
        },
        _storage = 12,
        _area = 3,
        _recipes = {
            ["[Food Raw] Vegetables"] = {
                [3] = {
                    [9] = {
                        _buildings = {"Hallowed SmallFarm"},
                        _grade = 3,
                        _time = 60.0,
                        _productPair = {_id = "[Food Raw] Vegetables", _amount = 9},
                        _isService = false,
                        _ingredients = {},
                    },
                },
            },
            ["[Food Raw] Grain"] = {
                [3] = {
                    [9] = {
                        _buildings = {"Hallowed SmallFarm"},
                        _grade = 3,
                        _time = 60.0,
                        _productPair = {_id = "[Food Raw] Grain", _amount = 9},
                        _isService = false,
                        _ingredients = {},
                    },
                },
            },
        },
    },
    ["Herb Garden"] = {
        _id = "Herb Garden",
        _displayName = "Herb Garden",
        _description = "Uses nearby farm fields to grow  <sprite name=[food raw] roots> Roots (<sprite name=grade1>), <sprite name=[food raw] herbs> Herbs (<sprite name=grade2>).",
        _iconFilename = "Herb Garden_icon.png",
        _category = "Food Production",
        _categoryDisplay = "Farm",
        _sizeX = 2,
        _sizeY = 2,
        _constructionTime = 20,
        _cityScore = 2,
        _isMovable = true,
        _isInitiallyEssential = false,
        _workerCapacity = 2,
        _constructionCosts = {
            {_id = "[Mat Processed] Planks", _amount = 2}
        },
        _tags = {
            "Farming"
        },
        _storage = 12,
        _area = 3,
        _recipes = {
            ["[Food Raw] Roots"] = {
                [1] = {
                    [3] = {
                        _buildings = {"Herb Garden"},
                        _grade = 1,
                        _time = 60.0,
                        _productPair = {_id = "[Food Raw] Roots", _amount = 3},
                        _isService = false,
                        _ingredients = {},
                    },
                },
            },
            ["[Food Raw] Herbs"] = {
                [2] = {
                    [6] = {
                        _buildings = {"Herb Garden"},
                        _grade = 2,
                        _time = 60.0,
                        _productPair = {_id = "[Food Raw] Herbs", _amount = 6},
                        _isService = false,
                        _ingredients = {},
                    },
                },
            },
        },
    },
    ["Homestead"] = {
        _id = "Homestead",
        _displayName = "Homestead",
        _description = "Uses a large area of nearby farm fields to grow  <sprite name=[food raw] grain> Grain (<sprite name=grade3>), <sprite name=[mat raw] plant fibre> Plant Fiber (<sprite name=grade3>), <sprite name=[food raw] vegetables> Vegetables (<sprite name=grade2>), <sprite name=[food raw] mushrooms> Mushrooms (<sprite name=grade2>).",
        _iconFilename = "Homestead_icon.png",
        _category = "Food Production",
        _categoryDisplay = "Farm",
        _sizeX = 3,
        _sizeY = 3,
        _constructionTime = 50,
        _cityScore = 10,
        _isMovable = true,
        _isInitiallyEssential = false,
        _workerCapacity = 4,
        _constructionCosts = {
            {_id = "[Mat Processed] Planks", _amount = 5},
            {_id = "[Mat Processed] Bricks", _amount = 2},
            {_id = "[Mat Processed] Fabric", _amount = 2}
        },
        _tags = {
            "Farming",
            "FoxesCooperation"
        },
        _storage = 20,
        _area = 10,
        _recipes = {
            ["[Food Raw] Grain"] = {
                [3] = {
                    [9] = {
                        _buildings = {"Homestead"},
                        _grade = 3,
                        _time = 60.0,
                        _productPair = {_id = "[Food Raw] Grain", _amount = 9},
                        _isService = false,
                        _ingredients = {},
                    },
                },
            },
            ["[Mat Raw] Plant Fibre"] = {
                [3] = {
                    [9] = {
                        _buildings = {"Homestead"},
                        _grade = 3,
                        _time = 60.0,
                        _productPair = {_id = "[Mat Raw] Plant Fibre", _amount = 9},
                        _isService = false,
                        _ingredients = {},
                    },
                },
            },
            ["[Food Raw] Vegetables"] = {
                [2] = {
                    [6] = {
                        _buildings = {"Homestead"},
                        _grade = 2,
                        _time = 60.0,
                        _productPair = {_id = "[Food Raw] Vegetables", _amount = 6},
                        _isService = false,
                        _ingredients = {},
                    },
                },
            },
            ["[Food Raw] Mushrooms"] = {
                [2] = {
                    [6] = {
                        _buildings = {"Homestead"},
                        _grade = 2,
                        _time = 60.0,
                        _productPair = {_id = "[Food Raw] Mushrooms", _amount = 6},
                        _isService = false,
                        _ingredients = {},
                    },
                },
            },
        },
    },
    ["Plantation"] = {
        _id = "Plantation",
        _displayName = "Plantation",
        _description = "Uses nearby farm fields to grow  <sprite name=[food raw] berries> Berries (<sprite name=grade2>), <sprite name=[mat raw] plant fibre> Plant Fiber (<sprite name=grade2>).",
        _iconFilename = "Plantation_icon.png",
        _category = "Food Production",
        _categoryDisplay = "Farm",
        _sizeX = 2,
        _sizeY = 2,
        _constructionTime = 20,
        _cityScore = 2,
        _isMovable = true,
        _isInitiallyEssential = false,
        _workerCapacity = 2,
        _constructionCosts = {
            {_id = "[Mat Processed] Planks", _amount = 2}
        },
        _tags = {
            "Farming"
        },
        _storage = 12,
        _area = 3,
        _recipes = {
            ["[Food Raw] Berries"] = {
                [2] = {
                    [6] = {
                        _buildings = {"Plantation"},
                        _grade = 2,
                        _time = 60.0,
                        _productPair = {_id = "[Food Raw] Berries", _amount = 6},
                        _isService = false,
                        _ingredients = {},
                    },
                },
            },
            ["[Mat Raw] Plant Fibre"] = {
                [2] = {
                    [6] = {
                        _buildings = {"Plantation"},
                        _grade = 2,
                        _time = 60.0,
                        _productPair = {_id = "[Mat Raw] Plant Fibre", _amount = 6},
                        _isService = false,
                        _ingredients = {},
                    },
                },
            },
        },
    },
    ["SmallFarm"] = {
        _id = "SmallFarm",
        _displayName = "Small Farm",
        _description = "Uses nearby farm fields to grow  <sprite name=[food raw] vegetables> Vegetables (<sprite name=grade1>), <sprite name=[food raw] grain> Grain (<sprite name=grade2>).",
        _iconFilename = "SmallFarm_icon.png",
        _category = "Food Production",
        _categoryDisplay = "Farm",
        _sizeX = 2,
        _sizeY = 2,
        _constructionTime = 20,
        _cityScore = 3,
        _isMovable = true,
        _isInitiallyEssential = false,
        _workerCapacity = 2,
        _constructionCosts = {
            {_id = "[Mat Processed] Planks", _amount = 2}
        },
        _tags = {
            "Farming"
        },
        _storage = 12,
        _area = 3,
        _recipes = {
            ["[Food Raw] Vegetables"] = {
                [1] = {
                    [3] = {
                        _buildings = {"SmallFarm"},
                        _grade = 1,
                        _time = 60.0,
                        _productPair = {_id = "[Food Raw] Vegetables", _amount = 3},
                        _isService = false,
                        _ingredients = {},
                    },
                },
            },
            ["[Food Raw] Grain"] = {
                [2] = {
                    [6] = {
                        _buildings = {"SmallFarm"},
                        _grade = 2,
                        _time = 60.0,
                        _productPair = {_id = "[Food Raw] Grain", _amount = 6},
                        _isService = false,
                        _ingredients = {},
                    },
                },
            },
        },
    },
}