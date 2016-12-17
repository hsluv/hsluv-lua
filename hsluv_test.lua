local hsluv = require "hsluv"
local json = require "dkjson"

do
    local function assert_tuples_close(a, b)
        local string_a = string.format("(%f,%f,%f)", a[1], a[2], a[3])
        local string_b = string.format("(%f,%f,%f)", b[1], b[2], b[3])

        for i=1,#a do
            assert(math.abs(a[i] - b[i]) < 0.00000001, "Mismatch: " .. string_a .. " " .. string_b)
        end
    end

    local function assert_equal(a, b)
        assert(a == b, "Mismatch: " .. a .. " " .. b)
    end

    local file = io.open("snapshot-rev4.json", "r")
    local content = file:read("*all")
    file:close()

    local snapshot, pos, err = json.decode(content)

    for hex_color, colors in pairs(snapshot) do

        -- test forward functions
        local test_rgb = hsluv.hex_to_rgb(hex_color)
        assert_tuples_close(test_rgb, colors.rgb)
        local test_xyz = hsluv.rgb_to_xyz(test_rgb)
        assert_tuples_close(test_xyz, colors.xyz)
        local test_luv = hsluv.xyz_to_luv(test_xyz)
        assert_tuples_close(test_luv, colors.luv)
        local test_lch = hsluv.luv_to_lch(test_luv)
        assert_tuples_close(test_lch, colors.lch)
        local test_hsluv = hsluv.lch_to_hsluv(test_lch)
        assert_tuples_close(test_hsluv, colors.hsluv)
        local test_hpluv = hsluv.lch_to_hpluv(test_lch)
        assert_tuples_close(test_hpluv, colors.hpluv)

        -- test backward functions
        local test_lch = hsluv.hsluv_to_lch(colors.hsluv)
        assert_tuples_close(test_lch, colors.lch)
        local test_lch = hsluv.hpluv_to_lch(colors.hpluv)
        assert_tuples_close(test_lch, colors.lch)
        local test_luv = hsluv.lch_to_luv(test_lch)
        assert_tuples_close(test_luv, colors.luv)
        local test_xyz = hsluv.luv_to_xyz(test_luv)
        assert_tuples_close(test_xyz, colors.xyz)
        local test_rgb = hsluv.xyz_to_rgb(test_xyz)
        assert_tuples_close(test_rgb, colors.rgb)
        assert_equal(hsluv.rgb_to_hex(test_rgb), hex_color)

        -- full test
        assert_equal(hsluv.hsluv_to_hex(colors.hsluv), hex_color)
        assert_tuples_close(hsluv.hex_to_hsluv(hex_color), colors.hsluv)
        assert_equal(hsluv.hpluv_to_hex(colors.hpluv), hex_color)
        assert_tuples_close(hsluv.hex_to_hpluv(hex_color), colors.hpluv)
    end
    print "success"
end
