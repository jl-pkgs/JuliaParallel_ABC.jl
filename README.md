# Julia Multiple Nodes 并行说明

## 1 Julia代码

```julia
# using MPI
using Ipaper
using Statistics

@show mpi_nwork()
@show get_clusters()
x = rand(1000)

for j in 1:4 # 4个node, isCurrentWorker自动确定node
  !isCurrentWorker(j) && continue
  host = gethostname()
  cluster = mpi_id()
  println("[$host, mpi=$cluster]: $j")

  n = Int(1e10)
  chunk = Int(1e8)
  p = Progress(Int(n / chunk))
  @time Threads.@threads for i = 1:n
    if mod(i, chunk) == 0 
      next!(p)
      # flush(stdout)
    end
    x_bar = mean(x)
  end
end
```

## 2 提交任务

```bash
cpus_per_node=32
nodes=4
cpus=$((threads_per_node * nodes))

bsub -J kongdd_m01 \
     -o log_all.out \
     -e log_all.err \
     -n $cpus \
     -R "span[ptile=$cpus_per_node]" \
     mpiexecjl -n $nodes -ppn 1 julia -t $cpus_per_node s1_hello.jl
```

## 3 查看任务进度

```bash
bpeek job_id
```
