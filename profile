# vim:ft=sh

# Guard against double-loading the profile, duplicating paths, etc.
if [ -z "$PROFILE_LOADED" ]; then
  export PROFILE_LOADED=1;

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

  # Set config dir
  export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:=${HOME}/.config}"
  export SH_CFG_DIR="${SH_CFG_DIR:=${XDG_CONFIG_HOME}/sh}"

  # Set Path
  [ -s "${SH_CFG_DIR}/path" ] && . "${SH_CFG_DIR}/path"

  # Load environment variables
  [ -s "${SH_CFG_DIR}/env" ] && . "${SH_CFG_DIR}/env"

  # Aliases
  [ -s "${SH_CFG_DIR}/aliases" ] && . "${SH_CFG_DIR}/aliases"

  # Functions
  [ -s "${SH_CFG_DIR}/functions" ] && . "${SH_CFG_DIR}/functions"

  # Set the prompt
  [ -s "${SH_CFG_DIR}/prompt" ] && . "${SH_CFG_DIR}/prompt"
fi
