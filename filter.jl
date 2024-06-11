using CategoricalArrays

function to_categorical(str::String)
    if str == "DA"
        return 1
    elseif str == "NE"
        return 0
    else
        return missing
    end
end

function filter_DANE(str::String3)
    if str == "DA"
        return true
    else
        return false
    end
end

function fix_categorical!(df, col::String)
    levels = ["DA", "NE"]
    verify = categorical(df[!, col]; levels, ordered=true)
    df[!, col] = verify
    df
end

function fix_categorical!(df, col::Int64)
    levels = ["DA", "NE"]
    verify = categorical(df[!, col]; levels, ordered=true)
    df[!, col] = verify
    df
end

function string2float!(df, col::Int64)
    for i in 1:nrow(df)
        try
            if df[i, col] == "NIJE MJERENO"
                df[i, col] = missing
            else
                df[i, col] = parse(Float64, df[i, col])
            end
        catch
            println("Error convertinf element at row $i.")
        end
    end
end

function string2float!(df, col::String)
    for i in 1:nrow(df)
        if df[i, col] == "NIJE MJERENO"
            df[i, col] = missing
        else
            df[i, col] = parse(Float64, df[i, col])
        end
    end
end

function parse_to_float(x)
    try
        return parse(Float64, x)
    catch
        return missing
    end
end

function model_selection(X, y)
    for m in models(matching(X, y))
        if m.prediction_type == :probabilistic
            println(rpad(m.name, 30), "($(m.package_name))")
        end
    end
end
