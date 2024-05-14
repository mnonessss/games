function bulls_and_cows {
    echo "Правила этой игры такие: Вы вводите четырехзначное число. Оно не может начинаться с нуля и содержать одинаковые цифры."
    echo "В ответ компьютер выводит количество быков - количество цифр, стоящих на своих местах"
    echo "Также выводится количество коров - количество цифр, которые угаданы верно, но поставлены вами не на свои места" 
    #генерация рандомного четырехзначного числа
    first=$((RANDOM%(9)))
    first=$(($first+1))
    second=$((RANDOM%(10)))
    while [[ $second -eq $first ]]
    do
        second=$((RANDOM%(10)))
    done
    third=$((RANDOM%(10)))
    while [[ $first -eq $third ]] || [[ $second -eq $third ]]
    do
        third=$((RANDOM%(10)))
    done
    fourth=$((RANDOM%(10)))
    while [[ $fourth -eq $first ]] || [[ $fourth -eq $second ]] || [[ $fourth -eq $third ]]
    do
        fourth=$((RANDOM%(10)))
    done
    a=$(($first * 1000))
    b=$(($second * 100))
    c=$(($third * 10))
    d=$fourth
    answer=$(($a + $b + $c + $d))
    read -p "Введите число: " number
    while [[ $number != $answer ]]
    do
        number_checked=false
        #проверка числа на корректность
        while [[ $number_checked != true ]]
        do
            is_digit $number
            if [[ $check_is_digit == false ]]
            then
                echo "Вы ввели не число"
                read -p "Попробуйте еще раз: " number
                continue
            fi
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
                continue
            fi
            check_different
            if [[ $check == false ]]
            then
                echo "В числе не могут содержаться одинаковые цифры"
                read -p "Попробуйте еще раз:" number
            else
                number_checked=true
            fi
        done
        #разделение числа на цифры
        digit4=$(($number%10))
        let "digit3 = $number / 10"
        digit3=$(($digit3%10))
        let "digit2 = $number / 100"
        digit2=$(($digit2%10))
        let "digit1 = $number / 1000"
        bulls=0
        cows=0
        digits_my_number_array=($digit1 $digit2 $digit3 $digit4)
        digits_computer_number_array=($first $second $third $fourth)
        for ((i=0;i<4;i++))
        do
            if [[ ${digits_my_number_array[i]} -eq ${digits_computer_number_array[i]} ]]
            then
                bulls=$(($bulls+1))
            fi
        done
        echo "В вашем числе $bulls быков"
        for ((i=0;i<4;i++))
        do
            for ((j=0;j<4;j++))
            do
                if [[ $i != $j ]]
                then
                    if [[ ${digits_my_number_array[i]} -eq ${digits_computer_number_array[j]} ]]
                    then
                        cows=$(($cows+1))
                    fi
                fi
            done
        done
        echo "В вашем числе $cows коров"
        read -p "Повторите попытку: " number
    done
    echo "Вы победили!!!"
}
