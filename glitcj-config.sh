# Start fresh SSH agent
eval "$(ssh-agent -s)"
ssh-add -q ~/.ssh/id_ed25519_glitcj

# Export GitHub username (optional but can be used in scripts)
export GITHUB_USERNAME="glitcj"

# Git config keys to fully remove
keys=(
  user.name
  user.email
  gpg.format
  user.signingkey
  gpg.ssh.allowedSignersFile
  gpg.ssh.allowedSignersFiles
  commit.gpgsign
)

# Remove Git config keys from system, global, and local scopes
for key in "${keys[@]}"; do
  git config --system --unset-all "$key" 2>/dev/null || true
  git config --global --unset-all "$key" 2>/dev/null || true
  git config --local --unset-all "$key" 2>/dev/null || true
done


# Apply new Git configuration
git config --global user.name "glitcj"
git config --global user.email "glitcjjj@gmail.com"

git config user.name "glitcj"
git config user.email "glitcjjj@gmail.com"
