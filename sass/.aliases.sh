sasswatch() {
    param_count="${#}"
    command="style.scss:style.css"

    if [ "${param_count}" -ge 1 ]; then
        command="${@}"
    fi

    sass \
        --style "expanded" \
        --unix-newlines \
        --watch "${command}"
}