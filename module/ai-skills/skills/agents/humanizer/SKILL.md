---
name: humanizer
description: Audit, rewrite, or draft text so it carries zero AI-writing tells and makes only honest, sourced, self-consistent claims. Built from Wikipedia's "Signs of AI writing" (WikiProject AI Cleanup), open-source detector heuristics, and a writing-integrity contract. Use for ALL writing and editing tasks (blogs, LinkedIn, Quora, PR, case studies, emails, landing pages, executive ghostwriting) even when the user doesn't say "humanize". Also trigger when asked to detect AI patterns, de-AI a draft, audit claims, or check whether text would pass as human. Applies to everything except code and raw data.
---

# Humanizer v3.0.0

Two engines in one skill:

1. **Pattern engine.** Removes the ~60 patterns that mark text as AI-generated, while preserving meaning, register, and length.
2. **Integrity engine.** Enforces honest claims: no fabricated metrics, no unprovable superlatives, credible sourcing, self-consistent numbers.

A piece ships only when both pass. Human-sounding lies and honest robot-prose are both failures.

## What this skill is and isn't

The patterns flagged here are statistically more common in LLM output, but humans on autopilot produce the same shapes, especially under deadline pressure, in unfamiliar genres, or in a second language. Independent audits found false-positive rates above 60% on non-native English writers (Liang et al., Stanford, Patterns 2023) and misclassification above 70% on open-source detectors (Jabarian & Imas, BFI WP 2025-116). Adversarial paraphrase cuts detection accuracy by ~88% across every method tested (arXiv:2506.07001).

So: signals, not proof. Act on **clusters**, never a single hit. Never use this skill as the sole basis for a consequential decision about a human writer (grades, hiring, attribution).

## Modes

- **rewrite** (default): audit, then return a clean version.
- **detect**: flag only, grouped by severity, with a judgment note per flag (clear problem vs. possibly intentional). Trigger on "detect", "flag only", "audit", "scan", "what AI patterns are in this".
- **edit**: fix a named file in place with minimal targeted edits. Leave already-human passages untouched. Never edit quotes, code blocks, or text attributed to someone else; flag those instead. Re-read the file after editing and confirm resolution.

Optional flags: `--mode`, `--voice`, `--context`, `--file`, `--iterate N` (cap 2; rewrite mode already includes one corrective second pass, so iterate does not stack on it). Report convergence ("clean in 2 passes").

## Process (rewrite mode)

1. **Draft rewrite.** Fix every visible pattern.
2. **Adversarial pass.** Ask "what makes this still obviously AI?" List remaining tells by name.
3. **Integrity pass.** Run the claims checklist (section below). PASS/FAIL each item.
4. **Final rewrite.** Zero em/en dashes, all tells resolved, all claims verified or cut.
5. **Deliver** per output format.

## Hard rules (never violate)

- Rewrite, don't delete. Meaning, approximate length, register, and paragraph count survive every fix. Scrubbing a tell by cutting the sentence is a failure.
- No em dashes (—) or en dashes (–) anywhere, headings included. Catch the double-hyphen substitute (--) too. Use commas, parentheses, colons, periods.
- No fabricated statistics, named frameworks, customer quotes, or credentials. Ever. Not even "illustrative" ones presented as real.
- Never flatten quoted or secondhand text; tells inside a quote belong to the speaker.
- Never cite a source you haven't seen. No invented attributions.

## Severity tiers (for triage and quick passes)

**P0: Credibility killers (fix immediately)**
- Chatbot artifacts, sycophancy, cutoff disclaimers ("As of my last update")
- Citation markup leaks and AI-tool URL params (see Fingerprints)
- Unfilled placeholders ("[Your Name]", "2025-XX-XX")
- Vague attributions without sources ("Experts believe")
- Fabricated or unverifiable first-party metrics
- Numbers that contradict each other within the piece
- Hashtag stuffing (6+) on LinkedIn/email

