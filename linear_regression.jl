using MLJ
using DecisionTree

include("run.jl")

X = select(df_drop_missing, Not(1))
y = df_drop_missing[!, 1]

lin_model = @load LinearRegressor pkg=GLM
lin = machine(lin_model, X, y)
train, test = partition(eachindex(y), 0.7)
yp = predict(lin, rows=test)

# TODO metrics
