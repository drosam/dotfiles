# CONTEXT.md Format

Glossary only. Definitions say what a thing *is*, in one or two sentences.

```md
# {Context name}

{One or two sentences: what this context is and why it exists.}

## Language

**Order**:
A customer's request to buy specific items at a specific time.
_Avoid_: purchase, transaction

**Customer**:
A person or organization that places orders.
_Avoid_: client, buyer, account
```

## Rules

- Be opinionated: one canonical term per concept; list rejected synonyms under `_Avoid_`.
- Only project-specific concepts. General programming vocabulary (timeout, retry, DTO) does not belong.
- Group under subheadings only when natural clusters emerge.
- No implementation detail, spec prose, decisions, or scratch notes. Those belong in ADRs, specs, or the conversation.
- Edit an existing entry in place when a term is redefined; note the change to the user.

## Single vs multi-context

- Default: `.agent-work/context/CONTEXT.md`, created lazily on the first resolved term.
- Multiple contexts: `.agent-work/context/CONTEXT-MAP.md` links to `<context>/CONTEXT.md` beneath that same directory. Ask when the topic's context is unclear.
- Read existing project glossaries/maps too, but do not write outside `.agent-work/` or copy/redefine conflicting terms without clarification.

```md
# Context Map

## Contexts

- [Ordering](./ordering/CONTEXT.md): receives and tracks customer orders
- [Billing](./billing/CONTEXT.md): generates invoices and processes payments

## Relationships

- **Ordering → Billing**: Ordering emits `OrderPlaced`; Billing consumes it to invoice
```
