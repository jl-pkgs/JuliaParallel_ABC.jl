# using MPI
using Ipaper
using Statistics
using Polyester

@show mpi_nwork()
@show get_clusters()

x = rand(1000)

for j in 1:4
  !isCurrentWorker(j) && continue
  host = gethostname()
  cluster = mpi_id()
  println("[$host, mpi=$cluster]: $j")

  n = Int(1e10)
  chunk = Int(1e8)
  p = Progress(Int(n / chunk))
  @time @batch for i = 1:n
    if mod(i, chunk) == 0 
      next!(p)
      flush(stdout)
    end
    x_bar = mean(x)
  end
end
