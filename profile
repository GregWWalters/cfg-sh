# vim:ft=sh

# Guard against double-loading the profile, duplicating paths, etc.
if [ -z "$PROFILE_LOADED" ]; then
  export PROFILE_LOADED=1;

  # Set config dir
  export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:=${HOME}/.config}"
  export SH_CFG_DIR="${SH_CFG_DIR:=${XDG_CONFIG_HOME}/sh}"

  # Set Path
  [ -s "${SH_CFG_DIR}/path" ] && source "${SH_CFG_DIR}/path"

  # Load environment variables
  [ -s "${SH_CFG_DIR}/env" ] && source "${SH_CFG_DIR}/env"

  # Aliases
  [ -s "${SH_CFG_DIR}/aliases" ] && source "${SH_CFG_DIR}/aliases"

  # Functions
  [ -s "${SH_CFG_DIR}/functions" ] && source "${SH_CFG_DIR}/functions"

  # Set the prompt
  [ -s "${SH_CFG_DIR}/prompt" ] && source "${SH_CFG_DIR}/prompt"
fi
