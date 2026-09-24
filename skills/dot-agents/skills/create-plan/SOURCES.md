# Create Plan Sources

Retrieved: 2026-09-24. Class: workflow-process; shape: phased plan/validate workflow.

| Source | Trust tier | Confidence | Usage constraints |
| --- | --- | --- | --- |
| Local skill and history `f1ff2f87ff72e170bf897326c1a6f60b64cc308e` | canonical local | high | Preserve research/findings/doc/walkthrough/approval phases |
| https://github.com/getsentry/skills/tree/c2f99a5b04b4cd992ec3022d7c2c3e23e938d241/skills/skill-writer | secondary authoring patterns | high | Guidance only; not claimed as original create-plan source |

Decision: narrow unsolicited activation, permit bounded direct reads on denied delegation, distinguish design acceptance from implementation authority. Preserve output destination and one-step walkthrough.

Coverage/profile: workflow preconditions, phases, fallback, safety and handoff covered; inline template and good/bad interaction examples retained. Desk checks: research request → findings before file; review complete → no code; blocked worker → direct reads or explicit gap. Negative trigger: already-approved small fix.

Stop: local process is authoritative; generic planning searches would not establish lineage. Gap: exact original unrecorded; ask owner for URL before claiming upstream synchronization. Strict validator blocked by missing PyYAML; no behavioral benchmark.
