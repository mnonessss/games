temp=temp_file
for n in $(sed "$number_of_user c\ $coins" coins_of_users)
do
    echo $n >> $temp
done
rm coins_of_users
mv $temp coins_of_users