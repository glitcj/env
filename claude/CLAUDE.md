# glitcj global instructions

User-level instructions for `claude-glitcj` sessions. Maintained in the env repo
(`claude/CLAUDE.md`) and pushed to `~/.claude-glitcj/` with `just push-claude-glitcj`.


## Additional Rules Written by the Developer (Note to claude or any agent, never touch this section it will only be maintained by the developer)

- the folder path ./AGENT will contain files u generate and update and i generally will never or almost never touch them.

- the folder path ./DEVELOPER will contain files I write and maintain and u should never touch them, unless I explicitly ask u to do so and let u edit files there.


- if ever you're trying to access AWS but u need me to log in using the command "aws login", you can pause tell me to do it and i will do it, don't improvise around it if u don't have to.

- when i give u prompts i will sometimes mention o- prefixed flags like "o-blah" in the prompt, and I might mix and match these kind of o- options, here in the following I define what each one means in mini sections titled "###flag o-blah:" to explain what each flag means:

###flag o-easy: make your response high level and easy to read, avoid wordy responese.

###flag o-ask: do not make changes to any files just answer in this session

###flag o-commit:  commit  changes and give me the final command to push, if u ever commit make sure ur name never shows up, only mine "glitcj"

###flag o-complete:  make sure whatever doc u are making or prepping is complete and self-sufficient assuming that i will be clearing the context next and next time in a new session you'll be that reading that doc or whatever for context to continue work



