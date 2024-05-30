. ./functions.sh
. ./bull_and_cows.sh
. ./cards.sh
. ./review.sh
. ./rate.sh
separator="|"
db_grades_bc=grades_bulls_and_cows
db_grades_cards=grades_cards
db_review_bc=reviews_bulls_and_cows
db_review_c=reviews_cards
files=(bull_and_cows.sh cards.sh functions.sh grades_bulls_and_cows grades_cards main.sh rate.sh review.sh reviews_bulls_and_cows reviews_cards)
for ((i=0;i<${#files[*]};i++))
do
    if [[ ! -f ${files[$i]} ]]
    then
        echo "Нет файла ${files[$i]}"
        exit 1
    fi
done
echo "Добро пожаловать в скрипт 'мини - игры'"
#основная часть скрипта
repetitions=true
while [[ $repetitions == true ]]
do
    echo "Чтобы сыграть в игру Быки и коровы - введите 1. Cредняя оценка: " $(average $db_grades_bc)
    echo "Чтобы сыграть в игру Memory - введите 2. Cредняя оценка: " $(average $db_grades_cards)
    echo "Чтобы оставить отзыв на одну из игр - введите 3"
    echo "Чтобы посмотреть все отзывы на одну из игр - введите 4"
    echo "Чтобы оставить оценку на одну из игр - введите 5: "
    read -p "Чтобы посмотреть все оценки одной из игр, введите 6: " action
    action_check=false
    while [[ $action_check != true ]]
    do
        if [[ ! -n $action ]]
        then
            echo "Поле не может быть пустым"
            read -p "Попробуйте еще раз: " action
            continue
        fi
        is_digit $action
        if [[ $check_is_digit == false ]]
        then
            echo "Это некорректное значение"
            read -p "Попробуйте еще раз: " action
            continue
        fi
        if [[ $action -lt 1 ]] || [[ $action -gt 6 ]]
        then
            echo "Вы ввели некорректное значение"
            read -p "Попробуйте еще раз: " action
        else
            action_check=true
        fi
    done
    if [[ $action -eq 4 ]]
    then
        echo "Если вы хотите выйти из отзывов - введите 0"
        echo "Если Вы хотите посмотреть отзывы об игре 'Быки и коровы', введите 1"
        read -p "Если Вы хотите посмотреть отзывы об игре 'Memory', введите 2: " number_of_game
        check_num_game=false
        while [[ $check_num_game != true ]]
        do
            if [[ $number_of_game == "0" ]]
            then
                return 0
            fi
            if [[ $number_of_game == 1 ]] || [[ $number_of_game == 2 ]]
            then
                check_num_game=true
            else
                echo "Введено некорректное значение"
                read -p "Попробуйте еще раз: " number_of_game
            fi
        done
        if [[ $number_of_game == 1 ]]
        then
            db_for_action=reviews_bulls_and_cows
        else
            db_for_action=reviews_cards
        fi
    fi
    if [[ $action -eq 6 ]]
    then
        echo "Если вы хотите выйти из оценок - введите 0"
        echo "Если Вы хотите посмотреть оценки игры 'Быки и коровы', введите 1"
        read -p "Если Вы хотите посмотреть оценки игры 'Memory', введите 2: " number_of_game
        check_num_game=false
        while [[ $check_num_game != true ]]
        do
            if [[ $number_of_game == "0" ]]
            then
                return 0
            fi
            if [[ $number_of_game != 1 ]] && [[ $number_of_game != 2 ]]
            then
                echo "Это некорректное значение"
                read -p "Попробуйте еще раз: " number_of_game
            else
                check_num_game=true
            fi
        done
        if [[ $number_of_game == 1 ]]
        then
            db_for_action=grades_bulls_and_cows
        else
            db_for_action=grades_cards
        fi
    fi
    case $action in
    1) bulls_and_cows;;
    2) cards_game;;
    3) review;;
    4) all_reviews $db_for_action;;
    5) rates;;
    6) all_rates $db_for_action;;
    esac
    echo "Если хотите выйти из скрипта - введите 1"
    read -p "Если нет - введите 2: " repeat_or_not
    repeat_check=false
    while [[ $repeat_check != true ]]
    do
        if [[ $repeat_or_not != 1 ]] && [[ $repeat_or_not != 2 ]]
        then
            echo "Это некорректное значение"
            read -p "Попробуйте еще раз: " repeat_or_not
        else
            repeat_check=true
        fi
    done
    if [[ $repeat_or_not == 1 ]]
    then
        exit
    fi
done