**P1: Obvious AI smell (fix before publishing)**
- Tier 1 vocabulary hits; template phrases and slot-fills
- "Not just X, but Y" / negative parallelism; rule of three
- Em dash frequency; bold overuse; "Let's" transition openers
- Synonym cycling; formulaic openings ("In the rapidly evolving world of...")
- Hedge stacks ("could potentially"); generic future-narrative closers
- Social endorsement closers ("This one is worth your time:")
- Bare noun-phrase bullet walls (5+ verb-less items)
- Unprovable superlatives with no number behind them

**P2: Stylistic polish (fix when time allows)**
- Uniform paragraph/sentence length; copula avoidance
- Transition stacking (Moreover / Furthermore / Additionally)
- Generic conclusions; Title Case headings; single Tier 3 repeats

Quick pass = P0 + P1. Full audit = all three.

---

# Part 1: Pattern catalog

## A. Content tells

**A1. Significance inflation.** "Stands as a testament to", "marking a pivotal moment", "underscores its importance". State the fact; let the reader judge. Test: if the sentence still works after deleting the inflation clause, delete it.

**A2. Meaning-telling / superficial -ing tails.** "...highlighting its lasting impact", "...ensuring better outcomes", and the declarative form: "this represents a broader shift", "it speaks to a larger trend". End at the fact. If the implication is real, show a specific consequence.

**A3. Notability name-dropping.** Piling on prestigious citations ("featured in NYT, BBC, FT, and The Hindu") to manufacture credibility. One specific reference with context beats four name-drops.

**A4. Vague attributions (weasel wording).** "Studies show", "industry leaders agree", "observers have noted". Name the source or drop the claim.

**A5. Promotional puffery.** "Breathtaking", "vibrant hub", "thriving ecosystem", "world-class", "nestled". Wikipedia editors describe it as reading "like the transcript of a TV commercial". Replace with a checkable detail: "has 12 startups", "is a town in the Gonder region".

**A6. Formulaic challenges arc (the compliment sandwich).** "Despite challenges, X continues to thrive" and the full arc ("faces challenges like [negatives]... despite these, [positives]"). Name the actual challenge and the actual response, or cut.

**A7. Misconception-clearing framing.** "Contrary to popular belief...", "Many assume X. In reality..." (the reversed form is a known Grok fingerprint). Use only when a real, documented misconception exists.

**A8. Compulsive restating.** "In summary", "Overall", paragraph-end recaps, sections that open by summarizing the previous section. End on the last new point.

**A9. Novelty inflation.** "She coined the term", "a failure mode nobody talks about", "the insight everyone's missing". Describe what the person did with the concept, not that they discovered it. Assume ideas aren't novel unless verified.

**A10. Speculative gap-filling.** "Is believed to have", "likely began his career in", "maintains a relatively low public profile". Guesses formatted as facts. Worse than cutoff disclaimers because the reader can't see the gap. Cut or source.

**A11. Treadmill effect (content test).** Read each paragraph and ask "what's new here?" If you could cut 40-60% with no information loss, the piece restates instead of advancing. Name the one fact/claim/turn each paragraph contributes; if there isn't one, cut it.

## B. Language tells: tiered vocabulary

Match inflected forms (delve covers delving; leverage covers leveraging). When a variant has a separate honest sense ("real" meaning factual vs. the intensifier), judge by context.

**Tier 1: always replace** (5-20x more frequent in AI text):

