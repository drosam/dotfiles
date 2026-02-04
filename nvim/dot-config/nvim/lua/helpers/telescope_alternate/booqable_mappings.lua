local utils = require("helpers.telescope_alternate.utils")

-- Booqable-specific mappings for Rails 8 + React project

local booqable_mappings = {
	-- ============================================
	-- BACKEND MAPPINGS
	-- ============================================

	-- Models
	{
		"app/models/(.*).rb",
		{
			{ "app/resources/[1]_resource.rb", "Resource", true },
			{ "app/serializers/[1]_serializer.rb", "Serializer", true },
			{ "app/policies/[1]_policy.rb", "Policy", true },
			{ "spec/factories/[1:pluralize].rb", "Factory", true },
			{ "spec/models/[1]_spec.rb", "Spec", true },
		},
	},
	{
		"spec/models/(.*)_spec.rb",
		{
			{ "app/models/[1].rb", "Model" },
			{ "app/resources/[1]_resource.rb", "Resource", true },
			{ "app/serializers/[1]_serializer.rb", "Serializer", true },
			{ "spec/factories/[1:pluralize].rb", "Factory", true },
		},
	},

	-- Resources
	{
		"app/resources/(.*)_resource.rb",
		{
			{ "app/models/[1].rb", "Model", true },
			{ "app/serializers/[1]_serializer.rb", "Serializer", true },
			{ "spec/resources/[1]_resource_spec.rb", "Spec", true },
		},
	},
	{
		"spec/resources/(.*)_resource_spec.rb",
		{
			{ "app/resources/[1]_resource.rb", "Resource" },
			{ "app/models/[1].rb", "Model", true },
		},
	},

	-- Serializers
	{
		"app/serializers/(.*)_serializer.rb",
		{
			{ "app/models/[1].rb", "Model", true },
			{ "app/resources/[1]_resource.rb", "Resource", true },
			{ "spec/serializers/[1]_serializer_spec.rb", "Spec", true },
		},
	},
	{
		"spec/serializers/(.*)_serializer_spec.rb",
		{
			{ "app/serializers/[1]_serializer.rb", "Serializer" },
			{ "app/models/[1].rb", "Model", true },
		},
	},

	-- Policies
	{
		"app/policies/(.*)_policy.rb",
		{
			{ "app/models/[1].rb", "Model", true },
			{ "spec/policies/[1]_policy_spec.rb", "Spec", true },
		},
	},
	{
		"spec/policies/(.*)_policy_spec.rb",
		{
			{ "app/policies/[1]_policy.rb", "Policy" },
			{ "app/models/[1].rb", "Model", true },
		},
	},

	-- Interactors (domain-nested: app/interactors/orders/create.rb)
	{
		"app/interactors/(.*)/(.*)%.rb",
		{
			{ "spec/interactors/[1]/[2]_spec.rb", "Spec", true },
			{ "app/models/[1:singularize].rb", "Model", true },
		},
	},
	{
		"spec/interactors/(.*)/(.*)_spec.rb",
		{
			{ "app/interactors/[1]/[2].rb", "Interactor" },
			{ "app/models/[1:singularize].rb", "Model", true },
		},
	},
	-- Interactors (flat: app/interactors/create_order.rb)
	{
		"app/interactors/([^/]+)%.rb",
		{
			{ "spec/interactors/[1]_spec.rb", "Spec", true },
		},
	},
	{
		"spec/interactors/([^/]+)_spec.rb",
		{
			{ "app/interactors/[1].rb", "Interactor" },
		},
	},

	-- Workers (domain-nested: app/workers/orders/process_worker.rb)
	{
		"app/workers/(.*)/(.*)_worker.rb",
		{
			{ "spec/workers/[1]/[2]_worker_spec.rb", "Spec", true },
			{ "app/models/[1:singularize].rb", "Model", true },
		},
	},
	{
		"spec/workers/(.*)/(.*)_worker_spec.rb",
		{
			{ "app/workers/[1]/[2]_worker.rb", "Worker" },
			{ "app/models/[1:singularize].rb", "Model", true },
		},
	},
	-- Workers (flat: app/workers/process_order_worker.rb)
	{
		"app/workers/([^/]+_worker).rb",
		{
			{ "spec/workers/[1]_spec.rb", "Spec", true },
		},
	},
	{
		"spec/workers/([^/]+_worker)_spec.rb",
		{
			{ "app/workers/[1].rb", "Worker" },
		},
	},

	-- Controllers (handles namespaces like admin/, api/v1/, back_office/)
	{
		"app/controllers(.*)/(.*)_controller.rb",
		{
			{ "spec/controllers[1]/[2]_controller_spec.rb", "Spec", true },
			{ "spec/requests[1]/[2]_spec.rb", "Request Spec", true },
			{ "app/models/[2:singularize].rb", "Model", true },
		},
	},
	{
		"spec/controllers(.*)/(.*)_controller_spec.rb",
		{
			{ "app/controllers[1]/[2]_controller.rb", "Controller" },
			{ "app/models/[2:singularize].rb", "Model", true },
		},
	},
	{
		"spec/requests(.*)/(.*)_spec.rb",
		{
			{ "app/controllers[1]/[2]_controller.rb", "Controller", true },
			{ "app/models/[2:singularize].rb", "Model", true },
		},
	},

	-- Uploaders
	{
		"app/uploaders/(.*)_uploader.rb",
		{
			{ "spec/uploaders/[1]_uploader_spec.rb", "Spec", true },
		},
	},
	{
		"spec/uploaders/(.*)_uploader_spec.rb",
		{
			{ "app/uploaders/[1]_uploader.rb", "Uploader" },
		},
	},

	-- Mailers
	{
		"app/mailers/(.*)_mailer.rb",
		{
			{ "spec/mailers/[1]_mailer_spec.rb", "Spec", true },
			{ "app/views/[1]_mailer/*.html.erb", "Views", true },
		},
	},
	{
		"spec/mailers/(.*)_mailer_spec.rb",
		{
			{ "app/mailers/[1]_mailer.rb", "Mailer" },
			{ "app/views/[1]_mailer/*.html.erb", "Views", true },
		},
	},

	-- Event Listeners (domain-nested)
	{
		"app/event_listeners/(.*)/(.*)_event_listener.rb",
		{
			{ "spec/event_listeners/[1]/[2]_event_listener_spec.rb", "Spec", true },
		},
	},
	{
		"spec/event_listeners/(.*)/(.*)_event_listener_spec.rb",
		{
			{ "app/event_listeners/[1]/[2]_event_listener.rb", "Event Listener" },
		},
	},

	-- Queries
	{
		"app/queries/(.*).rb",
		{
			{ "spec/queries/[1]_spec.rb", "Spec", true },
		},
	},
	{
		"spec/queries/(.*)_spec.rb",
		{
			{ "app/queries/[1].rb", "Query" },
		},
	},

	-- Validators
	{
		"app/validators/(.*).rb",
		{
			{ "spec/validators/[1]_spec.rb", "Spec", true },
		},
	},
	{
		"spec/validators/(.*)_spec.rb",
		{
			{ "app/validators/[1].rb", "Validator" },
		},
	},

	-- Factories (plural -> singular for model)
	{
		"spec/factories/(.*).rb",
		{
			{ "app/models/[1:singularize].rb", "Model", true },
			{ "app/resources/[1:singularize]_resource.rb", "Resource", true },
			{ "spec/models/[1:singularize]_spec.rb", "Model Spec", true },
		},
	},

	-- ============================================
	-- FRONTEND MAPPINGS (webpack/)
	-- ============================================

	-- Components with index file (webpack/*/components/Button/index.jsx)
	{
		"webpack/(.*)/components/([^/]+)/index%.[jt]sx?$",
		{
			{ "webpack/[1]/components/[2]/__tests__/[2].test.jsx", "Test", true },
			{ "webpack/[1]/components/[2]/__tests__/[2].test.tsx", "Test", true },
			{ "webpack/[1]/components/[2]/[2].test.jsx", "Test", true },
			{ "webpack/[1]/components/[2]/[2].test.tsx", "Test", true },
			{ "webpack/[1]/components/[2]/[2].stories.jsx", "Story", true },
			{ "webpack/[1]/components/[2]/[2].stories.tsx", "Story", true },
		},
	},
	-- Component tests back to component
	{
		"webpack/(.*)/components/([^/]+)/__tests__/([^/]+).test%.[jt]sx?$",
		{
			{ "webpack/[1]/components/[2]/index.jsx", "Component", true },
			{ "webpack/[1]/components/[2]/index.tsx", "Component", true },
			{ "webpack/[1]/components/[2]/[3].jsx", "Component", true },
			{ "webpack/[1]/components/[2]/[3].tsx", "Component", true },
		},
	},
	-- Component stories back to component
	{
		"webpack/(.*)/components/([^/]+)/([^/]+).stories%.[jt]sx?$",
		{
			{ "webpack/[1]/components/[2]/index.jsx", "Component", true },
			{ "webpack/[1]/components/[2]/index.tsx", "Component", true },
			{ "webpack/[1]/components/[2]/[3].jsx", "Component", true },
			{ "webpack/[1]/components/[2]/[3].tsx", "Component", true },
		},
	},

	-- Components with named file (webpack/*/components/Button/Button.jsx)
	{
		"webpack/(.*)/components/([^/]+)/([^/]+)%.[jt]sx?$",
		{
			{ "webpack/[1]/components/[2]/__tests__/[3].test.jsx", "Test", true },
			{ "webpack/[1]/components/[2]/__tests__/[3].test.tsx", "Test", true },
			{ "webpack/[1]/components/[2]/[3].test.jsx", "Test", true },
			{ "webpack/[1]/components/[2]/[3].test.tsx", "Test", true },
			{ "webpack/[1]/components/[2]/[3].stories.jsx", "Story", true },
			{ "webpack/[1]/components/[2]/[3].stories.tsx", "Story", true },
		},
	},

	-- Redux Reducers
	{
		"webpack/(.*)/redux/reducers/(.*).js",
		{
			{ "webpack/[1]/redux/actions/[2].js", "Actions", true },
			{ "webpack/[1]/redux/selectors/[2].js", "Selectors", true },
			{ "webpack/[1]/redux/reducers/__tests__/[2].test.js", "Test", true },
		},
	},
	{
		"webpack/(.*)/redux/reducers/__tests__/(.*).test.js",
		{
			{ "webpack/[1]/redux/reducers/[2].js", "Reducer" },
			{ "webpack/[1]/redux/actions/[2].js", "Actions", true },
			{ "webpack/[1]/redux/selectors/[2].js", "Selectors", true },
		},
	},

	-- Redux Actions
	{
		"webpack/(.*)/redux/actions/(.*).js",
		{
			{ "webpack/[1]/redux/reducers/[2].js", "Reducer", true },
			{ "webpack/[1]/redux/selectors/[2].js", "Selectors", true },
			{ "webpack/[1]/redux/actions/__tests__/[2].test.js", "Test", true },
		},
	},
	{
		"webpack/(.*)/redux/actions/__tests__/(.*).test.js",
		{
			{ "webpack/[1]/redux/actions/[2].js", "Actions" },
			{ "webpack/[1]/redux/reducers/[2].js", "Reducer", true },
		},
	},

	-- Redux Selectors
	{
		"webpack/(.*)/redux/selectors/(.*).js",
		{
			{ "webpack/[1]/redux/reducers/[2].js", "Reducer", true },
			{ "webpack/[1]/redux/actions/[2].js", "Actions", true },
			{ "webpack/[1]/redux/selectors/__tests__/[2].test.js", "Test", true },
		},
	},
	{
		"webpack/(.*)/redux/selectors/__tests__/(.*).test.js",
		{
			{ "webpack/[1]/redux/selectors/[2].js", "Selectors" },
			{ "webpack/[1]/redux/reducers/[2].js", "Reducer", true },
		},
	},
}

return booqable_mappings
