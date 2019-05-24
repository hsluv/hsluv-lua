package = "hsluv"
version = "0.1-1"

source = {
	url = "git://github.com/hsluv/hsluv-lua.git"
}

description = {
	summary = "Human-friendly HSL",
	homepage = "http://www.hsluv.org",
	maintainer = "Alexei Boronine <alexei@boronine.com>",
	license = "MIT"
}

build = {
	type = "builtin",
	modules = {
		["hsluv"] = "hsluv.lua"
	}
}
