# vim:ft=sh

# Set config dir
if [ -n "$XDG_CONFIG_HOME" ]; then
	XDG_CONFIG_HOME="${HOME}/.config"
fi
sh_config="${XDG_CONFIG_HOME}/sh"

# Load environment variables
[ -s "${sh_config}/env" ] && source "${sh_config}/env"

# Set Path
[ -s "${sh_config}/path" ] && source "${sh_config}/path"

# Aliases
[ -s "${sh_config}/aliases" ] && source "${sh_config}/aliases"

# Functions
[ -s "${sh_config}/functions" ] && source "${sh_config}/functions"

# Set the prompt
[ -s "${sh_config}/prompt" ] && source "${sh_config}/prompt"

