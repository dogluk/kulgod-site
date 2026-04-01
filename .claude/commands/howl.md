# Howl: Adapt a blog post for social platforms

Take a blog post from `_posts/` and generate platform-adapted versions for X, LinkedIn, Instagram, and Substack Notes. Save all output to the `howl/` directory. The goal: write once in dogluk, then howl it across every platform.

## Arguments

`$ARGUMENTS` is the post identifier. It can be:
- A filename or partial match (e.g. `dogs-as-deep-tech`, `affordances`, `turning-25`)
- A keyword to search for (e.g. `deep tech`, `willpower`)
- `latest` or empty — defaults to the most recently dated post

## Step 1: Resolve and read the source post

1. Search `_posts/` for a file matching `$ARGUMENTS`. If empty or `latest`, pick the file with the most recent date prefix.
2. If multiple matches, list them and ask the user to pick.
3. Read the full post. Extract: `title`, `date`, `permalink`, `categories`, `external_url` (if present), and the body text.
4. Determine the Substack URL:
   - If `external_url` exists and points to `tumbles.run`, use that as the canonical Substack link.
   - Otherwise, the full essay will need to be posted to Substack — note this in the output.
5. Determine the blog URL: `https://dogl.uk{permalink}`

## Step 2: Analyze the post

Before generating, identify:
- The single most arresting/provocative idea (this becomes the hook everywhere)
- The core argument or insight in 1-2 sentences
- Any quotable lines or phrases that stand on their own
- The emotional register (reflective? provocative? playful? urgent?)
- Whether there are links, images, or references worth preserving per platform

## Step 3: Generate platform adaptations

**Key principle across all platforms**: Each piece must be **self-contained** — it delivers real value and a complete thought on its own. But it should also **naturally signal** that there's a deeper essay available ("wrote about this more fully on substack", "full essay on tumbles.run", etc.). The Substack link is always the canonical destination for "read more."

**Substack URL to link**: Use the `external_url` if it points to tumbles.run. Otherwise use `https://dogl.uk{permalink}` and note that the essay should be cross-posted to Substack first.

### A. X/Twitter thread → `x.md`

- **Format**: Thread of 1-5 tweets. Each tweet MUST be under 280 characters. Count carefully.
- **Voice**: Punchy, provocative, lowercase-casual. This is Akash's native Twitter voice — think bar conversation with a smart friend, not a press release.
- **Structure**:
  - Tweet 1 (hook): The single most arresting idea, stated boldly. Should make someone stop scrolling.
  - Tweets 2-3: Develop the argument or share the most interesting supporting point. Keep each tweet self-contained enough to be retweeted alone.
  - Final tweet: A soft landing that references the full essay. Include the Substack link. Something like "wrote about this more fully here: [link]" — not "check out my blog post!!"
- **Rules**: No hashtags unless genuinely additive (1-2 max). No "thread:" prefix. No numbered tweets. Each tweet separated by `---`.

### B. LinkedIn post → `linkedin.md`

- **Format**: Single post, 800-1300 characters (sweet spot before the "see more" fold).
- **Voice**: Founder-with-substance. Professional but not corporate. First-person, grounded in real experience building Dognosis. NOT the "8 things I learned" LinkedIn-brain voice. NOT engagement bait. Think: someone who has genuine expertise sharing a real insight.
- **Structure**:
  - Opening hook (1-2 lines that stop the scroll — a counterintuitive claim, a vivid image, a question that reframes)
  - Core insight distilled to 2-3 short paragraphs
  - Natural reference to the full essay: "I wrote about this at length on my Substack" or similar
  - Substack link at the end
- **Rules**: No "Agree?" at the end. No emoji bullets. No "I'm humbled to announce." Line breaks between paragraphs for readability.

### C. Instagram caption + carousel concept → `instagram.md`

- **Format**: Two sections — a **Caption** and a **Carousel Concept**.
- **Voice**: Most personal and reflective. Lowercase-casual. The "sharing from the notebook" vibe. Can be longer (Instagram allows 2200 chars for caption).
- **Caption structure**:
  - Opening line must work as preview text (first ~125 chars are visible before "more")
  - Body that's more personal/narrative than analytical — pull from the most human, experiential parts of the essay
  - Natural mention of the full essay: "wrote about this on my substack, link in bio" or similar
  - 3-5 relevant hashtags at the bottom (genuinely relevant, not spam)
