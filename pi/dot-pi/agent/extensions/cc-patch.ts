/**
 * CC Prompt Patch — patches pi's built-in provider (no token swap)
 *
 * Uses pi's OWN OAuth token. Only patches the request payload:
 * 1. Adds billing header for subscription rate-limit bucket
 * 2. Strips the separate identity prefix block that triggers detection
 *
 * Preserves pi's built-in behaviors: prompt caching, session routing,
 * compaction, tool name mapping, thinking modes, token refresh, etc.
 *
 * REQUIRES: /login (pi's normal OAuth)
 *
 * Source: https://github.com/sndrgrdn/pi/blob/master/extensions/cc-patch.ts
 */

import type { ExtensionAPI } from "@mariozechner/pi-coding-agent";

type ProviderPayload = Record<string, any>;
type ModelLike = { provider?: string; id?: string } | undefined;
type SystemBlock = { type?: string; text?: string; [key: string]: any };

function isAnthropicTarget(payload: ProviderPayload, model: ModelLike): boolean {
	const provider = typeof model?.provider === "string" ? model.provider.toLowerCase() : "";
	const modelId = typeof model?.id === "string" ? model.id.toLowerCase() : "";
	const payloadModel = typeof payload.model === "string" ? payload.model.toLowerCase() : "";

	return (
		provider.includes("anthropic") ||
		modelId.includes("claude") ||
		payloadModel.includes("anthropic") ||
		payloadModel.includes("claude")
	);
}

export default function (pi: ExtensionAPI) {
	pi.on("before_provider_request", async (event, ctx) => {
		const payload = event.payload as ProviderPayload;
		if (!payload || typeof payload !== "object") return;
		if (!Array.isArray(payload.messages)) return;
		if (!isAnthropicTarget(payload, ctx.model as ModelLike)) return;

		if (Array.isArray(payload.system)) {
			const newBlocks: unknown[] = [];

			newBlocks.push({
				type: "text",
				text: "x-anthropic-billing-header: cc_version=2.1.96.000; cc_entrypoint=cli;",
			});

			for (const block of payload.system as SystemBlock[]) {
				if (block.type !== "text" || !block.text) {
					newBlocks.push(block);
					continue;
				}
				if (block.text.startsWith("x-anthropic-billing-header")) continue;
				if (block.text.startsWith("You are") && block.text.includes("official CLI")) continue;

				newBlocks.push(block);
			}

			payload.system = newBlocks;
		} else if (typeof payload.system === "string") {
			payload.system = [
				{ type: "text", text: "x-anthropic-billing-header: cc_version=2.1.96.000; cc_entrypoint=cli;" },
				{ type: "text", text: payload.system },
			];
		}

		if (!payload.metadata) {
			payload.metadata = {
				user_id: JSON.stringify({ device_id: "0", account_uuid: "", session_id: "0" }),
			};
		}

		return payload;
	});
}
