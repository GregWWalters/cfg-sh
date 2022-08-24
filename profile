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

  # Set Path
  [ -s "${SH_CFG_DIR}/path" ] && . "${SH_CFG_DIR}/path"

  # Load environment variables
  [ -s "${SH_CFG_DIR}/env" ] && . "${SH_CFG_DIR}/env"

  # Aliases
  [ -s "${SH_CFG_DIR}/aliases" ] && . "${SH_CFG_DIR}/aliases"

  # Functions
  [ -s "${SH_CFG_DIR}/functions" ] && . "${SH_CFG_DIR}/functions"

  # Set the prompt
  # [ -s "${SH_CFG_DIR}/prompt" ] && . "${SH_CFG_DIR}/prompt"
  # this needs to be sourced later

  # Load nvm (Node Version Manager)
  if [ -n ${NVM_DIR+x} ]; then

    case $SHELL_TYPE in
      bash|zsh)
        # This loads nvm bash_completion
        [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
        ;;
    esac

    # Only load NVM when needed so not to slow down shell startup
    nvm() {
      [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
      nvm "$@"
    }
  fi

  export PLATFORM SHELL_TYPE XDG_DATA_HOME XDG_CONFIG_HOME SH_CFG_DIR
fi

