# humanizer
A Claude skill that audits and rewrites text on two axes at once: does it read as AI-generated, and is it telling the truth. Most humanizer tools only handle the first. That's a mistake, because the fastest way to get burned isn't a "delve" in paragraph three. It's a fabricated statistic that a prospect fact-checks.

Built from three sources:

1. Wikipedia's "Signs of AI writing" catalog (WikiProject AI Cleanup), the largest human-curated corpus of AI tells, compiled by editors who have reviewed thousands of flagged submissions since 2023
2. Open-source detector heuristics: what classifiers like Pangram actually score (structural regularity above vocabulary), tiered word-frequency research, burstiness and perplexity
3. A writing-integrity contract from running content ops at a B2B SaaS company: no fabricated metrics, no unprovable superlatives, self-consistent numbers, competitor citation rules

## What it catches

Around 60 patterns across seven layers:

- **Content tells**: significance inflation, weasel attributions, promotional puffery, novelty inflation, speculative gap-filling, the "despite challenges, continues to thrive" arc
- **Tiered vocabulary**: Tier 1 words replaced on sight (delve, robust, seamless), Tier 2 flagged in clusters (harness, foster, nuanced), Tier 3 flagged only at density (significant, innovative). Tiering exists because "crucial" once is writing; "crucial" plus "foster" plus "elevate" in one paragraph is a fingerprint
- **Syntactic skeletons**: "not just X, but Y" (the single most recognized tell), rule of three, lexical bundles ("the potential for", "the role of"), slot-fill templates, hedge stacks
- **Formatting**: em dashes, bold overuse, bare noun-phrase bullet walls, list-label periods, hashtag stuffing, Title Case
- **Voice artifacts**: chatbot leftovers, sycophancy, infomercial hooks ("The kicker?"), social endorsement closers ("This one is worth your time:"), self-labeling significance
- **Structure and rhythm**: sentence-length uniformity, symmetric paragraphing, the hourglass shape, the paragraph-reshuffle test, the treadmill test. Structure is weighted highest because it's what classifiers actually measure; you can scrub every flagged word and still get caught by rhythm
- **Fingerprints**: citation markup leaks (citeturn0search0, Gemini's cite_start), utm_source=chatgpt.com URL params, unfilled [placeholders]. These aren't patterns, they're proof, and the skill treats them as P0

Plus the integrity layer: a 10-rule claims contract covering authority honesty (claim only the category you actually win), fabrication bans, a numeric self-consistency check, and citation credibility rules. Configurable per brand.

## The guidelines at a glance

The full rulebook lives in [SKILL.md](SKILL.md) (that's the file Claude reads; this README is the map, not the territory). The short version of how it decides:

1. **Clusters, not single hits.** One "crucial" is writing. "Crucial" + "foster" + "elevate" in one paragraph is a fingerprint. Vocabulary is tiered accordingly: Tier 1 replaced on sight, Tier 2 flagged in pairs, Tier 3 flagged only at density.
2. **Rewrite, don't delete.** Meaning, length, register, and paragraph count survive every fix. Scrubbing a tell by cutting the sentence is a failure.
3. **Structure outranks vocabulary.** Uniform sentence length, symmetric paragraphs, and the hourglass shape get fixed even when every word is clean, because that's what classifiers actually score.
4. **Fingerprints are P0.** Citation markup leaks, `utm_source=chatgpt.com` params, and `[unfilled placeholders]` get stripped before anything else; one of these outs the whole piece.
5. **Claims need evidence or they die.** Every superlative carries a cited number, every stat reconciles with every other stat in the piece, no fabricated metrics or quotes, ever.
6. **The writer's style beats the catalog.** Given a writing sample, the skill matches its rhythm and tics. Fragments, mild redundancy, and odd word choices are preserved; over-polishing is itself a tell.
7. **Quoted text is exempt.** Tells inside a quote belong to the speaker.

### Before / after

Before (11 tells in 48 words):

> In today's ever-evolving hiring landscape, skills assessments aren't just a screening tool — they're a game-changer. Leading organizations leverage robust, comprehensive platforms to streamline their processes, foster better outcomes, and elevate candidate experience. The result? A seamless workflow that empowers recruiters. The future of hiring looks bright.

After:

> Most screening still runs on resume keywords, which is why shortlisted candidates keep failing basic role tests. A skills assessment moves that failure to the top of the funnel, before anyone books a call. Recruiters lose the gut-call step. They gain an afternoon per role.

What changed: the filler opener, em dash, "not just X, they're Y" skeleton, six Tier 1/2 vocabulary hits, the rule-of-three, the infomercial hook, and the generic closer are gone. The rewrite carries a checkable mechanism, varied sentence lengths (17, 19, 7, 6 words), and ends on a consequence instead of a flourish.

## What it deliberately doesn't do

- **No verdicts on human writers.** Commercial AI detectors misclassify non-native English writers at rates above 60% (Liang et al., Stanford, 2023). This skill flags patterns and explains them; it never claims proof of authorship. Clusters are signal, single hits are noise.
- **No over-scrubbing.** Sanding away every irregularity pushes human writing toward AI statistical profiles. The skill preserves fragments, mild redundancy, and idiosyncratic word choice, and it has an explicit false-positive guard: the writer's own style always beats the catalog.
- **No thesaurus laundering.** "Delve" becoming "explore" while the rhythm stays metronomic fools nobody. Fixes rewrite the sentence, not the word.

## Modes

| Mode | What it does | Trigger |
|---|---|---|
| rewrite (default) | Audit, rewrite, second-pass self-audit | "humanize this", "rewrite" |
| detect | Flag only, grouped by severity, with judgment notes | "scan this", "what AI patterns are in this" |
| edit | Fix a file in place, minimal targeted edits | "clean up draft.md directly" |

Context profiles (linkedin, blog, technical-blog, investor-email, docs, casual) adjust strictness per audience; voice profiles (casual, professional, technical, warm, blunt) set how the prose sounds. Both auto-detect. Supplying a writing sample overrides everything: the skill matches your sentence rhythm, contraction rate, and tics instead of a generic "clean" register.

## Install

Claude Code:

```
mkdir -p ~/.claude/skills/humanizer
cp SKILL.md ~/.claude/skills/humanizer/
```

Claude.ai: upload SKILL.md as a skill in Settings > Capabilities.

Then just write. The skill triggers on any drafting or editing task; you don't need to invoke it by name. To force a mode: "detect only, don't rewrite" or "edit post.md in place".

## Usage examples

```
Rewrite this LinkedIn post in my voice, here's a sample of my writing: [...]

Scan this blog draft for AI tells, flag only

Audit this case study: patterns + claims check, the numbers came from three sources

Edit landing-page.md in place, docs profile
```

## Severity model

- **P0, credibility killers**: chatbot artifacts, citation markup leaks, placeholder text, sourceless attributions, fabricated metrics, contradictory numbers. Fix before anything else.
- **P1, obvious AI smell**: word-list hits, template skeletons, hedge stacks, endorsement closers. Fix before publishing.
- **P2, polish**: uniform rhythm, transition stacking, generic conclusions. Fix when time allows.

Quick pass = P0 + P1. Full audit = everything.

## Honest caveats

The patterns here are statistical tendencies, not laws. Humans under deadline produce the same shapes. Detection research shows adversarial paraphrase defeats every automated method tested (~88% accuracy drop, arXiv:2506.07001), which is exactly why this skill focuses on making writing genuinely better rather than gaming a classifier: specific claims, varied rhythm, earned emphasis, and honest sourcing happen to be both what humans write and what good writing is.

## Sources and credit

- Wikipedia, "Signs of AI writing" (WikiProject AI Cleanup)
- Liang et al., "GPT detectors are biased against non-native English writers", Patterns (2023)
- Jabarian & Imas, BFI Working Paper 2025-116 (2025)
- arXiv:2506.07001, adversarial paraphrase vs. detection methods (2025)
- Vocabulary tiering adapted from brandonwise/humanizer; several patterns adapted from Aboudjem/humanizer-skill and blader/humanizer
- EMNLP 2024 findings on syntactic template reliance in model-generated text

MIT license. Issues and pattern submissions welcome; a pattern needs a quoted real-world example and a fix, not just a word you're tired of seeing.
