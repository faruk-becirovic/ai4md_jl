# data_path = joinpath(pkgdir(), "data")
#print(pkgdir())

using CSV
using DataFrames

function load_csv(filename)
    data = CSV.File("/home/faruk/Projects/AI4MD/data/" * filename, header=true)
    return DataFrame(data)
end

