events = {
    ["Acid Rain"] = {
        custom = function()

            SetPH( -3 )

        end
    },
    ["Meteor Shower"] = {
        custom = function()

            AddTemperature( 50 )

        end
    },
    ["Thermal Vent"] = {
        custom = function()

            AddTemperature( 60 )

        end
    },
    ["Disease"] = {
        custom = function()

            local species = math.Random( 1, 3 )

            if species == 1 then

                -- kill them

            end

            if species == 2 then

                --kill them

            end

            if species == 3 then

                --kill them

            end

        end
    }
}
