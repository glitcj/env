# glitcj global instructions

User-level instructions for `claude-glitcj` sessions. Maintained in the env repo
(`claude/CLAUDE.md`) and pushed to `~/.claude-glitcj/` with `just push-claude-glitcj`.


## Additional Rules Written by the Developer (Note to claude or any agent, never touch this section it will only be maintained by the developer)







- comments u write eg in python start with "# :C: " (use the language's comment symbol). one sentence per comment, max 10 words per line, max 3 lines. only the first line gets ":C:", the next lines are plain comment lines. i will replace each :C: comment with my own once i review that code, just so u know what comments u wrote and what comments i wrote in general. 

- comment the why, not the what. one comment above a function, no comment blocks, no section banners, no commented-out code.

- names say exactly what the thing is, using the project's own words: e.g., "lambda_queue" not "queue", "script_path" not "path". no abbreviations. a longer clear name beats a short vague one.

- functions are short and do one thing, readable top to bottom without scrolling. guard clauses go on one line at the top ("if x == null: return").

- keep it LEAN: write for the cases that exist today. if the set of things is fixed and known, list it in a const instead of discovering it at runtime. no "in case we need it later" options, parameters or layers.


- when u finish, tell me what u noticed but left alone, instead of doing extra work i didn't ask for.


- never remove comments starting with "# i0" or "# o-", i write those usually to cross reference against your comments and so on


- the folder path ./.artifacts/AGENT will contain files u generate and update and i generally will never or almost never touch them.

- the folder path ./.artifacts/DEVELOPER will contain files I write and maintain and u should never touch them, unless I explicitly ask u to do so and let u edit files there.


- if ever you're trying to access AWS but u need me to log in using the command "aws login", you can pause tell me to do it and i will do it, don't improvise around it if u don't have to.

- when i give u prompts i will sometimes mention o- prefixed flags like "o-blah" in the prompt, and I might mix and match these kind of o- options, here in the following I define what each one means in mini sections titled "###flag o-blah:" to explain what each flag means:


- always assume we are in o-ask mode that's the default unless i say o-do in the message in which case you make changes pls

###flag o-ask: do not make changes to any files just answer in this session

##flag o-do: you can make changes, this is the opposite of o-ask


##flag o-verify: i'll probs send u a few code lines that include code and comments you wrote and a few comments i wrote starting with # i0 or # o-, verify what my comments are saying are true, do *not* make any changes when i ask with o-verify

###flag o-review: show me a few chunks in an interactive way with one sentence to explain each. feel free to replace some parts with pseudo code in the snippets or chunks u show me, ill be cross referencing what u show me with the actual code as u show me the main snippets to review.

###flag o-diff: do not change anything. don't be too wordy and just show me the code diff lines to answer the question or achieve what is asked. would be nice if the diffs are shown in same git colours or theme or whatever.


###flag o-diffint: do not apply anything straight away. Show me the work as small chunks using the interactive question tool, each chunk a git-style diff preview (- removed, + added, a couple of unchanged lines for context) of at most about 15 changed lines. Split a big change into several chunks and walk me through them in order, up to 4 at a time. For each chunk give me three choices: "y - ok", "n - not this", and "explain" (tell me in a few lines why, then ask again). Do not write to any file until I have answered every chunk. Then apply all the approved chunks together. If I said n to a chunk that others depend on, stop and tell me which ones break before applying anything. Finish with a one-line-per-chunk summary of what was applied and skipped.

###flag o-man: do not make changes to any files, I will apply them manually. Show me exactly what to change as a git-style diff in a ```diff code block (lines starting with - for removed and + for added, with a couple of unchanged lines around each change so I can find the spot), one block per file with the file path above it. After the diff add a short table of each change and why. Keep it brief, no long explanations, and only include changes that matter.

###flag o-sum: summarise what u said before and make it less wordy, if a table or list makes sense make a table or a list, if not just summarise without being too wordy and without losing too much info, like retain at least 75% of info or 100% if u can in less wordy form

###flag o-easy: make your response high level and easy to read, avoid wordy responese.


###flag o-commit:  commit  changes and give me the final command to push, if u ever commit make sure ur name never shows up, only mine "glitcj"

###flag o-complete:  make sure whatever doc u are making or prepping is complete and self-sufficient assuming that i will be clearing the context next and next time in a new session you'll be that reading that doc or whatever for context to continue work



