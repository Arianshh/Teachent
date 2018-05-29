var
  Database: TSQLiteDatabase;
  Query: TSQLiteQuery;
begin
  Database := TSQLiteDatabase.Create(nil);
  try
    Database.FileName := 'C:\ProgramData\SQLite Expert\Professional 4 - 32bit\Data\dbdemos.db3';
    Database.Connected := True;
    Query := TSQLiteQuery.Create(nil);
    try
      Query.Database := Database;
      Query.SQL := 'select * from sqlite_master where type = "table"';
      Query.Open;
      while not Query.Eof do
      begin
        Writeln(Query.FieldByName('name').AsString);
        Query.Next;
      end;
      DisplayData(Query);
    finally
      Query.Free;
    end;
  finally
    Database.Free;
  end;
end.