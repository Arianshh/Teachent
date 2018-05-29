-- Lua sample: how to export a query to a CSV file

function quote(x) 
  return('"' .. string.gsub(x, '"', '""') .. '"') 
end 

function exporttocsv(query, filename)
  file = io.open(filename,"w")

  -- write header with field names
  for i=0, query:fieldcount() - 1 do
    file:write(quote(query:getfield(i):name()))
    if i < query:fieldcount() - 1 then
      file:write(',')
    end
  end
  file:write('\n')

  -- write all rows
  query:first()
  while (query:eof() == false) do
    for i=0, query:fieldcount() - 1 do
      file:write(quote(query:getfield(i):value()))
      if i < query:fieldcount() - 1 then
        file:write(',')
      end
    end
    file:write('\n')
    query:next()
  end
  file:close()
end

database = sqlitedatabase:new()
database:filename("C:\\ProgramData\\SQLite Expert\\Professional 4 - 64bit\\Data\\dbdemos.db3")
database:connected(true)
query = sqlitequery:new()
query:database(database)
query:sql("select * from customer")
query:active(true)
displaydata(query)
filename="C:\\customer.csv"
exporttocsv(query, filename)
print(query:recordcount(), " rows saved to ", filename, ".\n")
query:free()
database:free()