- **Carousel concept** (separate section):
  - 5-8 slides for a text-on-image carousel
  - Each slide: a short statement or quote (1-3 lines) that works as a standalone visual
  - Slide 1 is the hook/title. Last slide is the CTA ("full essay on substack" + handle).
  - Include notes on visual mood/aesthetic if relevant (minimal, dark bg, serif font, etc.)
  - Note: If Figma MCP is available, offer to generate the carousel designs. If Canva MCP is available, offer that too.

### D. Substack Note → `substack.md`

- **Format**: A Substack Note — short, punchy, 2-4 sentences max. This is NOT a full essay repost.
- **Purpose**: Drive subscribers/followers to the full essay post on Substack.
- **Voice**: Essay voice distilled to its sharpest form. The most polished single-paragraph version of the idea.
- **Structure**:
  - 1-2 sentences that capture the core provocation
  - A line that invites reading the full piece
  - Link to the full essay (Substack URL or blog URL)
- **Also include**: If the essay does NOT already exist on Substack (no `external_url` pointing to tumbles.run), include a section called `## Full Essay for Substack` with the complete post adapted for Substack's editor — proper title, suggested subtitle, and body in clean markdown.

## Step 4: Write metadata → `meta.md`

Create a `meta.md` in the same output directory with:

```
source: _posts/{filename}
blog_url: https://dogl.uk{permalink}
substack_url: {substack URL or "needs cross-post"}
generated: {today's date YYYY-MM-DD}
handles:
  twitter: @akadogluk
  linkedin: akashkulgod
  instagram: akadogluk
  substack: tumbles.run
```

## Step 5: Write all files

Save everything to `/Users/ask/gitcat/howl/{slug}/` where `{slug}` is the permalink slug (e.g. `dogsdeeptech`, `affordances`). Create the directory if it doesn't exist.

Files to write:
- `howl/{slug}/x.md`
- `howl/{slug}/linkedin.md`
- `howl/{slug}/instagram.md`
- `howl/{slug}/substack.md`
- `howl/{slug}/meta.md`

## Step 6: Distribution assist

After generating all files, help the user get to "paste and send" on each platform:

1. **Show a summary table** of what was generated, with character counts for each platform.

2. **Ask which platform to prep first.** Then for that platform:
   - **X**: Copy the hook tweet to clipboard via `pbcopy`. Print a pre-filled compose URL: `https://twitter.com/intent/tweet?text={url-encoded-hook-tweet}`. Display the remaining thread tweets clearly numbered for quick sequential paste.
   - **LinkedIn**: Copy the full post to clipboard via `pbcopy`. Suggest opening `https://www.linkedin.com/feed/?shareActive=true`.
   - **Instagram**: Copy the caption to clipboard via `pbcopy`. If Figma or Canva MCP is connected, offer to generate the carousel visuals. Otherwise, note the carousel concept is ready for manual creation.
   - **Substack**: Copy the Note to clipboard via `pbcopy`. For full essays, note it's ready to paste into the Substack editor.

3. **Cycle through remaining platforms** — ask "next platform?" and repeat.

## Voice reference

Akash's writing has these characteristics — preserve them in adaptation:
- Lowercase-casual, especially for shorter/personal pieces. Formal pieces use standard capitalization.
- Intellectual but not academic — cites thinkers (PG, Gibson, Freeman) but doesn't posture
- Dogs/biology/evolution metaphors are native vocabulary, not forced
- Punchy short sentences interspersed with longer flowing ones
- Comfortable with profanity when it serves emphasis ("fuck willpower")
- Self-aware humor, doesn't take himself too seriously
- The mystic and the operator sharing one body — can go from startup tactics to consciousness in one paragraph
- References span wide: neuroscience, philosophy, startups, history, ecology
- Often ends with a warm, direct sign-off or callback
