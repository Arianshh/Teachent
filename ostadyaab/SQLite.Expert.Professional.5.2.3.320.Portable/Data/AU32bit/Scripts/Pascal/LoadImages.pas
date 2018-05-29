program LoadImages;
var
  FileName, Path, Mask: string;
  Database: TSQLiteDatabase;
  SearchRec: TSearchRec;
  Code: Integer;
  Query: TSQLiteQuery;
begin
  Path := 'D:\images\';  // replace this with the path where the images are stored
  Mask := '*.jpg';  
  FileName := Path + 'images.db3';
  Database := TSQLiteDatabase.Create(nil);
  try
    Database.FileName := FileName;
    if FileExists(FileName) then
    begin
      Database.Connected := True;
      Database.Execute('drop table if exists images');
    end
    else
      Database.CreateDatabase;
    Database.Execute('create table images (filename char, image blob)');
    Query := TSQLiteQuery.Create(nil);    
    Query.Database := Database;    
    Query.SQL := 'select * from images';    
    Query.Open;
    try
      Code := FindFirst(Path + Mask, faAnyFile, SearchRec);
      if Code = 0 then
      try
        while Code = 0 do
        begin        
          Writeln(SearchRec.Name);
          Query.Insert;
          Query.FieldByName('filename').AsString := SearchRec.Name;
          TBlobField(Query.FieldByName('image')).LoadFromFile(Path + SearchRec.Name);
          Query.Post;
          Query.Next;
          Code := FindNext(SearchRec);
        end;
      finally
        FindClose(SearchRec);
      end;
    finally
      Query.Free;
    end;
  finally
    Database.Free;
  end;
end.

