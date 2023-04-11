#### Personal Fork of AppUp ####
# Adds start, stop, up and down commands when it detects:
#   - a docker-compose.yml
#   - a docker-compose.yaml
#   - a Vagrantfile
# in the current directory (e.g. your application). Just type 'up' and get coding!

# Docker
__AppUp_docker () {
  if hash docker-compose >/dev/null 2>&1; then
    # Check if docker has been started
    if [ "${APPUP_CHECK_STARTED:-true}" = true ]; then
        if hash docker-machine >/dev/null 2>&1 && [ "${APPUP_DOCKER_MACHINE:-true}" = true ]; then            
            if docker-machine status | grep -qi "Stopped"; then
                read -r -k 1 "REPLY?Docker Machine is not running, would you like to start it? [y/N] "
                echo ""
                
                if [[ "$REPLY" == "y" ]]; then
                    docker-machine start default && eval $(docker-machine env default)
                    echo ""
                else
                    return 0
                fi
            fi
        elif docker ps 2>&1 | grep -qi "Is the docker daemon running?"; then
            read -r -k 1 "REPLY?Docker for Mac is not running, would you like to start it? [y/N] "
            echo ""
            
            if [[ "$REPLY" == "y" ]]; then
                open -a Docker
                
                echo ""
                echo "Waiting for docker to start.."
                echo ""

                # Wait for it to start
                while true; do
                    if docker ps 2>&1 | grep -qi "Is the docker daemon running?" || docker ps 2>&1 | grep -qi "connection refused"; then
                        sleep 5
                    else
                        break
                    fi
                done
            else
                return0
            fi
        fi
    fi
      
    # Check YAML extension
    compose_file=''
    compose_project_file=''
    
    if [ -e "docker-compose.yml" ]; then
      compose_file='docker-compose.yml'
    elif [ -e "docker-compose.yaml" ]; then
      compose_file='docker-compose.yaml'
    fi
    
    # <cmd> <project name> will look for docker-compose.<project name>.yml
    if [ -n "$2" ]; then
      if [ -e "docker-compose.$2.yml" ]; then
          compose_project_file="docker-compose.$2.yml"
      elif [ -e "docker-compose.$2.yaml" ]; then
          compose_project_file="docker-compose.$2.yaml"
      fi
      if [ -n "$compose_project_file" ]; then 
        # Override project name from custom env
        if [ -e ".env.$2" ]; then
          project=$(source ".env.$2"; echo $COMPOSE_PROJECT_NAME)
          if [ -n $project ]; then
            docker-compose -p "${project}" -f "$compose_file" -f "$compose_project_file" $1 "${@:3}"
            return
          fi
        fi
        docker-compose -f "$compose_file" -f "$compose_project_file" $1 "${@:3}"
        return
      fi
    fi
    docker-compose $1 "${@:2}"
  else
      echo >&2 "Docker compose file found but docker-compose is not installed."
  fi
}

# Vagrant
__AppUp_vagrant () {
  if hash vagrant >/dev/null 2>&1; then
    vagrant $1 "${@:2}"
  else
    echo >&2 "Vagrant file found but vagrant is not installed."
  fi
}

# removes all aliases for AppUp
__AppUp_clearAliases () {
  if alias up > /dev/null; then
    unalias up;
  fi
  if alias down > /dev/null; then
    unalias down;
  fi
  if alias start > /dev/null; then
    unalias start;
  fi
  if alias restart > /dev/null; then
    unalias restart;
  fi
  if alias start > /dev/null; then
    unalias start;
  fi
}

# Commands
__AppUp_up () {
  if [ -e "docker-compose.yml" ] || [ -e "docker-compose.yaml" ]; then
    __AppUp_docker up "$@"
  elif [ -e "Vagrantfile" ]; then
    __AppUp_vagrant up "$@"
  elif hash up >/dev/null 2>&1; then
    env up "$@"
  fi
}

__AppUp_down () {
  if [ -e "docker-compose.yml" ] || [ -e "docker-compose.yaml" ]; then
    __AppUp_docker down "$@"
  elif [ -e "Vagrantfile" ]; then
    __AppUp_vagrant destroy "$@"
  elif hash down >/dev/null 2>&1; then
    env down "$@"
  fi
}

__AppUp_start () {
  if [ -e "docker-compose.yml" ] || [ -e "docker-compose.yaml" ]; then
    __AppUp_docker start "$@"
  elif [ -e "Vagrantfile" ]; then
    __AppUp_vagrant up "$@"
  elif hash start >/dev/null 2>&1; then
    env start "$@"
  fi
}

__AppUp_restart () {
  if [ -e "docker-compose.yml" ] || [ -e "docker-compose.yaml" ]; then
    __AppUp_docker restart "$@"
  elif [ -e "Vagrantfile" ]; then
    __AppUp_vagrant reload "$@"
  elif hash start >/dev/null 2>&1; then
    env start "$@"
  fi
}

__AppUp_stop () {
  if [ -e "docker-compose.yml" ] || [ -e "docker-compose.yaml" ]; then
    __AppUp_docker stop "$@"
  elif [ -e "Vagrantfile" ]; then
    __AppUp_vagrant halt "$@"
  elif hash stop >/dev/null 2>&1; then
    env stop "$@"
  fi
}

# checks to see if AppUp is needed (no point having aliases when we can't use them)
__AppUp_check () {
  if [ -e "docker-compose.yml" ] || [ -e "docker-compose.yaml" ] || [ -e "Vagrantfile" ]; then
    alias up='__AppUp_up';
    alias down='__AppUp_down';
    alias start='__AppUp_start';
    alias restart='__AppUp_restart';
    alias stop='__AppUp_stop';
  else
    __AppUp_clearAliases;
  fi
}

# now set up the right hook so that we check if AppUp is required in a folder
add-zsh-hook chpwd __AppUp_check
