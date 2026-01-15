local M = {}

function M.mergeArrays(a, b)
	local z = {}
	local n = 0
	for _, v in ipairs(a) do
		n = n + 1
		z[n] = v
	end
	for _, v in ipairs(b) do
		n = n + 1
		z[n] = v
	end
	return z
end

function M.generate_spec_mapping(base_path, mapping)
	return {
		{
			base_path .. "/" .. mapping .. "/(.*).rb",
			{
				{ "spec/" .. mapping .. "/[1]_spec.rb", "Test", true },
			},
		},
		{
			"spec/" .. mapping .. "/(.*)_spec.rb",
			{
				{ base_path .. "/" .. mapping .. "/[1].rb", "Model", true },
			},
		},
	}
end

function M.get_ruby_mappings()
	local ruby_mappings = {}

	for _, mapping in ipairs({
		"models",
		"serializers",
		"policies",
		"jobs",
		"helpers",
	}) do
		ruby_mappings = M.mergeArrays(ruby_mappings, M.generate_spec_mapping("app", mapping))
	end

	for _, mapping in ipairs({ "request", "service" }) do
		ruby_mappings = M.mergeArrays(ruby_mappings, M.generate_spec_mapping("lib", mapping))
	end

	return ruby_mappings
end

return M
