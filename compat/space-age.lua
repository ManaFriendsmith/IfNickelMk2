local rm = require("__pf-functions__/recipe-manipulation")
local tm = require("__pf-functions__/technology-manipulation")
local misc = require("__pf-functions__/misc")

if mods["Age-of-Production"] then
    require("compat.age-of-production")
end

--SPACE PLATFORM

rm.AddProduct("advanced-metallic-asteroid-crushing", "nickel-ore", 4)

if misc.difficulty > 1 then
    rm.ReplaceIngredientProportional("space-platform-foundation", "copper-cable", "electromagnetic-coil", 0.5, 10)
end

if misc.difficulty > 1 then
    if mods["BrassTacksMk2"] then
        rm.ReplaceIngredientProportional("asteroid-collector", "complex-joint", "motorized-arm", 1, 10)
    else
        rm.AddIngredient("asteroid-collector", "motorized-arm", 10)
    end

    rm.AddIngredient("thruster", "gimbaled-rocket-engine", 20)
    rm.AddIngredient("thruster", "fluid-regulator", 5)
else
    rm.AddIngredient("thruster", "high-pressure-valve", 25)
end

if data.raw.item["nitinol-plate"] then
    rm.AddIngredient("asteroid-collector", "nitinol-plate", 10)
end

if misc.difficulty == 3 then
    rm.ReplaceIngredientProportional("asteroid-collector", "electric-engine-unit", "grabber", 0.5)
end

--VULCANUS
tm.AddUnlock("foundry", "molten-nickel-from-lava", "molten-copper-from-lava")
tm.RemoveUnlock("foundry", "molten-copper-from-lava")
tm.AddUnlock("full-spectrum-magmallurgy", "molten-copper-from-lava")
if mods["BrimStuffMk2"] then
    rm.AddIngredient("molten-copper-from-lava", "malachite", 10)
end
--data.raw.recipe["molten-copper-from-lava"].hidden = true
--data.raw.recipe["molten-copper-from-lava"].hidden_in_factoriopedia = true
tm.AddUnlock("foundry", "copper-ore-from-malachite", "molten-nickel-from-lava")

tm.AddUnlock("foundry", "molten-nickel", mods["BrassTacksMk2"] and "molten-zinc" or "molten-copper")
tm.AddUnlock("foundry", "copper-ore-from-malachite", "-molten-iron")
tm.AddUnlock("foundry", "casting-nickel", "-casting-steel")
tm.AddUnlock("foundry", "casting-invar", "-casting-steel")

if misc.difficulty > 1 then
    rm.AddIngredient("big-mining-drill", "motorized-arm", 10)
    rm.ReplaceIngredientProportional("foundry", "electronic-circuit", "motorized-arm", 1, 10)
else
    rm.ReplaceIngredientProportional("foundry", "electronic-circuit", "electric-motor", 1, 10)
end

if mods["BrassTacksMk2"] then
    --keep ingredient count down
    rm.ReplaceIngredientProportional("foundry", "steel-plate", "invar-plate")
else
    rm.ReplaceIngredientProportional("foundry", "steel-plate", "invar-plate", 1, 20)
end

if data.raw.item["nitinol-plate"] then
    rm.AddIngredient("metallurgic-science-pack", "nitinol-plate", 1)
end

if misc.starting_planet == "vulcanus" then
    table.insert(data.raw["simple-entity"]["huge-volcanic-rock"].minable.results, {type="item", name="nickel-ore", amount_min=10, amount_max=30})
    table.insert(data.raw["simple-entity"]["big-volcanic-rock"].minable.results, {type="item", name="nickel-ore", amount_min=5, amount_max=10})

    tm.RemovePrerequisite("invar-processing", "logistic-science-pack")
    tm.SetTechnologyTrigger("invar-processing", "nickel-plate")
    tm.SetTechnologyTrigger("high-pressure-valve", "invar-plate")

    if misc.difficulty > 1 and not mods["BrassTacksMk2"] then
        tm.RemoveSciencePack("mechanical-engineering", "logistic-science-pack")
        tm.RemovePrerequisite("mechanical-engineering", "logistic-science-pack")
        tm.AddPrerequisite("mechanical-engineering", "automation-science-pack")
        tm.SetTechnologyCost("mechanical-engineering", 10)
    end
else
    table.insert(data.raw["simple-entity"]["huge-volcanic-rock"].minable.results, {type="item", name="nickel-ore", amount_min=5, amount_max=15})
    table.insert(data.raw["simple-entity"]["big-volcanic-rock"].minable.results, {type="item", name="nickel-ore", amount_min=2, amount_max=5})
end

if mods["LasingAroundMk2"] then
    rm.AddIngredient("lavaser", "invar-plate", 5)
    if misc.difficulty > 1 then
        if misc.starting_planet == "fulgora" then
            rm.AddIngredient("electrolaser", "electromagnetic-coil", 10)
        else
            rm.AddIngredient("electrolaser", "electromagnetic-coil", 2)
        end
        rm.ReplaceIngredientProportional("electrolaser", "processing-unit", "advanced-circuit")
        rm.ReplaceIngredientProportional("bioluminaser", "bioflux", "stem-cells", 1, 2)
    end
end

--GLEBA
tm.AddUnlock(mods["BrassTacksMk2"] and "jellynut" or "yumako", "nickel-bacteria")

if mods["BrassTacksMk2"] then
    table.insert(data.raw["simple-entity"]["iron-stromatolite"].minable.results, {type="item", name="nickel-ore", amount_min=8, amount_max=16})
