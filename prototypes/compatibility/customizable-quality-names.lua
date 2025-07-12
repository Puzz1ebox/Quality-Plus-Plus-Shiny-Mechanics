-- Code Credit: https://mods.factorio.com/mod/customizable-quality-names --

if mods["customizable-quality-names"] and mods["Quality-Plus-Plus"] then
    for quality_name, _quality_data in pairs(data.raw.quality) do
        if not string.find(quality_name, "-shiny") then
            if settings.startup[quality_name .. "-custom-name-compat"] and settings.startup[quality_name .. "-custom-name-compat"].value then
                data.raw.quality[quality_name].localised_name = settings.startup[quality_name .. "-custom-name-compat"].value
                local shiny_quality = data.raw.quality[quality_name.."-shiny"]
                if shiny_quality then
                    shiny_quality.localised_name = settings.startup[quality_name .. "-custom-name-compat"].value..": Shiny"
                end
            end
        end
    end
end

if mods["customizable-quality-names"] and not mods["Quality-Plus-Plus"] then
    for quality_name, _quality_data in pairs(data.raw.quality) do
        if not string.find(quality_name, "-shiny") then
            if settings.startup[quality_name .. "-custom-name"] and settings.startup[quality_name .. "-custom-name"].value then
                local shiny_quality = data.raw.quality[quality_name.."-shiny"]
                if shiny_quality then
                    shiny_quality.localised_name = settings.startup[quality_name .. "-custom-name"].value..": Shiny"
                end
            end
        end
    end
end

-- End Code Credit --