db=$1
for line in $(cat $db)
do
    echo $line
done