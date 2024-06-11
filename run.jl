include("eda.jl")
include("filter.jl")

using DataFrames


#select!(df, Not(
# "Broj naloga",
# "Broj izvještaja",
# "Datum izdavanja",
# "Status verifikacije",
# "Zahtjev za verifikaciju",
# "Metoda",
# "Vrsta",
# "Proizvođač",
#  "Uređaj",
#   "Serijski broj"
#))  # Replace :column1, :column2, etc. with the names of the columns you want to drop

#select!(df, Not(6:8))
#select!(df, Not(7:10))

data = CSV.File("data/PacijentMonitori_cleaned.csv", header=true)
df = DataFrame(data)

filter("Verifikacija ispravna" => filter_DANE, df)
fix_categorical!(df, 1)
fix_categorical!(df, 2)
fix_categorical!(df, 3)
fix_categorical!(df, 4)
fix_categorical!(df, 5)

for i in 1:21 transform!(df, "$i: Greška mjerenja [ % ]" => ByRow(parse_to_float) => "$i: Greška mjerenja [ % ]") end
for i in 22:29 transform!(df, "$i: Greška mjerenja [ mmHg ]" => ByRow(parse_to_float) => "$i: Greška mjerenja [ mmHg ]") end

df_drop_missing = dropmissing(df)
df_replace_missing = coalesce.(df, 0.0)
