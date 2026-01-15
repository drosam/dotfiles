local utils = require("helpers.telescope_alternate.utils")

local ruby_api_mappings = utils.mergeArrays({
	{
		"app/controllers(.*)/(.*)_controller.rb",
		{
			{ "app/models/[2:singularize].rb", "Model" },
			{ "app/serializers/[2:singularize]_serializer.rb", "Serializer", true },
			{ "spec/controllers[1]/[2]_controller_spec.rb", "Test", true },
		},
	},
	{
		"spec/controllers(.*)/(.*)_spec.rb",
		{
			{ "app/controllers[1]/[2].rb", "Controller" },
		},
	},
	{
		"app/mailers(.*)/(.*)_mailer.rb",
		{
			{ "app/views/[1][2]_mailer/*.html.erb", "View", true },
			{ "spec/mailers[1]/[2]_mailer_spec.rb", "Test", true },
		},
	},
	{
		"spec/mailers(.*)/(.*)_spec.rb",
		{
			{ "app/mailers[1]/[2].rb", "Mailer" },
		},
	},
	{
		"app/views/(.*)/(.*).html.(.*)",
		{
			{ "app/controllers/**/*[1]_controller.rb", "Controller" },
			{ "app/mailers/**/*[1].rb", "Mailer" },
			{ "app/models/[1:singularize].rb", "Model" },
			{ "app/helpers/**/*[1]_helper.rb", "Helper" },
		},
	},
	{
		"lib/tasks/(.*).thor",
		{
			{ "spec/tasks/[1]_spec.rb", "Test", true },
		},
	},
	{
		"lib/tasks/(.*).rake",
		{
			{ "spec/tasks/[1]_spec.rb", "Test", true },
		},
	},
	{
		"spec/tasks/(.*)_spec.rb",
		{
			{ "lib/tasks/[1].rake", "Rake", true },
			{ "lib/tasks/[1].thor", "THOR", true },
		},
	},
}, utils.get_ruby_mappings())

return ruby_api_mappings
