-- Lua sample: list all files in a database

database = sqlitedatabase:new()
database:filename("C:\\ProgramData\\SQLite Expert\\Professional 4 - 32bit\\Data\\dbdemos.db3")
database:open()
query = sqlitequery:new()
query:database(database)
query:sql("select * from sqlite_master where type = \"table\"")
query:open()
query:first()
while (query:eof() == false) do
  print(query:getfield("name"):value(), "\n")
  query:next()
end
query:free()
database:free()