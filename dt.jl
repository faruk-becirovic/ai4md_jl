using MLJ
using DecisionTree

include("run.jl")

X = select(df_drop_missing, Not(1))
y = df_drop_missing[!, 1]

dt = @load DecisionTreeClassifier

model = machine(dt, X, y)
train, test = partition(eachindex(y), 0.7, shuffle=true)
fit!(model, rows=train)
fitted_params(model)
yp = predict(model, rows=test)
mce = cross_entropy(yp, y[test]) |> mean
mce = round(mce, digits=4)
