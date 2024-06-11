using MLJ
using DecisionTree

include("run.jl")

X = select(df_drop_missing, Not(1))
y = df_drop_missing[!, 1]

svc_model = @load SVC
svc = machine(svc_model, X, y)
