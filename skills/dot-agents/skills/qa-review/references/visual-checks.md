# Visual and style QA

Run this pass for every changed UI. Successful clicks, a DOM/accessibility snapshot, and a green test suite do not establish correct appearance. Visually inspect the actual screenshots, not just their filenames.

## Establish the visual oracle

1. Use the linked approved Figma node/state and project design-system rules, tokens, components, and explicit acceptance criteria. Record node URL, state/variant, reference dimensions, available version/update time, and retrieval time. Read relevant design context plus screenshot; generated design code is not a specification.
2. If Figma is absent, compare with documented design rules and representative established components/screens. A pinned base screenshot can establish regression, but capture it only in an authorized isolated baseline environment; never switch the user's branch to obtain it.
3. If the reference is stale, unavailable, conflicting, or lacks a mobile/error state, separate known contract checks from inferred consistency expectations. Ask about consequential conflicts; never invent a design or label unverified Figma fidelity as passed. Continue objective visual usability checks where safe.
4. Match viewport, device scale, browser/OS where relevant, zoom, theme, locale, font loading, content/fixture, scroll position, and interaction state. Wait for the intended settled state before comparing, while separately testing loading states. Do not compare a desktop mockup to a mobile page or ignore genuine flicker by waiting it away.

## Visual matrix

Cover the changed view and representative consumers of changed shared CSS/tokens/components. Pick viewports from project requirements/Figma. If unspecified, propose a desktop and narrow mobile viewport, record actual dimensions, and inspect relevant breakpoint boundaries; don't assert universal responsiveness from two samples.

| Dimension | Concrete checks |
| --- | --- |
| Layout | Alignment, spacing rhythm, padding/gaps, grid/flex distribution, container widths, positioning, sticky/fixed behavior, scrolling, unintended horizontal overflow |
| Typography | Loaded font/fallback, size/weight/line-height, hierarchy, wrapping/truncation, long labels, translated copy, text zoom/reflow |
| Colors and surfaces | Design tokens, foreground/background, borders/radius/shadows, selected/disabled/error states, light/dark theme when supported |
| Assets | Correct icon/image/logo, intrinsic dimensions, aspect ratio/crop, resolution, missing/broken resources, inconsistent icon size/stroke/alignment |
| Responsive behavior | Supported widths, breakpoint transitions, stacking/order, menus/dialogs, tap target usability, clipped actions, overlap, fixed headers/footers, content reflow |
| Interaction states | Hover, focus-visible, active/selected, disabled, loading, empty, validation/error, success; focus ring not clipped/obscured |
| Overlays | Dialog/popover/tooltip stacking, overflow and viewport edges, scroll lock, backdrop, keyboard focus/escape and return focus |
| Accessibility appearance | Legible contrast, non-color status cues, visible keyboard focus, zoom/reflow, reduced-motion behavior when relevant |

Use actual keyboard navigation to inspect focus, not a forced CSS pseudo-state alone. Accessibility-tree inspection helps semantics but is not a full accessibility audit. For contrast or numeric spacing claims, measure with available approved tooling/computed styles and document the method; do not invent ratios or pixel differences by eye. Missing measurement leaves a qualified observation, not fabricated precision.

## Compare and capture

- Capture matched-state page and/or component screenshots, including responsive and relevant interaction states. Pair expected/reference and actual evidence when available. Describe the location unambiguously with route, component, viewport, and state.
- Reuse the project's existing visual regression tooling if installed and permitted. Record baseline identity, threshold/config, changed regions, and observed result. Never update snapshots, baselines, styles, or tolerances to turn a mismatch green during review.
- For manual visual comparison, say manual. Do not claim pixel-perfect, measured contrast compliance, automated diff scores, or cross-browser coverage without those checks.
- Investigate apparent deltas: fonts not loaded, different content/theme/viewport, dynamic timestamps, animation, antialiasing, device scale, and stale assets. Stabilize only irrelevant variability; never hide a real defect through broad masking or DOM edits.
- Inspect console/network for missing fonts/images/styles and connect those failures to the rendered symptom. A downloaded asset is not proof of correct rendering.

## Findings and limits

Report a visual defect when supported by an applicable design requirement, demonstrated regression, or concrete usability/accessibility impact. Cite the expected source; separate subjective preference into optional suggestions only when requested. A missing Figma reference does not excuse clipped controls, unreadable text, or broken layout.

Use the same `QA-###` finding schema as functional defects, with category `visual`, `responsive`, or `accessibility`, matched viewport/state, expected/actual evidence, relevant CSS/component location if verified, impact, and a retest scenario. A cosmetic mismatch can still block when an explicit mandatory design requirement is violated; priority and blocking policy remain separate.

If screenshots cannot be captured or visually inspected, mark visual verification incomplete. If only some browsers/states/viewports were checked, name the limits. Never report the entire visual pass green merely because the primary desktop screenshot looks reasonable.
