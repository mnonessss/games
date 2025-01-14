function cards_game {
    echo "В этой игре есть десять карточек с цифрами от 0 до 4. Каждая из этих цифр написана ровно на двух карточках."
    echo "Изначально все карточки скрыты"
    echo "За одну попытку вы можете открыть две карточки"
    echo "Если цифры на этих двух карточках совпадают, они отправляются в сброс"
    echo "Если же они не совпадают, карточки переворачиваются обратно"
    echo "Ваша задача - отправить в сброс все карточки"
    declare -a array_cards
    numbers_to_guess=10
    count0=0
    count1=0
    count2=0
    count3=0
    count4=0
    index=0
    while [[ $count0 -ne 2 ]] || [[ $count1 -ne 2 ]] || [[ $count3 -ne 2 ]] || [[ $count4 -ne 2 ]]
    do
        card_checked=false
        while [[ $card_checked != true ]]
        do
            card=$((RANDOM%(5)))
            if [[ $card -eq 0 ]] && [[ $count0 -eq 2 ]]
            then
                break
            fi
            if [[ $card -eq 1 ]] && [[ $count1 -eq 2 ]]
            then
                break
            fi
            if [[ $card -eq 2 ]] && [[ $count2 -eq 2 ]]
            then
                break
            fi
            if [[ $card -eq 3 ]] && [[ $count3 -eq 2 ]]
            then
                break
            fi
            if [[ $card -eq 4 ]] && [[ $count4 -eq 2 ]]
            then
                break
            fi
            case $card in
            0) count0=$(($count0+1));array_cards[$index]=0;;
            1) count1=$(($count1+1));array_cards[$index]=1;;
            2) count2=$(($count2+1));array_cards[$index]=2;;
            3) count3=$(($count3+1));array_cards[$index]=3;;
            4) count4=$(($count4+1));array_cards[$index]=4;;
            esac
            index=$(($index+1)) 
        done
    done
    while [[ $numbers_to_guess -gt 0 ]]
    do
        echo "Вам нужно сбросить еще $numbers_to_guess карточек. Обратите внимание: номер первой карточки должен быть меньше второго"
        echo "Если вы хотите выйти из игры - введите 0 в первом поле"
        read -p "Введите номер первой карточки: " number1
        read -p "Введите номер второй карточки: " number2
        #проверяем корректность номеров карточек
        check_numbers_to_guess=false
        while [[ $check_numbers_to_guess != true ]]
        do
            if [[ $number1 == "0" ]]
            then
                return 0
            fi
            if [[ ${#number1} -ge 2 ]]
            then
                echo "В первом поле вы ввели некорректное значение. Попробуйте еще раз"
                read -p "Введите первое число: " number1
                read -p "Введите второе число: " number2
                continue
            fi 
            if [[ ${#number2} -gt 2 ]]
            then
                echo "Во втором поле вы ввели некорректное значение. Попробуйте еще раз"
                read -p "Введите первое число: " number1
                read -p "Введите второе число: " number2
                continue
            fi                
            is_digit $number1
            if [[ $check_is_digit != true ]]
            then
                echo "В первом поле вы ввели не число. Попробуйте еще раз."
                read -p "Введите первое число: " number1
                read -p "Введите второе число: " number2
                continue
            fi
            is_digit $number2
            if [[ $check_is_digit != true ]]
            then
                echo "Во втором поле вы ввели не число"
                read -p "Попробуйте еще раз: (введите только второе число): " number2
                continue
            fi
            if [[ $number1 -ge $number2 ]]
            then
                echo "Номер первой карточки должен быть меньше второго. Попробуйте еще раз"
                read -p "Введите номер первой карточки: " number1
                read -p "Введите номер второй карточки: " number2
                continue
            fi
            if [[ $number1 -gt $numbers_to_guess ]] || [[ $number2 -gt $numbers_to_guess ]]
            then
                echo "Номера карточек должны быть не больше $numbers_to_guess, так как именно столько вам осталось сбросить. Попробуйте еще раз"
                read -p "Введите номер первой карточки: " number1
                read -p "Введите номер второй карточки: " number2
                continue
            fi
            check_numbers_to_guess=true
        done
        echo ${array_cards[$number1-1]}
        echo ${array_cards[$number2-1]}
        if [[ ${array_cards[$number1-1]} -eq ${array_cards[$number2-1]} ]]
        then
            start=$(($number2-1))
            fin=$(($numbers_to_guess-1))
            for ((i=$start;i<$fin;i++))
            do
                array_cards[$i]=${array_cards[$i+1]}
            done
            numbers_to_guess=$(($numbers_to_guess-1))
            start=$(($number1-1))
            fin=$(($numbers_to_guess-1))
            for ((i=$start;i<$fin;i++))
            do
                array_cards[$i]=${array_cards[$i+1]}
            done
            numbers_to_guess=$(($numbers_to_guess-1))
        fi
        sleep 2
        clear
    done
    echo "Вы выиграли!"
}
