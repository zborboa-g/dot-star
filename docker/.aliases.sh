docker_psa() {
    clear

    ps_result=$(docker ps --all --format "table {{.Image}}\t{{.Names}}\t{{.Ports}}\t{{.Status}}")
    ps_table_header=$(echo "${ps_result}" | head --lines=1)
    ps_table_rows_up=$(
        echo "${ps_result}" |
        tail --lines=+2 |
        \grep "Up" |
        # List running instances first.
        sort --ignore-leading-blanks --version-sort --key=4 --key=2 --key=1
    )
    ps_table_rows_exited=$(
        echo "${ps_result}" |
        tail --lines=+2 |
        \grep "Exited" |
        # List running instances first.
        sort --ignore-leading-blanks --version-sort --key=4 --key=2 --key=1
    )

    i=0
    echo "${ps_table_header}"
    echo "${ps_table_rows_up}" | while read row; do
        if [ $(( $i % 2 )) -eq 0 ]; then
            echo -e "\e[48;5;235m${row}\e[0m"
        else
            echo -e "\e[48;5;232m${row}\e[0m"
        fi
        ((i+=1))
    done
    echo "${ps_table_rows_exited}" | while read row; do
        echo -e "\e[2;40;97m${row}\e[0m"
        ((i+=1))
    done
    echo

    images_result="$(docker images)"
    images_table_header=$(echo "${images_result}" | head --lines=1)
    images_table_rows=$(
        echo "${images_result}" |
        tail --lines=+2
    )
    echo "${images_table_header}"
    echo "${images_table_rows}" | while read row; do
        if [ $(( $i % 2 )) -eq 0 ]; then
            echo -e "\e[48;5;235m${row}\e[0m"
        else
            echo -e "\e[48;5;232m${row}\e[0m"
        fi
        ((i+=1))
    done
}

docker_image_prune() {
    # Use `docker image prune --all' for removing dangling and ununsed images
    # (images not referenced by any container).
    docker image prune --all
}

alias attach="docker attach"
alias dc="docker"
alias doc="docker"
alias img="clear; docker images; echo; docker ps -a"
alias pause="docker pause"
alias prune="docker_image_prune"
alias psa="docker_psa"
alias rmi="clear; docker rmi"
alias stop="docker stop"
