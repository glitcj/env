

this repo is gonna be a whollistic environment setup, it assumes that the developer (myself) will always be working on mac, and it will include the tools to setup and environment of any new mac i start working on

eg it will include the following environment setups:

~/.zshrc
~/.vimrc
~/.claude

I included the "starter" .zshrc here to get things going




and it should have make targets for the following:

make push-zshrc
this target will copy the .zshrc in this repo and put it into ~/.zshrc


make push-vimrc
same but for ~/.vimrc or whatever i dont have a base for it, so u can make a simple base that shows lines syntax and a bottom bar or something

make push-claude-glitcj
this target will copy the .claude here and push it to ~/.claude-glitcj, and .zshrc would give a command alias claude-glitcj that i can from anywhere and will link to the correct settings file


make push-codex-glitch
same but for codex

make push-everything
just runs all the push commands we have, probs give a safety prompt first or smth


## so the general idea is 
- the .zshrc maintained in this repo will give all the commands and aliases that point to the correct place
- the the .zshrc we push to ~/ will "remember" where this repo's absolute path is, this will include things like an git ignored .env that ~/.zshrc will then have an alias to export ( eg an alias get-env the alias will export the env variables which live in an s3 path ill give for example)
- command aliases and more commands will be expanded over time
- by maintaing this repo, i can just update skills here or .zsh or .vimrc settings here and just push things easily, maintain a whole dev environment from one repo
- *maybe* down the line the "glitcj env" will be a full on docker container, but i think that is a bit limiting and overkill
