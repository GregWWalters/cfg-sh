# vim:ft=sh

# Set config dir
XDG_DATA_HOME="${XDG_DATA_HOME:=$HOME/.local/share}"
XDG_CONFIG_HOME="${XDG_CONFIG_HOME:=$HOME/.config}"
SH_CFG_DIR="${SH_CFG_DIR:=$XDG_CONFIG_HOME/sh}"

# Guard against double-loading the profile, duplicating paths, etc.
if [ -z "$PROFILE_LOADED" ]; then
  PROFILE_LOADED=1;

  # Try to determine OS for system-specific settings
  PLATFORM='unknown'
  case "$(uname -s | tr '[:upper:]' '[:lower:]')" in
    'linux'*)
      PLATFORM='linux'
      ;;
    'msys'*|'mingw'*|'cygwin'*|'windows'*)
      PLATFORM='windows'
      ;;
    'darwin'*|'freebsd'*|'netbsd'*|'openbsd'*|'bsd'*)
      PLATFORM='bsd'
      ;;
  esac

  # Try to determine running shell
  SHELL_TYPE="$(ps -o args= $$)"
  case ${SHELL_TYPE%% *} in
    zsh|-zsh|*/zsh)
      SHELL_TYPE='zsh'
      ;;
    bash|-bash|*/bash)
      SHELL_TYPE='bash'
      ;;
    ash|-ash|*/ash)
      # assume base POSIX functionality
      SHELL_TYPE='sh'
      ;;
    dash|-dash|*/dash)
      # assume base POSIX functionality
      SHELL_TYPE='sh'
      ;;
    ksh|-ksh|*/ksh)
      # assume base POSIX functionality
      SHELL_TYPE='sh'
      ;;
    sh|-sh|*/sh)
      # assume base POSIX functionality
      SHELL_TYPE='sh'
      ;;
    *)
      # if unrecognized, leave it as the output
      ;;
  esac

  # Splash screen
  [ -s "${SH_CFG_DIR}/splash" ] && sh "${SH_CFG_DIR}/splash"

  # Prompt must be sourced later from "${SH_CFG_DIR}/prompt"

  export PLATFORM SHELL_TYPE XDG_DATA_HOME XDG_CONFIG_HOME SH_CFG_DIR
fi

# Get SWAYSOCK if running inside tmux
swaymsg(){
  export SWAYSOCK=$XDG_RUNTIME_DIR/sway-ipc.$UID.$(pgrep -x sway).sock
  command swaymsg "$@"
}

# Homebrew
if brewbin=$(which brew 2>/dev/null); then
	eval "$($brewbin shellenv)"
elif [ -x '/opt/homebrew/bin/brew' ]; then
	eval $(/opt/homebrew/bin/brew shellenv)
elif [ -x '/usr/local/bin/brew' ]; then
	eval $(/usr/local/bin/brew shellenv)
fi

# Set Path
[ -s "${SH_CFG_DIR}/path" ] && . "${SH_CFG_DIR}/path"

# Load environment variables
[ -s "${SH_CFG_DIR}/env" ] && . "${SH_CFG_DIR}/env"

# Scripts
[ -s "${SH_CFG_DIR}/scripts" ] && . "${SH_CFG_DIR}/scripts"

# Aliases
[ -s "${SH_CFG_DIR}/aliases" ] && . "${SH_CFG_DIR}/aliases"

# Functions
[ -s "${SH_CFG_DIR}/functions" ] && . "${SH_CFG_DIR}/functions"

