function autorization {
    attempts=3
    number_of_user=1
    read -p "Введите логин: " login
    login_in_base=0
    #проверка на наличие логина в базе
    for line in $(cat $db_name)
    do
        if [[ $line == $login$separator* ]]
        then
            login_in_base=1
            break
        fi
        number_of_user=$(($number_of_user+1))
    done

    if [[ $login_in_base -eq 0 ]]
    then
        echo "Пользователя $login нет в базе"
        exit
    fi

    #ввод пароля
    while [[ $attempts -gt 0 ]]
    do
        if [[ $attempts -eq 3 ]]
        then
            read -s -p "Введите пароль: " password
        fi
        if [[ $attempts -lt 3 ]]
        then
            echo "Пароль неверный. Повторите попытку."
            read -s -p "Введите пароль снова: " password
        fi
        hashed_pswd=$(hash_pswd $password)
        if [[ $line == $login$separator$hashed_pswd ]]
        then
            echo "Вы успешно вошли в систему"
            break
        else
            attempts=$(($attempts-1))
        fi
    done
    if [[ $attempts -eq 0 ]]
    then
        echo "Неудачная попытка входа в систему"
        exit
    fi
}

