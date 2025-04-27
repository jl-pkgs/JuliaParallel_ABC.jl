cpus_per_node=32
nodes=4
cpus=$((threads_per_node * nodes))

bsub -J kongdd_m01 \
     -o log_all.out \
     -e log_all.err \
     -n $cpus \
     -R "span[ptile=$cpus_per_node]" \
     mpiexecjl -n $nodes -ppn 1 julia -t $cpus_per_node ex1_Threads.jl
