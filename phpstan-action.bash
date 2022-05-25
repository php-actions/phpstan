#!/bin/bash
set -e
github_action_path=$(dirname "$0")
docker_tag=$(cat ./docker_tag)
echo "Docker tag: $docker_tag" >> output.log 2>&1

phar_url="https://www.getrelease.download/phpstan/phpstan/$ACTION_VERSION/phar"
curl --silent -H "User-agent: cURL (https://github.com/php-actions)" -L "$phar_url" > "${github_action_path}/phpstan.phar"
chmod +x "${github_action_path}/phpstan.phar"

command_string=("phpstan")
command_string+=("--debug")

if [ -n "$ACTION_COMMAND" ]
then
	command_string+=("$ACTION_COMMAND")
fi

if [ -n "$ACTION_PATH" ]
then
	IFS=" "
	read -r -a splitIFS <<< "$ACTION_PATH"
	for path in "${splitIFS[@]}"
	do
		command_string+=("$path")
	done
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

dockerKeys=()
while IFS= read -r line
do
	dockerKeys+=( $(echo "$line" | cut -f1 -d=) )
done <<<$(docker run --rm "${docker_tag}" env)

while IFS= read -r line
do
	key=$(echo "$line" | cut -f1 -d=)
	if printf '%s\n' "${dockerKeys[@]}" | grep -q -P "^${key}\$"
	then
    		echo "Skipping env variable $key" >> output.log
	else
		echo "$line" >> DOCKER_ENV
	fi
done <<<$(env)

echo "Command: " "${command_string[@]}" >> output.log 2>&1
echo "::set-output name=full_command::${command_string}"

docker run --rm \
	--volume "${github_action_path}/phpstan.phar":/usr/local/bin/phpstan \
	--volume "${GITHUB_WORKSPACE}":/app \
	--workdir /app \
	--env-file ./DOCKER_ENV \
	--network host \
	${docker_tag} "${command_string[@]}"
