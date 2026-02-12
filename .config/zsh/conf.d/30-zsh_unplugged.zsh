# get zsh_unplugged and store it with your other plugins
if [[ ! -d ${ZPLUGINDIR}/zsh_unplugged ]]; then
  git clone --quiet --depth 1 https://github.com/mattmc3/zsh_unplugged ${ZPLUGINDIR}/zsh_unplugged
fi
source ${ZPLUGINDIR}/zsh_unplugged/zsh_unplugged.zsh

function plugin-update {
  for d in ${ZPLUGINDIR}/*/.git(/); do
    echo "Updating ${d:h:t}..."
    command git -C "${d:h}" pull --ff --recurse-submodules --depth 1 --rebase --autostash
  done
}

# make list of the Zsh plugins you use
plugin_repos=(
  mattmc3/ez-compinit
  sindresorhus/pure # A pretty, minimal and fast ZSH prompt.
  zsh-users/zsh-completions # Additional completion definitions for ZSH
  rupa/z # Tracks your most used directories, based on 'frecency'.
  Skylor-Tang/auto-venv # Automatically activates the Python virtual environment in the current directory or its parent directories.
  
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-syntax-highlighting
  kulynyak/zsh.prepend-sudo
  zsh-users/zsh-history-substring-search
  amyreese/zsh-titles
)

# load plugins
plugin-load ${plugin_repos}