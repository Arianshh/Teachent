-- Lua example: display field information

database = sqlitedatabase:new()
database:filename("C:\\ProgramData\\SQLite Expert\\Professional 4 - 32bit\\Data\\dbdemos.db3")
database:connected(true)
query = sqlitequery:new()
query:database(database)
query:sql("select * from customer")
query:active(true)
print("Name                      Declared type   Type             Size   Precision\n")
print("---------------------------------------------------------------------------\n")
for i=0, query:fieldcount() - 1 do
  print(string.format("%-25s", query:getfield(i):name()), ' ', 
    string.format("%-15s", query:getfield(i):fullsqltype()), ' ', 
    string.format("%-15s", query:getfield(i):sqltype()), ' ', 
    string.format("%5s", query:getfield(i):size()), ' ', 
    string.format("%11s", query:getfield(i):precision()), '\n')
end
query:active(false)
query:free()
database:free()
print("\n")