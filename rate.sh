function rates {
    echo "Если Вы хотите поставить оценку игре 'Быки и коровы' - введите 1"
    read -p "Если Вы хотите поставить оценку игре 'Memory' - введите 2: " game
    db_grades_bc=grades_bulls_and_cows
    db_grades_cards=grades_cards
    game_check=false
    while [[ $game_check != true ]]
    do
        if [[ $game -ne 1 ]] && [[ $game -ne 2 ]]
        then
            echo "Вы ввели некорректное значение. Здесь можно вводить только 1 или 2"
            read -p "Попробуйте еще раз: " game
        else
            game_check=true
        fi
    done
    read -p "Введите оценку от 0 до 5 включительно: " rate
    rate_check=false
    while [[ $rate_check != true ]]
    do
        if [[ ! -n $rate ]]
        then
            echo "Это поле не может быть пустым"
            read -p "Попробуйте еще раз: " rate
        fi
        if [[ $rate != 0 ]] && [[ $rate != 1 ]] && [[ $rate != 2 ]] && [[ $rate != 3 ]] && [[ $rate != 4 ]] && [[ $rate != 5 ]]
        then
            echo "Вы ввели некорректное значение. Оценка может быть числом от 0 до 5"
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