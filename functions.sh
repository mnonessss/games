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
    fi
}

function all_rates {
    db_for_rates=$1
    while read line
    do
        echo $line
    done < $db_for_rates
}

function check_different {
    number_to_digits $number
    array_digits_user=($digit1 $digit2 $digit3 $digit4)
    check=true
    for ((i=0;i<4;i++))
    do
        for ((j=$(($i+1));j<4;j++))
        do
            if [[ ${array_digits_user[$i]} -eq ${array_digits_user[$j]} ]]
            then
                check=false
                break
            fi
        done
        if [[ $check == false ]]
        then
            break
        fi
    done
}
