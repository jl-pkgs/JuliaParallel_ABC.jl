# using MPI
using Ipaper
using Statistics

@show mpi_nwork()
@show get_clusters()
# 采用mpi去运行能取得更高的效率
flush(stdout)

# -t 10：10线程
# -j 10: 10站点
x = rand(1000)
## 提供一个progress

for j in 1:4
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
      flush(stdout)
    end
    x_bar = mean(x)
  end
end
