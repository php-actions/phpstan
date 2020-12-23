#!/bin/bash
set -e
github_action_path=$(dirname "$0")
docker_tag=$(cat ./docker_tag)
echo "Docker tag: $docker_tag" >> output.log 2>&1

phar_url="https://www.getrelease.download/phpstan/phpstan/$ACTION_VERSION/phar"
curl --silent -H "User-agent: cURL (https://github.com/php-actions)" -L "$phar_url" > "${github_action_path}/phpstan.phar"
chmod +x "${github_action_path}/phpstan.phar"

command_string=("phpstan --no-ansi")

if [ -n "$ACTION_COMMAND" ]
then
	command_string+=("$ACTION_COMMAND")
fi

if [ -n "$ACTION_PATH" ]
then
	command_string+=("$ACTION_PATH")
fi

if [ -n "$ACTION_CONFIGURATION" ]
then
	command_string+=(--configuration="$ACTION_CONFIGURATION")
fi

if [ -n "$ACTION_LEVEL" ]
then
	command_string+=(--level="$ACTION_LEVEL")
fi

if [ -n "$ACTION_PATHS_FILE" ]
then
	command_string+=(--paths-file="$ACTION_PATHS_FILE")
fi

if [ -n "$ACTION_AUTOLOAD_FILE" ]
then
	command_string+=(--autoload-file="$ACTION_AUTOLOAD_FILE")
fi

if [ -n "$ACTION_ERROR_FORMAT" ]
then
	command_string+=(--error-format="$ACTION_ERROR_FORMAT")
fi

if [ -n "$ACTION_GENERATE_BASELINE" ]
then
	command_string+=(--generate-baseline="$ACTION_GENERATE_BASELINE")
fi

if [ -n "$ACTION_MEMORY_LIMIT" ]
then
	command_string+=(--memory-limit="$ACTION_MEMORY_LIMIT")
fi

if [ -n "$ACTION_ARGS" ]
then
	command_string+=($ACTION_ARGS)
fi

echo "Command: " "${command_string[@]}" >> output.log 2>&1
docker run --rm \
	--volume "${github_action_path}/phpstan.phar":/usr/local/bin/phpstan \
	--volume "${GITHUB_WORKSPACE}":/app \
	--workdir /app \
	${docker_tag} "${command_string[@]}"
