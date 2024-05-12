n=1276435g
function is_digit {
    str=$1
    digit_or_not=$(echo $str | awk '/^[0-9]+$/{print$1}')
    if [[ -n $digit_or_not ]]
    then
        echo "Это число"
    else
        echo "Это не число"
    fi
}

is_digit $n







