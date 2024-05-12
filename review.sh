function review {
    echo "Если Вы хотите оставить отзыв на игру 'Быки и коровы' - введите 1"
    read -p "Если Вы хотите оставить отзыв на игру 'Memory' - введите 2: " game
    db_review_bc=reviews_bulls_and_cows
    db_review_c=reviews_cards
    game_check=false
    while [[ $game_check != true ]]
    do
        if [[ ! -n $game ]]
        then
            echo "Поле с номером игры не может быть пустым"
            read -p "Попробуйте еще раз: " game
        fi
        if [[ $game != 1 ]] && [[ $game != 2 ]]
        then
            echo "Введено некорректное значение"
            read -p "Попробуйте еще раз: " game
        else
            game_check=true
        fi
    done
    read -p "Введите отзыв: " review
    review_check=false
    while [[ $review_check != true ]]
    do
        if [[ ! -n $review ]]
        then
            echo "Поле с отзывом не может быть пустым"
            read -p "Попробуйте еще раз:" review
        else
            review_check=true
        fi
    done
    if [[ $game -eq 1 ]]
    then
        echo $review >> $db_review_bc
    else
        echo $review >> $db_review_c
    fi
}