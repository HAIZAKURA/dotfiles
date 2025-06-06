function _container_list --description "List containers"
    _docker_check; or return 1

    set exited_containers
    set running_containers
    docker ps --format "{{.ID}} {{.Names}} {{.Status}}" $argv | while read -l container_id container_name container_status
        if string match -qr "Exited*" "$container_status"
            set -a exited_containers "$(set_color red)$container_id $container_name (Exited)$(set_color normal)"
        else if string match -qr "Up*" $container_status
            set -a running_containers "$(set_color green)$container_id $container_name$(set_color normal)"
        end
    end

    set all_containers $exited_containers $running_containers
    for container in $all_containers
        echo -e "$container"
    end
end
