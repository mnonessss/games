function rates {
    echo "Если вы хотите выйти из раздела оценок - введите 0"
    echo "Если Вы хотите поставить оценку игре 'Быки и коровы' - введите 1"
    read -p "Если Вы хотите поставить оценку игре 'Memory' - введите 2: " game
    db_grades_bc=grades_bulls_and_cows
    db_grades_cards=grades_cards
    game_check=false
    while [[ $game_check != true ]]
    do
        if [[ $game == "0" ]]
        then
            return 0
        fi
        if [[ $game != 1 ]] && [[ $game != 2 ]]
        then
            echo "Вы ввели некорректное значение. Здесь можно вводить только 1 или 2"
            echo "Если вы хотите выйти из раздела оценок - введите 0"
            read -p "Попробуйте еще раз: " game
        else
            game_check=true
        fi
    done
    echo "Если вы хотите выйти из раздела оценок - введите 6"
    read -p "Введите оценку от 0 до 5 включительно: " rate
    rate_check=false
    while [[ $rate_check != true ]]
    do
        if [[ ! -n $rate ]]
        then
            echo "Это поле не может быть пустым"
            echo "Если вы хотите выйти из раздела оценок - введите 6"
            read -p "Попробуйте еще раз: " rate
        fi
        if [[ $rate == "6" ]]
        then
            return 0
        fi
        is_digit $rate
        if [[ $check_is_digit == false ]]
        then
            echo "Это не число"
            echo "Если вы хотите выйти из раздела оценок - введите 6"
            read -p "Попробуйте еще раз: " rate
            continue
        fi
        if [[ $rate -lt 0 ]] || [[ $rate -gt 5 ]]
        then
            echo "Вы ввели некорректное значение. Оценка может быть числом от 0 до 5"
            echo "Если вы хотите выйти из раздела оценок - введите 6"
            read -p "Попробуйте еще раз: " rate
        else
            rate_check=true
        fi
    done
    if [[ $game -eq 1 ]]
    then
        echo $rate >> $db_grades_bc
    else
        echo $rate >> $db_grades_cards
    fi
}