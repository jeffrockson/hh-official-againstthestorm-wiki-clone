return {
    ["Field Engineering Station"] = {
        _id = "Field Engineering Station",
        _displayName = "Field Engineering Station",
        _description = "A makeshift workstation designed by the Brass Order. It's far simpler than the sophisticated machinery back in the Citadel, but it'll get the job done. Can produce: <sprite name=[WE] fuel core> Enriched Fuel (<sprite name=grade1>), <sprite name=[other] fuel rod> Fuel Rods (<sprite name=grade3>).",
        _iconFilename = "Field_Engineering_Station_icon.png",
        _category = "Industry",
        _categoryDisplay = "Production Building",
        _sizeX = 2,
        _sizeY = 2,
        _constructionTime = 20,
        _cityScore = 5,
        _isMovable = false,
        _isInitiallyEssential = false,
        _workerCapacity = 2,
        _constructionCosts = {
            {_id = "[Mat Processed] Planks", _amount = 4},
            {_id = "[Mat Processed] Parts", _amount = 2}
        },
        _tags = {
            "Tech"
        },
        _storage = 5,
        _waterUsed = "[Water] Storm Water",
        _recipes = {
            ["[WE] Fuel Core"] = {
                [1] = {
                    [1] = {
                        _buildings = {"Field Engineering Station"},
                        _grade = 1,
                        _time = 120,
                        _productPair = {_id = "[WE] Fuel Core", _amount = 1},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Water] Storm Water", _amount = 25},
                                {_id = "[Water] Clearance Water", _amount = 25},
                                {_id = "[Water] Drizzle Water", _amount = 25}
                            },
                            {
                                {_id = "[Mat Raw] Wood", _amount = 6},
                                {_id = "[Crafting] Oil", _amount = 3},
                                {_id = "[Crafting] Coal", _amount = 2},
                                {_id = "[Crafting] Sea Marrow", _amount = 2}
                            }
                        },
                    },
                },
            },
            ["[Other] Fuel Rod"] = {
                [3] = {
                    [1] = {
                        _buildings = {"Field Engineering Station"},
                        _grade = 3,
                        _time = 120,
                        _productPair = {_id = "[Other] Fuel Rod", _amount = 1},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Crafting] Oil", _amount = 12},
                                {_id = "[Crafting] Coal", _amount = 9},
                                {_id = "[Crafting] Sea Marrow", _amount = 9}
                            },
                            {
                                {_id = "[Metal] Copper Bar", _amount = 4},
                                {_id = "[Metal] Crystalized Dew", _amount = 4}
                            },
                            {
                                {_id = "[Mat Raw] Algae", _amount = 12},
                                {_id = "[Mat Raw] Reeds", _amount = 12},
                                {_id = "[Food Raw] Grain", _amount = 12},
                                {_id = "[Food Raw] Herbs", _amount = 12},
                                {_id = "[Food Raw] Berries", _amount = 12},
                                {_id = "[Food Raw] Vegetables", _amount = 12},
                                {_id = "[Mat Raw] Plant Fibre", _amount = 12}
                            }
                        },
                    },
                },
            },
        },
    },
    ["Alchemist Hut"] = {
        _id = "Alchemist Hut",
        _displayName = "Alchemist's Hut",
        _description = "Can produce:  <sprite name=[metal] crystalized dew> Crystalized Dew (<sprite name=grade2>), <sprite name=[needs] tea> Tea (<sprite name=grade2>), <sprite name=[needs] wine> Wine (<sprite name=grade2>). \nRain engine: <sprite name=\"[water] clearance water\"> Clearance Water.",
        _iconFilename = "Alchemist Hut_icon.png",
        _category = "Industry",
        _categoryDisplay = "Production Building",
        _sizeX = 3,
        _sizeY = 2,
        _constructionTime = 20,
        _cityScore = 5,
        _isMovable = false,
        _isInitiallyEssential = false,
        _workerCapacity = 2,
        _constructionCosts = {
            {_id = "[Mat Processed] Planks", _amount = 5},
            {_id = "[Mat Processed] Bricks", _amount = 2}
        },
        _tags = {
            "Alchemy",
            "Brewing",
            "FoxesCooperation"
        },
        _storage = 8,
        _waterUsed = "[Water] Clearance Water",
        _recipes = {
            ["[Metal] Crystalized Dew"] = {
                [2] = {
                    [2] = {
                        _buildings = {"Alchemist Hut"},
                        _grade = 2,
                        _time = 42.0,
                        _productPair = {_id = "[Metal] Crystalized Dew", _amount = 2},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Food Raw] Herbs", _amount = 2},
                                {_id = "[Food Raw] Insects", _amount = 2},
                                {_id = "[Mat Raw] Resin", _amount = 2},
                                {_id = "[Food Raw] Vegetables", _amount = 2},
                                {_id = "[Mat Raw] Algae", _amount = 2}
                            },
                            {
                                {_id = "[Mat Raw] Stone", _amount = 3},
                                {_id = "[Mat Raw] Clay", _amount = 3},
                                {_id = "[Crafting] Salt", _amount = 2}
                            },
                            {
                                {_id = "[Water] Storm Water", _amount = 8},
                                {_id = "[Water] Clearance Water", _amount = 12},
                                {_id = "[Water] Drizzle Water", _amount = 16}
                            }
                        },
                    },
                },
            },
            ["[Needs] Tea"] = {
                [2] = {
                    [10] = {
                        _buildings = {"Alchemist Hut"},
                        _grade = 2,
                        _time = 126.0,
                        _productPair = {_id = "[Needs] Tea", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Food Raw] Herbs", _amount = 3},
                                {_id = "[Crafting] Dye", _amount = 3},
                                {_id = "[Mat Raw] Resin", _amount = 3},
                                {_id = "[Food Raw] Mushrooms", _amount = 3},
                                {_id = "[Food Raw] Roots", _amount = 3}
                            },
                            {
                                {_id = "[Water] Drizzle Water", _amount = 3},
                                {_id = "[Water] Clearance Water", _amount = 4},
                                {_id = "[Water] Storm Water", _amount = 5}
                            },
                            {
                                {_id = "[Vessel] Pottery", _amount = 3},
                                {_id = "[Vessel] Barrels", _amount = 2},
                                {_id = "[Vessel] Waterskin", _amount = 3}
                            }
                        },
                    },
                },
            },
            ["[Needs] Wine"] = {
                [2] = {
                    [10] = {
                        _buildings = {"Alchemist Hut"},
                        _grade = 2,
                        _time = 84.0,
                        _productPair = {_id = "[Needs] Wine", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Food Raw] Berries", _amount = 3},
                                {_id = "[Food Raw] Mushrooms", _amount = 3},
                                {_id = "[Mat Raw] Reeds", _amount = 3}
                            },
                            {
                                {_id = "[Vessel] Pottery", _amount = 3},
                                {_id = "[Vessel] Barrels", _amount = 3},
                                {_id = "[Vessel] Waterskin", _amount = 3}
                            }
                        },
                    },
                },
            },
        },
    },
    ["Apothecary"] = {
        _id = "Apothecary",
        _displayName = "Apothecary",
        _description = "Can produce:  <sprite name=[needs] tea> Tea (<sprite name=grade2>), <sprite name=[crafting] dye> Dye (<sprite name=grade2>), <sprite name=[food processed] jerky> Jerky (<sprite name=grade2>). \nRain engine: <sprite name=\"[water] drizzle water\"> Drizzle Water.",
        _iconFilename = "Apothecary_icon.png",
        _category = "Food Production",
        _categoryDisplay = "Production Building",
        _sizeX = 2,
        _sizeY = 2,
        _constructionTime = 20,
        _cityScore = 5,
        _isMovable = false,
        _isInitiallyEssential = false,
        _workerCapacity = 2,
        _constructionCosts = {
            {_id = "[Mat Processed] Planks", _amount = 5},
            {_id = "[Mat Processed] Bricks", _amount = 2}
        },
        _tags = {
            "Alchemy",
            "Rainwater",
            "FoxesCooperation"
        },
        _storage = 8,
        _waterUsed = "[Water] Drizzle Water",
        _recipes = {
            ["[Needs] Tea"] = {
                [2] = {
                    [10] = {
                        _buildings = {"Apothecary"},
                        _grade = 2,
                        _time = 126.0,
                        _productPair = {_id = "[Needs] Tea", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Food Raw] Herbs", _amount = 3},
                                {_id = "[Crafting] Dye", _amount = 3},
                                {_id = "[Mat Raw] Resin", _amount = 3},
                                {_id = "[Food Raw] Mushrooms", _amount = 3},
                                {_id = "[Food Raw] Roots", _amount = 3}
                            },
                            {
                                {_id = "[Water] Drizzle Water", _amount = 3},
                                {_id = "[Water] Clearance Water", _amount = 4},
                                {_id = "[Water] Storm Water", _amount = 5}
                            },
                            {
                                {_id = "[Vessel] Pottery", _amount = 3},
                                {_id = "[Vessel] Barrels", _amount = 2},
                                {_id = "[Vessel] Waterskin", _amount = 3}
                            }
                        },
                    },
                },
            },
            ["[Crafting] Dye"] = {
                [2] = {
                    [10] = {
                        _buildings = {"Apothecary"},
                        _grade = 2,
                        _time = 126.0,
                        _productPair = {_id = "[Crafting] Dye", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Food Raw] Insects", _amount = 4},
                                {_id = "[Food Raw] Berries", _amount = 4},
                                {_id = "[Metal] Copper Ore", _amount = 4},
                                {_id = "[Mat Raw] Scales", _amount = 4},
                                {_id = "[Crafting] Coal", _amount = 3}
                            }
                        },
                    },
                },
            },
            ["[Food Processed] Jerky"] = {
                [2] = {
                    [10] = {
                        _buildings = {"Apothecary"},
                        _grade = 2,
                        _time = 126.0,
                        _productPair = {_id = "[Food Processed] Jerky", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Food Raw] Insects", _amount = 5},
                                {_id = "[Food Raw] Meat", _amount = 5}
                            },
                            {
                                {_id = "[Mat Raw] Wood", _amount = 5},
                                {_id = "[Crafting] Oil", _amount = 2},
                                {_id = "[Crafting] Salt", _amount = 2},
                                {_id = "[Crafting] Coal", _amount = 1},
                                {_id = "[Crafting] Sea Marrow", _amount = 1}
                            }
                        },
                    },
                },
            },
        },
    },
    ["Artisan"] = {
        _id = "Artisan",
        _displayName = "Artisan",
        _description = "Can produce:  <sprite name=[vessel] barrels> Barrels (<sprite name=grade2>), <sprite name=[needs] coats> Coats (<sprite name=grade2>), <sprite name=[needs] scrolls> Scrolls (<sprite name=grade2>). \nRain engine: <sprite name=\"[water] clearance water\"> Clearance Water.",
        _iconFilename = "Artisan_icon.png",
        _category = "Industry",
        _categoryDisplay = "Production Building",
        _sizeX = 3,
        _sizeY = 2,
        _constructionTime = 40,
        _cityScore = 5,
        _isMovable = false,
        _isInitiallyEssential = false,
        _workerCapacity = 3,
        _constructionCosts = {
            {_id = "[Mat Processed] Planks", _amount = 8},
            {_id = "[Mat Processed] Fabric", _amount = 4}
        },
        _tags = {
            "Cloth",
            "FoxesCooperation"
        },
        _storage = 8,
        _waterUsed = "[Water] Clearance Water",
        _recipes = {
            ["[Vessel] Barrels"] = {
                [2] = {
                    [10] = {
                        _buildings = {"Artisan"},
                        _grade = 2,
                        _time = 126.0,
                        _productPair = {_id = "[Vessel] Barrels", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Metal] Copper Bar", _amount = 2},
                                {_id = "[Metal] Crystalized Dew", _amount = 2}
                            },
                            {
                                {_id = "[Mat Processed] Planks", _amount = 2}
                            }
                        },
                    },
                },
            },
            ["[Needs] Coats"] = {
                [2] = {
                    [10] = {
                        _buildings = {"Artisan"},
                        _grade = 2,
                        _time = 126.0,
                        _productPair = {_id = "[Needs] Coats", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Mat Processed] Fabric", _amount = 2},
                                {_id = "[Mat Raw] Leather", _amount = 2}
                            },
                            {
                                {_id = "[Crafting] Dye", _amount = 3},
                                {_id = "[Mat Raw] Resin", _amount = 3}
                            }
                        },
                    },
                },
            },
            ["[Needs] Scrolls"] = {
                [2] = {
                    [8] = {
                        _buildings = {"Artisan"},
                        _grade = 2,
                        _time = 84.0,
                        _productPair = {_id = "[Needs] Scrolls", _amount = 8},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Mat Raw] Leather", _amount = 3},
                                {_id = "[Mat Raw] Plant Fibre", _amount = 3},
                                {_id = "[Mat Raw] Wood", _amount = 8}
                            },
                            {
                                {_id = "[Crafting] Dye", _amount = 2},
                                {_id = "[Needs] Wine", _amount = 2}
                            }
                        },
                    },
                },
            },
        },
    },
    ["Bakery"] = {
        _id = "Bakery",
        _displayName = "Bakery",
        _description = "Can produce:  <sprite name=[food processed] biscuits> Biscuits (<sprite name=grade2>), <sprite name=[food processed] pie> Pie (<sprite name=grade2>), <sprite name=[vessel] pottery> Pottery (<sprite name=grade2>). \nRain engine: <sprite name=\"[water] drizzle water\"> Drizzle Water.",
        _iconFilename = "Bakery_icon.png",
        _category = "Food Production",
        _categoryDisplay = "Production Building",
        _sizeX = 3,
        _sizeY = 2,
        _constructionTime = 40,
        _cityScore = 5,
        _isMovable = false,
        _isInitiallyEssential = false,
        _workerCapacity = 2,
        _constructionCosts = {
            {_id = "[Mat Processed] Planks", _amount = 5},
            {_id = "[Mat Processed] Fabric", _amount = 2}
        },
        _tags = {
            "Warmth",
            "FoxesCooperation"
        },
        _storage = 8,
        _waterUsed = "[Water] Drizzle Water",
        _recipes = {
            ["[Food Processed] Biscuits"] = {
                [2] = {
                    [10] = {
                        _buildings = {"Bakery"},
                        _grade = 2,
                        _time = 110.0,
                        _productPair = {_id = "[Food Processed] Biscuits", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Crafting] Flour", _amount = 6}
                            },
                            {
                                {_id = "[Food Raw] Herbs", _amount = 3},
                                {_id = "[Food Raw] Berries", _amount = 3},
                                {_id = "[Food Raw] Roots", _amount = 3},
                                {_id = "[Food Raw] Eggs", _amount = 3},
                                {_id = "[Crafting] Salt", _amount = 3}
                            }
                        },
                    },
                },
            },
            ["[Food Processed] Pie"] = {
                [2] = {
                    [10] = {
                        _buildings = {"Bakery"},
                        _grade = 2,
                        _time = 126.0,
                        _productPair = {_id = "[Food Processed] Pie", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Crafting] Flour", _amount = 6}
                            },
                            {
                                {_id = "[Food Raw] Herbs", _amount = 4},
                                {_id = "[Food Raw] Meat", _amount = 4},
                                {_id = "[Food Raw] Insects", _amount = 4},
                                {_id = "[Food Raw] Berries", _amount = 4},
                                {_id = "[Food Raw] Fish", _amount = 4}
                            }
                        },
                    },
                },
            },
            ["[Vessel] Pottery"] = {
                [2] = {
                    [5] = {
                        _buildings = {"Bakery"},
                        _grade = 2,
                        _time = 84.0,
                        _productPair = {_id = "[Vessel] Pottery", _amount = 5},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Mat Raw] Clay", _amount = 3}
                            },
                            {
                                {_id = "[Mat Raw] Wood", _amount = 5},
                                {_id = "[Crafting] Oil", _amount = 2},
                                {_id = "[Crafting] Coal", _amount = 1},
                                {_id = "[Crafting] Sea Marrow", _amount = 1}
                            }
                        },
                    },
                },
            },
        },
    },
    ["Beanery"] = {
        _id = "Beanery",
        _displayName = "Beanery",
        _description = "Can produce:  <sprite name=[food processed] porridge> Porridge (<sprite name=grade3>), <sprite name=[food processed] pickled goods> Pickled Goods (<sprite name=grade1>), <sprite name=[metal] crystalized dew> Crystalized Dew (<sprite name=grade1>). \nRain engine: <sprite name=\"[water] drizzle water\"> Drizzle Water.",
        _iconFilename = "Beanery_icon.png",
        _category = "Food Production",
        _categoryDisplay = "Production Building",
        _sizeX = 3,
        _sizeY = 2,
        _constructionTime = 50,
        _cityScore = 5,
        _isMovable = false,
        _isInitiallyEssential = false,
        _workerCapacity = 3,
        _constructionCosts = {
            {_id = "[Mat Processed] Planks", _amount = 8},
            {_id = "[Mat Processed] Bricks", _amount = 4}
        },
        _tags = {
            "Warmth",
            "Rainwater",
            "FoxesCooperation"
        },
        _storage = 8,
        _waterUsed = "[Water] Drizzle Water",
        _recipes = {
            ["[Food Processed] Porridge"] = {
                [3] = {
                    [10] = {
                        _buildings = {"Beanery"},
                        _grade = 3,
                        _time = 105.0,
                        _productPair = {_id = "[Food Processed] Porridge", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Food Raw] Grain", _amount = 4},
                                {_id = "[Food Raw] Vegetables", _amount = 4},
                                {_id = "[Food Raw] Mushrooms", _amount = 4},
                                {_id = "[Food Raw] Herbs", _amount = 4},
                                {_id = "[Food Raw] Fish", _amount = 4}
                            },
                            {
                                {_id = "[Water] Drizzle Water", _amount = 6},
                                {_id = "[Water] Clearance Water", _amount = 8},
                                {_id = "[Water] Storm Water", _amount = 10}
                            }
                        },
                    },
                },
            },
            ["[Food Processed] Pickled Goods"] = {
                [1] = {
                    [10] = {
                        _buildings = {"Beanery"},
                        _grade = 1,
                        _time = 126.0,
                        _productPair = {_id = "[Food Processed] Pickled Goods", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Food Raw] Vegetables", _amount = 6},
                                {_id = "[Food Raw] Mushrooms", _amount = 6},
                                {_id = "[Food Raw] Roots", _amount = 6},
                                {_id = "[Food Raw] Berries", _amount = 6},
                                {_id = "[Food Raw] Eggs", _amount = 6}
                            },
                            {
                                {_id = "[Vessel] Pottery", _amount = 3},
                                {_id = "[Vessel] Barrels", _amount = 3},
                                {_id = "[Vessel] Waterskin", _amount = 3}
                            }
                        },
                    },
                },
            },
            ["[Metal] Crystalized Dew"] = {
                [1] = {
                    [2] = {
                        _buildings = {"Beanery"},
                        _grade = 1,
                        _time = 42.0,
                        _productPair = {_id = "[Metal] Crystalized Dew", _amount = 2},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Food Raw] Herbs", _amount = 3},
                                {_id = "[Food Raw] Insects", _amount = 3},
                                {_id = "[Mat Raw] Resin", _amount = 3},
                                {_id = "[Food Raw] Vegetables", _amount = 3},
                                {_id = "[Mat Raw] Algae", _amount = 3}
                            },
                            {
                                {_id = "[Mat Raw] Stone", _amount = 4},
                                {_id = "[Mat Raw] Clay", _amount = 4},
                                {_id = "[Crafting] Salt", _amount = 3}
                            },
                            {
                                {_id = "[Water] Storm Water", _amount = 10},
                                {_id = "[Water] Clearance Water", _amount = 14},
                                {_id = "[Water] Drizzle Water", _amount = 18}
                            }
                        },
                    },
                },
            },
        },
    },
    ["Brewery"] = {
        _id = "Brewery",
        _displayName = "Brewery",
        _description = "Can produce:  <sprite name=[needs] ale> Ale (<sprite name=grade3>), <sprite name=[food processed] porridge> Porridge (<sprite name=grade2>), <sprite name=[packs] pack of crops> Pack of Crops (<sprite name=grade1>). \nRain engine: <sprite name=\"[water] drizzle water\"> Drizzle Water.",
        _iconFilename = "Brewery_icon.png",
        _category = "Industry",
        _categoryDisplay = "Production Building",
        _sizeX = 3,
        _sizeY = 3,
        _constructionTime = 50,
        _cityScore = 5,
        _isMovable = false,
        _isInitiallyEssential = false,
        _workerCapacity = 2,
        _constructionCosts = {
            {_id = "[Mat Processed] Planks", _amount = 2},
            {_id = "[Mat Processed] Bricks", _amount = 2},
            {_id = "[Mat Processed] Fabric", _amount = 2}
        },
        _tags = {
            "Brewing",
            "FoxesCooperation"
        },
        _storage = 8,
        _waterUsed = "[Water] Drizzle Water",
        _recipes = {
            ["[Needs] Ale"] = {
                [3] = {
                    [10] = {
                        _buildings = {"Brewery"},
                        _grade = 3,
                        _time = 105.0,
                        _productPair = {_id = "[Needs] Ale", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Food Raw] Grain", _amount = 4},
                                {_id = "[Food Raw] Roots", _amount = 4}
                            },
                            {
                                {_id = "[Vessel] Pottery", _amount = 2},
                                {_id = "[Vessel] Barrels", _amount = 1},
                                {_id = "[Vessel] Waterskin", _amount = 2}
                            }
                        },
                    },
                },
            },
            ["[Food Processed] Porridge"] = {
                [2] = {
                    [10] = {
                        _buildings = {"Brewery"},
                        _grade = 2,
                        _time = 126.0,
                        _productPair = {_id = "[Food Processed] Porridge", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Food Raw] Grain", _amount = 5},
                                {_id = "[Food Raw] Vegetables", _amount = 5},
                                {_id = "[Food Raw] Mushrooms", _amount = 5},
                                {_id = "[Food Raw] Herbs", _amount = 5},
                                {_id = "[Food Raw] Fish", _amount = 5}
                            },
                            {
                                {_id = "[Water] Drizzle Water", _amount = 7},
                                {_id = "[Water] Clearance Water", _amount = 9},
                                {_id = "[Water] Storm Water", _amount = 11}
                            }
                        },
                    },
                },
            },
            ["[Packs] Pack of Crops"] = {
                [1] = {
                    [2] = {
                        _buildings = {"Brewery"},
                        _grade = 1,
                        _time = 42.0,
                        _productPair = {_id = "[Packs] Pack of Crops", _amount = 2},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Food Raw] Roots", _amount = 5},
                                {_id = "[Food Raw] Grain", _amount = 5},
                                {_id = "[Food Raw] Vegetables", _amount = 5},
                                {_id = "[Food Raw] Mushrooms", _amount = 5}
                            }
                        },
                    },
                },
            },
        },
    },
    ["Brick Oven"] = {
        _id = "Brick Oven",
        _displayName = "Brick Oven",
        _description = "Can produce:  <sprite name=[food processed] biscuits> Biscuits (<sprite name=grade3>), <sprite name=[needs] incense> Incense (<sprite name=grade2>), <sprite name=[crafting] coal> Coal (<sprite name=grade1>). \nRain engine: <sprite name=\"[water] clearance water\"> Clearance Water.",
        _iconFilename = "Brick Oven_icon.png",
        _category = "Industry",
        _categoryDisplay = "Production Building",
        _sizeX = 2,
        _sizeY = 2,
        _constructionTime = 40,
        _cityScore = 5,
        _isMovable = false,
        _isInitiallyEssential = false,
        _workerCapacity = 3,
        _constructionCosts = {
            {_id = "[Mat Processed] Bricks", _amount = 5}
        },
        _tags = {
            "Warmth",
            "FoxesCooperation"
        },
        _storage = 8,
        _waterUsed = "[Water] Clearance Water",
        _recipes = {
            ["[Food Processed] Biscuits"] = {
                [3] = {
                    [10] = {
                        _buildings = {"Brick Oven"},
                        _grade = 3,
                        _time = 90.0,
                        _productPair = {_id = "[Food Processed] Biscuits", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Crafting] Flour", _amount = 6}
                            },
                            {
                                {_id = "[Food Raw] Herbs", _amount = 2},
                                {_id = "[Food Raw] Berries", _amount = 2},
                                {_id = "[Food Raw] Roots", _amount = 2},
                                {_id = "[Food Raw] Eggs", _amount = 2},
                                {_id = "[Crafting] Salt", _amount = 2}
                            }
                        },
                    },
                },
            },
            ["[Needs] Incense"] = {
                [2] = {
                    [10] = {
                        _buildings = {"Brick Oven"},
                        _grade = 2,
                        _time = 126.0,
                        _productPair = {_id = "[Needs] Incense", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Food Raw] Herbs", _amount = 5},
                                {_id = "[Food Raw] Roots", _amount = 5},
                                {_id = "[Food Raw] Insects", _amount = 5},
                                {_id = "[Mat Raw] Scales", _amount = 5},
                                {_id = "[Crafting] Salt", _amount = 5},
                                {_id = "[Mat Raw] Resin", _amount = 7}
                            },
                            {
                                {_id = "[Mat Raw] Wood", _amount = 6},
                                {_id = "[Crafting] Oil", _amount = 3},
                                {_id = "[Crafting] Coal", _amount = 2},
                                {_id = "[Crafting] Sea Marrow", _amount = 2}
                            }
                        },
                    },
                },
            },
            ["[Crafting] Coal"] = {
                [1] = {
                    [3] = {
                        _buildings = {"Brick Oven"},
                        _grade = 1,
                        _time = 126.0,
                        _productPair = {_id = "[Crafting] Coal", _amount = 3},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Mat Raw] Wood", _amount = 15},
                                {_id = "[Mat Raw] Algae", _amount = 8}
                            }
                        },
                    },
                },
            },
        },
    },
    ["Brickyard"] = {
        _id = "Brickyard",
        _displayName = "Brickyard",
        _description = "Can produce:  <sprite name=[mat processed] bricks> Bricks (<sprite name=grade3>), <sprite name=[vessel] pottery> Pottery (<sprite name=grade2>), <sprite name=[metal] crystalized dew> Crystalized Dew (<sprite name=grade1>). \nRain engine: <sprite name=\"[water] storm water\"> Storm Water.",
        _iconFilename = "Brickyard_icon.png",
        _category = "Industry",
        _categoryDisplay = "Production Building",
        _sizeX = 3,
        _sizeY = 3,
        _constructionTime = 25,
        _cityScore = 5,
        _isMovable = false,
        _isInitiallyEssential = false,
        _workerCapacity = 2,
        _constructionCosts = {
            {_id = "[Mat Processed] Planks", _amount = 8}
        },
        _tags = {
            "Stone",
            "FoxesCooperation"
        },
        _storage = 8,
        _waterUsed = "[Water] Storm Water",
        _recipes = {
            ["[Mat Processed] Bricks"] = {
                [3] = {
                    [2] = {
                        _buildings = {"Brickyard"},
                        _grade = 3,
                        _time = 28.0,
                        _productPair = {_id = "[Mat Processed] Bricks", _amount = 2},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Mat Raw] Clay", _amount = 2},
                                {_id = "[Mat Raw] Stone", _amount = 2}
                            }
                        },
                    },
                },
            },
            ["[Vessel] Pottery"] = {
                [2] = {
                    [5] = {
                        _buildings = {"Brickyard"},
                        _grade = 2,
                        _time = 84.0,
                        _productPair = {_id = "[Vessel] Pottery", _amount = 5},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Mat Raw] Clay", _amount = 3}
                            },
                            {
                                {_id = "[Mat Raw] Wood", _amount = 5},
                                {_id = "[Crafting] Oil", _amount = 2},
                                {_id = "[Crafting] Coal", _amount = 1},
                                {_id = "[Crafting] Sea Marrow", _amount = 1}
                            }
                        },
                    },
                },
            },
            ["[Metal] Crystalized Dew"] = {
                [1] = {
                    [2] = {
                        _buildings = {"Brickyard"},
                        _grade = 1,
                        _time = 42.0,
                        _productPair = {_id = "[Metal] Crystalized Dew", _amount = 2},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Food Raw] Herbs", _amount = 3},
                                {_id = "[Food Raw] Insects", _amount = 3},
                                {_id = "[Mat Raw] Resin", _amount = 3},
                                {_id = "[Food Raw] Vegetables", _amount = 3},
                                {_id = "[Mat Raw] Algae", _amount = 3}
                            },
                            {
                                {_id = "[Mat Raw] Stone", _amount = 4},
                                {_id = "[Mat Raw] Clay", _amount = 4},
                                {_id = "[Crafting] Salt", _amount = 3}
                            },
                            {
                                {_id = "[Water] Storm Water", _amount = 10},
                                {_id = "[Water] Clearance Water", _amount = 14},
                                {_id = "[Water] Drizzle Water", _amount = 18}
                            }
                        },
                    },
                },
            },
        },
    },
    ["Butcher"] = {
        _id = "Butcher",
        _displayName = "Butcher",
        _description = "Can produce:  <sprite name=[food processed] skewers> Skewers (<sprite name=grade2>), <sprite name=[food processed] jerky> Jerky (<sprite name=grade2>), <sprite name=[crafting] oil> Oil (<sprite name=grade2>). \nRain engine: <sprite name=\"[water] drizzle water\"> Drizzle Water.",
        _iconFilename = "Butcher_icon.png",
        _category = "Food Production",
        _categoryDisplay = "Production Building",
        _sizeX = 3,
        _sizeY = 3,
        _constructionTime = 40,
        _cityScore = 5,
        _isMovable = false,
        _isInitiallyEssential = false,
        _workerCapacity = 3,
        _constructionCosts = {
            {_id = "[Mat Processed] Planks", _amount = 5},
            {_id = "[Mat Processed] Bricks", _amount = 2}
        },
        _tags = {
            "Animals",
            "FoxesCooperation"
        },
        _storage = 8,
        _waterUsed = "[Water] Drizzle Water",
        _recipes = {
            ["[Food Processed] Skewers"] = {
                [2] = {
                    [10] = {
                        _buildings = {"Butcher"},
                        _grade = 2,
                        _time = 126.0,
                        _productPair = {_id = "[Food Processed] Skewers", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Food Raw] Insects", _amount = 3},
                                {_id = "[Food Raw] Meat", _amount = 3},
                                {_id = "[Food Raw] Mushrooms", _amount = 3},
                                {_id = "[Food Raw] Fish", _amount = 3},
                                {_id = "[Food Processed] Jerky", _amount = 2}
                            },
                            {
                                {_id = "[Food Raw] Vegetables", _amount = 4},
                                {_id = "[Food Raw] Roots", _amount = 4},
                                {_id = "[Food Raw] Berries", _amount = 4},
                                {_id = "[Food Raw] Eggs", _amount = 4}
                            }
                        },
                    },
                },
            },
            ["[Food Processed] Jerky"] = {
                [2] = {
                    [10] = {
                        _buildings = {"Butcher"},
                        _grade = 2,
                        _time = 126.0,
                        _productPair = {_id = "[Food Processed] Jerky", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Food Raw] Insects", _amount = 5},
                                {_id = "[Food Raw] Meat", _amount = 5}
                            },
                            {
                                {_id = "[Mat Raw] Wood", _amount = 5},
                                {_id = "[Crafting] Oil", _amount = 2},
                                {_id = "[Crafting] Salt", _amount = 2},
                                {_id = "[Crafting] Coal", _amount = 1},
                                {_id = "[Crafting] Sea Marrow", _amount = 1}
                            }
                        },
                    },
                },
            },
            ["[Crafting] Oil"] = {
                [2] = {
                    [5] = {
                        _buildings = {"Butcher"},
                        _grade = 2,
                        _time = 84.0,
                        _productPair = {_id = "[Crafting] Oil", _amount = 5},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Food Raw] Grain", _amount = 3},
                                {_id = "[Food Raw] Meat", _amount = 3},
                                {_id = "[Food Raw] Vegetables", _amount = 3},
                                {_id = "[Mat Raw] Plant Fibre", _amount = 3},
                                {_id = "[Food Raw] Fish", _amount = 3}
                            }
                        },
                    },
                },
            },
        },
    },
    ["Cannery"] = {
        _id = "Cannery",
        _displayName = "Cannery",
        _description = "Can produce:  <sprite name=[food processed] paste> Paste (<sprite name=grade3>), <sprite name=[needs] wine> Wine (<sprite name=grade2>), <sprite name=[food processed] biscuits> Biscuits (<sprite name=grade1>). \nRain engine: <sprite name=\"[water] drizzle water\"> Drizzle Water.",
        _iconFilename = "Cannery_icon.png",
        _category = "Food Production",
        _categoryDisplay = "Production Building",
        _sizeX = 3,
        _sizeY = 2,
        _constructionTime = 50,
        _cityScore = 5,
        _isMovable = false,
        _isInitiallyEssential = false,
        _workerCapacity = 2,
        _constructionCosts = {
            {_id = "[Mat Processed] Bricks", _amount = 2},
            {_id = "[Mat Processed] Fabric", _amount = 2}
        },
        _tags = {
            "FoxesCooperation"
        },
        _storage = 8,
        _waterUsed = "[Water] Drizzle Water",
        _recipes = {
            ["[Food Processed] Paste"] = {
                [3] = {
                    [10] = {
                        _buildings = {"Cannery"},
                        _grade = 3,
                        _time = 105.0,
                        _productPair = {_id = "[Food Processed] Paste", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Crafting] Dye", _amount = 2},
                                {_id = "[Crafting] Salt", _amount = 3}
                            },
                            {
                                {_id = "[Food Raw] Eggs", _amount = 4},
                                {_id = "[Food Raw] Fish", _amount = 4},
                                {_id = "[Food Raw] Meat", _amount = 4}
                            }
                        },
                    },
                },
            },
            ["[Needs] Wine"] = {
                [2] = {
                    [10] = {
                        _buildings = {"Cannery"},
                        _grade = 2,
                        _time = 84.0,
                        _productPair = {_id = "[Needs] Wine", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Food Raw] Berries", _amount = 3},
                                {_id = "[Food Raw] Mushrooms", _amount = 3},
                                {_id = "[Mat Raw] Reeds", _amount = 3}
                            },
                            {
                                {_id = "[Vessel] Pottery", _amount = 3},
                                {_id = "[Vessel] Barrels", _amount = 3},
                                {_id = "[Vessel] Waterskin", _amount = 3}
                            }
                        },
                    },
                },
            },
            ["[Food Processed] Biscuits"] = {
                [1] = {
                    [10] = {
                        _buildings = {"Cannery"},
                        _grade = 1,
                        _time = 110.0,
                        _productPair = {_id = "[Food Processed] Biscuits", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Crafting] Flour", _amount = 6}
                            },
                            {
                                {_id = "[Food Raw] Herbs", _amount = 4},
                                {_id = "[Food Raw] Berries", _amount = 4},
                                {_id = "[Food Raw] Roots", _amount = 4},
                                {_id = "[Food Raw] Eggs", _amount = 4},
                                {_id = "[Crafting] Salt", _amount = 4}
                            }
                        },
                    },
                },
            },
        },
    },
    ["Carpenter"] = {
        _id = "Carpenter",
        _displayName = "Carpenter",
        _description = "Can produce:  <sprite name=[mat processed] planks> Planks (<sprite name=grade2>), <sprite name=[tools] simple tools> Tools (<sprite name=grade2>), <sprite name=[packs] pack of luxury goods> Pack of Luxury Goods (<sprite name=grade2>). \nRain engine: <sprite name=\"[water] storm water\"> Storm Water.",
        _iconFilename = "Carpenter_icon.png",
        _category = "Industry",
        _categoryDisplay = "Production Building",
        _sizeX = 3,
        _sizeY = 2,
        _constructionTime = 40,
        _cityScore = 5,
        _isMovable = false,
        _isInitiallyEssential = false,
        _workerCapacity = 3,
        _constructionCosts = {
            {_id = "[Mat Processed] Planks", _amount = 5},
            {_id = "[Mat Processed] Fabric", _amount = 2}
        },
        _tags = {
            "Wood",
            "FoxesCooperation"
        },
        _storage = 8,
        _waterUsed = "[Water] Storm Water",
        _recipes = {
            ["[Mat Processed] Planks"] = {
                [2] = {
                    [2] = {
                        _buildings = {"Carpenter"},
                        _grade = 2,
                        _time = 42.0,
                        _productPair = {_id = "[Mat Processed] Planks", _amount = 2},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Mat Raw] Wood", _amount = 5}
                            }
                        },
                    },
                },
            },
            ["[Tools] Simple Tools"] = {
                [2] = {
                    [2] = {
                        _buildings = {"Carpenter"},
                        _grade = 2,
                        _time = 75.0,
                        _productPair = {_id = "[Tools] Simple Tools", _amount = 2},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Mat Raw] Wood", _amount = 8},
                                {_id = "[Mat Processed] Planks", _amount = 2}
                            },
                            {
                                {_id = "[Metal] Copper Bar", _amount = 3},
                                {_id = "[Metal] Crystalized Dew", _amount = 3}
                            }
                        },
                    },
                },
            },
            ["[Packs] Pack of Luxury Goods"] = {
                [2] = {
                    [2] = {
                        _buildings = {"Carpenter"},
                        _grade = 2,
                        _time = 42.0,
                        _productPair = {_id = "[Packs] Pack of Luxury Goods", _amount = 2},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Needs] Wine", _amount = 4},
                                {_id = "[Needs] Training Gear", _amount = 4},
                                {_id = "[Needs] Incense", _amount = 4},
                                {_id = "[Needs] Scrolls", _amount = 4},
                                {_id = "[Needs] Ale", _amount = 4},
                                {_id = "[Needs] Tea", _amount = 4}
                            }
                        },
                    },
                },
            },
        },
    },
    ["Cellar"] = {
        _id = "Cellar",
        _displayName = "Cellar",
        _description = "Can produce:  <sprite name=[needs] wine> Wine (<sprite name=grade3>), <sprite name=[food processed] pickled goods> Pickled Goods (<sprite name=grade2>), <sprite name=[packs] pack of provisions> Pack of Provisions (<sprite name=grade1>). \nRain engine: <sprite name=\"[water] drizzle water\"> Drizzle Water.",
        _iconFilename = "Cellar_icon.png",
        _category = "Food Production",
        _categoryDisplay = "Production Building",
        _sizeX = 2,
        _sizeY = 2,
        _constructionTime = 50,
        _cityScore = 5,
        _isMovable = false,
        _isInitiallyEssential = false,
        _workerCapacity = 2,
        _constructionCosts = {
            {_id = "[Mat Processed] Bricks", _amount = 2},
            {_id = "[Mat Processed] Fabric", _amount = 2}
        },
        _tags = {
            "Brewing",
            "FoxesCooperation"
        },
        _storage = 8,
        _waterUsed = "[Water] Drizzle Water",
        _recipes = {
            ["[Needs] Wine"] = {
                [3] = {
                    [10] = {
                        _buildings = {"Cellar"},
                        _grade = 3,
                        _time = 63.0,
                        _productPair = {_id = "[Needs] Wine", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Food Raw] Berries", _amount = 2},
                                {_id = "[Food Raw] Mushrooms", _amount = 2},
                                {_id = "[Mat Raw] Reeds", _amount = 2}
                            },
                            {
                                {_id = "[Vessel] Pottery", _amount = 2},
                                {_id = "[Vessel] Barrels", _amount = 2},
                                {_id = "[Vessel] Waterskin", _amount = 2}
                            }
                        },
                    },
                },
            },
            ["[Food Processed] Pickled Goods"] = {
                [2] = {
                    [10] = {
                        _buildings = {"Cellar"},
                        _grade = 2,
                        _time = 126.0,
                        _productPair = {_id = "[Food Processed] Pickled Goods", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Food Raw] Vegetables", _amount = 5},
                                {_id = "[Food Raw] Mushrooms", _amount = 5},
                                {_id = "[Food Raw] Roots", _amount = 5},
                                {_id = "[Food Raw] Berries", _amount = 5},
                                {_id = "[Food Raw] Eggs", _amount = 5}
                            },
                            {
                                {_id = "[Vessel] Pottery", _amount = 3},
                                {_id = "[Vessel] Barrels", _amount = 3},
                                {_id = "[Vessel] Waterskin", _amount = 2}
                            }
                        },
                    },
                },
            },
            ["[Packs] Pack of Provisions"] = {
                [1] = {
                    [3] = {
                        _buildings = {"Cellar"},
                        _grade = 1,
                        _time = 42.0,
                        _productPair = {_id = "[Packs] Pack of Provisions", _amount = 3},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Food Raw] Herbs", _amount = 5},
                                {_id = "[Food Raw] Berries", _amount = 5},
                                {_id = "[Food Raw] Insects", _amount = 5},
                                {_id = "[Food Raw] Meat", _amount = 5},
                                {_id = "[Food Raw] Eggs", _amount = 5},
                                {_id = "[Food Raw] Fish", _amount = 5}
                            }
                        },
                    },
                },
            },
        },
    },
    ["Clay Pit Workshop"] = {
        _id = "Clay Pit Workshop",
        _displayName = "Clay Pit",
        _description = "Uses Clearance Water to produce goods regardless of the season. Must be placed on fertile soil. Can produce:  <sprite name=[mat raw] clay> Clay (<sprite name=grade2>), <sprite name=[mat raw] reeds> Reed (<sprite name=grade2>), <sprite name=[mat raw] resin> Resin (<sprite name=grade2>)\nRain engine: <sprite name=\"[water] storm water\"> Storm Water.",
        _iconFilename = "Clay Pit Workshop_icon.png",
        _category = "Resource Acquisition",
        _categoryDisplay = "Production Building",
        _sizeX = 2,
        _sizeY = 2,
        _constructionTime = 30,
        _cityScore = 5,
        _isMovable = false,
        _isInitiallyEssential = false,
        _workerCapacity = 3,
        _constructionCosts = {
            {_id = "[Mat Processed] Planks", _amount = 2},
            {_id = "[Mat Processed] Fabric", _amount = 2}
        },
        _tags = {
            "Stone",
            "FoxesCooperation"
        },
        _storage = 8,
        _waterUsed = "[Water] Storm Water",
        _recipes = {
            ["[Mat Raw] Clay"] = {
                [2] = {
                    [4] = {
                        _buildings = {"Clay Pit Workshop"},
                        _grade = 2,
                        _time = 60.0,
                        _productPair = {_id = "[Mat Raw] Clay", _amount = 4},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Water] Clearance Water", _amount = 2}
                            }
                        },
                    },
                },
            },
            ["[Mat Raw] Reeds"] = {
                [2] = {
                    [4] = {
                        _buildings = {"Clay Pit Workshop"},
                        _grade = 2,
                        _time = 60.0,
                        _productPair = {_id = "[Mat Raw] Reeds", _amount = 4},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Water] Clearance Water", _amount = 2}
                            }
                        },
                    },
                },
            },
            ["[Mat Raw] Resin"] = {
                [2] = {
                    [4] = {
                        _buildings = {"Clay Pit Workshop"},
                        _grade = 2,
                        _time = 60.0,
                        _productPair = {_id = "[Mat Raw] Resin", _amount = 4},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Water] Clearance Water", _amount = 2}
                            }
                        },
                    },
                },
            },
        },
    },
    ["Clothier"] = {
        _id = "Clothier",
        _displayName = "Clothier",
        _description = "Can produce:  <sprite name=[needs] coats> Coats (<sprite name=grade3>), <sprite name=[packs] pack of building materials> Pack of Building Materials (<sprite name=grade2>), <sprite name=[vessel] waterskin> Waterskins (<sprite name=grade1>). \nRain engine: <sprite name=\"[water] clearance water\"> Clearance Water.",
        _iconFilename = "Clothier_icon.png",
        _category = "Industry",
        _categoryDisplay = "Production Building",
        _sizeX = 3,
        _sizeY = 2,
        _constructionTime = 20,
        _cityScore = 5,
        _isMovable = false,
        _isInitiallyEssential = false,
        _workerCapacity = 2,
        _constructionCosts = {
            {_id = "[Mat Processed] Planks", _amount = 5},
            {_id = "[Mat Processed] Fabric", _amount = 2}
        },
        _tags = {
            "Cloth",
            "FoxesCooperation"
        },
        _storage = 8,
        _waterUsed = "[Water] Clearance Water",
        _recipes = {
            ["[Needs] Coats"] = {
                [3] = {
                    [10] = {
                        _buildings = {"Clothier"},
                        _grade = 3,
                        _time = 105.0,
                        _productPair = {_id = "[Needs] Coats", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Mat Processed] Fabric", _amount = 1},
                                {_id = "[Mat Raw] Leather", _amount = 1}
                            },
                            {
                                {_id = "[Crafting] Dye", _amount = 2},
                                {_id = "[Mat Raw] Resin", _amount = 2}
                            }
                        },
                    },
                },
            },
            ["[Packs] Pack of Building Materials"] = {
                [2] = {
                    [2] = {
                        _buildings = {"Clothier"},
                        _grade = 2,
                        _time = 42.0,
                        _productPair = {_id = "[Packs] Pack of Building Materials", _amount = 2},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Mat Processed] Planks", _amount = 7},
                                {_id = "[Mat Processed] Fabric", _amount = 4},
                                {_id = "[Mat Processed] Bricks", _amount = 4},
                                {_id = "[Metal] Copper Ore", _amount = 10}
                            }
                        },
                    },
                },
            },
            ["[Vessel] Waterskin"] = {
                [1] = {
                    [10] = {
                        _buildings = {"Clothier"},
                        _grade = 1,
                        _time = 84.0,
                        _productPair = {_id = "[Vessel] Waterskin", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Mat Raw] Leather", _amount = 6},
                                {_id = "[Mat Raw] Scales", _amount = 6}
                            },
                            {
                                {_id = "[Crafting] Oil", _amount = 4},
                                {_id = "[Food Raw] Meat", _amount = 4},
                                {_id = "[Crafting] Salt", _amount = 4}
                            }
                        },
                    },
                },
            },
        },
    },
    ["Cobbler"] = {
        _id = "Cobbler",
        _displayName = "Cobbler",
        _description = "Can produce:  <sprite name=[needs] boots> Boots (<sprite name=grade3>), <sprite name=[packs] pack of building materials> Pack of Building Materials (<sprite name=grade2>), <sprite name=[crafting] dye> Dye (<sprite name=grade1>). \nRain engine: <sprite name=\"[water] clearance water\"> Clearance Water.",
        _iconFilename = "Cobbler_icon.png",
        _category = "Industry",
        _categoryDisplay = "Production Building",
        _sizeX = 3,
        _sizeY = 3,
        _constructionTime = 40,
        _cityScore = 5,
        _isMovable = false,
        _isInitiallyEssential = false,
        _workerCapacity = 2,
        _constructionCosts = {
            {_id = "[Mat Processed] Planks", _amount = 8}
        },
        _tags = {
            "Cloth",
            "FoxesCooperation"
        },
        _storage = 8,
        _waterUsed = "[Water] Clearance Water",
        _recipes = {
            ["[Needs] Boots"] = {
                [3] = {
                    [10] = {
                        _buildings = {"Cobbler"},
                        _grade = 3,
                        _time = 126.0,
                        _productPair = {_id = "[Needs] Boots", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Mat Raw] Leather", _amount = 3},
                                {_id = "[Mat Raw] Scales", _amount = 3}
                            }
                        },
                    },
                },
            },
            ["[Packs] Pack of Building Materials"] = {
                [2] = {
                    [2] = {
                        _buildings = {"Cobbler"},
                        _grade = 2,
                        _time = 42.0,
                        _productPair = {_id = "[Packs] Pack of Building Materials", _amount = 2},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Mat Processed] Planks", _amount = 7},
                                {_id = "[Mat Processed] Fabric", _amount = 4},
                                {_id = "[Mat Processed] Bricks", _amount = 4},
                                {_id = "[Metal] Copper Ore", _amount = 10}
                            }
                        },
                    },
                },
            },
            ["[Crafting] Dye"] = {
                [1] = {
                    [10] = {
                        _buildings = {"Cobbler"},
                        _grade = 1,
                        _time = 126.0,
                        _productPair = {_id = "[Crafting] Dye", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Food Raw] Insects", _amount = 5},
                                {_id = "[Food Raw] Berries", _amount = 5},
                                {_id = "[Metal] Copper Ore", _amount = 5},
                                {_id = "[Mat Raw] Scales", _amount = 5},
                                {_id = "[Crafting] Coal", _amount = 4}
                            }
                        },
                    },
                },
            },
        },
    },
    ["Cookhouse"] = {
        _id = "Cookhouse",
        _displayName = "Cookhouse",
        _description = "Can produce:  <sprite name=[food processed] skewers> Skewers (<sprite name=grade2>), <sprite name=[food processed] biscuits> Biscuits (<sprite name=grade2>), <sprite name=[food processed] porridge> Porridge (<sprite name=grade2>). \nRain engine: <sprite name=\"[water] drizzle water\"> Drizzle Water.",
        _iconFilename = "Cookhouse_icon.png",
        _category = "Food Production",
        _categoryDisplay = "Production Building",
        _sizeX = 4,
        _sizeY = 3,
        _constructionTime = 50,
        _cityScore = 5,
        _isMovable = false,
        _isInitiallyEssential = false,
        _workerCapacity = 4,
        _constructionCosts = {
            {_id = "[Mat Processed] Planks", _amount = 8},
            {_id = "[Mat Processed] Bricks", _amount = 4}
        },
        _tags = {
            "Warmth",
            "FoxesCooperation"
        },
        _storage = 8,
        _waterUsed = "[Water] Drizzle Water",
        _recipes = {
            ["[Food Processed] Skewers"] = {
                [2] = {
                    [10] = {
                        _buildings = {"Cookhouse"},
                        _grade = 2,
                        _time = 126.0,
                        _productPair = {_id = "[Food Processed] Skewers", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Food Raw] Insects", _amount = 3},
                                {_id = "[Food Raw] Meat", _amount = 3},
                                {_id = "[Food Raw] Mushrooms", _amount = 3},
                                {_id = "[Food Raw] Fish", _amount = 3},
                                {_id = "[Food Processed] Jerky", _amount = 2}
                            },
                            {
                                {_id = "[Food Raw] Vegetables", _amount = 4},
                                {_id = "[Food Raw] Roots", _amount = 4},
                                {_id = "[Food Raw] Berries", _amount = 4},
                                {_id = "[Food Raw] Eggs", _amount = 4}
                            }
                        },
                    },
                },
            },
            ["[Food Processed] Biscuits"] = {
                [2] = {
                    [10] = {
                        _buildings = {"Cookhouse"},
                        _grade = 2,
                        _time = 110.0,
                        _productPair = {_id = "[Food Processed] Biscuits", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Crafting] Flour", _amount = 6}
                            },
                            {
                                {_id = "[Food Raw] Herbs", _amount = 3},
                                {_id = "[Food Raw] Berries", _amount = 3},
                                {_id = "[Food Raw] Roots", _amount = 3},
                                {_id = "[Food Raw] Eggs", _amount = 3},
                                {_id = "[Crafting] Salt", _amount = 3}
                            }
                        },
                    },
                },
            },
            ["[Food Processed] Porridge"] = {
                [2] = {
                    [10] = {
                        _buildings = {"Cookhouse"},
                        _grade = 2,
                        _time = 126.0,
                        _productPair = {_id = "[Food Processed] Porridge", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Food Raw] Grain", _amount = 5},
                                {_id = "[Food Raw] Vegetables", _amount = 5},
                                {_id = "[Food Raw] Mushrooms", _amount = 5},
                                {_id = "[Food Raw] Herbs", _amount = 5},
                                {_id = "[Food Raw] Fish", _amount = 5}
                            },
                            {
                                {_id = "[Water] Drizzle Water", _amount = 7},
                                {_id = "[Water] Clearance Water", _amount = 9},
                                {_id = "[Water] Storm Water", _amount = 11}
                            }
                        },
                    },
                },
            },
        },
    },
    ["Cooperage"] = {
        _id = "Cooperage",
        _displayName = "Cooperage",
        _description = "Can produce:  <sprite name=[vessel] barrels> Barrels (<sprite name=grade3>), <sprite name=[needs] coats> Coats (<sprite name=grade2>), <sprite name=[packs] pack of luxury goods> Pack of Luxury Goods (<sprite name=grade1>). \nRain engine: <sprite name=\"[water] clearance water\"> Clearance Water.",
        _iconFilename = "Cooperage_icon.png",
        _category = "Industry",
        _categoryDisplay = "Production Building",
        _sizeX = 3,
        _sizeY = 2,
        _constructionTime = 40,
        _cityScore = 5,
        _isMovable = false,
        _isInitiallyEssential = false,
        _workerCapacity = 2,
        _constructionCosts = {
            {_id = "[Mat Processed] Planks", _amount = 5},
            {_id = "[Mat Processed] Bricks", _amount = 2}
        },
        _tags = {
            "Wood",
            "Metallurgy",
            "FoxesCooperation"
        },
        _storage = 8,
        _waterUsed = "[Water] Clearance Water",
        _recipes = {
            ["[Vessel] Barrels"] = {
                [3] = {
                    [10] = {
                        _buildings = {"Cooperage"},
                        _grade = 3,
                        _time = 105.0,
                        _productPair = {_id = "[Vessel] Barrels", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Metal] Copper Bar", _amount = 1},
                                {_id = "[Metal] Crystalized Dew", _amount = 1}
                            },
                            {
                                {_id = "[Mat Processed] Planks", _amount = 2}
                            }
                        },
                    },
                },
            },
            ["[Needs] Coats"] = {
                [2] = {
                    [10] = {
                        _buildings = {"Cooperage"},
                        _grade = 2,
                        _time = 126.0,
                        _productPair = {_id = "[Needs] Coats", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Mat Processed] Fabric", _amount = 2},
                                {_id = "[Mat Raw] Leather", _amount = 2}
                            },
                            {
                                {_id = "[Crafting] Dye", _amount = 3},
                                {_id = "[Mat Raw] Resin", _amount = 3}
                            }
                        },
                    },
                },
            },
            ["[Packs] Pack of Luxury Goods"] = {
                [1] = {
                    [2] = {
                        _buildings = {"Cooperage"},
                        _grade = 1,
                        _time = 42.0,
                        _productPair = {_id = "[Packs] Pack of Luxury Goods", _amount = 2},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Needs] Wine", _amount = 5},
                                {_id = "[Needs] Training Gear", _amount = 5},
                                {_id = "[Needs] Incense", _amount = 5},
                                {_id = "[Needs] Scrolls", _amount = 5},
                                {_id = "[Needs] Ale", _amount = 5},
                                {_id = "[Needs] Tea", _amount = 5}
                            }
                        },
                    },
                },
            },
        },
    },
    ["Crude Workstation"] = {
        _id = "Crude Workstation",
        _displayName = "Crude Workstation",
        _description = "Can produce:  <sprite name=[mat processed] planks> Planks (<sprite name=grade0>), <sprite name=[mat processed] fabric> Fabric (<sprite name=grade0>), <sprite name=[mat processed] bricks> Bricks (<sprite name=grade0>), <sprite name=[mat processed] pipe> Pipes (<sprite name=grade0>). \nRain engine: <sprite name=\"[water] storm water\"> Storm Water.",
        _iconFilename = "Crude Workstation_icon.png",
        _category = "Industry",
        _categoryDisplay = "Production Building",
        _sizeX = 2,
        _sizeY = 2,
        _constructionTime = 20,
        _cityScore = 2,
        _isMovable = true,
        _isInitiallyEssential = false,
        _workerCapacity = 2,
        _constructionCosts = {
            {_id = "[Mat Raw] Wood", _amount = 5}
        },
        _tags = {
            "FoxesCooperation"
        },
        _storage = 5,
        _waterUsed = "[Water] Storm Water",
        _recipes = {
            ["[Mat Processed] Planks"] = {
                [0] = {
                    [2] = {
                        _buildings = {"Crude Workstation"},
                        _grade = 0,
                        _time = 56.0,
                        _productPair = {_id = "[Mat Processed] Planks", _amount = 2},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Mat Raw] Wood", _amount = 8}
                            }
                        },
                    },
                },
            },
            ["[Mat Processed] Fabric"] = {
                [0] = {
                    [2] = {
                        _buildings = {"Crude Workstation"},
                        _grade = 0,
                        _time = 56.0,
                        _productPair = {_id = "[Mat Processed] Fabric", _amount = 2},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Mat Raw] Plant Fibre", _amount = 6},
                                {_id = "[Mat Raw] Reeds", _amount = 6},
                                {_id = "[Mat Raw] Algae", _amount = 6}
                            }
                        },
                    },
                },
            },
            ["[Mat Processed] Bricks"] = {
                [0] = {
                    [2] = {
                        _buildings = {"Crude Workstation"},
                        _grade = 0,
                        _time = 56.0,
                        _productPair = {_id = "[Mat Processed] Bricks", _amount = 2},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Mat Raw] Clay", _amount = 6},
                                {_id = "[Mat Raw] Stone", _amount = 6}
                            }
                        },
                    },
                },
            },
            ["[Mat Processed] Pipe"] = {
                [0] = {
                    [2] = {
                        _buildings = {"Crude Workstation"},
                        _grade = 0,
                        _time = 60.0,
                        _productPair = {_id = "[Mat Processed] Pipe", _amount = 2},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Metal] Copper Bar", _amount = 3},
                                {_id = "[Metal] Crystalized Dew", _amount = 3}
                            }
                        },
                    },
                },
            },
        },
    },
    ["Distillery"] = {
        _id = "Distillery",
        _displayName = "Distillery",
        _description = "Can produce:  <sprite name=[needs] ale> Ale (<sprite name=grade2>), <sprite name=[needs] incense> Incense (<sprite name=grade2>), <sprite name=[food processed] pickled goods> Pickled Goods (<sprite name=grade2>). \nRain engine: <sprite name=\"[water] drizzle water\"> Drizzle Water.",
        _iconFilename = "Distillery_icon.png",
        _category = "Industry",
        _categoryDisplay = "Production Building",
        _sizeX = 3,
        _sizeY = 3,
        _constructionTime = 50,
        _cityScore = 5,
        _isMovable = false,
        _isInitiallyEssential = false,
        _workerCapacity = 2,
        _constructionCosts = {
            {_id = "[Mat Processed] Planks", _amount = 2},
            {_id = "[Mat Processed] Bricks", _amount = 2},
            {_id = "[Mat Processed] Fabric", _amount = 2}
        },
        _tags = {
            "Brewing",
            "Rainwater",
            "FoxesCooperation"
        },
        _storage = 8,
        _waterUsed = "[Water] Drizzle Water",
        _recipes = {
            ["[Needs] Ale"] = {
                [2] = {
                    [10] = {
                        _buildings = {"Distillery"},
                        _grade = 2,
                        _time = 126.0,
                        _productPair = {_id = "[Needs] Ale", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Food Raw] Grain", _amount = 5},
                                {_id = "[Food Raw] Roots", _amount = 5}
                            },
                            {
                                {_id = "[Vessel] Pottery", _amount = 3},
                                {_id = "[Vessel] Barrels", _amount = 2},
                                {_id = "[Vessel] Waterskin", _amount = 3}
                            }
                        },
                    },
                },
            },
            ["[Needs] Incense"] = {
                [2] = {
                    [10] = {
                        _buildings = {"Distillery"},
                        _grade = 2,
                        _time = 126.0,
                        _productPair = {_id = "[Needs] Incense", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Food Raw] Herbs", _amount = 5},
                                {_id = "[Food Raw] Roots", _amount = 5},
                                {_id = "[Food Raw] Insects", _amount = 5},
                                {_id = "[Mat Raw] Scales", _amount = 5},
                                {_id = "[Crafting] Salt", _amount = 5},
                                {_id = "[Mat Raw] Resin", _amount = 7}
                            },
                            {
                                {_id = "[Mat Raw] Wood", _amount = 6},
                                {_id = "[Crafting] Oil", _amount = 3},
                                {_id = "[Crafting] Coal", _amount = 2},
                                {_id = "[Crafting] Sea Marrow", _amount = 2}
                            }
                        },
                    },
                },
            },
            ["[Food Processed] Pickled Goods"] = {
                [2] = {
                    [10] = {
                        _buildings = {"Distillery"},
                        _grade = 2,
                        _time = 126.0,
                        _productPair = {_id = "[Food Processed] Pickled Goods", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Food Raw] Vegetables", _amount = 5},
                                {_id = "[Food Raw] Mushrooms", _amount = 5},
                                {_id = "[Food Raw] Roots", _amount = 5},
                                {_id = "[Food Raw] Berries", _amount = 5},
                                {_id = "[Food Raw] Eggs", _amount = 5}
                            },
                            {
                                {_id = "[Vessel] Pottery", _amount = 3},
                                {_id = "[Vessel] Barrels", _amount = 3},
                                {_id = "[Vessel] Waterskin", _amount = 2}
                            }
                        },
                    },
                },
            },
        },
    },
    ["Druid"] = {
        _id = "Druid",
        _displayName = "Druid's Hut",
        _description = "Can produce:  <sprite name=[crafting] oil> Oil (<sprite name=grade3>), <sprite name=[needs] tea> Tea (<sprite name=grade2>), <sprite name=[needs] coats> Coats (<sprite name=grade1>). \nRain engine: <sprite name=\"[water] clearance water\"> Clearance Water.",
        _iconFilename = "Druid_icon.png",
        _category = "Industry",
        _categoryDisplay = "Production Building",
        _sizeX = 2,
        _sizeY = 2,
        _constructionTime = 30,
        _cityScore = 5,
        _isMovable = false,
        _isInitiallyEssential = false,
        _workerCapacity = 3,
        _constructionCosts = {
            {_id = "[Mat Processed] Planks", _amount = 5},
            {_id = "[Mat Processed] Fabric", _amount = 2}
        },
        _tags = {
            "Alchemy",
            "FoxesCooperation"
        },
        _storage = 8,
        _waterUsed = "[Water] Clearance Water",
        _recipes = {
            ["[Crafting] Oil"] = {
                [3] = {
                    [5] = {
                        _buildings = {"Druid"},
                        _grade = 3,
                        _time = 63.0,
                        _productPair = {_id = "[Crafting] Oil", _amount = 5},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Food Raw] Grain", _amount = 2},
                                {_id = "[Food Raw] Meat", _amount = 2},
                                {_id = "[Food Raw] Vegetables", _amount = 2},
                                {_id = "[Mat Raw] Plant Fibre", _amount = 2},
                                {_id = "[Food Raw] Fish", _amount = 2}
                            }
                        },
                    },
                },
            },
            ["[Needs] Tea"] = {
                [2] = {
                    [10] = {
                        _buildings = {"Druid"},
                        _grade = 2,
                        _time = 126.0,
                        _productPair = {_id = "[Needs] Tea", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Food Raw] Herbs", _amount = 3},
                                {_id = "[Crafting] Dye", _amount = 3},
                                {_id = "[Mat Raw] Resin", _amount = 3},
                                {_id = "[Food Raw] Mushrooms", _amount = 3},
                                {_id = "[Food Raw] Roots", _amount = 3}
                            },
                            {
                                {_id = "[Water] Drizzle Water", _amount = 3},
                                {_id = "[Water] Clearance Water", _amount = 4},
                                {_id = "[Water] Storm Water", _amount = 5}
                            },
                            {
                                {_id = "[Vessel] Pottery", _amount = 3},
                                {_id = "[Vessel] Barrels", _amount = 2},
                                {_id = "[Vessel] Waterskin", _amount = 3}
                            }
                        },
                    },
                },
            },
            ["[Needs] Coats"] = {
                [1] = {
                    [10] = {
                        _buildings = {"Druid"},
                        _grade = 1,
                        _time = 126.0,
                        _productPair = {_id = "[Needs] Coats", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Mat Processed] Fabric", _amount = 3},
                                {_id = "[Mat Raw] Leather", _amount = 3}
                            },
                            {
                                {_id = "[Crafting] Dye", _amount = 4},
                                {_id = "[Mat Raw] Resin", _amount = 4}
                            }
                        },
                    },
                },
            },
        },
    },
    ["Field Kitchen"] = {
        _id = "Field Kitchen",
        _displayName = "Field Kitchen",
        _description = "Can produce:  <sprite name=[food processed] skewers> Skewers (<sprite name=grade0>), <sprite name=[food processed] paste> Paste (<sprite name=grade0>), <sprite name=[food processed] biscuits> Biscuits (<sprite name=grade0>), <sprite name=[food processed] pickled goods> Pickled Goods (<sprite name=grade0>). \nRain engine: <sprite name=\"[water] drizzle water\"> Drizzle Water.",
        _iconFilename = "Field Kitchen_icon.png",
        _category = "Food Production",
        _categoryDisplay = "Production Building",
        _sizeX = 2,
        _sizeY = 2,
        _constructionTime = 20,
        _cityScore = 5,
        _isMovable = true,
        _isInitiallyEssential = false,
        _workerCapacity = 2,
        _constructionCosts = {
            {_id = "[Mat Processed] Planks", _amount = 2},
            {_id = "[Mat Processed] Fabric", _amount = 2}
        },
        _tags = {
            "FoxesCooperation"
        },
        _storage = 8,
        _waterUsed = "[Water] Drizzle Water",
        _recipes = {
            ["[Food Processed] Skewers"] = {
                [0] = {
                    [10] = {
                        _buildings = {"Field Kitchen"},
                        _grade = 0,
                        _time = 126.0,
                        _productPair = {_id = "[Food Processed] Skewers", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Food Raw] Insects", _amount = 5},
                                {_id = "[Food Raw] Meat", _amount = 5},
                                {_id = "[Food Raw] Mushrooms", _amount = 5},
                                {_id = "[Food Raw] Fish", _amount = 5},
                                {_id = "[Food Processed] Jerky", _amount = 4}
                            },
                            {
                                {_id = "[Food Raw] Vegetables", _amount = 5},
                                {_id = "[Food Raw] Roots", _amount = 5},
                                {_id = "[Food Raw] Berries", _amount = 5},
                                {_id = "[Food Raw] Eggs", _amount = 5}
                            }
                        },
                    },
                },
            },
            ["[Food Processed] Paste"] = {
                [0] = {
                    [10] = {
                        _buildings = {"Field Kitchen"},
                        _grade = 0,
                        _time = 126.0,
                        _productPair = {_id = "[Food Processed] Paste", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Crafting] Dye", _amount = 2},
                                {_id = "[Crafting] Salt", _amount = 3}
                            },
                            {
                                {_id = "[Food Raw] Eggs", _amount = 8},
                                {_id = "[Food Raw] Fish", _amount = 8},
                                {_id = "[Food Raw] Meat", _amount = 8}
                            }
                        },
                    },
                },
            },
            ["[Food Processed] Biscuits"] = {
                [0] = {
                    [10] = {
                        _buildings = {"Field Kitchen"},
                        _grade = 0,
                        _time = 110.0,
                        _productPair = {_id = "[Food Processed] Biscuits", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Crafting] Flour", _amount = 8}
                            },
                            {
                                {_id = "[Food Raw] Herbs", _amount = 4},
                                {_id = "[Food Raw] Berries", _amount = 4},
                                {_id = "[Food Raw] Roots", _amount = 4},
                                {_id = "[Food Raw] Eggs", _amount = 4},
                                {_id = "[Crafting] Salt", _amount = 4}
                            }
                        },
                    },
                },
            },
            ["[Food Processed] Pickled Goods"] = {
                [0] = {
                    [10] = {
                        _buildings = {"Field Kitchen"},
                        _grade = 0,
                        _time = 126.0,
                        _productPair = {_id = "[Food Processed] Pickled Goods", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Food Raw] Vegetables", _amount = 7},
                                {_id = "[Food Raw] Mushrooms", _amount = 7},
                                {_id = "[Food Raw] Roots", _amount = 7},
                                {_id = "[Food Raw] Berries", _amount = 7},
                                {_id = "[Food Raw] Eggs", _amount = 7}
                            },
                            {
                                {_id = "[Vessel] Pottery", _amount = 3},
                                {_id = "[Vessel] Barrels", _amount = 3},
                                {_id = "[Vessel] Waterskin", _amount = 3}
                            }
                        },
                    },
                },
            },
        },
    },
    ["Finesmith"] = {
        _id = "Finesmith",
        _displayName = "Finesmith",
        _description = "Can produce:  <sprite name=[valuable] amber> Amber (<sprite name=grade3>), <sprite name=[tools] simple tools> Tools (<sprite name=grade3>). \nRain engine: <sprite name=\"[water] storm water\"> Storm Water.",
        _iconFilename = "Finesmith_icon.png",
        _category = "Industry",
        _categoryDisplay = "Production Building",
        _sizeX = 3,
        _sizeY = 3,
        _constructionTime = 40,
        _cityScore = 10,
        _isMovable = false,
        _isInitiallyEssential = false,
        _workerCapacity = 3,
        _constructionCosts = {
            {_id = "[Mat Processed] Planks", _amount = 10},
            {_id = "[Mat Processed] Bricks", _amount = 10}
        },
        _tags = {
            "Metallurgy",
            "Tech",
            "FoxesCooperation"
        },
        _storage = 8,
        _waterUsed = "[Water] Storm Water",
        _recipes = {
            ["[Valuable] Amber"] = {
                [3] = {
                    [1] = {
                        _buildings = {"Finesmith"},
                        _grade = 3,
                        _time = 42.0,
                        _productPair = {_id = "[Valuable] Amber", _amount = 1},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Mat Raw] Resin", _amount = 3}
                            },
                            {
                                {_id = "[Water] Clearance Water", _amount = 10},
                                {_id = "[Crafting] Oil", _amount = 1}
                            }
                        },
                    },
                },
            },
            ["[Tools] Simple Tools"] = {
                [3] = {
                    [2] = {
                        _buildings = {"Finesmith"},
                        _grade = 3,
                        _time = 60.0,
                        _productPair = {_id = "[Tools] Simple Tools", _amount = 2},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Mat Raw] Wood", _amount = 6},
                                {_id = "[Mat Processed] Planks", _amount = 1}
                            },
                            {
                                {_id = "[Metal] Copper Bar", _amount = 2},
                                {_id = "[Metal] Crystalized Dew", _amount = 2}
                            }
                        },
                    },
                },
            },
        },
    },
    ["Flawless Brewery"] = {
        _id = "Flawless Brewery",
        _displayName = "Flawless Brewery",
        _description = "An upgraded production building with all recipes at the highest grade. Can produce:  <sprite name=[needs] ale> Ale (<sprite name=grade3>), <sprite name=[food processed] porridge> Porridge (<sprite name=grade3>), <sprite name=[packs] pack of crops> Pack of Crops (<sprite name=grade3>).\nRain engine: <sprite name=\"[water] drizzle water\"> Drizzle Water.",
        _iconFilename = "Flawless Brewery_icon.png",
        _category = "Industry",
        _categoryDisplay = "Production Building",
        _sizeX = 3,
        _sizeY = 3,
        _constructionTime = 50,
        _cityScore = 5,
        _isMovable = false,
        _isInitiallyEssential = false,
        _workerCapacity = 2,
        _constructionCosts = {
            {_id = "[Mat Processed] Planks", _amount = 2},
            {_id = "[Mat Processed] Bricks", _amount = 2},
            {_id = "[Mat Processed] Fabric", _amount = 2}
        },
        _tags = {
            "Brewing",
            "FoxesCooperation"
        },
        _storage = 8,
        _waterUsed = "[Water] Drizzle Water",
        _recipes = {
            ["[Needs] Ale"] = {
                [3] = {
                    [10] = {
                        _buildings = {"Flawless Brewery"},
                        _grade = 3,
                        _time = 105.0,
                        _productPair = {_id = "[Needs] Ale", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Food Raw] Grain", _amount = 4},
                                {_id = "[Food Raw] Roots", _amount = 4}
                            },
                            {
                                {_id = "[Vessel] Pottery", _amount = 2},
                                {_id = "[Vessel] Barrels", _amount = 1},
                                {_id = "[Vessel] Waterskin", _amount = 2}
                            }
                        },
                    },
                },
            },
            ["[Food Processed] Porridge"] = {
                [3] = {
                    [10] = {
                        _buildings = {"Flawless Brewery"},
                        _grade = 3,
                        _time = 105.0,
                        _productPair = {_id = "[Food Processed] Porridge", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Food Raw] Grain", _amount = 4},
                                {_id = "[Food Raw] Vegetables", _amount = 4},
                                {_id = "[Food Raw] Mushrooms", _amount = 4},
                                {_id = "[Food Raw] Herbs", _amount = 4},
                                {_id = "[Food Raw] Fish", _amount = 4}
                            },
                            {
                                {_id = "[Water] Drizzle Water", _amount = 6},
                                {_id = "[Water] Clearance Water", _amount = 8},
                                {_id = "[Water] Storm Water", _amount = 10}
                            }
                        },
                    },
                },
            },
            ["[Packs] Pack of Crops"] = {
                [3] = {
                    [2] = {
                        _buildings = {"Flawless Brewery"},
                        _grade = 3,
                        _time = 28.0,
                        _productPair = {_id = "[Packs] Pack of Crops", _amount = 2},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Food Raw] Roots", _amount = 3},
                                {_id = "[Food Raw] Grain", _amount = 3},
                                {_id = "[Food Raw] Vegetables", _amount = 3},
                                {_id = "[Food Raw] Mushrooms", _amount = 3}
                            }
                        },
                    },
                },
            },
        },
    },
    ["Flawless Cellar"] = {
        _id = "Flawless Cellar",
        _displayName = "Flawless Cellar",
        _description = "An upgraded production building with all recipes at the highest grade. Can produce:  <sprite name=[needs] wine> Wine (<sprite name=grade3>), <sprite name=[food processed] pickled goods> Pickled Goods (<sprite name=grade3>), <sprite name=[packs] pack of provisions> Pack of Provisions (<sprite name=grade3>).\nRain engine: <sprite name=\"[water] drizzle water\"> Drizzle Water.",
        _iconFilename = "Flawless Cellar_icon.png",
        _category = "Food Production",
        _categoryDisplay = "Production Building",
        _sizeX = 2,
        _sizeY = 2,
        _constructionTime = 50,
        _cityScore = 5,
        _isMovable = false,
        _isInitiallyEssential = false,
        _workerCapacity = 2,
        _constructionCosts = {
            {_id = "[Mat Processed] Bricks", _amount = 2},
            {_id = "[Mat Processed] Fabric", _amount = 2}
        },
        _tags = {
            "Brewing",
            "FoxesCooperation"
        },
        _storage = 8,
        _waterUsed = "[Water] Drizzle Water",
        _recipes = {
            ["[Needs] Wine"] = {
                [3] = {
                    [10] = {
                        _buildings = {"Flawless Cellar"},
                        _grade = 3,
                        _time = 63.0,
                        _productPair = {_id = "[Needs] Wine", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Food Raw] Berries", _amount = 2},
                                {_id = "[Food Raw] Mushrooms", _amount = 2},
                                {_id = "[Mat Raw] Reeds", _amount = 2}
                            },
                            {
                                {_id = "[Vessel] Pottery", _amount = 2},
                                {_id = "[Vessel] Barrels", _amount = 2},
                                {_id = "[Vessel] Waterskin", _amount = 2}
                            }
                        },
                    },
                },
            },
            ["[Food Processed] Pickled Goods"] = {
                [3] = {
                    [10] = {
                        _buildings = {"Flawless Cellar"},
                        _grade = 3,
                        _time = 105.0,
                        _productPair = {_id = "[Food Processed] Pickled Goods", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Food Raw] Vegetables", _amount = 4},
                                {_id = "[Food Raw] Mushrooms", _amount = 4},
                                {_id = "[Food Raw] Roots", _amount = 4},
                                {_id = "[Food Raw] Berries", _amount = 4},
                                {_id = "[Food Raw] Eggs", _amount = 4}
                            },
                            {
                                {_id = "[Vessel] Pottery", _amount = 3},
                                {_id = "[Vessel] Barrels", _amount = 3},
                                {_id = "[Vessel] Waterskin", _amount = 2}
                            }
                        },
                    },
                },
            },
            ["[Packs] Pack of Provisions"] = {
                [3] = {
                    [3] = {
                        _buildings = {"Flawless Cellar"},
                        _grade = 3,
                        _time = 28.0,
                        _productPair = {_id = "[Packs] Pack of Provisions", _amount = 3},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Food Raw] Herbs", _amount = 3},
                                {_id = "[Food Raw] Berries", _amount = 3},
                                {_id = "[Food Raw] Insects", _amount = 3},
                                {_id = "[Food Raw] Meat", _amount = 3},
                                {_id = "[Food Raw] Eggs", _amount = 3},
                                {_id = "[Food Raw] Fish", _amount = 3}
                            }
                        },
                    },
                },
            },
        },
    },
    ["Flawless Cooperage"] = {
        _id = "Flawless Cooperage",
        _displayName = "Flawless Cooperage",
        _description = "An upgraded production building with all recipes at the highest grade. Can produce:  <sprite name=[vessel] barrels> Barrels (<sprite name=grade3>), <sprite name=[needs] coats> Coats (<sprite name=grade3>), <sprite name=[packs] pack of luxury goods> Pack of Luxury Goods (<sprite name=grade3>).\nRain engine: <sprite name=\"[water] clearance water\"> Clearance Water.",
        _iconFilename = "Flawless Cooperage_icon.png",
        _category = "Industry",
        _categoryDisplay = "Production Building",
        _sizeX = 3,
        _sizeY = 2,
        _constructionTime = 40,
        _cityScore = 5,
        _isMovable = false,
        _isInitiallyEssential = false,
        _workerCapacity = 2,
        _constructionCosts = {
            {_id = "[Mat Processed] Planks", _amount = 5},
            {_id = "[Mat Processed] Bricks", _amount = 2}
        },
        _tags = {
            "Wood",
            "FoxesCooperation",
            "Metallurgy"
        },
        _storage = 8,
        _waterUsed = "[Water] Clearance Water",
        _recipes = {
            ["[Vessel] Barrels"] = {
                [3] = {
                    [10] = {
                        _buildings = {"Flawless Cooperage"},
                        _grade = 3,
                        _time = 105.0,
                        _productPair = {_id = "[Vessel] Barrels", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Metal] Copper Bar", _amount = 1},
                                {_id = "[Metal] Crystalized Dew", _amount = 1}
                            },
                            {
                                {_id = "[Mat Processed] Planks", _amount = 2}
                            }
                        },
                    },
                },
            },
            ["[Needs] Coats"] = {
                [3] = {
                    [10] = {
                        _buildings = {"Flawless Cooperage"},
                        _grade = 3,
                        _time = 105.0,
                        _productPair = {_id = "[Needs] Coats", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Mat Processed] Fabric", _amount = 1},
                                {_id = "[Mat Raw] Leather", _amount = 1}
                            },
                            {
                                {_id = "[Crafting] Dye", _amount = 2},
                                {_id = "[Mat Raw] Resin", _amount = 2}
                            }
                        },
                    },
                },
            },
            ["[Packs] Pack of Luxury Goods"] = {
                [3] = {
                    [2] = {
                        _buildings = {"Flawless Cooperage"},
                        _grade = 3,
                        _time = 28.0,
                        _productPair = {_id = "[Packs] Pack of Luxury Goods", _amount = 2},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Needs] Wine", _amount = 3},
                                {_id = "[Needs] Training Gear", _amount = 3},
                                {_id = "[Needs] Incense", _amount = 3},
                                {_id = "[Needs] Scrolls", _amount = 3},
                                {_id = "[Needs] Ale", _amount = 3},
                                {_id = "[Needs] Tea", _amount = 3}
                            }
                        },
                    },
                },
            },
        },
    },
    ["Flawless Druid"] = {
        _id = "Flawless Druid",
        _displayName = "Flawless Druid's Hut",
        _description = "An upgraded production building with all recipes at the highest grade. Can produce:  <sprite name=[crafting] oil> Oil (<sprite name=grade3>), <sprite name=[needs] tea> Tea (<sprite name=grade3>), <sprite name=[needs] coats> Coats (<sprite name=grade3>).\nRain engine: <sprite name=\"[water] clearance water\"> Clearance Water.",
        _iconFilename = "Flawless Druid_icon.png",
        _category = "Industry",
        _categoryDisplay = "Production Building",
        _sizeX = 2,
        _sizeY = 2,
        _constructionTime = 30,
        _cityScore = 5,
        _isMovable = false,
        _isInitiallyEssential = false,
        _workerCapacity = 3,
        _constructionCosts = {
            {_id = "[Mat Processed] Planks", _amount = 5},
            {_id = "[Mat Processed] Fabric", _amount = 2}
        },
        _tags = {
            "Alchemy",
            "FoxesCooperation"
        },
        _storage = 8,
        _waterUsed = "[Water] Clearance Water",
        _recipes = {
            ["[Crafting] Oil"] = {
                [3] = {
                    [5] = {
                        _buildings = {"Flawless Druid"},
                        _grade = 3,
                        _time = 63.0,
                        _productPair = {_id = "[Crafting] Oil", _amount = 5},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Food Raw] Grain", _amount = 2},
                                {_id = "[Food Raw] Meat", _amount = 2},
                                {_id = "[Food Raw] Vegetables", _amount = 2},
                                {_id = "[Mat Raw] Plant Fibre", _amount = 2},
                                {_id = "[Food Raw] Fish", _amount = 2}
                            }
                        },
                    },
                },
            },
            ["[Needs] Tea"] = {
                [3] = {
                    [10] = {
                        _buildings = {"Flawless Druid"},
                        _grade = 3,
                        _time = 105.0,
                        _productPair = {_id = "[Needs] Tea", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Food Raw] Herbs", _amount = 2},
                                {_id = "[Crafting] Dye", _amount = 2},
                                {_id = "[Mat Raw] Resin", _amount = 2},
                                {_id = "[Food Raw] Mushrooms", _amount = 2},
                                {_id = "[Food Raw] Roots", _amount = 2}
                            },
                            {
                                {_id = "[Water] Drizzle Water", _amount = 2},
                                {_id = "[Water] Clearance Water", _amount = 3},
                                {_id = "[Water] Storm Water", _amount = 4}
                            },
                            {
                                {_id = "[Vessel] Pottery", _amount = 2},
                                {_id = "[Vessel] Barrels", _amount = 1},
                                {_id = "[Vessel] Waterskin", _amount = 2}
                            }
                        },
                    },
                },
            },
            ["[Needs] Coats"] = {
                [3] = {
                    [10] = {
                        _buildings = {"Flawless Druid"},
                        _grade = 3,
                        _time = 105.0,
                        _productPair = {_id = "[Needs] Coats", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Mat Processed] Fabric", _amount = 1},
                                {_id = "[Mat Raw] Leather", _amount = 1}
                            },
                            {
                                {_id = "[Crafting] Dye", _amount = 2},
                                {_id = "[Mat Raw] Resin", _amount = 2}
                            }
                        },
                    },
                },
            },
        },
    },
    ["Flawless Leatherworks"] = {
        _id = "Flawless Leatherworks",
        _displayName = "Flawless Leatherworker",
        _description = "An upgraded production building with all recipes at the highest grade. Can produce:  <sprite name=[vessel] waterskin> Waterskins (<sprite name=grade3>), <sprite name=[needs] boots> Boots (<sprite name=grade3>), <sprite name=[needs] training gear> Training Gear (<sprite name=grade3>).\nRain engine: <sprite name=\"[water] clearance water\"> Clearance Water.",
        _iconFilename = "Flawless Leatherworks_icon.png",
        _category = "Industry",
        _categoryDisplay = "Production Building",
        _sizeX = 3,
        _sizeY = 3,
        _constructionTime = 25,
        _cityScore = 5,
        _isMovable = false,
        _isInitiallyEssential = false,
        _workerCapacity = 2,
        _constructionCosts = {
            {_id = "[Mat Processed] Bricks", _amount = 2},
            {_id = "[Mat Processed] Fabric", _amount = 2}
        },
        _tags = {
            "Cloth",
            "Animals",
            "FoxesCooperation"
        },
        _storage = 8,
        _waterUsed = "[Water] Clearance Water",
        _recipes = {
            ["[Vessel] Waterskin"] = {
                [3] = {
                    [10] = {
                        _buildings = {"Flawless Leatherworks"},
                        _grade = 3,
                        _time = 63.0,
                        _productPair = {_id = "[Vessel] Waterskin", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Mat Raw] Leather", _amount = 4},
                                {_id = "[Mat Raw] Scales", _amount = 4}
                            },
                            {
                                {_id = "[Crafting] Oil", _amount = 2},
                                {_id = "[Food Raw] Meat", _amount = 2},
                                {_id = "[Crafting] Salt", _amount = 2}
                            }
                        },
                    },
                },
            },
            ["[Needs] Boots"] = {
                [3] = {
                    [10] = {
                        _buildings = {"Flawless Leatherworks"},
                        _grade = 3,
                        _time = 126.0,
                        _productPair = {_id = "[Needs] Boots", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Mat Raw] Leather", _amount = 3},
                                {_id = "[Mat Raw] Scales", _amount = 3}
                            }
                        },
                    },
                },
            },
            ["[Needs] Training Gear"] = {
                [3] = {
                    [10] = {
                        _buildings = {"Flawless Leatherworks"},
                        _grade = 3,
                        _time = 105.0,
                        _productPair = {_id = "[Needs] Training Gear", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Mat Raw] Stone", _amount = 3},
                                {_id = "[Metal] Copper Bar", _amount = 1},
                                {_id = "[Metal] Crystalized Dew", _amount = 1}
                            },
                            {
                                {_id = "[Mat Processed] Planks", _amount = 2},
                                {_id = "[Mat Raw] Reeds", _amount = 2},
                                {_id = "[Mat Raw] Leather", _amount = 2}
                            }
                        },
                    },
                },
            },
        },
    },
    ["Flawless Rain Mill"] = {
        _id = "Flawless Rain Mill",
        _displayName = "Flawless Rain Mill",
        _description = "An upgraded production building with all recipes at the highest grade. Can produce:  <sprite name=[crafting] flour> Flour (<sprite name=grade3>), <sprite name=[needs] scrolls> Scrolls (<sprite name=grade3>), <sprite name=[food processed] paste> Paste (<sprite name=grade3>).\nRain engine: <sprite name=\"[water] clearance water\"> Clearance Water.",
        _iconFilename = "Flawless Rain Mill_icon.png",
        _category = "Food Production",
        _categoryDisplay = "Production Building",
        _sizeX = 3,
        _sizeY = 2,
        _constructionTime = 20,
        _cityScore = 5,
        _isMovable = false,
        _isInitiallyEssential = false,
        _workerCapacity = 3,
        _constructionCosts = {
            {_id = "[Mat Processed] Planks", _amount = 5},
            {_id = "[Mat Processed] Fabric", _amount = 2}
        },
        _tags = {
            "Tech",
            "Farming",
            "FoxesCooperation"
        },
        _storage = 8,
        _waterUsed = "[Water] Clearance Water",
        _recipes = {
            ["[Crafting] Flour"] = {
                [3] = {
                    [10] = {
                        _buildings = {"Flawless Rain Mill"},
                        _grade = 3,
                        _time = 63.0,
                        _productPair = {_id = "[Crafting] Flour", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Food Raw] Grain", _amount = 5},
                                {_id = "[Food Raw] Mushrooms", _amount = 5},
                                {_id = "[Food Raw] Roots", _amount = 5},
                                {_id = "[Mat Raw] Algae", _amount = 5}
                            }
                        },
                    },
                },
            },
            ["[Needs] Scrolls"] = {
                [3] = {
                    [8] = {
                        _buildings = {"Flawless Rain Mill"},
                        _grade = 3,
                        _time = 63.0,
                        _productPair = {_id = "[Needs] Scrolls", _amount = 8},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Mat Raw] Leather", _amount = 2},
                                {_id = "[Mat Raw] Plant Fibre", _amount = 2},
                                {_id = "[Mat Raw] Wood", _amount = 6}
                            },
                            {
                                {_id = "[Crafting] Dye", _amount = 1},
                                {_id = "[Needs] Wine", _amount = 1}
                            }
                        },
                    },
                },
            },
            ["[Food Processed] Paste"] = {
                [3] = {
                    [10] = {
                        _buildings = {"Flawless Rain Mill"},
                        _grade = 3,
                        _time = 105.0,
                        _productPair = {_id = "[Food Processed] Paste", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Crafting] Dye", _amount = 2},
                                {_id = "[Crafting] Salt", _amount = 3}
                            },
                            {
                                {_id = "[Food Raw] Eggs", _amount = 4},
                                {_id = "[Food Raw] Fish", _amount = 4},
                                {_id = "[Food Raw] Meat", _amount = 4}
                            }
                        },
                    },
                },
            },
        },
    },
    ["Flawless Smelter"] = {
        _id = "Flawless Smelter",
        _displayName = "Flawless Smelter",
        _description = "An upgraded production building with all recipes at the highest grade. Can produce:  <sprite name=[metal] copper bar> Copper Bars (<sprite name=grade3>), <sprite name=[needs] training gear> Training Gear (<sprite name=grade3>), <sprite name=[food processed] pie> Pie (<sprite name=grade3>).\nRain engine: <sprite name=\"[water] storm water\"> Storm Water.",
        _iconFilename = "Flawless Smelter_icon.png",
        _category = "Industry",
        _categoryDisplay = "Production Building",
        _sizeX = 3,
        _sizeY = 3,
        _constructionTime = 40,
        _cityScore = 5,
        _isMovable = false,
        _isInitiallyEssential = false,
        _workerCapacity = 3,
        _constructionCosts = {
            {_id = "[Mat Processed] Bricks", _amount = 4}
        },
        _tags = {
            "Metallurgy",
            "Warmth",
            "FoxesCooperation"
        },
        _storage = 8,
        _waterUsed = "[Water] Storm Water",
        _recipes = {
            ["[Metal] Copper Bar"] = {
                [3] = {
                    [2] = {
                        _buildings = {"Flawless Smelter"},
                        _grade = 3,
                        _time = 28.0,
                        _productPair = {_id = "[Metal] Copper Bar", _amount = 2},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Metal] Copper Ore", _amount = 4},
                                {_id = "[Mat Raw] Scales", _amount = 4}
                            },
                            {
                                {_id = "[Mat Raw] Wood", _amount = 5},
                                {_id = "[Crafting] Oil", _amount = 2},
                                {_id = "[Crafting] Coal", _amount = 1},
                                {_id = "[Crafting] Sea Marrow", _amount = 1}
                            }
                        },
                    },
                },
            },
            ["[Needs] Training Gear"] = {
                [3] = {
                    [10] = {
                        _buildings = {"Flawless Smelter"},
                        _grade = 3,
                        _time = 105.0,
                        _productPair = {_id = "[Needs] Training Gear", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Mat Raw] Stone", _amount = 3},
                                {_id = "[Metal] Copper Bar", _amount = 1},
                                {_id = "[Metal] Crystalized Dew", _amount = 1}
                            },
                            {
                                {_id = "[Mat Processed] Planks", _amount = 2},
                                {_id = "[Mat Raw] Reeds", _amount = 2},
                                {_id = "[Mat Raw] Leather", _amount = 2}
                            }
                        },
                    },
                },
            },
            ["[Food Processed] Pie"] = {
                [3] = {
                    [10] = {
                        _buildings = {"Flawless Smelter"},
                        _grade = 3,
                        _time = 105.0,
                        _productPair = {_id = "[Food Processed] Pie", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Crafting] Flour", _amount = 6}
                            },
                            {
                                {_id = "[Food Raw] Herbs", _amount = 3},
                                {_id = "[Food Raw] Meat", _amount = 3},
                                {_id = "[Food Raw] Insects", _amount = 3},
                                {_id = "[Food Raw] Berries", _amount = 3},
                                {_id = "[Food Raw] Fish", _amount = 3}
                            }
                        },
                    },
                },
            },
        },
    },
    ["Furnace"] = {
        _id = "Furnace",
        _displayName = "Furnace",
        _description = "Can produce:  <sprite name=[food processed] pie> Pie (<sprite name=grade2>), <sprite name=[food processed] skewers> Skewers (<sprite name=grade2>), <sprite name=[metal] copper bar> Copper Bars (<sprite name=grade2>). \nRain engine: <sprite name=\"[water] drizzle water\"> Drizzle Water.",
        _iconFilename = "Furnace_icon.png",
        _category = "Food Production",
        _categoryDisplay = "Production Building",
        _sizeX = 3,
        _sizeY = 2,
        _constructionTime = 40,
        _cityScore = 5,
        _isMovable = false,
        _isInitiallyEssential = false,
        _workerCapacity = 3,
        _constructionCosts = {
            {_id = "[Mat Processed] Planks", _amount = 5},
            {_id = "[Mat Processed] Bricks", _amount = 2}
        },
        _tags = {
            "Metallurgy",
            "Warmth",
            "FoxesCooperation"
        },
        _storage = 8,
        _waterUsed = "[Water] Drizzle Water",
        _recipes = {
            ["[Food Processed] Pie"] = {
                [2] = {
                    [10] = {
                        _buildings = {"Furnace"},
                        _grade = 2,
                        _time = 126.0,
                        _productPair = {_id = "[Food Processed] Pie", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Crafting] Flour", _amount = 6}
                            },
                            {
                                {_id = "[Food Raw] Herbs", _amount = 4},
                                {_id = "[Food Raw] Meat", _amount = 4},
                                {_id = "[Food Raw] Insects", _amount = 4},
                                {_id = "[Food Raw] Berries", _amount = 4},
                                {_id = "[Food Raw] Fish", _amount = 4}
                            }
                        },
                    },
                },
            },
            ["[Food Processed] Skewers"] = {
                [2] = {
                    [10] = {
                        _buildings = {"Furnace"},
                        _grade = 2,
                        _time = 126.0,
                        _productPair = {_id = "[Food Processed] Skewers", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Food Raw] Insects", _amount = 3},
                                {_id = "[Food Raw] Meat", _amount = 3},
                                {_id = "[Food Raw] Mushrooms", _amount = 3},
                                {_id = "[Food Raw] Fish", _amount = 3},
                                {_id = "[Food Processed] Jerky", _amount = 2}
                            },
                            {
                                {_id = "[Food Raw] Vegetables", _amount = 4},
                                {_id = "[Food Raw] Roots", _amount = 4},
                                {_id = "[Food Raw] Berries", _amount = 4},
                                {_id = "[Food Raw] Eggs", _amount = 4}
                            }
                        },
                    },
                },
            },
            ["[Metal] Copper Bar"] = {
                [2] = {
                    [2] = {
                        _buildings = {"Furnace"},
                        _grade = 2,
                        _time = 42.0,
                        _productPair = {_id = "[Metal] Copper Bar", _amount = 2},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Metal] Copper Ore", _amount = 5},
                                {_id = "[Mat Raw] Scales", _amount = 5}
                            },
                            {
                                {_id = "[Mat Raw] Wood", _amount = 5},
                                {_id = "[Crafting] Oil", _amount = 2},
                                {_id = "[Crafting] Coal", _amount = 1},
                                {_id = "[Crafting] Sea Marrow", _amount = 1}
                            }
                        },
                    },
                },
            },
        },
    },
    ["Granary"] = {
        _id = "Granary",
        _displayName = "Granary",
        _description = "Can produce:  <sprite name=[food processed] pickled goods> Pickled Goods (<sprite name=grade2>), <sprite name=[mat processed] fabric> Fabric (<sprite name=grade2>), <sprite name=[packs] pack of crops> Pack of Crops (<sprite name=grade2>). \nRain engine: <sprite name=\"[water] drizzle water\"> Drizzle Water.",
        _iconFilename = "Granary_icon.png",
        _category = "Food Production",
        _categoryDisplay = "Production Building",
        _sizeX = 2,
        _sizeY = 2,
        _constructionTime = 30,
        _cityScore = 5,
        _isMovable = false,
        _isInitiallyEssential = false,
        _workerCapacity = 3,
        _constructionCosts = {
            {_id = "[Mat Processed] Planks", _amount = 5},
            {_id = "[Mat Processed] Fabric", _amount = 2}
        },
        _tags = {
            "Farming",
            "FoxesCooperation"
        },
        _storage = 8,
        _waterUsed = "[Water] Drizzle Water",
        _recipes = {
            ["[Food Processed] Pickled Goods"] = {
                [2] = {
                    [10] = {
                        _buildings = {"Granary"},
                        _grade = 2,
                        _time = 126.0,
                        _productPair = {_id = "[Food Processed] Pickled Goods", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Food Raw] Vegetables", _amount = 5},
                                {_id = "[Food Raw] Mushrooms", _amount = 5},
                                {_id = "[Food Raw] Roots", _amount = 5},
                                {_id = "[Food Raw] Berries", _amount = 5},
                                {_id = "[Food Raw] Eggs", _amount = 5}
                            },
                            {
                                {_id = "[Vessel] Pottery", _amount = 3},
                                {_id = "[Vessel] Barrels", _amount = 3},
                                {_id = "[Vessel] Waterskin", _amount = 2}
                            }
                        },
                    },
                },
            },
            ["[Mat Processed] Fabric"] = {
                [2] = {
                    [2] = {
                        _buildings = {"Granary"},
                        _grade = 2,
                        _time = 42.0,
                        _productPair = {_id = "[Mat Processed] Fabric", _amount = 2},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Mat Raw] Plant Fibre", _amount = 3},
                                {_id = "[Mat Raw] Reeds", _amount = 3},
                                {_id = "[Mat Raw] Algae", _amount = 3}
                            }
                        },
                    },
                },
            },
            ["[Packs] Pack of Crops"] = {
                [2] = {
                    [2] = {
                        _buildings = {"Granary"},
                        _grade = 2,
                        _time = 42.0,
                        _productPair = {_id = "[Packs] Pack of Crops", _amount = 2},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Food Raw] Roots", _amount = 4},
                                {_id = "[Food Raw] Grain", _amount = 4},
                                {_id = "[Food Raw] Vegetables", _amount = 4},
                                {_id = "[Food Raw] Mushrooms", _amount = 4}
                            }
                        },
                    },
                },
            },
        },
    },
    ["Greenhouse Workshop"] = {
        _id = "Greenhouse Workshop",
        _displayName = "Greenhouse",
        _description = "Uses Drizzle Water to grow crops regardless of the season. Must be placed on fertile soil. Can produce:  <sprite name=[food raw] mushrooms> Mushrooms (<sprite name=grade2>), <sprite name=[food raw] herbs> Herbs (<sprite name=grade2>)",
        _iconFilename = "Greenhouse Workshop_icon.png",
        _category = "Food Production",
        _categoryDisplay = "Production Building",
        _sizeX = 2,
        _sizeY = 2,
        _constructionTime = 30,
        _cityScore = 5,
        _isMovable = false,
        _isInitiallyEssential = false,
        _workerCapacity = 3,
        _constructionCosts = {
            {_id = "[Mat Processed] Bricks", _amount = 2},
            {_id = "[Mat Processed] Fabric", _amount = 2}
        },
        _tags = {
            "Farming",
            "FoxesCooperation"
        },
        _storage = 8,
        _waterUsed = "None",
        _recipes = {
            ["[Food Raw] Mushrooms"] = {
                [2] = {
                    [4] = {
                        _buildings = {"Greenhouse Workshop"},
                        _grade = 2,
                        _time = 84.0,
                        _productPair = {_id = "[Food Raw] Mushrooms", _amount = 4},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Water] Drizzle Water", _amount = 4}
                            }
                        },
                    },
                },
            },
            ["[Food Raw] Herbs"] = {
                [2] = {
                    [4] = {
                        _buildings = {"Greenhouse Workshop"},
                        _grade = 2,
                        _time = 84.0,
                        _productPair = {_id = "[Food Raw] Herbs", _amount = 4},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Water] Drizzle Water", _amount = 4}
                            }
                        },
                    },
                },
            },
        },
    },
    ["Grill"] = {
        _id = "Grill",
        _displayName = "Grill",
        _description = "Can produce:  <sprite name=[food processed] skewers> Skewers (<sprite name=grade3>), <sprite name=[food processed] paste> Paste (<sprite name=grade2>), <sprite name=[metal] copper bar> Copper Bars (<sprite name=grade1>). \nRain engine: <sprite name=\"[water] drizzle water\"> Drizzle Water.",
        _iconFilename = "Grill_icon.png",
        _category = "Food Production",
        _categoryDisplay = "Production Building",
        _sizeX = 3,
        _sizeY = 2,
        _constructionTime = 40,
        _cityScore = 5,
        _isMovable = false,
        _isInitiallyEssential = false,
        _workerCapacity = 3,
        _constructionCosts = {
            {_id = "[Mat Processed] Planks", _amount = 5},
            {_id = "[Mat Processed] Bricks", _amount = 2}
        },
        _tags = {
            "Animals",
            "Warmth",
            "FoxesCooperation"
        },
        _storage = 8,
        _waterUsed = "[Water] Drizzle Water",
        _recipes = {
            ["[Food Processed] Skewers"] = {
                [3] = {
                    [10] = {
                        _buildings = {"Grill"},
                        _grade = 3,
                        _time = 105.0,
                        _productPair = {_id = "[Food Processed] Skewers", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Food Raw] Insects", _amount = 2},
                                {_id = "[Food Raw] Meat", _amount = 2},
                                {_id = "[Food Raw] Mushrooms", _amount = 2},
                                {_id = "[Food Raw] Fish", _amount = 2},
                                {_id = "[Food Processed] Jerky", _amount = 1}
                            },
                            {
                                {_id = "[Food Raw] Vegetables", _amount = 3},
                                {_id = "[Food Raw] Roots", _amount = 3},
                                {_id = "[Food Raw] Berries", _amount = 3},
                                {_id = "[Food Raw] Eggs", _amount = 3}
                            }
                        },
                    },
                },
            },
            ["[Food Processed] Paste"] = {
                [2] = {
                    [10] = {
                        _buildings = {"Grill"},
                        _grade = 2,
                        _time = 126.0,
                        _productPair = {_id = "[Food Processed] Paste", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Crafting] Dye", _amount = 2},
                                {_id = "[Crafting] Salt", _amount = 3}
                            },
                            {
                                {_id = "[Food Raw] Eggs", _amount = 5},
                                {_id = "[Food Raw] Fish", _amount = 5},
                                {_id = "[Food Raw] Meat", _amount = 5}
                            }
                        },
                    },
                },
            },
            ["[Metal] Copper Bar"] = {
                [1] = {
                    [2] = {
                        _buildings = {"Grill"},
                        _grade = 1,
                        _time = 42.0,
                        _productPair = {_id = "[Metal] Copper Bar", _amount = 2},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Metal] Copper Ore", _amount = 6},
                                {_id = "[Mat Raw] Scales", _amount = 6}
                            },
                            {
                                {_id = "[Mat Raw] Wood", _amount = 5},
                                {_id = "[Crafting] Oil", _amount = 2},
                                {_id = "[Crafting] Coal", _amount = 1},
                                {_id = "[Crafting] Sea Marrow", _amount = 1}
                            }
                        },
                    },
                },
            },
        },
    },
    ["Kiln"] = {
        _id = "Kiln",
        _displayName = "Kiln",
        _description = "Can produce:  <sprite name=[crafting] coal> Coal (<sprite name=grade3>), <sprite name=[mat processed] bricks> Bricks (<sprite name=grade1>), <sprite name=[food processed] jerky> Jerky (<sprite name=grade1>). \nRain engine: <sprite name=\"[water] storm water\"> Storm Water.",
        _iconFilename = "Kiln_icon.png",
        _category = "Industry",
        _categoryDisplay = "Production Building",
        _sizeX = 2,
        _sizeY = 2,
        _constructionTime = 40,
        _cityScore = 5,
        _isMovable = false,
        _isInitiallyEssential = false,
        _workerCapacity = 3,
        _constructionCosts = {
            {_id = "[Mat Processed] Bricks", _amount = 4}
        },
        _tags = {
            "Warmth",
            "Stone",
            "FoxesCooperation"
        },
        _storage = 8,
        _waterUsed = "[Water] Storm Water",
        _recipes = {
            ["[Crafting] Coal"] = {
                [3] = {
                    [5] = {
                        _buildings = {"Kiln"},
                        _grade = 3,
                        _time = 84.0,
                        _productPair = {_id = "[Crafting] Coal", _amount = 5},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Mat Raw] Wood", _amount = 10},
                                {_id = "[Mat Raw] Algae", _amount = 4}
                            }
                        },
                    },
                },
            },
            ["[Mat Processed] Bricks"] = {
                [1] = {
                    [2] = {
                        _buildings = {"Kiln"},
                        _grade = 1,
                        _time = 42.0,
                        _productPair = {_id = "[Mat Processed] Bricks", _amount = 2},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Mat Raw] Clay", _amount = 4},
                                {_id = "[Mat Raw] Stone", _amount = 4}
                            }
                        },
                    },
                },
            },
            ["[Food Processed] Jerky"] = {
                [1] = {
                    [10] = {
                        _buildings = {"Kiln"},
                        _grade = 1,
                        _time = 126.0,
                        _productPair = {_id = "[Food Processed] Jerky", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Food Raw] Insects", _amount = 6},
                                {_id = "[Food Raw] Meat", _amount = 6}
                            },
                            {
                                {_id = "[Mat Raw] Wood", _amount = 5},
                                {_id = "[Crafting] Oil", _amount = 2},
                                {_id = "[Crafting] Salt", _amount = 2},
                                {_id = "[Crafting] Coal", _amount = 1},
                                {_id = "[Crafting] Sea Marrow", _amount = 1}
                            }
                        },
                    },
                },
            },
        },
    },
    ["Leatherworks"] = {
        _id = "Leatherworks",
        _displayName = "Leatherworker",
        _description = "Can produce:  <sprite name=[vessel] waterskin> Waterskins (<sprite name=grade3>), <sprite name=[needs] boots> Boots (<sprite name=grade2>), <sprite name=[needs] training gear> Training Gear (<sprite name=grade1>). \nRain engine: <sprite name=\"[water] clearance water\"> Clearance Water.",
        _iconFilename = "Leatherworks_icon.png",
        _category = "Industry",
        _categoryDisplay = "Production Building",
        _sizeX = 3,
        _sizeY = 3,
        _constructionTime = 25,
        _cityScore = 5,
        _isMovable = false,
        _isInitiallyEssential = false,
        _workerCapacity = 2,
        _constructionCosts = {
            {_id = "[Mat Processed] Bricks", _amount = 2},
            {_id = "[Mat Processed] Fabric", _amount = 2}
        },
        _tags = {
            "Cloth",
            "Animals",
            "FoxesCooperation"
        },
        _storage = 8,
        _waterUsed = "[Water] Clearance Water",
        _recipes = {
            ["[Vessel] Waterskin"] = {
                [3] = {
                    [10] = {
                        _buildings = {"Leatherworks"},
                        _grade = 3,
                        _time = 63.0,
                        _productPair = {_id = "[Vessel] Waterskin", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Mat Raw] Leather", _amount = 4},
                                {_id = "[Mat Raw] Scales", _amount = 4}
                            },
                            {
                                {_id = "[Crafting] Oil", _amount = 2},
                                {_id = "[Food Raw] Meat", _amount = 2},
                                {_id = "[Crafting] Salt", _amount = 2}
                            }
                        },
                    },
                },
            },
            ["[Needs] Boots"] = {
                [2] = {
                    [10] = {
                        _buildings = {"Leatherworks"},
                        _grade = 2,
                        _time = 168.0,
                        _productPair = {_id = "[Needs] Boots", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Mat Raw] Leather", _amount = 4},
                                {_id = "[Mat Raw] Scales", _amount = 4}
                            }
                        },
                    },
                },
            },
            ["[Needs] Training Gear"] = {
                [1] = {
                    [10] = {
                        _buildings = {"Leatherworks"},
                        _grade = 1,
                        _time = 126.0,
                        _productPair = {_id = "[Needs] Training Gear", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Mat Raw] Stone", _amount = 8},
                                {_id = "[Metal] Copper Bar", _amount = 3},
                                {_id = "[Metal] Crystalized Dew", _amount = 3}
                            },
                            {
                                {_id = "[Mat Processed] Planks", _amount = 3},
                                {_id = "[Mat Raw] Reeds", _amount = 3},
                                {_id = "[Mat Raw] Leather", _amount = 3}
                            }
                        },
                    },
                },
            },
        },
    },
    ["Lumbermill"] = {
        _id = "Lumbermill",
        _displayName = "Lumber Mill",
        _description = "Can produce:  <sprite name=[mat processed] planks> Planks (<sprite name=grade3>), <sprite name=[needs] scrolls> Scrolls (<sprite name=grade1>), <sprite name=[packs] pack of trade goods> Pack of Trade Goods (<sprite name=grade1>). \nRain engine: <sprite name=\"[water] storm water\"> Storm Water.",
        _iconFilename = "Lumbermill_icon.png",
        _category = "Industry",
        _categoryDisplay = "Production Building",
        _sizeX = 3,
        _sizeY = 2,
        _constructionTime = 25,
        _cityScore = 5,
        _isMovable = false,
        _isInitiallyEssential = false,
        _workerCapacity = 2,
        _constructionCosts = {
            {_id = "[Mat Processed] Bricks", _amount = 2},
            {_id = "[Mat Processed] Fabric", _amount = 2}
        },
        _tags = {
            "Wood",
            "FoxesCooperation"
        },
        _storage = 8,
        _waterUsed = "[Water] Storm Water",
        _recipes = {
            ["[Mat Processed] Planks"] = {
                [3] = {
                    [2] = {
                        _buildings = {"Lumbermill"},
                        _grade = 3,
                        _time = 28.0,
                        _productPair = {_id = "[Mat Processed] Planks", _amount = 2},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Mat Raw] Wood", _amount = 3}
                            }
                        },
                    },
                },
            },
            ["[Needs] Scrolls"] = {
                [1] = {
                    [8] = {
                        _buildings = {"Lumbermill"},
                        _grade = 1,
                        _time = 84.0,
                        _productPair = {_id = "[Needs] Scrolls", _amount = 8},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Mat Raw] Leather", _amount = 4},
                                {_id = "[Mat Raw] Plant Fibre", _amount = 4},
                                {_id = "[Mat Raw] Wood", _amount = 10}
                            },
                            {
                                {_id = "[Crafting] Dye", _amount = 3},
                                {_id = "[Needs] Wine", _amount = 3}
                            }
                        },
                    },
                },
            },
            ["[Packs] Pack of Trade Goods"] = {
                [1] = {
                    [2] = {
                        _buildings = {"Lumbermill"},
                        _grade = 1,
                        _time = 42.0,
                        _productPair = {_id = "[Packs] Pack of Trade Goods", _amount = 2},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Crafting] Dye", _amount = 8},
                                {_id = "[Crafting] Oil", _amount = 8},
                                {_id = "[Crafting] Flour", _amount = 6},
                                {_id = "[Vessel] Pottery", _amount = 6},
                                {_id = "[Vessel] Barrels", _amount = 6},
                                {_id = "[Vessel] Waterskin", _amount = 6}
                            }
                        },
                    },
                },
            },
        },
    },
    ["Makeshift Post"] = {
        _id = "Makeshift Post",
        _displayName = "Makeshift Post",
        _description = "Can produce:  <sprite name=[packs] pack of crops> Pack of Crops (<sprite name=grade0>), <sprite name=[packs] pack of provisions> Pack of Provisions (<sprite name=grade0>), <sprite name=[packs] pack of building materials> Pack of Building Materials (<sprite name=grade0>). \nRain engine: <sprite name=\"[water] clearance water\"> Clearance Water.",
        _iconFilename = "Makeshift Post_icon.png",
        _category = "Industry",
        _categoryDisplay = "Production Building",
        _sizeX = 2,
        _sizeY = 2,
        _constructionTime = 20,
        _cityScore = 2,
        _isMovable = true,
        _isInitiallyEssential = false,
        _workerCapacity = 2,
        _constructionCosts = {
            {_id = "[Mat Raw] Wood", _amount = 5}
        },
        _tags = {
            "FoxesCooperation"
        },
        _storage = 8,
        _waterUsed = "[Water] Clearance Water",
        _recipes = {
            ["[Packs] Pack of Crops"] = {
                [0] = {
                    [2] = {
                        _buildings = {"Makeshift Post"},
                        _grade = 0,
                        _time = 56.0,
                        _productPair = {_id = "[Packs] Pack of Crops", _amount = 2},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Food Raw] Roots", _amount = 6},
                                {_id = "[Food Raw] Grain", _amount = 6},
                                {_id = "[Food Raw] Vegetables", _amount = 6},
                                {_id = "[Food Raw] Mushrooms", _amount = 6}
                            }
                        },
                    },
                },
            },
            ["[Packs] Pack of Provisions"] = {
                [0] = {
                    [3] = {
                        _buildings = {"Makeshift Post"},
                        _grade = 0,
                        _time = 56.0,
                        _productPair = {_id = "[Packs] Pack of Provisions", _amount = 3},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Food Raw] Herbs", _amount = 6},
                                {_id = "[Food Raw] Berries", _amount = 6},
                                {_id = "[Food Raw] Insects", _amount = 6},
                                {_id = "[Food Raw] Meat", _amount = 6},
                                {_id = "[Food Raw] Eggs", _amount = 6},
                                {_id = "[Food Raw] Fish", _amount = 6}
                            }
                        },
                    },
                },
            },
            ["[Packs] Pack of Building Materials"] = {
                [0] = {
                    [2] = {
                        _buildings = {"Makeshift Post"},
                        _grade = 0,
                        _time = 56.0,
                        _productPair = {_id = "[Packs] Pack of Building Materials", _amount = 2},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Mat Processed] Planks", _amount = 10},
                                {_id = "[Mat Processed] Fabric", _amount = 6},
                                {_id = "[Mat Processed] Bricks", _amount = 6},
                                {_id = "[Metal] Copper Ore", _amount = 14}
                            }
                        },
                    },
                },
            },
        },
    },
    ["Manufactory"] = {
        _id = "Manufactory",
        _displayName = "Manufactory",
        _description = "Can produce:  <sprite name=[mat processed] fabric> Fabric (<sprite name=grade2>), <sprite name=[vessel] barrels> Barrels (<sprite name=grade2>), <sprite name=[crafting] dye> Dye (<sprite name=grade2>). \nRain engine: <sprite name=\"[water] storm water\"> Storm Water.",
        _iconFilename = "Manufactory_icon.png",
        _category = "Industry",
        _categoryDisplay = "Production Building",
        _sizeX = 3,
        _sizeY = 3,
        _constructionTime = 50,
        _cityScore = 5,
        _isMovable = false,
        _isInitiallyEssential = false,
        _workerCapacity = 3,
        _constructionCosts = {
            {_id = "[Mat Processed] Planks", _amount = 5},
            {_id = "[Mat Processed] Fabric", _amount = 2}
        },
        _tags = {
            "Cloth",
            "FoxesCooperation"
        },
        _storage = 8,
        _waterUsed = "[Water] Storm Water",
        _recipes = {
            ["[Mat Processed] Fabric"] = {
                [2] = {
                    [2] = {
                        _buildings = {"Manufactory"},
                        _grade = 2,
                        _time = 42.0,
                        _productPair = {_id = "[Mat Processed] Fabric", _amount = 2},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Mat Raw] Plant Fibre", _amount = 3},
                                {_id = "[Mat Raw] Reeds", _amount = 3},
                                {_id = "[Mat Raw] Algae", _amount = 3}
                            }
                        },
                    },
                },
            },
            ["[Vessel] Barrels"] = {
                [2] = {
                    [10] = {
                        _buildings = {"Manufactory"},
                        _grade = 2,
                        _time = 126.0,
                        _productPair = {_id = "[Vessel] Barrels", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Metal] Copper Bar", _amount = 2},
                                {_id = "[Metal] Crystalized Dew", _amount = 2}
                            },
                            {
                                {_id = "[Mat Processed] Planks", _amount = 2}
                            }
                        },
                    },
                },
            },
            ["[Crafting] Dye"] = {
                [2] = {
                    [10] = {
                        _buildings = {"Manufactory"},
                        _grade = 2,
                        _time = 126.0,
                        _productPair = {_id = "[Crafting] Dye", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Food Raw] Insects", _amount = 4},
                                {_id = "[Food Raw] Berries", _amount = 4},
                                {_id = "[Metal] Copper Ore", _amount = 4},
                                {_id = "[Mat Raw] Scales", _amount = 4},
                                {_id = "[Crafting] Coal", _amount = 3}
                            }
                        },
                    },
                },
            },
        },
    },
    ["Pantry"] = {
        _id = "Pantry",
        _displayName = "Pantry",
        _description = "Can produce:  <sprite name=[food processed] porridge> Porridge (<sprite name=grade2>), <sprite name=[food processed] pie> Pie (<sprite name=grade2>), <sprite name=[packs] pack of luxury goods> Pack of Luxury Goods (<sprite name=grade2>). \nRain engine: <sprite name=\"[water] drizzle water\"> Drizzle Water.",
        _iconFilename = "Pantry_icon.png",
        _category = "Food Production",
        _categoryDisplay = "Production Building",
        _sizeX = 2,
        _sizeY = 2,
        _constructionTime = 30,
        _cityScore = 5,
        _isMovable = false,
        _isInitiallyEssential = false,
        _workerCapacity = 3,
        _constructionCosts = {
            {_id = "[Mat Processed] Planks", _amount = 5},
            {_id = "[Mat Processed] Fabric", _amount = 2}
        },
        _tags = {
            "Farming",
            "FoxesCooperation"
        },
        _storage = 8,
        _waterUsed = "[Water] Drizzle Water",
        _recipes = {
            ["[Food Processed] Porridge"] = {
                [2] = {
                    [10] = {
                        _buildings = {"Pantry"},
                        _grade = 2,
                        _time = 126.0,
                        _productPair = {_id = "[Food Processed] Porridge", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Food Raw] Grain", _amount = 5},
                                {_id = "[Food Raw] Vegetables", _amount = 5},
                                {_id = "[Food Raw] Mushrooms", _amount = 5},
                                {_id = "[Food Raw] Herbs", _amount = 5},
                                {_id = "[Food Raw] Fish", _amount = 5}
                            },
                            {
                                {_id = "[Water] Drizzle Water", _amount = 7},
                                {_id = "[Water] Clearance Water", _amount = 9},
                                {_id = "[Water] Storm Water", _amount = 11}
                            }
                        },
                    },
                },
            },
            ["[Food Processed] Pie"] = {
                [2] = {
                    [10] = {
                        _buildings = {"Pantry"},
                        _grade = 2,
                        _time = 126.0,
                        _productPair = {_id = "[Food Processed] Pie", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Crafting] Flour", _amount = 6}
                            },
                            {
                                {_id = "[Food Raw] Herbs", _amount = 4},
                                {_id = "[Food Raw] Meat", _amount = 4},
                                {_id = "[Food Raw] Insects", _amount = 4},
                                {_id = "[Food Raw] Berries", _amount = 4},
                                {_id = "[Food Raw] Fish", _amount = 4}
                            }
                        },
                    },
                },
            },
            ["[Packs] Pack of Luxury Goods"] = {
                [2] = {
                    [2] = {
                        _buildings = {"Pantry"},
                        _grade = 2,
                        _time = 42.0,
                        _productPair = {_id = "[Packs] Pack of Luxury Goods", _amount = 2},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Needs] Wine", _amount = 4},
                                {_id = "[Needs] Training Gear", _amount = 4},
                                {_id = "[Needs] Incense", _amount = 4},
                                {_id = "[Needs] Scrolls", _amount = 4},
                                {_id = "[Needs] Ale", _amount = 4},
                                {_id = "[Needs] Tea", _amount = 4}
                            }
                        },
                    },
                },
            },
        },
    },
    ["Press"] = {
        _id = "Press",
        _displayName = "Press",
        _description = "Can produce:  <sprite name=[crafting] oil> Oil (<sprite name=grade3>), <sprite name=[crafting] flour> Flour (<sprite name=grade1>), <sprite name=[food processed] paste> Paste (<sprite name=grade1>). \nRain engine: <sprite name=\"[water] clearance water\"> Clearance Water.",
        _iconFilename = "Press_icon.png",
        _category = "Industry",
        _categoryDisplay = "Production Building",
        _sizeX = 3,
        _sizeY = 2,
        _constructionTime = 20,
        _cityScore = 5,
        _isMovable = false,
        _isInitiallyEssential = false,
        _workerCapacity = 3,
        _constructionCosts = {
            {_id = "[Mat Processed] Planks", _amount = 5},
            {_id = "[Mat Processed] Bricks", _amount = 2}
        },
        _tags = {
            "Tech",
            "FoxesCooperation"
        },
        _storage = 8,
        _waterUsed = "[Water] Clearance Water",
        _recipes = {
            ["[Crafting] Oil"] = {
                [3] = {
                    [5] = {
                        _buildings = {"Press"},
                        _grade = 3,
                        _time = 63.0,
                        _productPair = {_id = "[Crafting] Oil", _amount = 5},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Food Raw] Grain", _amount = 2},
                                {_id = "[Food Raw] Meat", _amount = 2},
                                {_id = "[Food Raw] Vegetables", _amount = 2},
                                {_id = "[Mat Raw] Plant Fibre", _amount = 2},
                                {_id = "[Food Raw] Fish", _amount = 2}
                            }
                        },
                    },
                },
            },
            ["[Crafting] Flour"] = {
                [1] = {
                    [10] = {
                        _buildings = {"Press"},
                        _grade = 1,
                        _time = 84.0,
                        _productPair = {_id = "[Crafting] Flour", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Food Raw] Grain", _amount = 8},
                                {_id = "[Food Raw] Mushrooms", _amount = 8},
                                {_id = "[Food Raw] Roots", _amount = 8},
                                {_id = "[Mat Raw] Algae", _amount = 8}
                            }
                        },
                    },
                },
            },
            ["[Food Processed] Paste"] = {
                [1] = {
                    [10] = {
                        _buildings = {"Press"},
                        _grade = 1,
                        _time = 126.0,
                        _productPair = {_id = "[Food Processed] Paste", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Crafting] Dye", _amount = 2},
                                {_id = "[Crafting] Salt", _amount = 3}
                            },
                            {
                                {_id = "[Food Raw] Eggs", _amount = 6},
                                {_id = "[Food Raw] Fish", _amount = 6},
                                {_id = "[Food Raw] Meat", _amount = 6}
                            }
                        },
                    },
                },
            },
        },
    },
    ["Provisioner"] = {
        _id = "Provisioner",
        _displayName = "Provisioner",
        _description = "Can produce:  <sprite name=[crafting] flour> Flour (<sprite name=grade2>), <sprite name=[vessel] barrels> Barrels (<sprite name=grade2>), <sprite name=[packs] pack of provisions> Pack of Provisions (<sprite name=grade2>). \nRain engine: <sprite name=\"[water] clearance water\"> Clearance Water.",
        _iconFilename = "Provisioner_icon.png",
        _category = "Industry",
        _categoryDisplay = "Production Building",
        _sizeX = 3,
        _sizeY = 2,
        _constructionTime = 40,
        _cityScore = 5,
        _isMovable = false,
        _isInitiallyEssential = false,
        _workerCapacity = 2,
        _constructionCosts = {
            {_id = "[Mat Processed] Planks", _amount = 8},
            {_id = "[Mat Processed] Fabric", _amount = 4}
        },
        _tags = {
            "FoxesCooperation"
        },
        _storage = 8,
        _waterUsed = "[Water] Clearance Water",
        _recipes = {
            ["[Crafting] Flour"] = {
                [2] = {
                    [10] = {
                        _buildings = {"Provisioner"},
                        _grade = 2,
                        _time = 63.0,
                        _productPair = {_id = "[Crafting] Flour", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Food Raw] Grain", _amount = 7},
                                {_id = "[Food Raw] Mushrooms", _amount = 7},
                                {_id = "[Food Raw] Roots", _amount = 7},
                                {_id = "[Mat Raw] Algae", _amount = 7}
                            }
                        },
                    },
                },
            },
            ["[Vessel] Barrels"] = {
                [2] = {
                    [10] = {
                        _buildings = {"Provisioner"},
                        _grade = 2,
                        _time = 126.0,
                        _productPair = {_id = "[Vessel] Barrels", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Metal] Copper Bar", _amount = 2},
                                {_id = "[Metal] Crystalized Dew", _amount = 2}
                            },
                            {
                                {_id = "[Mat Processed] Planks", _amount = 2}
                            }
                        },
                    },
                },
            },
            ["[Packs] Pack of Provisions"] = {
                [2] = {
                    [3] = {
                        _buildings = {"Provisioner"},
                        _grade = 2,
                        _time = 42.0,
                        _productPair = {_id = "[Packs] Pack of Provisions", _amount = 3},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Food Raw] Herbs", _amount = 4},
                                {_id = "[Food Raw] Berries", _amount = 4},
                                {_id = "[Food Raw] Insects", _amount = 4},
                                {_id = "[Food Raw] Meat", _amount = 4},
                                {_id = "[Food Raw] Eggs", _amount = 4},
                                {_id = "[Food Raw] Fish", _amount = 4}
                            }
                        },
                    },
                },
            },
        },
    },
    ["Rain Mill"] = {
        _id = "Rain Mill",
        _displayName = "Rain Mill",
        _description = "Can produce:  <sprite name=[crafting] flour> Flour (<sprite name=grade3>), <sprite name=[needs] scrolls> Scrolls (<sprite name=grade1>), <sprite name=[food processed] paste> Paste (<sprite name=grade1>). \nRain engine: <sprite name=\"[water] clearance water\"> Clearance Water.",
        _iconFilename = "Rain Mill_icon.png",
        _category = "Food Production",
        _categoryDisplay = "Production Building",
        _sizeX = 3,
        _sizeY = 2,
        _constructionTime = 20,
        _cityScore = 5,
        _isMovable = false,
        _isInitiallyEssential = false,
        _workerCapacity = 3,
        _constructionCosts = {
            {_id = "[Mat Processed] Planks", _amount = 5},
            {_id = "[Mat Processed] Fabric", _amount = 2}
        },
        _tags = {
            "Tech",
            "Farming",
            "FoxesCooperation"
        },
        _storage = 8,
        _waterUsed = "[Water] Clearance Water",
        _recipes = {
            ["[Crafting] Flour"] = {
                [3] = {
                    [10] = {
                        _buildings = {"Rain Mill"},
                        _grade = 3,
                        _time = 63.0,
                        _productPair = {_id = "[Crafting] Flour", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Food Raw] Grain", _amount = 5},
                                {_id = "[Food Raw] Mushrooms", _amount = 5},
                                {_id = "[Food Raw] Roots", _amount = 5},
                                {_id = "[Mat Raw] Algae", _amount = 5}
                            }
                        },
                    },
                },
            },
            ["[Needs] Scrolls"] = {
                [1] = {
                    [8] = {
                        _buildings = {"Rain Mill"},
                        _grade = 1,
                        _time = 84.0,
                        _productPair = {_id = "[Needs] Scrolls", _amount = 8},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Mat Raw] Leather", _amount = 4},
                                {_id = "[Mat Raw] Plant Fibre", _amount = 4},
                                {_id = "[Mat Raw] Wood", _amount = 10}
                            },
                            {
                                {_id = "[Crafting] Dye", _amount = 3},
                                {_id = "[Needs] Wine", _amount = 3}
                            }
                        },
                    },
                },
            },
            ["[Food Processed] Paste"] = {
                [1] = {
                    [10] = {
                        _buildings = {"Rain Mill"},
                        _grade = 1,
                        _time = 126.0,
                        _productPair = {_id = "[Food Processed] Paste", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Crafting] Dye", _amount = 2},
                                {_id = "[Crafting] Salt", _amount = 3}
                            },
                            {
                                {_id = "[Food Raw] Eggs", _amount = 6},
                                {_id = "[Food Raw] Fish", _amount = 6},
                                {_id = "[Food Raw] Meat", _amount = 6}
                            }
                        },
                    },
                },
            },
        },
    },
    ["Rainpunk Foundry"] = {
        _id = "Rainpunk Foundry",
        _displayName = "Rainpunk Foundry",
        _description = "A very advanced piece of technology. Can produce  <sprite name=[mat processed] parts> Parts (<sprite name=grade3>), <sprite name=hearth parts> Wildfire Essence (<sprite name=grade3>).\nRain engine: <sprite name=\"[water] storm water\"> Storm Water.",
        _iconFilename = "Rainpunk Foundry_icon.png",
        _category = "Industry",
        _categoryDisplay = "Production Building",
        _sizeX = 3,
        _sizeY = 3,
        _constructionTime = 25,
        _cityScore = 10,
        _isMovable = false,
        _isInitiallyEssential = false,
        _workerCapacity = 3,
        _constructionCosts = {
            {_id = "[Mat Processed] Planks", _amount = 8},
            {_id = "[Mat Processed] Bricks", _amount = 2},
            {_id = "[Mat Processed] Fabric", _amount = 2}
        },
        _tags = {
            "Metallurgy",
            "Tech",
            "Rainwater",
            "FoxesCooperation"
        },
        _storage = 8,
        _waterUsed = "[Water] Storm Water",
        _recipes = {
            ["[Mat Processed] Parts"] = {
                [3] = {
                    [1] = {
                        _buildings = {"Rainpunk Foundry"},
                        _grade = 3,
                        _time = 90.0,
                        _productPair = {_id = "[Mat Processed] Parts", _amount = 1},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Metal] Copper Bar", _amount = 3},
                                {_id = "[Metal] Crystalized Dew", _amount = 3}
                            },
                            {
                                {_id = "[Crafting] Coal", _amount = 1},
                                {_id = "[Crafting] Sea Marrow", _amount = 1},
                                {_id = "[Crafting] Oil", _amount = 1},
                                {_id = "[Mat Raw] Wood", _amount = 5}
                            }
                        },
                    },
                },
            },
            ["Hearth Parts"] = {
                [3] = {
                    [1] = {
                        _buildings = {"Rainpunk Foundry"},
                        _grade = 3,
                        _time = 90.0,
                        _productPair = {_id = "Hearth Parts", _amount = 1},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Crafting] Coal", _amount = 5},
                                {_id = "[Crafting] Sea Marrow", _amount = 5},
                                {_id = "[Crafting] Oil", _amount = 5},
                                {_id = "[Mat Raw] Wood", _amount = 15}
                            },
                            {
                                {_id = "[Vessel] Pottery", _amount = 1},
                                {_id = "[Vessel] Waterskin", _amount = 1},
                                {_id = "[Vessel] Barrels", _amount = 1}
                            },
                            {
                                {_id = "[Water] Drizzle Water", _amount = 10},
                                {_id = "[Water] Clearance Water", _amount = 10},
                                {_id = "[Water] Storm Water", _amount = 10}
                            }
                        },
                    },
                },
            },
        },
    },
    ["Ranch"] = {
        _id = "Ranch",
        _displayName = "Ranch",
        _description = "Can produce:  <sprite name=[food raw] meat> Meat (<sprite name=grade1>), <sprite name=[mat raw] leather> Leather (<sprite name=grade1>), <sprite name=[food raw] eggs> Eggs (<sprite name=grade1>). \nRain engine: <sprite name=\"[water] drizzle water\"> Drizzle Water.",
        _iconFilename = "Ranch_icon.png",
        _category = "Food Production",
        _categoryDisplay = "Production Building",
        _sizeX = 3,
        _sizeY = 3,
        _constructionTime = 40,
        _cityScore = 5,
        _isMovable = false,
        _isInitiallyEssential = false,
        _workerCapacity = 2,
        _constructionCosts = {
            {_id = "[Mat Processed] Planks", _amount = 5}
        },
        _tags = {
            "Animals",
            "FoxesCooperation"
        },
        _storage = 8,
        _waterUsed = "[Water] Drizzle Water",
        _recipes = {
            ["[Food Raw] Meat"] = {
                [1] = {
                    [10] = {
                        _buildings = {"Ranch"},
                        _grade = 1,
                        _time = 84.0,
                        _productPair = {_id = "[Food Raw] Meat", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Mat Raw] Plant Fibre", _amount = 8},
                                {_id = "[Mat Raw] Reeds", _amount = 8},
                                {_id = "[Mat Raw] Algae", _amount = 8},
                                {_id = "[Food Raw] Grain", _amount = 8},
                                {_id = "[Food Raw] Vegetables", _amount = 5}
                            }
                        },
                    },
                },
            },
            ["[Mat Raw] Leather"] = {
                [1] = {
                    [4] = {
                        _buildings = {"Ranch"},
                        _grade = 1,
                        _time = 42.0,
                        _productPair = {_id = "[Mat Raw] Leather", _amount = 4},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Mat Raw] Algae", _amount = 2},
                                {_id = "[Mat Raw] Reeds", _amount = 2},
                                {_id = "[Food Raw] Grain", _amount = 2},
                                {_id = "[Food Raw] Vegetables", _amount = 1}
                            }
                        },
                    },
                },
            },
            ["[Food Raw] Eggs"] = {
                [1] = {
                    [5] = {
                        _buildings = {"Ranch"},
                        _grade = 1,
                        _time = 84.0,
                        _productPair = {_id = "[Food Raw] Eggs", _amount = 5},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Food Raw] Grain", _amount = 3},
                                {_id = "[Food Raw] Insects", _amount = 2},
                                {_id = "[Mat Raw] Reeds", _amount = 2},
                                {_id = "[Food Raw] Berries", _amount = 2}
                            }
                        },
                    },
                },
            },
        },
    },
    ["Scribe"] = {
        _id = "Scribe",
        _displayName = "Scribe",
        _description = "Can produce:  <sprite name=[needs] scrolls> Scrolls (<sprite name=grade3>), <sprite name=[packs] pack of trade goods> Pack of Trade Goods (<sprite name=grade2>), <sprite name=[needs] ale> Ale (<sprite name=grade1>). \nRain engine: <sprite name=\"[water] clearance water\"> Clearance Water.",
        _iconFilename = "Scribe_icon.png",
        _category = "Industry",
        _categoryDisplay = "Production Building",
        _sizeX = 3,
        _sizeY = 2,
        _constructionTime = 40,
        _cityScore = 5,
        _isMovable = false,
        _isInitiallyEssential = false,
        _workerCapacity = 3,
        _constructionCosts = {
            {_id = "[Mat Processed] Planks", _amount = 5},
            {_id = "[Mat Processed] Fabric", _amount = 2}
        },
        _tags = {
            "Brewing",
            "FoxesCooperation"
        },
        _storage = 8,
        _waterUsed = "[Water] Clearance Water",
        _recipes = {
            ["[Needs] Scrolls"] = {
                [3] = {
                    [8] = {
                        _buildings = {"Scribe"},
                        _grade = 3,
                        _time = 63.0,
                        _productPair = {_id = "[Needs] Scrolls", _amount = 8},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Mat Raw] Leather", _amount = 2},
                                {_id = "[Mat Raw] Plant Fibre", _amount = 2},
                                {_id = "[Mat Raw] Wood", _amount = 6}
                            },
                            {
                                {_id = "[Crafting] Dye", _amount = 1},
                                {_id = "[Needs] Wine", _amount = 1}
                            }
                        },
                    },
                },
            },
            ["[Packs] Pack of Trade Goods"] = {
                [2] = {
                    [2] = {
                        _buildings = {"Scribe"},
                        _grade = 2,
                        _time = 42.0,
                        _productPair = {_id = "[Packs] Pack of Trade Goods", _amount = 2},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Crafting] Dye", _amount = 6},
                                {_id = "[Crafting] Oil", _amount = 6},
                                {_id = "[Crafting] Flour", _amount = 4},
                                {_id = "[Vessel] Pottery", _amount = 4},
                                {_id = "[Vessel] Barrels", _amount = 4},
                                {_id = "[Vessel] Waterskin", _amount = 4}
                            }
                        },
                    },
                },
            },
            ["[Needs] Ale"] = {
                [1] = {
                    [10] = {
                        _buildings = {"Scribe"},
                        _grade = 1,
                        _time = 126.0,
                        _productPair = {_id = "[Needs] Ale", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Food Raw] Grain", _amount = 6},
                                {_id = "[Food Raw] Roots", _amount = 6}
                            },
                            {
                                {_id = "[Vessel] Pottery", _amount = 3},
                                {_id = "[Vessel] Barrels", _amount = 2},
                                {_id = "[Vessel] Waterskin", _amount = 3}
                            }
                        },
                    },
                },
            },
        },
    },
    ["Smelter"] = {
        _id = "Smelter",
        _displayName = "Smelter",
        _description = "Can produce:  <sprite name=[metal] copper bar> Copper Bars (<sprite name=grade3>), <sprite name=[needs] training gear> Training Gear (<sprite name=grade2>), <sprite name=[food processed] pie> Pie (<sprite name=grade1>). \nRain engine: <sprite name=\"[water] storm water\"> Storm Water.",
        _iconFilename = "Smelter_icon.png",
        _category = "Industry",
        _categoryDisplay = "Production Building",
        _sizeX = 3,
        _sizeY = 3,
        _constructionTime = 40,
        _cityScore = 5,
        _isMovable = false,
        _isInitiallyEssential = false,
        _workerCapacity = 3,
        _constructionCosts = {
            {_id = "[Mat Processed] Bricks", _amount = 4}
        },
        _tags = {
            "Metallurgy",
            "Warmth",
            "FoxesCooperation"
        },
        _storage = 8,
        _waterUsed = "[Water] Storm Water",
        _recipes = {
            ["[Metal] Copper Bar"] = {
                [3] = {
                    [2] = {
                        _buildings = {"Smelter"},
                        _grade = 3,
                        _time = 28.0,
                        _productPair = {_id = "[Metal] Copper Bar", _amount = 2},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Metal] Copper Ore", _amount = 4},
                                {_id = "[Mat Raw] Scales", _amount = 4}
                            },
                            {
                                {_id = "[Mat Raw] Wood", _amount = 5},
                                {_id = "[Crafting] Oil", _amount = 2},
                                {_id = "[Crafting] Coal", _amount = 1},
                                {_id = "[Crafting] Sea Marrow", _amount = 1}
                            }
                        },
                    },
                },
            },
            ["[Needs] Training Gear"] = {
                [2] = {
                    [10] = {
                        _buildings = {"Smelter"},
                        _grade = 2,
                        _time = 126.0,
                        _productPair = {_id = "[Needs] Training Gear", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Mat Raw] Stone", _amount = 5},
                                {_id = "[Metal] Copper Bar", _amount = 2},
                                {_id = "[Metal] Crystalized Dew", _amount = 2}
                            },
                            {
                                {_id = "[Mat Processed] Planks", _amount = 3},
                                {_id = "[Mat Raw] Reeds", _amount = 3},
                                {_id = "[Mat Raw] Leather", _amount = 3}
                            }
                        },
                    },
                },
            },
            ["[Food Processed] Pie"] = {
                [1] = {
                    [10] = {
                        _buildings = {"Smelter"},
                        _grade = 1,
                        _time = 126.0,
                        _productPair = {_id = "[Food Processed] Pie", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Crafting] Flour", _amount = 6}
                            },
                            {
                                {_id = "[Food Raw] Herbs", _amount = 5},
                                {_id = "[Food Raw] Meat", _amount = 5},
                                {_id = "[Food Raw] Insects", _amount = 5},
                                {_id = "[Food Raw] Berries", _amount = 5},
                                {_id = "[Food Raw] Fish", _amount = 5}
                            }
                        },
                    },
                },
            },
        },
    },
    ["Smithy"] = {
        _id = "Smithy",
        _displayName = "Smithy",
        _description = "Can produce:  <sprite name=[tools] simple tools> Tools (<sprite name=grade2>), <sprite name=[mat processed] pipe> Pipes (<sprite name=grade2>), <sprite name=[packs] pack of trade goods> Pack of Trade Goods (<sprite name=grade2>). \nRain engine: <sprite name=\"[water] storm water\"> Storm Water.",
        _iconFilename = "Smithy_icon.png",
        _category = "Industry",
        _categoryDisplay = "Production Building",
        _sizeX = 3,
        _sizeY = 3,
        _constructionTime = 50,
        _cityScore = 5,
        _isMovable = false,
        _isInitiallyEssential = false,
        _workerCapacity = 2,
        _constructionCosts = {
            {_id = "[Mat Processed] Planks", _amount = 5},
            {_id = "[Mat Processed] Bricks", _amount = 2}
        },
        _tags = {
            "Tech",
            "Metallurgy",
            "Warmth",
            "FoxesCooperation"
        },
        _storage = 8,
        _waterUsed = "[Water] Storm Water",
        _recipes = {
            ["[Tools] Simple Tools"] = {
                [2] = {
                    [2] = {
                        _buildings = {"Smithy"},
                        _grade = 2,
                        _time = 75.0,
                        _productPair = {_id = "[Tools] Simple Tools", _amount = 2},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Mat Raw] Wood", _amount = 8},
                                {_id = "[Mat Processed] Planks", _amount = 2}
                            },
                            {
                                {_id = "[Metal] Copper Bar", _amount = 3},
                                {_id = "[Metal] Crystalized Dew", _amount = 3}
                            }
                        },
                    },
                },
            },
            ["[Mat Processed] Pipe"] = {
                [2] = {
                    [3] = {
                        _buildings = {"Smithy"},
                        _grade = 2,
                        _time = 60.0,
                        _productPair = {_id = "[Mat Processed] Pipe", _amount = 3},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Metal] Copper Bar", _amount = 2},
                                {_id = "[Metal] Crystalized Dew", _amount = 2}
                            }
                        },
                    },
                },
            },
            ["[Packs] Pack of Trade Goods"] = {
                [2] = {
                    [2] = {
                        _buildings = {"Smithy"},
                        _grade = 2,
                        _time = 42.0,
                        _productPair = {_id = "[Packs] Pack of Trade Goods", _amount = 2},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Crafting] Dye", _amount = 6},
                                {_id = "[Crafting] Oil", _amount = 6},
                                {_id = "[Crafting] Flour", _amount = 4},
                                {_id = "[Vessel] Pottery", _amount = 4},
                                {_id = "[Vessel] Barrels", _amount = 4},
                                {_id = "[Vessel] Waterskin", _amount = 4}
                            }
                        },
                    },
                },
            },
        },
    },
    ["Smokehouse"] = {
        _id = "Smokehouse",
        _displayName = "Smokehouse",
        _description = "Can produce:  <sprite name=[food processed] jerky> Jerky (<sprite name=grade3>), <sprite name=[vessel] pottery> Pottery (<sprite name=grade1>), <sprite name=[needs] incense> Incense (<sprite name=grade1>). \nRain engine: <sprite name=\"[water] drizzle water\"> Drizzle Water.",
        _iconFilename = "Smokehouse_icon.png",
        _category = "Food Production",
        _categoryDisplay = "Production Building",
        _sizeX = 3,
        _sizeY = 3,
        _constructionTime = 50,
        _cityScore = 5,
        _isMovable = false,
        _isInitiallyEssential = false,
        _workerCapacity = 3,
        _constructionCosts = {
            {_id = "[Mat Processed] Planks", _amount = 5},
            {_id = "[Mat Processed] Fabric", _amount = 2}
        },
        _tags = {
            "Warmth",
            "Animals",
            "FoxesCooperation"
        },
        _storage = 8,
        _waterUsed = "[Water] Drizzle Water",
        _recipes = {
            ["[Food Processed] Jerky"] = {
                [3] = {
                    [10] = {
                        _buildings = {"Smokehouse"},
                        _grade = 3,
                        _time = 105.0,
                        _productPair = {_id = "[Food Processed] Jerky", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Food Raw] Insects", _amount = 4},
                                {_id = "[Food Raw] Meat", _amount = 4}
                            },
                            {
                                {_id = "[Mat Raw] Wood", _amount = 5},
                                {_id = "[Crafting] Oil", _amount = 2},
                                {_id = "[Crafting] Salt", _amount = 2},
                                {_id = "[Crafting] Coal", _amount = 1},
                                {_id = "[Crafting] Sea Marrow", _amount = 1}
                            }
                        },
                    },
                },
            },
            ["[Vessel] Pottery"] = {
                [1] = {
                    [5] = {
                        _buildings = {"Smokehouse"},
                        _grade = 1,
                        _time = 84.0,
                        _productPair = {_id = "[Vessel] Pottery", _amount = 5},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Mat Raw] Clay", _amount = 4}
                            },
                            {
                                {_id = "[Mat Raw] Wood", _amount = 5},
                                {_id = "[Crafting] Oil", _amount = 2},
                                {_id = "[Crafting] Coal", _amount = 1},
                                {_id = "[Crafting] Sea Marrow", _amount = 1}
                            }
                        },
                    },
                },
            },
            ["[Needs] Incense"] = {
                [1] = {
                    [10] = {
                        _buildings = {"Smokehouse"},
                        _grade = 1,
                        _time = 126.0,
                        _productPair = {_id = "[Needs] Incense", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Food Raw] Herbs", _amount = 6},
                                {_id = "[Food Raw] Roots", _amount = 6},
                                {_id = "[Food Raw] Insects", _amount = 6},
                                {_id = "[Mat Raw] Scales", _amount = 6},
                                {_id = "[Crafting] Salt", _amount = 6},
                                {_id = "[Mat Raw] Resin", _amount = 8}
                            },
                            {
                                {_id = "[Mat Raw] Wood", _amount = 6},
                                {_id = "[Crafting] Oil", _amount = 3},
                                {_id = "[Crafting] Coal", _amount = 2},
                                {_id = "[Crafting] Sea Marrow", _amount = 2}
                            }
                        },
                    },
                },
            },
        },
    },
    ["Stamping Mill"] = {
        _id = "Stamping Mill",
        _displayName = "Stamping Mill",
        _description = "Can produce:  <sprite name=[mat processed] bricks> Bricks (<sprite name=grade2>), <sprite name=[crafting] flour> Flour (<sprite name=grade2>), <sprite name=[metal] copper bar> Copper Bars (<sprite name=grade2>). \nRain engine: <sprite name=\"[water] clearance water\"> Clearance Water.",
        _iconFilename = "Stamping Mill_icon.png",
        _category = "Industry",
        _categoryDisplay = "Production Building",
        _sizeX = 2,
        _sizeY = 2,
        _constructionTime = 20,
        _cityScore = 5,
        _isMovable = false,
        _isInitiallyEssential = false,
        _workerCapacity = 2,
        _constructionCosts = {
            {_id = "[Mat Processed] Planks", _amount = 5},
            {_id = "[Mat Processed] Bricks", _amount = 2}
        },
        _tags = {
            "Metallurgy",
            "Tech",
            "Stone",
            "FoxesCooperation"
        },
        _storage = 8,
        _waterUsed = "[Water] Clearance Water",
        _recipes = {
            ["[Mat Processed] Bricks"] = {
                [2] = {
                    [2] = {
                        _buildings = {"Stamping Mill"},
                        _grade = 2,
                        _time = 42.0,
                        _productPair = {_id = "[Mat Processed] Bricks", _amount = 2},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Mat Raw] Clay", _amount = 3},
                                {_id = "[Mat Raw] Stone", _amount = 3}
                            }
                        },
                    },
                },
            },
            ["[Crafting] Flour"] = {
                [2] = {
                    [10] = {
                        _buildings = {"Stamping Mill"},
                        _grade = 2,
                        _time = 63.0,
                        _productPair = {_id = "[Crafting] Flour", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Food Raw] Grain", _amount = 7},
                                {_id = "[Food Raw] Mushrooms", _amount = 7},
                                {_id = "[Food Raw] Roots", _amount = 7},
                                {_id = "[Mat Raw] Algae", _amount = 7}
                            }
                        },
                    },
                },
            },
            ["[Metal] Copper Bar"] = {
                [2] = {
                    [2] = {
                        _buildings = {"Stamping Mill"},
                        _grade = 2,
                        _time = 42.0,
                        _productPair = {_id = "[Metal] Copper Bar", _amount = 2},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Metal] Copper Ore", _amount = 5},
                                {_id = "[Mat Raw] Scales", _amount = 5}
                            },
                            {
                                {_id = "[Mat Raw] Wood", _amount = 5},
                                {_id = "[Crafting] Oil", _amount = 2},
                                {_id = "[Crafting] Coal", _amount = 1},
                                {_id = "[Crafting] Sea Marrow", _amount = 1}
                            }
                        },
                    },
                },
            },
        },
    },
    ["Supplier"] = {
        _id = "Supplier",
        _displayName = "Supplier",
        _description = "Can produce:  <sprite name=[crafting] flour> Flour (<sprite name=grade2>), <sprite name=[mat processed] planks> Planks (<sprite name=grade2>), <sprite name=[vessel] waterskin> Waterskins (<sprite name=grade2>). \nRain engine: <sprite name=\"[water] clearance water\"> Clearance Water.",
        _iconFilename = "Supplier_icon.png",
        _category = "Industry",
        _categoryDisplay = "Production Building",
        _sizeX = 3,
        _sizeY = 3,
        _constructionTime = 50,
        _cityScore = 5,
        _isMovable = false,
        _isInitiallyEssential = false,
        _workerCapacity = 2,
        _constructionCosts = {
            {_id = "[Mat Processed] Planks", _amount = 5},
            {_id = "[Mat Processed] Bricks", _amount = 2}
        },
        _tags = {
            "Cloth",
            "FoxesCooperation"
        },
        _storage = 8,
        _waterUsed = "[Water] Clearance Water",
        _recipes = {
            ["[Crafting] Flour"] = {
                [2] = {
                    [10] = {
                        _buildings = {"Supplier"},
                        _grade = 2,
                        _time = 63.0,
                        _productPair = {_id = "[Crafting] Flour", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Food Raw] Grain", _amount = 7},
                                {_id = "[Food Raw] Mushrooms", _amount = 7},
                                {_id = "[Food Raw] Roots", _amount = 7},
                                {_id = "[Mat Raw] Algae", _amount = 7}
                            }
                        },
                    },
                },
            },
            ["[Mat Processed] Planks"] = {
                [2] = {
                    [2] = {
                        _buildings = {"Supplier"},
                        _grade = 2,
                        _time = 42.0,
                        _productPair = {_id = "[Mat Processed] Planks", _amount = 2},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Mat Raw] Wood", _amount = 5}
                            }
                        },
                    },
                },
            },
            ["[Vessel] Waterskin"] = {
                [2] = {
                    [10] = {
                        _buildings = {"Supplier"},
                        _grade = 2,
                        _time = 84.0,
                        _productPair = {_id = "[Vessel] Waterskin", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Mat Raw] Leather", _amount = 5},
                                {_id = "[Mat Raw] Scales", _amount = 5}
                            },
                            {
                                {_id = "[Crafting] Oil", _amount = 3},
                                {_id = "[Food Raw] Meat", _amount = 3},
                                {_id = "[Crafting] Salt", _amount = 3}
                            }
                        },
                    },
                },
            },
        },
    },
    ["Tea House"] = {
        _id = "Tea House",
        _displayName = "Teahouse",
        _description = "Can produce:  <sprite name=[needs] tea> Tea (<sprite name=grade3>), <sprite name=[needs] incense> Incense (<sprite name=grade2>), <sprite name=[vessel] waterskin> Waterskins (<sprite name=grade1>). \nRain engine: <sprite name=\"[water] drizzle water\"> Drizzle Water.",
        _iconFilename = "Tea House_icon.png",
        _category = "Industry",
        _categoryDisplay = "Production Building",
        _sizeX = 3,
        _sizeY = 2,
        _constructionTime = 20,
        _cityScore = 5,
        _isMovable = false,
        _isInitiallyEssential = false,
        _workerCapacity = 2,
        _constructionCosts = {
            {_id = "[Mat Processed] Planks", _amount = 5},
            {_id = "[Mat Processed] Bricks", _amount = 2}
        },
        _tags = {
            "Alchemy",
            "Rainwater",
            "FoxesCooperation"
        },
        _storage = 8,
        _waterUsed = "[Water] Drizzle Water",
        _recipes = {
            ["[Needs] Tea"] = {
                [3] = {
                    [10] = {
                        _buildings = {"Tea House"},
                        _grade = 3,
                        _time = 105.0,
                        _productPair = {_id = "[Needs] Tea", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Food Raw] Herbs", _amount = 2},
                                {_id = "[Crafting] Dye", _amount = 2},
                                {_id = "[Mat Raw] Resin", _amount = 2},
                                {_id = "[Food Raw] Mushrooms", _amount = 2},
                                {_id = "[Food Raw] Roots", _amount = 2}
                            },
                            {
                                {_id = "[Water] Drizzle Water", _amount = 2},
                                {_id = "[Water] Clearance Water", _amount = 3},
                                {_id = "[Water] Storm Water", _amount = 4}
                            },
                            {
                                {_id = "[Vessel] Pottery", _amount = 2},
                                {_id = "[Vessel] Barrels", _amount = 1},
                                {_id = "[Vessel] Waterskin", _amount = 2}
                            }
                        },
                    },
                },
            },
            ["[Needs] Incense"] = {
                [2] = {
                    [10] = {
                        _buildings = {"Tea House"},
                        _grade = 2,
                        _time = 126.0,
                        _productPair = {_id = "[Needs] Incense", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Food Raw] Herbs", _amount = 5},
                                {_id = "[Food Raw] Roots", _amount = 5},
                                {_id = "[Food Raw] Insects", _amount = 5},
                                {_id = "[Mat Raw] Scales", _amount = 5},
                                {_id = "[Crafting] Salt", _amount = 5},
                                {_id = "[Mat Raw] Resin", _amount = 7}
                            },
                            {
                                {_id = "[Mat Raw] Wood", _amount = 6},
                                {_id = "[Crafting] Oil", _amount = 3},
                                {_id = "[Crafting] Coal", _amount = 2},
                                {_id = "[Crafting] Sea Marrow", _amount = 2}
                            }
                        },
                    },
                },
            },
            ["[Vessel] Waterskin"] = {
                [1] = {
                    [10] = {
                        _buildings = {"Tea House"},
                        _grade = 1,
                        _time = 84.0,
                        _productPair = {_id = "[Vessel] Waterskin", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Mat Raw] Leather", _amount = 6},
                                {_id = "[Mat Raw] Scales", _amount = 6}
                            },
                            {
                                {_id = "[Crafting] Oil", _amount = 4},
                                {_id = "[Food Raw] Meat", _amount = 4},
                                {_id = "[Crafting] Salt", _amount = 4}
                            }
                        },
                    },
                },
            },
        },
    },
    ["Tinctury"] = {
        _id = "Tinctury",
        _displayName = "Tinctury",
        _description = "Can produce:  <sprite name=[crafting] dye> Dye (<sprite name=grade3>), <sprite name=[needs] ale> Ale (<sprite name=grade2>), <sprite name=[needs] wine> Wine (<sprite name=grade1>). \nRain engine: <sprite name=\"[water] drizzle water\"> Drizzle Water.",
        _iconFilename = "Tinctury_icon.png",
        _category = "Industry",
        _categoryDisplay = "Production Building",
        _sizeX = 3,
        _sizeY = 2,
        _constructionTime = 40,
        _cityScore = 5,
        _isMovable = false,
        _isInitiallyEssential = false,
        _workerCapacity = 2,
        _constructionCosts = {
            {_id = "[Mat Processed] Planks", _amount = 5},
            {_id = "[Mat Processed] Fabric", _amount = 2}
        },
        _tags = {
            "Brewing",
            "Alchemy",
            "FoxesCooperation"
        },
        _storage = 8,
        _waterUsed = "[Water] Drizzle Water",
        _recipes = {
            ["[Crafting] Dye"] = {
                [3] = {
                    [10] = {
                        _buildings = {"Tinctury"},
                        _grade = 3,
                        _time = 105.0,
                        _productPair = {_id = "[Crafting] Dye", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Food Raw] Insects", _amount = 3},
                                {_id = "[Food Raw] Berries", _amount = 3},
                                {_id = "[Metal] Copper Ore", _amount = 3},
                                {_id = "[Mat Raw] Scales", _amount = 3},
                                {_id = "[Crafting] Coal", _amount = 2}
                            }
                        },
                    },
                },
            },
            ["[Needs] Ale"] = {
                [2] = {
                    [10] = {
                        _buildings = {"Tinctury"},
                        _grade = 2,
                        _time = 126.0,
                        _productPair = {_id = "[Needs] Ale", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Food Raw] Grain", _amount = 5},
                                {_id = "[Food Raw] Roots", _amount = 5}
                            },
                            {
                                {_id = "[Vessel] Pottery", _amount = 3},
                                {_id = "[Vessel] Barrels", _amount = 2},
                                {_id = "[Vessel] Waterskin", _amount = 3}
                            }
                        },
                    },
                },
            },
            ["[Needs] Wine"] = {
                [1] = {
                    [10] = {
                        _buildings = {"Tinctury"},
                        _grade = 1,
                        _time = 84.0,
                        _productPair = {_id = "[Needs] Wine", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Food Raw] Berries", _amount = 4},
                                {_id = "[Food Raw] Mushrooms", _amount = 4},
                                {_id = "[Mat Raw] Reeds", _amount = 4}
                            },
                            {
                                {_id = "[Vessel] Pottery", _amount = 3},
                                {_id = "[Vessel] Barrels", _amount = 3},
                                {_id = "[Vessel] Waterskin", _amount = 3}
                            }
                        },
                    },
                },
            },
        },
    },
    ["Tinkerer"] = {
        _id = "Tinkerer",
        _displayName = "Tinkerer",
        _description = "Can produce:  <sprite name=[tools] simple tools> Tools (<sprite name=grade2>), <sprite name=[needs] training gear> Training Gear (<sprite name=grade2>), <sprite name=[vessel] pottery> Pottery (<sprite name=grade2>). \nRain engine: <sprite name=\"[water] storm water\"> Storm Water.",
        _iconFilename = "Tinkerer_icon.png",
        _category = "Industry",
        _categoryDisplay = "Production Building",
        _sizeX = 3,
        _sizeY = 2,
        _constructionTime = 50,
        _cityScore = 5,
        _isMovable = false,
        _isInitiallyEssential = false,
        _workerCapacity = 3,
        _constructionCosts = {
            {_id = "[Mat Processed] Planks", _amount = 5},
            {_id = "[Mat Processed] Bricks", _amount = 2}
        },
        _tags = {
            "Metallurgy",
            "Tech",
            "FoxesCooperation"
        },
        _storage = 8,
        _waterUsed = "[Water] Storm Water",
        _recipes = {
            ["[Tools] Simple Tools"] = {
                [2] = {
                    [2] = {
                        _buildings = {"Tinkerer"},
                        _grade = 2,
                        _time = 75.0,
                        _productPair = {_id = "[Tools] Simple Tools", _amount = 2},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Mat Raw] Wood", _amount = 8},
                                {_id = "[Mat Processed] Planks", _amount = 2}
                            },
                            {
                                {_id = "[Metal] Copper Bar", _amount = 3},
                                {_id = "[Metal] Crystalized Dew", _amount = 3}
                            }
                        },
                    },
                },
            },
            ["[Needs] Training Gear"] = {
                [2] = {
                    [10] = {
                        _buildings = {"Tinkerer"},
                        _grade = 2,
                        _time = 126.0,
                        _productPair = {_id = "[Needs] Training Gear", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Mat Raw] Stone", _amount = 5},
                                {_id = "[Metal] Copper Bar", _amount = 2},
                                {_id = "[Metal] Crystalized Dew", _amount = 2}
                            },
                            {
                                {_id = "[Mat Processed] Planks", _amount = 3},
                                {_id = "[Mat Raw] Reeds", _amount = 3},
                                {_id = "[Mat Raw] Leather", _amount = 3}
                            }
                        },
                    },
                },
            },
            ["[Vessel] Pottery"] = {
                [2] = {
                    [5] = {
                        _buildings = {"Tinkerer"},
                        _grade = 2,
                        _time = 84.0,
                        _productPair = {_id = "[Vessel] Pottery", _amount = 5},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Mat Raw] Clay", _amount = 3}
                            },
                            {
                                {_id = "[Mat Raw] Wood", _amount = 5},
                                {_id = "[Crafting] Oil", _amount = 2},
                                {_id = "[Crafting] Coal", _amount = 1},
                                {_id = "[Crafting] Sea Marrow", _amount = 1}
                            }
                        },
                    },
                },
            },
        },
    },
    ["Toolshop"] = {
        _id = "Toolshop",
        _displayName = "Toolshop",
        _description = "Can produce:  <sprite name=[tools] simple tools> Tools (<sprite name=grade3>), <sprite name=[mat processed] pipe> Pipes (<sprite name=grade2>), <sprite name=[needs] boots> Boots (<sprite name=grade2>). \nRain engine: <sprite name=\"[water] storm water\"> Storm Water.",
        _iconFilename = "Toolshop_icon.png",
        _category = "Industry",
        _categoryDisplay = "Production Building",
        _sizeX = 3,
        _sizeY = 2,
        _constructionTime = 40,
        _cityScore = 5,
        _isMovable = false,
        _isInitiallyEssential = false,
        _workerCapacity = 2,
        _constructionCosts = {
            {_id = "[Mat Processed] Planks", _amount = 5},
            {_id = "[Mat Processed] Fabric", _amount = 2}
        },
        _tags = {
            "Tech",
            "FoxesCooperation"
        },
        _storage = 8,
        _waterUsed = "[Water] Storm Water",
        _recipes = {
            ["[Tools] Simple Tools"] = {
                [3] = {
                    [2] = {
                        _buildings = {"Toolshop"},
                        _grade = 3,
                        _time = 60.0,
                        _productPair = {_id = "[Tools] Simple Tools", _amount = 2},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Mat Raw] Wood", _amount = 6},
                                {_id = "[Mat Processed] Planks", _amount = 1}
                            },
                            {
                                {_id = "[Metal] Copper Bar", _amount = 2},
                                {_id = "[Metal] Crystalized Dew", _amount = 2}
                            }
                        },
                    },
                },
            },
            ["[Mat Processed] Pipe"] = {
                [2] = {
                    [3] = {
                        _buildings = {"Toolshop"},
                        _grade = 2,
                        _time = 60.0,
                        _productPair = {_id = "[Mat Processed] Pipe", _amount = 3},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Metal] Copper Bar", _amount = 2},
                                {_id = "[Metal] Crystalized Dew", _amount = 2}
                            }
                        },
                    },
                },
            },
            ["[Needs] Boots"] = {
                [2] = {
                    [10] = {
                        _buildings = {"Toolshop"},
                        _grade = 2,
                        _time = 168.0,
                        _productPair = {_id = "[Needs] Boots", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Mat Raw] Leather", _amount = 4},
                                {_id = "[Mat Raw] Scales", _amount = 4}
                            }
                        },
                    },
                },
            },
        },
    },
    ["Weaver"] = {
        _id = "Weaver",
        _displayName = "Weaver",
        _description = "Can produce:  <sprite name=[mat processed] fabric> Fabric (<sprite name=grade3>), <sprite name=[needs] boots> Boots (<sprite name=grade1>), <sprite name=[needs] training gear> Training Gear (<sprite name=grade1>). \nRain engine: <sprite name=\"[water] clearance water\"> Clearance Water.",
        _iconFilename = "Weaver_icon.png",
        _category = "Industry",
        _categoryDisplay = "Production Building",
        _sizeX = 3,
        _sizeY = 2,
        _constructionTime = 40,
        _cityScore = 5,
        _isMovable = false,
        _isInitiallyEssential = false,
        _workerCapacity = 2,
        _constructionCosts = {
            {_id = "[Mat Processed] Planks", _amount = 8}
        },
        _tags = {
            "Cloth",
            "FoxesCooperation"
        },
        _storage = 8,
        _waterUsed = "[Water] Clearance Water",
        _recipes = {
            ["[Mat Processed] Fabric"] = {
                [3] = {
                    [2] = {
                        _buildings = {"Weaver"},
                        _grade = 3,
                        _time = 28.0,
                        _productPair = {_id = "[Mat Processed] Fabric", _amount = 2},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Mat Raw] Plant Fibre", _amount = 2},
                                {_id = "[Mat Raw] Reeds", _amount = 2},
                                {_id = "[Mat Raw] Algae", _amount = 2}
                            }
                        },
                    },
                },
            },
            ["[Needs] Boots"] = {
                [1] = {
                    [10] = {
                        _buildings = {"Weaver"},
                        _grade = 1,
                        _time = 168.0,
                        _productPair = {_id = "[Needs] Boots", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Mat Raw] Leather", _amount = 5},
                                {_id = "[Mat Raw] Scales", _amount = 5}
                            }
                        },
                    },
                },
            },
            ["[Needs] Training Gear"] = {
                [1] = {
                    [10] = {
                        _buildings = {"Weaver"},
                        _grade = 1,
                        _time = 126.0,
                        _productPair = {_id = "[Needs] Training Gear", _amount = 10},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Mat Raw] Stone", _amount = 8},
                                {_id = "[Metal] Copper Bar", _amount = 3},
                                {_id = "[Metal] Crystalized Dew", _amount = 3}
                            },
                            {
                                {_id = "[Mat Processed] Planks", _amount = 3},
                                {_id = "[Mat Raw] Reeds", _amount = 3},
                                {_id = "[Mat Raw] Leather", _amount = 3}
                            }
                        },
                    },
                },
            },
        },
    },
    ["Workshop"] = {
        _id = "Workshop",
        _displayName = "Workshop",
        _description = "Can produce:  <sprite name=[mat processed] planks> Planks (<sprite name=grade2>), <sprite name=[mat processed] fabric> Fabric (<sprite name=grade2>), <sprite name=[mat processed] bricks> Bricks (<sprite name=grade2>), <sprite name=[mat processed] pipe> Pipes (<sprite name=grade0>). \nRain engine: <sprite name=\"[water] storm water\"> Storm Water.",
        _iconFilename = "Workshop_icon.png",
        _category = "Industry",
        _categoryDisplay = "Production Building",
        _sizeX = 3,
        _sizeY = 3,
        _constructionTime = 20,
        _cityScore = 5,
        _isMovable = false,
        _isInitiallyEssential = false,
        _workerCapacity = 2,
        _constructionCosts = {
            {_id = "[Mat Processed] Planks", _amount = 4},
            {_id = "[Mat Processed] Bricks", _amount = 4},
            {_id = "[Mat Processed] Fabric", _amount = 4}
        },
        _tags = {
            "FoxesCooperation"
        },
        _storage = 8,
        _waterUsed = "[Water] Storm Water",
        _recipes = {
            ["[Mat Processed] Planks"] = {
                [2] = {
                    [2] = {
                        _buildings = {"Workshop"},
                        _grade = 2,
                        _time = 42.0,
                        _productPair = {_id = "[Mat Processed] Planks", _amount = 2},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Mat Raw] Wood", _amount = 5}
                            }
                        },
                    },
                },
            },
            ["[Mat Processed] Fabric"] = {
                [2] = {
                    [2] = {
                        _buildings = {"Workshop"},
                        _grade = 2,
                        _time = 42.0,
                        _productPair = {_id = "[Mat Processed] Fabric", _amount = 2},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Mat Raw] Plant Fibre", _amount = 3},
                                {_id = "[Mat Raw] Reeds", _amount = 3},
                                {_id = "[Mat Raw] Algae", _amount = 3}
                            }
                        },
                    },
                },
            },
            ["[Mat Processed] Bricks"] = {
                [2] = {
                    [2] = {
                        _buildings = {"Workshop"},
                        _grade = 2,
                        _time = 42.0,
                        _productPair = {_id = "[Mat Processed] Bricks", _amount = 2},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Mat Raw] Clay", _amount = 3},
                                {_id = "[Mat Raw] Stone", _amount = 3}
                            }
                        },
                    },
                },
            },
            ["[Mat Processed] Pipe"] = {
                [0] = {
                    [2] = {
                        _buildings = {"Workshop"},
                        _grade = 0,
                        _time = 60.0,
                        _productPair = {_id = "[Mat Processed] Pipe", _amount = 2},
                        _isService = false,
                        _ingredients = {
                            {
                                {_id = "[Metal] Copper Bar", _amount = 3},
                                {_id = "[Metal] Crystalized Dew", _amount = 3}
                            }
                        },
                    },
                },
            },
        },
    },
}