require("__Quality-Plus-Plus-Shiny-Mechanics__.prototypes.quality")

-- reorder the standard qualities

    local normal = data.raw.quality["normal"]
    normal.next = "uncommon-shiny"

    local uncommon = data.raw.quality["uncommon"]
    uncommon.next = "rare-shiny"

    local rare = data.raw.quality["rare"]
    rare.next = "epic-shiny"

    local epic = data.raw.quality["epic"]
    epic.next = "legendary-shiny"

    

-- TODO: Write dynamic compatibility for Customizable Quality Names mod

require("__Quality-Plus-Plus-Shiny-Mechanics__.prototypes.compatibility.customizable-quality-names")