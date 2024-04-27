. ./registration.sh
. ./autorization.sh
. ./functions.sh
. ./bull_and_cows.sh
separator="|"
db_name=users
db_coins=coins_of_users
echo "Добро пожаловать в скрипт 'мини - игры'"
read -p "Вы хотите войти или зарегистрироваться? Если войти - введите 1, если зарегистрироваться - введите 2: " autorize_or_registration
if [[ $autorize_or_registration == 1 ]]
then
    autorization
fi

if [[ $autorize_or_registration == 2 ]]
then
    registration
fi

if [[ $autorize_or_registration != 1 ]] && [[ $autorize_or_registration != 2 ]]
then
    echo "Вы ввели недопустимое значение"
    exit
fi
line_now=1
for line in $(cat $db_coins)
do
    if [[ $line_now -eq $number_of_user ]]
    then
        coins=$line
    fi
    line_now=$(($line_now+1))
done
#Выбор игры, переход в магазин или написание отзыва
echo "Вы можете выбрать одну из трех игр, перейти в магазин или написать отзыв на одну из игр"






