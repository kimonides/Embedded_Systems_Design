function getAverageRuntime {
    total=0
    for i in {1..10}
    do
        currentRuntime=$(./tables)
        total=$((total+currentRuntime))
    done
    echo $((total/10))
}

gcc -O0 tables_optimized.c -o tables
getAverageRuntime