| Replace | With |
|---|---|
| delve / delve into | dig into, look at, examine |
| landscape (metaphor) | field, space, industry, market |
| tapestry | (describe the actual complexity) |
| realm | area, field, domain |
| paradigm | model, approach, framework |
| embark | start, begin |
| beacon | (rewrite entirely) |
| testament to | shows, proves, demonstrates |
| robust | strong, reliable, solid |
| comprehensive | thorough, complete, full |
| cutting-edge | latest, newest, advanced |
| leverage (verb) | use |
| pivotal | important, key, critical |
| underscores | highlights, shows |
| meticulous(ly) | careful, detailed, precise |
| seamless(ly) | smooth, easy, without friction |
| game-changer / game-changing | (describe what specifically changed and why) |
| hit differently / hits different | (say what changed, or cut) |
| utilize | use |
| watershed moment | turning point, shift (or describe what changed) |
| marking a pivotal moment | (state what happened) |
| the future looks bright | (cut, or say something specific) |
| only time will tell | (cut, or say something specific) |
| nestled | is located, sits, is in |
| vibrant | (describe what makes it active, or cut) |
| thriving | growing, active (or cite a number) |
| showcasing | showing, demonstrating (or cut the clause) |
| deep dive / dive into | look at, examine |
| unpack / unpacking | explain, break down, walk through |
| bustling | busy, active (or cite what makes it busy) |
| intricate / intricacies / complexities | complex, detailed (or name the specific complexity) |
| ever-evolving | changing, growing (or describe how) |
| enduring | lasting, long-running (or cite how long) |
| daunting | hard, difficult |
| holistic(ally) | complete, full, whole (or list what's included) |
| actionable | practical, useful, concrete |
| impactful | effective, significant (or describe the impact) |
| learnings | lessons, findings, takeaways |
| thought leader(ship) | expert, authority (or describe the actual contribution) |
| best practices | what works, proven methods, standard approach |
| at its core | (cut; just state the thing) |
| synergy / synergies | (describe the actual combined effect) |
| interplay | relationship, connection |
| in order to | to |
| due to the fact that | because |
| serves as | is |
| features (verb) | has, includes |
| boasts | has |
| presents (inflated) | is, shows, gives |
| commence | start, begin |
| ascertain | find out, determine |
| endeavor | effort, attempt, try |
| keen (intensifier) | interested, eager (or cut; state the interest) |
| genuine(ly) (intensifier) | (cut; just state the fact) |
| symphony (metaphor) | (describe the actual coordination) |
| embrace (metaphor) | adopt, accept, use, switch to |

**Tier 2: flag when 2+ share a paragraph** (fine alone, suspicious together):

| Replace | With |
|---|---|
| harness | use, take advantage of |
| navigate / navigating | work through, handle, deal with |
| foster | encourage, support, build |
| elevate | improve, raise, strengthen |
| unleash | release, enable, unlock |
| streamline | simplify, speed up |
| empower | enable, let, allow |
| bolster | support, strengthen, back up |
| spearhead | lead, drive, run |
| resonate(s) with | connect with, appeal to, matter to |
| revolutionize | change, transform, reshape (or describe what changed) |
| facilitate(s) | enable, help, allow, run |
| underpin(nings) | support, form the basis of |
| nuanced | specific, subtle, detailed (or name the actual nuance) |
| crucial | important, key, necessary |
| multifaceted | (describe the actual facets, or cut) |
| ecosystem (metaphor) | system, community, network, market |
| myriad | many, numerous (or give a number) |
| plethora | many, a lot of (or give a number) |
| encompass | include, cover, span |
| catalyze | start, trigger, accelerate |
| reimagine | rethink, redesign, rebuild |
| galvanize | motivate, rally, push |
| augment | add to, expand, supplement |
| cultivate | build, develop, grow |
| illuminate / elucidate | clarify, explain, show, spell out |
| juxtapose | compare, contrast, set side by side |
| paradigm-shifting / transformative | (describe what actually shifted) |
| cornerstone | foundation, basis, key part |
| paramount | most important, top priority |
| poised (to) | ready, set, about to |
| burgeoning | growing, emerging (or cite a number) |
| nascent | new, early-stage, emerging |
| quintessential | typical, classic, defining |
| overarching | main, central, broad |

**Tier 3: flag by density only** (~3%+ of total words, or visible stacking):

| Word | What to do |
|---|---|
| significant(ly) | replace some with specifics: numbers, comparisons, examples |
| innovative / innovation | describe what's actually new |
| effective(ly) | say how, or cite a metric |
| dynamic(s) | name the actual forces or changes |
| scalable / scalability | describe what scales and to what |
| compelling | say why it compels |
| unprecedented | name the precedent it breaks (or cut) |
| exceptional(ly) / remarkable / remarkably | cite what makes it an exception |
| sophisticated | describe the sophistication |
| instrumental | say what role it played |
| world-class / state-of-the-art / best-in-class | cite a benchmark or comparison |

**Tier 3 phrases: flag at 2+ uses of one phrase, or 3+ distinct phrases in one piece** (the cluster rule matters: varied boilerplate is exactly how LLMs disguise repetition):

| Phrase | What to do |
|---|---|
| emerging sector / space / category | name the actual sector or what's emerging about it |
| the integration of X with Y | describe what's integrated and what changes for the user |
| the intersection of X and Y | pick the specific overlap that matters, or cut the framing |
| community-driven | name what the community does |
| long-term sustainability | cite the time horizon and the constraint |
| user engagement | name the action (clicks, comments, retention) |
| designed for long-term X | cut "designed for"; either it is or it isn't, then state the property |

**Transition and filler phrases: remove or rewrite on sight:**

| Phrase | Fix |
|---|---|
| Moreover / Furthermore / Additionally | restructure so the connection is obvious, or "and", "also", "on top of that" |
| In today's [X] / In an era where | cut, or state the specific context |
| It's worth noting that / Notably | just state the fact |
| Here's what's interesting / what stood out | let the content signal its own importance; if a lead-in is needed, make it specific |
| In conclusion / In summary / To summarize | the conclusion should be obvious; cut |
| When it comes to | talk about the thing directly |
| At the end of the day | cut |
| That said / That being said | cut, or "but" / "yet" (don't overuse any one) |
| It is important to note that | just state it |
| In terms of | rewrite around the actual subject |
| The reality is that | cut, or state the claim |
| Let's explore / Let's break this down / Let's dive in | start with the point; flag any "let's + verb" functioning as a transition |

## C. Syntactic skeletons and template phrases

**C1. Negative parallelism.** "It's not X, it's Y", "not just X, but Y", "not only... but also". The single most recognized tell; a 2024 EMNLP study found model text leans on such syntactic templates far more than human text. Rewrite as a direct positive statement. Max one per piece, only if it earns its place.

**C2. Rule of three.** "Innovative, transformative, and groundbreaking." Triplet adjectives, phrases, or takeaways used to fake comprehensiveness. Use one strong item, or an uneven count.

**C3. Lexical bundles.** Rigid scaffolds documented in ChatGPT-written prose: "this essay will", "the potential for", "the ability to", "the need for", "the role of", "when it comes to", "in terms of". Rewrite around the actual subject and verb.

**C4. Slot-fill constructions.** "A [adjective] step towards [adjective] AI infrastructure", "Whether you're [X] or [Y]" (false breadth; pick your real audience), "I recently had the pleasure of [verb]-ing". If the sentence sounds identical with different nouns plugged in, it's a template.

**C5. False ranges.** "From startups to enterprises", "from the Big Bang to dark matter". Sweeping, says nothing. Name the actual cases.

**C6. Hedge-stacked predictions.** "Could potentially", "may eventually unlock", "might ultimately transform". Either word alone is fine; the stack asserts nothing. Pick one.

**C7. Generic future-narrative closers.** Pattern: modal + "become" + "one of the most [adj]" + (narrative/trend/chapter/force). Grammatically a prediction, contains no testable content. Fix: make it falsifiable or cut.

**C8. Real/actual adjective inflation.** "Genuine utility", "true product-market fit", "actual reward sustainability" with no named contrast. Carve-out: if the fake version is named ("actual revenue from paying customers, not grants"), keep it; that's honest contrastive writing.

**C9. Copula avoidance.** "Serves as", "boasts", "features", "functions as", "represents" instead of is/has. Default to is/has.

**C10. Synonym cycling.** "Developers... engineers... practitioners... builders" in one paragraph. Repeat the clearest word. (Note: newer models sometimes flip to the opposite, mechanical repetition from repetition-penalty tuning. Both extremes are tells; human variation has no formula.)

**C11. Subjectless passive fragments.** "Designed for speed. Built for scale." Give the sentence a subject.

**C12. Hyphenated-pair pileups.** "A high-quality, well-architected, future-proof solution." Keep the one modifier that matters. Also fix the predicate error: hyphenate before the noun ("a high-quality report"), not after a linking verb ("the report is high quality").

## D. Formatting tells

**D1. Em/en dashes.** Zero tolerance, including headings. (Repeat of the hard rule because it's the most common miss.)

**D2. Bold overuse.** One bolded phrase per major section, or none. If it's that important, restructure to lead with it.

**D3. Bullet overkill.** Bullets only for genuinely parallel discrete items. Connected reasoning is prose. 8+ bullets in under 200 words should be a paragraph.

**D4. Inline-header lists and list-label periods.** "**Speed:** description" items, and the period-terminated label form ("- Intros. Years of conferences.") where a human writes "Intros: years of conferences". Fix period to colon, or write it as a sentence. Carve-out: a full sentence opening a bullet keeps its period.

**D5. Bare noun-phrase bullet walls.** 5+ consecutive items, each ≤6 words, adjective+noun, no verbs, all the same shape ("Stable mining efficiency / Reliable pool connectivity / ..."). Rewrite items as checkable claims ("failed shares stayed under 1% across a 12-hour run") or convert to prose. Genuine list content (changelogs, parameters, ingredients) is exempt.

**D6. Title Case Headings.** Sentence case for everything except possibly the main title.

**D7. Emojis in headers or mid-sentence.** Remove. Social posts may keep 1-2 at line ends if the writer's own voice uses them.

**D8. Hashtag stuffing.** 6+ trailing hashtags is a hard flag; LLM defaults are 10-15 while engaged human posts run 0-3. Keep 2-3 specific tags or none.

**D9. Excessive structure.** More than 3 headings in under 300 words; default scaffolding headers ("Overview", "Key Points", "Conclusion"). Merge sections; make headers say something specific.

**D10. Numbered list inflation.** "Three key takeaways", "Five things to know", "Here are the top seven". Numbered lists only when the content genuinely has that many discrete, parallel items. If you're padding to hit the number, the list shouldn't exist.

**D11. Curly quotes in plain-text contexts.** A weak paste-from-chat signal in code comments, commit messages, plaintext. Corroborating only; word processors curl quotes by default, so never flag in finished documents.

## E. Voice and chat-artifact tells

**E1. Chatbot artifacts.** "I hope this helps!", "Certainly!", "Feel free to reach out", "Let's dive in", "In this article, we will explore". Remove entirely.

**E2. Sycophancy.** "Great question!", "You're absolutely right!". Distinct from E1: it validates the reader rather than performing helpfulness. Remove.

**E3. Acknowledgment loops.** Restating the prompt before answering; opening a section by recapping the previous one. Just answer.

**E4. Cutoff disclaimers.** "As of my last update", "while specific details are limited". Find the information or remove the hedge. Never publish a sentence admitting the writer didn't look something up.

**E5. Reasoning-chain leaks.** "Let me think step by step", "Breaking this down", "Step 1:", numbered internal monologue. State the conclusion, then the evidence.

**E6. Fake-candid openers.** "Honestly? It depends.", "Here's the thing.", "Let me be real with you." Open with the substance.

**E7. Manufactured staccato drama.** "One word. Game changer." Engineered dopamine fragments. Write the point as a sentence.

**E8. Infomercial hooks.** "The catch?", "The kicker?", "Plot twist:", "The best part?" Mid-flow teasers that fake momentum. Delete the hook, state the thing.

**E9. Rhetorical question stalls.** "So why should you care?" as a section transition. If you know the answer, say it. One earned rhetorical hook max, in social contexts only.

**E10. Persuasive authority tropes.** "The reality is", "make no mistake", "fundamentally", "the real question is". The claim stands or falls on its evidence.

**E11. Confidence calibration stacking.** "Notably", "Interestingly", "Importantly", "Surprisingly". One per 2,000 words is fine; three in 500 is emphasis stacking. Flag by density.

**E12. Emotional flatline.** "What surprised me most", "I was fascinated to discover", and the header variant "Interesting part:". Claimed emotion the writing hasn't earned. If it's surprising, the content should carry that; otherwise cut the claim.

**E13. Self-labeling significance.** Back-pointing at your own list: "That last move is the contrarian one", "here's where it gets clever". If it's genuinely contrarian, the description shows it. Cut the label; let the explanation carry the weight.

**E14. Social endorsement closers.** "This one is worth your time:", "Don't sleep on this", "Thank me later", "Bookmark this." A generic recommendation that fits under any link. Fix: say what the thing is and who it's for, then let the link stand.

**E15. Aphorism formulas and parallel closers.** Neat quotable maxims; final paragraphs built as matched clause pairs ("If you do X, you get Y. If you skip X, you lose Z."). End on function: a next step, a consequence, an open question. Close asymmetrically.

**E16. Generic conclusions.** "The future looks bright", "Only time will tell", "As we move forward". End on something only this piece could say.

**E17. False concession structure.** "While X is impressive, Y remains a challenge." Sounds balanced, weighs nothing; both halves are vague. Either make the concession specific (name what's impressive, name the actual challenge) or pick a side and argue it.

**E18. Parenthetical hedging.** "(and, increasingly, Z)", "(or, more precisely, Y)", "(and perhaps more importantly, W)". Nuance-flavored non-commitment. If the aside matters, give it its own sentence. If it doesn't, cut it.

## F. Structural and rhythm tells

Structure is the #1 detection signal. Classifier-based detectors weight structural regularity above vocabulary. Fix every Tier 1 word and leave the rhythm untouched, and the text still reads as AI.

**F1. Sentence-length uniformity (low burstiness).** Three or more consecutive sentences within a few words of each other. Mix 3-8 word punches with 20+ word runs. Fragments work. Questions break monotony.

**F2. Paragraph-length uniformity / symmetric paragraphing.** Every paragraph 3-5 sentences, visually balanced. Wikipedia editors note AI organizes for visual symmetry over content flow. Some paragraphs should be one sentence.

**F3. Hourglass structure.** Opening with a synthesis, closing with a synthesis, thin specifics in between. Common in AI explainers. Lead with the news or the insight; earn any closing synthesis with new material.

**F3a. Formulaic openings.** Broad context before the point: "In the rapidly evolving world of...", scene-setting that could preface any article on the topic. Rewrite to lead with the news or the insight; context comes second, if at all.

**F4. Paragraph-reshuffle immunity (structure test).** Can you swap two body paragraphs without breaking the piece? If yes, it's a list of points, not an argument. Build a through-line where each paragraph depends on the last, or make it an honest explicit list.

**F5. Missing bridges.** Related to F4: each paragraph should connect to the previous one with logic, not with "Moreover".

**F6. Transition stacking.** Additionally / Furthermore / Moreover opening consecutive paragraphs. One per stretch, or none.

**F7. Diff-anchored writing.** Edits that touch only the flagged phrase, leaving mismatched rhythm around it. Rewrite the full sentence or paragraph around any fix.

**F8. Missing first person.** Where the genre expects a voice, relentless neutrality is itself a tell. Opinions, preferences, one concrete anecdote.

**F9. Over-polishing.** Sanding away every irregularity pushes human writing toward AI statistical profiles. Keep deliberate fragments, sentences starting with And/But, idiosyncratic word choices, slight redundancy. Applying every rule at maximum strictness creates the uniformity you're avoiding.

**F10. Vocabulary diversity (TTR).** On general prose over ~200 words, distinct-words ÷ total-words below ~0.40 warrants a second look (human English prose usually runs 0.50-0.65). Not proof: technical and second-language writing compress legitimately. Fix by broadening the what (name specific things), not by thesaurus.

## G. Fingerprints and leaks (near-definitive evidence)

These aren't patterns; they're signatures. One instance is enough to flag, even if everything else reads human. The fix is mechanical: strip completely.

- **Citation markup leaks:** `citeturn0search0`, `contentReference[oaicite:0]{index=0}`, `oai_citation`, `[attached_file:1]`, `grok_card`, and Gemini's `cite_start` / `[cite: n]` tokens.
- **AI-tool URL parameters:** `utm_source=chatgpt.com`, `utm_source=openai`, `utm_source=claude.ai`, `utm_source=perplexity.ai`, `referrer=grok.com`. Keep the URL, lose the parameter.
- **Unfilled placeholders:** `[Your Name]`, `[INSERT SOURCE URL]`, `2025-XX-XX`, empty code fences, HTML comments with "todo/insert/fill in". Fill or delete.
- **Markdown artifacts:** stray ``` fences, broken bold, mixed straight/curly quotes in one document.

**Model-specific notes** (useful in detect mode): Grok overuses pseudo-scientific vocabulary (causal, empirical, correlate) and "underscore", and favors the reversed misconception frame ("Many assume X. In reality..."). Gemini leaks `cite_start` tokens. ChatGPT leans hardest on the lexical bundles in C3 and the "not just X, but Y" skeleton. Treat these as corroborating context, not attribution proof.

---

# Part 2: Writing integrity (the honest-claims contract)

Humanizing dishonest copy just makes the lie more convincing. Every piece also passes this contract. Configure the brand block per client/company; the rules themselves are universal.

**Brand config (fill per brand):**
```
PRODUCT_IS: <the one category the product genuinely wins; e.g. "pre-hire talent assessment: skills tests, proctoring, test library">
PRODUCT_IS_NOT: <adjacent categories never to claim; e.g. "ATS, sourcing/CRM, HRIS, background checks, video interviewing">
FIRST_PARTY_DATA: <path or list of verified internal stats usable this run; empty = use none>
COMPETITOR_LIST: <path to competitor list; never cite these as sources>
```

**I1. Authority honesty.** Position the product only where it genuinely wins. On broad topics, write the broad context honestly, then locate the product at its real slice. Claiming one slice well beats claiming the whole stack vaguely. Never imply ownership of PRODUCT_IS_NOT categories; "we integrate with" is not "we replace".

**I2. Say when you're not the fit.** State plainly where the product isn't the answer (team size, niche needs). It builds trust and it's what good comparison pages already do.

**I3. No overpromising.** No guaranteed outcomes, no "this fixes hiring". Acknowledge trade-offs. Transparent beats salesy.

**I4. No unprovable superlatives.** "Ultimate / revolutionary / game-changing / seamless / world-class" with no number behind it is banned (this overlaps Tier 1 vocab, but the integrity rule is stricter: even a permitted synonym needs evidence when it makes a claim). Every strong claim carries a real, cited number or it's cut.

**I5. Differentiation with honest hypotheticals.** The piece must carry a real point of view, a non-obvious trade-off, or a concrete workflow. Clearly-labeled hypothetical scenarios are allowed ("a 500-person SaaS company hiring 20 engineers a quarter could...") tied to genuine capability. HARD BAN: no named or implied real customer without documentation, no fake quotes, no fabricated first-party metrics (win rates, time-to-hire deltas, NPS, customer counts). Real first-party data only if actually supplied for the run.

**I6. Self-consistency check.** List every number used in the piece and confirm none contradict each other (a maturity %, an adoption %, an ROI figure, and a time-to-hire must all be simultaneously possible). PASS/FAIL. Fix the conflict (re-verify or drop the weaker stat) before shipping.

**I7. Never cite a competitor.** If the only source for a stat is on COMPETITOR_LIST, drop the stat or find a neutral primary. Critique competitor approaches generically, never by name.

**I8. Cite with credibility.** Prefer the most credible and most recent source available; judge on merits, no fixed whitelist. Primary sources beat aggregators.

**I9. Cite, don't promote.** A citation is evidence for one stat, not an endorsement. Never drive traffic to another brand's content. State the fact, cite neutrally (nofollow where applicable), move on. Max 2 citations per external domain; aim for 3+ distinct domains.

**I10. No stat quota.** Don't force a fixed number of statistics and don't stuff. A few load-bearing verified stats beat many impressive-sounding ones.

---

# Part 3: Calibration

## Context profiles (strictness per audience)

Auto-detect when unspecified: under 300 words + hashtags → linkedin; code blocks → technical-blog; salutation + fundraising language → investor-email; step-by-step/README shape → docs; otherwise → blog (all rules full strength). Say which profile you inferred; the user can override.

| Rule area | linkedin | blog | technical-blog | investor-email | docs | casual |
|---|---|---|---|---|---|---|
| Em dashes | strict (house rule: zero everywhere) | strict | strict | strict | strict | strict |
| Bold / emoji | relaxed (hooks, 1-2 emoji OK) | strict | strict | strict | relaxed | skip |
| Bullets | skip (lists work here) | strict | relaxed | strict | skip | skip |
| Word tables | strict | strict | partial (see below) | strict | relaxed | P0 only |
| Promotional language | relaxed (some sell expected) | strict | strict | extra strict | strict | skip |
| Hedging | strict | strict | relaxed ("may" is accuracy) | extra strict | relaxed | skip |
| Paragraph uniformity | skip (short-form) | strict | strict | strict | relaxed | skip |
| Rhetorical questions | relaxed (1 hook OK) | strict | strict | strict | strict | skip |
| Endorsement closers | strict (the LinkedIn tell) | strict | strict | strict | skip | relaxed |
| Hashtag stuffing | strict | strict | strict | extra strict | skip | skip |
| Integrity contract (Part 2) | full | full | full | extra strict | full | I4/I5 only |

Technical-blog vocabulary exceptions (legitimate technical meaning): robust, comprehensive, seamless, ecosystem, leverage (real platform leverage/APIs), facilitate, underpin, streamline. Still flag: delve, tapestry, beacon, embark, testament to, game-changer, harness.

"Extra strict" = flag borderline instances; in an investor email one "thriving ecosystem" can sink the message. "Skip" = don't audit that category.

## Voice profiles (how it sounds; independent of context)

Voice is optional. If none named, infer from the input's register and don't impose a persona.

- **casual**: contractions throughout; ≤14-word average sentences; fragments fine; one first-person or anecdote touch; keep warm hedges ("honestly"), cut corporate ones.
- **professional**: active voice; varied lengths; one concrete claim per paragraph (number, name, date); explicit ask; low hedging.
- **technical**: plain copulatives; one idea per sentence; imperative for instructions; jargon fine, defined on first use.
- **warm**: address the reader; stronger verbs over intensifiers; no performative empathy openers; unhurried 15-20 word cadence.
- **blunt**: lead with the claim; periods for emphasis; near-zero hedging; short declaratives with an occasional long contrast sentence.

**Sample calibration beats profiles.** If the writer supplies their own writing, match its sentence-length pattern, contraction rate, openings, and recurring word choices. Don't upgrade their vocabulary: if they write "stuff", keep "stuff". Ghostwriting default (when no sample given): uneven sentence lengths, colon-led signposts ("How we solved it:"), embedded hypothetical quoted speech where natural, slight redundancy and hyphenated coinages, end on function not flourish.

**Composition rule:** voice sets the target, context sets enforcement. Where they disagree, resolve to the stricter.

## False-positive guard

- Act on clusters, not isolated tells. One "however" is not evidence.
- Don't flatten: genuine polish, genre-appropriate formal vocabulary, a single transition, intentional emphasis, curly quotes in finished docs.
- Technical/reference text should stay neutral; adding "voice" there is itself a mistake.
- Quoted examples of bad writing (including in posts about AI writing) are exempt. Only flag the author's own prose.
- If unsure whether something is a tell or the writer's style: the writer's style wins. Their sample beats this catalog.

## When to rewrite from scratch vs. patch

5+ vocabulary hits across categories + 3+ distinct pattern categories triggered + uniform rhythm = the structure itself is generated. Patching won't fix it. State the core point in one sentence and rebuild.

---

# Output formats

**Rewrite mode, long-form** (blogs, case studies, PR, reports): four sections. (1) Issues found, each quoted, grouped P0/P1/P2, with integrity PASS/FAIL lines. (2) Rewritten version. (3) What changed. (4) Second-pass audit: re-read the rewrite, fix survivors inline, note them; if clean, say so.

**Rewrite mode, short-form** (LinkedIn posts/comments, Quora, pitches, emails): final version only + one-line note on tells fixed and integrity status.

**Detect mode:** (1) Issues found by severity. (2) Assessment: which flags are clear problems vs. judgment calls that might be intentional and effective.

**Edit mode:** (1) Edits made, each with location and before → after. (2) Verification: confirm re-read, note anything deliberately left alone.

# Tone calibration (the five principles)

1. Vary sentence length. Fragments are fine.
2. Be concrete: numbers, names, dates, examples over abstractions.
3. Have a voice where the genre allows one.
4. Cut the neutrality: if the piece should take a position, take it.
5. Earn your emphasis: don't tell the reader something is interesting; make it interesting.

If the original is already strong, say so and make only the necessary cuts. The replacement tables are defaults, not mandates: if a flagged word is clearly right in context, keep it.
