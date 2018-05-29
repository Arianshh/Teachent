// Pascal sample: how to export query to CSV file (UTF-16 encoded)

function QuoteStr(const S: string): string;
var
  I: Integer;
begin
  Result := S;
  for I := Length(Result) downto 1 do
    if Result[I] = '"' then Insert('"', Result, I);
  Result := '"' + Result + '"';
end;

procedure WriteString(Stream: TFileStream; const Value: string);
begin
  Stream.WriteBuffer(Value, Length(Value) * 2);
end;

procedure ExportToCsv(Query: TSQLiteQuery; const FileName: string);
var
  Stream: TFileStream;
  I: Integer;
begin
  Stream := TFileStream.Create(FileName, fmCreate);

  // write header with field names
  for I := 0 to Query.FieldCount - 1 do
  begin
    WriteString(Stream, QuoteStr(Query.Fields.Fields[I].FieldName));
    if I < Query.FieldCount - 1 then
      WriteString(Stream, ',');
  end;
  WriteString(Stream, #13#10);

  // write all rows
  Query.First;
  while not Query.Eof do
  begin
    for I := 0 to Query.FieldCount - 1 do
    begin
      WriteString(Stream, QuoteStr(Query.Fields.Fields[I].AsString));
      if I < Query.FieldCount - 1 then
        WriteString(Stream, ',');
    end;
    WriteString(Stream, #13#10);
    Query.Next;
  end;
  Stream.Free;
end;

var
  Database: TSQLiteDatabase;
  Query: TSQLiteQuery;

begin
  Database := TSQLiteDatabase.Create(nil);  
  try
    Database.FileName := 'C:\ProgramData\SQLite Expert\Professional 4 - 64bit\Data\dbdemos.db3';
    Database.Connected := True;
    Query := TSQLiteQuery.Create(nil);    
    try
      Query.Database := Database;
      Query.SQL := 'select * from customer';
      Query.Open;
      ExportToCSV(Query, 'C:\customer.csv');
      DisplayData(Query);            
    finally
      Query.Free;
    end;    
  finally
    Database.Free;    
  end;
end.