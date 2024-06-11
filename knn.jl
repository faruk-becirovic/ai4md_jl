using DataFrames
using MLJ
using DecisionTree

include("run.jl")

X = select(df_drop_missing, Not(1))
y = df_drop_missing[!, 1]

function convert_categorical(df::DataFrame, col::String)
    categories = levels(df[!, col])
    category_to_integer = Dict(category => i for (i, category) in enumerate(categories))
    df[!, col] .= map(x -> category_to_integer[x], df[!, col])
end