else
    table.insert(data.raw["simple-entity"]["copper-stromatolite"].minable.results, {type="item", name="nickel-ore", amount_min=4, amount_max=8})
    table.insert(data.raw["simple-entity"]["iron-stromatolite"].minable.results, {type="item", name="nickel-ore", amount_min=4, amount_max=8})
end

if misc.difficulty == 1 then
    rm.AddIngredient("biochamber", "high-pressure-valve", 5)
    rm.AddIngredient("agricultural-tower", "electric-motor", 3)
else
    rm.ReplaceIngredientProportional("biochamber", "electronic-circuit", "fluid-regulator")
    if misc.difficulty == 3 and misc.starting_planet ~= "gleba" then
        rm.AddIngredient("agricultural-tower", "grabber", 1)
    else
        rm.AddIngredient("agricultural-tower", "motorized-arm", 2)
    end
end

if misc.difficulty == 3 then
    --tm.AddUnlock("bacteria-productivity", {type="change-recipe-productivity", recipe="bacteria-extraction-from-sludge", change=0.1})

    tm.RemovePrerequisite("captivity", "agricultural-science-pack")
    tm.AddPrerequisite("captivity", "tissue-cultivation")
    rm.ReplaceIngredientProportional("capture-robot-rocket", "steel-plate", "non-reversible-tremie-pipe", 0.5)
    tm.AddPrerequisite("rocket-turret", "tissue-cultivation")
    rm.ReplaceIngredientProportional("rocket-turret", "steel-plate", "non-reversible-tremie-pipe", 0.2)
end

if data.raw.item["nitinol-plate"] then
    rm.AddIngredient("heating-tower", "self-regulating-valve", 5)
end

if mods["ThemTharHillsMk2"] then
    rm.AddProduct("brain-galactification", {type="item", name="mutagenic-sludge", amount=4, probability=0.01})
else
    rm.AddProduct("brain-galactification", {type="item", name="mutagenic-sludge", amount=1, probability=0.04})
end

--FULGORA

tm.AddUnlock("recycling", "invar-separation")

--many factors affect availability + demand of nickel here. you need invar and motors to make rocket engines to export anything.
local motor_chance = 0.07

--main other nickel source from scrap absent
if rm.GetIngredientCount("battery", "nickel-plate") == 0 then
    motor_chance = 0.1
end

if misc.difficulty > 1 and mods["LasingAroundMk2"] then
    motor_chance = motor_chance - 0.01
    rm.AddProduct("weird-alien-gizmo-recycling", {type="item", name="electric-motor", amount=1, probability=0.2})
end

--rocket engines exist
if misc.difficulty == 2 then
    motor_chance = motor_chance + 0.02
end

if misc.difficulty == 3 then
    rm.AddProduct("scrap-recycling", {type="item", name="ambifacient-lunar-waneshaft", amount=1, probability=0.02})
    
    --this plus LDS should be plenty of invar for anything you need invar for without needing to make more from nickel.

    --needs more motor chance because
    --diff 2: motor -> 0.5 nickel -> 0.75 magnet in EM plant. can use prodmods to get more magnets. magnets needed for lots of things on fulgora.
    --diff 3: motor -> 0.75 magnet, no way to increase prod
    motor_chance = motor_chance + 0.03
    if mods["bztitanium"] then
        --nitinol? the valves will likely be imported in the long term but idk
        motor_chance = motor_chance + 0.01
    end
end

rm.AddProduct("scrap-recycling", {type="item", name="electric-motor", amount=1, probability=motor_chance})

if misc.difficulty > 1 then
    rm.AddIngredient("electromagnetic-plant", "electromagnetic-coil", 50)
    rm.AddIngredient("tesla-gun", "electromagnetic-coil", 25)
end

if misc.difficulty == 3 then
    rm.AddIngredient("mech-armor", "grabber", 20)
end

if misc.starting_planet == "fulgora" then
    if data.raw.technology["mechanical-engineering"] then
        data.raw.technology["mechanical-engineering"].prerequisites = {"electronics"}
        tm.SetTechnologyTrigger("mechanical-engineering", "electric-motor", 5)
    end
end

if misc.difficulty == 3 and rm.GetIngredientCount("electromagnetic-science-pack", "electric-engine-unit") == 0 then
    rm.AddIngredient("electromagnetic-science-pack", "electric-engine-unit")
end

--AQUILO

if misc.difficulty == 3 then
    --pedantry really. i mean nothing else is as on-flavor as needing electromagnets but the main cost of this will be the rocket launches
    if rm.GetIngredientCount("fusion-reactor", "electric-coil") == 0 then
        rm.AddIngredient("fusion-reactor", "electromagnetic-coil", 200)
        rm.AddIngredient("fusion-generator", "electromagnetic-coil", 100)
    end

    tm.AddUnlock("cryogenic-science-pack", "organ-preservation")
    tm.AddPrerequisite("cryogenic-science-pack", "tissue-cultivation")
    rm.AddIngredient("cryogenic-science-pack", "cardiac-bioculture")

    rm.AddIngredient("cryogenic-plant", "non-reversible-tremie-pipe", 10)

    if mods["ThemTharHillsMk2"] then
        rm.ReplaceIngredientProportional("hydrocoptic-marzelvane", "pipe", "fluid-regulator", 0.3)
    end

    rm.MultiplyRecipe("fluoroketone-cooling", 10)
    rm.AddIngredient("fluoroketone-cooling", "cooling-fan", 1)
end

if misc.difficulty > 1 then
    rm.ReplaceIngredientProportional("railgun-ammo", "copper-cable", "electromagnetic-coil")
end
