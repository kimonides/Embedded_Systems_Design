function getAverageRuntime {
    total=0
    for i in {1..10}
    do
        currentRuntime=$(./phods)
        echo $currentRuntime >> "./logs/$questionNumber"
        total=$((total+currentRuntime))
    done
    echo $((total/10))
}

questionNumber=$1

rm -f "./logs/$questionNumber"

if [ "$1" == "2" ]
then
    gcc -O0 phods_original.c -o phods
    average="$(getAverageRuntime)"
    echo $average
    rm ./phods
elif [ "$1" == "3" ]
then
    gcc -O0 phods_optimized.c -o phods
    average="$(getAverageRuntime)"
    echo $average
    rm ./phods
elif [ "$1" == "4" ]
then
    N=144
    M=176
    best=0

    while [ "$M" -ne 0 ]; do
        remainder=$(( $N % $M ))	
        N=$M
        M=$remainder
    done

    GCD=$N

    echo "GCD : $GCD"

    modulo=0
    divisor=1
    let Nend=GCD+1

    currentMin=$((999999))

    while [  "$divisor" -lt $Nend ]; 
    do
        let modulo=GCD%divisor
        if [ "$modulo" -eq 0 ]
        then echo "Block size $divisor:"
            sed -i "/#define B/c\#define B $divisor" ./phods_optimized.c
            gcc -O0 phods_optimized.c -o phods
            average="$(getAverageRuntime)"
            echo $average
            if [ "$average" -lt "$currentMin" ]
            then
                currentMin=$average
                best=$divisor
            fi
            rm ./phods
            echo ""
        fi
        let divisor=divisor+1
    done

    echo "Best time:"
    echo $currentMin
    echo "Best config:"
    echo $best

elif [ "$1" == "5" ]
then

    Bx=144	
    By=176

    moduloy=0
    modulox=0
    divisorX=1
    divisorY=1
    bestX=0
    bestY=176
    let xEnd=Bx+1
    let yEnd=By+1
    currentMin=$((999999))

    sed -i "/#define Bx/c\#define Bx $divisorX" ./phods_optimized_xy.c
    sed -i "/#define By/c\#define By $divisorY" ./phods_optimized_xy.c 
    gcc -O0 phods_optimized_xy.c -o phods

    while [ "$divisorX" -lt $xEnd ] ; 
    do			
        let modulox=Bx%divisorX
        divisorY=1
        if [ "$modulox" -eq 0 ]
        then
            while [ "$divisorY" -lt $yEnd ] ; 
            do			
                let moduloy=By%divisorY
                if [ "$moduloy" -eq 0 ] 
                then	
                    sed -i "/#define Bx/c\#define Bx $divisorX" ./phods_optimized_xy.c
                    sed -i "/#define By/c\#define By $divisorY" ./phods_optimized_xy.c 
                    gcc -O0 phods_optimized_xy.c -o phods

                    average="$(getAverageRuntime)"
                    echo $average
                    echo "Bx:" $divisorX "By:" $divisorY "time:" $average
                    if [ "$average" -lt "$currentMin" ]
                    then
                        let currentMin=average  
                        let bestX=divisorX
                        let bestY=divisorY
                    fi
                    rm ./phods	
                fi
                let divisorY=divisorY+1
            done
        fi
        let divisorX=divisorX+1
    done

    echo ""
    echo "Best (Bx,By) is: $bestX" " $bestY"
fi