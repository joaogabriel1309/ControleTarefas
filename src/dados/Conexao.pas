unit Conexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet, System.IniFiles;

type
  TTconexao = class(TDataModule)
    FDConnection: TFDConnection;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    FDQuery: TFDQuery;

  private
    { Private declarations }
  public
    class function GetConexao: TFDCustomConnection;
    procedure ConectarBanco;
    procedure CriarTabelas;
    function TabelaExiste(NomeTabela: string): Boolean;
    { Public declarations }
  end;

var
  Tconexao: TTconexao;
  FDQuery1: TFDQuery;


implementation

{$R *.dfm}

class function TTconexao.GetConexao: TFDCustomConnection;
begin
  if not Assigned(Tconexao) then
    Tconexao := TConexao.Create(nil);

  Result := Tconexao.FDConnection;
end;

procedure TTconexao.ConectarBanco;
var
  Ini: TIniFile;
  ConfigPath, DriverName, Server, Database, UserName, Password, CharacterSet: string;
  Port: Integer;
begin
  try
    ConfigPath := ExtractFilePath(ParamStr(0)) + 'config.ini';

    if not FileExists(ConfigPath) then
      raise Exception.Create('Arquivo '+ConfigPath+' não encontrado!');

    Ini := TIniFile.Create(ConfigPath);
    try
      DriverName   := Ini.ReadString('DATABASE', 'DriverName', 'MySQL');
      Server       := Ini.ReadString('DATABASE', 'Server', 'localhost');
      Database     := Ini.ReadString('DATABASE', 'Database', 'bdtarefa');
      UserName     := Ini.ReadString('DATABASE', 'User_Name', 'root');
      Password     := Ini.ReadString('DATABASE', 'Password', '');
      Port         := Ini.ReadInteger('DATABASE', 'Port', 3306);
      CharacterSet := Ini.ReadString('DATABASE', 'CharacterSet', 'utf8mb4');
    finally
      Ini.Free;
    end;

    FDConnection.Connected := False;
    FDConnection.Params.Clear;
    FDConnection.DriverName := DriverName;
    FDConnection.Params.Add('Server=' + Server);
    FDConnection.Params.Add('Database=' + Database);
    FDConnection.Params.Add('User_Name=' + UserName);
    FDConnection.Params.Add('Password=' + Password);
    FDConnection.Params.Add('Port=' + IntToStr(Port));
    FDConnection.Params.Add('CharacterSet=' + CharacterSet);

    FDConnection.Connected := True;
  except
    on E: Exception do
      raise Exception.Create('Erro ao conectar ao banco: ' + E.Message);
  end;
end;

function TTconexao.TabelaExiste(NomeTabela: string): Boolean;
begin
  Result := False;
  FDQuery.Close;

  FDQuery.SQL.Text := 'SELECT COUNT(*) FROM information_schema.tables WHERE table_name = :NomeTabela';
  FDQuery.ParamByName('NomeTabela').AsString := NomeTabela;

  try
    FDQuery.Open;
    Result := FDQuery.Fields[0].AsInteger > 0;
  except
    on E: Exception do
      Result := False;
  end;
end;

procedure TTconexao.CriarTabelas;
begin
  if not TabelaExiste('usuarios') then
  begin
    FDQuery.SQL.Text :=
      'CREATE TABLE IF NOT EXISTS usuario ('+
      '    codigo INT PRIMARY KEY,'+
      '    nome VARCHAR(50) NOT NULL,'+
      '    direito CHAR(1) NOT NULL,'+
      '    senha CHAR(12) NOT NULL'+
      ');';
    FDQuery.ExecSQL;

    FDQuery.SQL.Text :=
      'INSERT INTO usuario (codigo, nome, direito, senha) '+
      'SELECT 1, ''administrador'', ''S'', ''admin'' '+
      'WHERE NOT EXISTS (SELECT 1 FROM usuario WHERE codigo = 1);';
    FDQuery.ExecSQL;
  end;

  if not TabelaExiste('tarefas') then
  begin
    FDQuery.SQL.Text :=
      'CREATE TABLE IF NOT EXISTS tarefa ('+
      '    codigo INT PRIMARY KEY,'+
      '    nome VARCHAR(30) NOT NULL,'+
      '    tipo CHAR(1) NOT NULL'+
      ');';
    FDQuery.ExecSQL;
  end;

  if not TabelaExiste('usuario_tarefa') then
  begin
    FDQuery.SQL.Text :=
      'CREATE TABLE IF NOT EXISTS usuario_tarefa ('+
      '    cod_usuario INT,'+
      '    cod_tarefa INT,'+
      '    PRIMARY KEY (cod_usuario, cod_tarefa),'+
      '    FOREIGN KEY (cod_usuario) REFERENCES usuario(codigo) ON DELETE CASCADE ON UPDATE CASCADE,'+
      '    FOREIGN KEY (cod_tarefa) REFERENCES tarefa(codigo) ON DELETE CASCADE ON UPDATE CASCADE'+
      ');';
    FDQuery.ExecSQL;
  end;
end;

end.
