function registration {
    separator="|"
    db_name=users
    echo "Добро пожаловать в скрипт регистрации"
    read -p "Введите логин (он не должен содержать $separator): " login

    #проверка на непустоту
    if [[ ! -n $login ]]
    then
        echo "Логин не может быть пустым"
        exit 1
    fi

    #проверка на наличие разделителя в логине
    if [[ $login == *$separator* ]]
    then
        echo "Логин не может содержать символа |"
        exit 1
    fi

    #проверка на наличие логина в базе
    if ! check_login $login $db_name $separator
    then
        echo "Пользователь с таким логином уже зарегистрирован"
        exit 1
    fi
    echo "Логин $login был принят!"
    read -s -p "Введите пароль (он не может содержать символ $separator и должен быть не менее 6 символов в длину)" password
    echo

    pswd_checked=false
    while [ $pswd_checked != true ]
    do
        #проверка на непустоту пароля
        if [[ ! -n $password ]]
        then
            read -s -p "Пароль не может быть пустым! Попробуйте еще раз: " password
            echo
            continue
        fi

        #проверка на отсутствие разделителя
        if [[ $password == *$separator* ]]
        then
            read -s -p "Пароль не должен содержать символ $separator. Попробуйте еще раз: " password
            echo
            continue
        fi

        #проверка на верную длину
        length=${#password}
        if [ $length -lt 6 ]
        then
            read -s -p "Пароль должен быть не менее 6 символов в длину. Попробуйте еще раз:" password
            echo
            continue
        fi

        if [[ -n $password ]] && [[ $password != *$separator* ]] && [[ $length -ge 6 ]]
        then
            pswd_checked=true
        fi
    done

    read -s -p "Подтвердите пароль: " repeat
    echo

    #проверка на совпадение паролей
    while [ ! $password == $repeat ]
    do
        read -s -p "Введенные пароли не совпадают. Попробуйте еще раз: " repeat
        echo
        continue
    done

    echo "Пароль принят"
    hashed_pswd=$(hash_pswd $password)
    echo $login$separator$hashed_pswd >> $db_name
    echo "Пользователь $login успешно зарегистрирован!"
    number_of_user=1
    for line in $(cat $db_name)
    do
        if [[ $line == $login$separator$hashed_pswd ]]
        then
            break
        fi
        number_of_user=$(($number_of_user+1))
    done
    echo 0 >> $db_coins
}

