program srv_arm;

{$mode objfpc}{$H+}

uses
    {$IFDEF UNIX}
    cthreads,
    {$ENDIF}
    Classes, SysUtils, CustApp, Crt,
    SynCommons, mORMot, mORMotSQLite3, SynSQLite3Static, mORMotHttpServer, DataModule;

type
    TServ_Arm = class(TCustomApplication)
    protected
      procedure DoRun; override;
    public
      Model : TSQLModel;
      DB : TSQLRestServerDB;
      Server : TSQLHttpServer;
    end;

procedure TServ_Arm.DoRun;
var
  sMsg : string ;
begin
  // aqui as coisas acontecem...
  Model := CreateDataModule;
  DB := TSQLRestServerDB.Create(Model, ChangeFileExt(ExeVersion.ProgramFileName,'.db3'),true);
  DB.CreateMissingTables;
  try
    sMsg := 'Server ON port:8080';
    Server := TSQLHttpServer.Create('8080', [DB], '+', HTTP_DEFAULT_MODE);
    Server.AccessControlAllowOrigin := '*';
  except
    sMsg := 'Ocorreu um erro. '
  end;
  Writeln(sMsg);
  Readln;
  Server.Free;
  DB.Free;
  Model.Free;
  Terminate;
end;

var
  Application : TServ_Arm;
begin
  Application := TServ_Arm.Create(nil);
  Application.Title := 'Server in arm';
  Application.Run;
  Application.Free;
end.

