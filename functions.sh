function check_login {
    login=$1
    db_name=$2
    separator=$3
    if [[ -f $db_name ]]
    then
        for line in $(cat $db_name)
        do
            if [[ $line == $login$separator* ]]
            then
                return 1
            fi
        done
    fi
}

function hash_pswd {
    echo $1 | sha256sum | awk '{print $1}'
}

function check_number {
    number=$1
    while [[ $number_checked != true ]]
    do
        number1="$number"
        number1=${number1: 0:1}
        if [[ $number1 -eq 0 ]]
        then
            echo "Ноль не может быть первой цифрой в числе"
            read -p "Повторите попытку: " number
            continue
        fi
        if [[ $number -le 999 ]] || [[ $number -gt 9999 ]]
        then
            echo "Число должно быть четырехзначным"
            read -p "Повторите попытку: " number
        else
            number_checked=true
        fi
    done
}

function number_to_digits {
    number=$1
    digit4=$(($number%10))
    let "digit3 = $number / 10"
    digit3=$(($digit3%10))
    let "digit2 = $number / 100"
    digit2=$(($digit2%10))
    let "digit1 = $number / 1000"
}

function rewrite_coins {
    temp=temp_file
    for n in $(sed "$number_of_user c\ $coins" $db_coins)
    do
        echo $n >> $temp
    done
    rm $db_coins
    mv $temp $db_coins
}

function all_reviews {
    db=$1
    while read line
    do
        echo $line
    done < $db
}

function average {
    db=$1
    sum=0
    k=0
    for line in $(cat $db)
    do
        sum=$(($sum+$line))
        k=$(($k+1))
    done
    echo "scale=2; $sum / $k" | bc
}

function is_digit {
    check_is_digit=false
    str=$1
    digit_or_not=$(echo $str | awk '/^[0-9]+$/{print$1}')
    if [[ -n $digit_or_not ]]
    then
        check_is_digit=true
    else
        echo "Это не число"
    fi
}
