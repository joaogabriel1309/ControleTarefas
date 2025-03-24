unit TUsuarioTarefa;

interface

uses
  System.SysUtils, System.Classes, Data.DB, FireDAC.Comp.Client, Conexao, TTarefa, TUsuario, System.Generics.Collections;

type
  UsuarioTarefa = class
  private
    FCodUsuario: Integer;
    FNomeUsuario: String;
    FCodTarefa: Integer;
    FNomeTarefa: String;
    FTipo: String;
  public
    constructor Create(const CodUsuario: Integer; const CodTarefa: Integer);
    function Salvar: Boolean;

    class function PegarTarefasPorUsuario(Const CodUsuario: Integer; Const Situacao: String = ''): TList<Tarefa>;

    property CodUsuario: Integer read FCodUsuario write FCodUsuario;
    property CodTarefa: Integer read FCodTarefa write FCodTarefa;
    property NomeUsuario: String read FNomeUsuario write FNomeUsuario;
    property NomeTarefa: String read FNomeTarefa write FNomeTarefa;
    property Tipo: String read FTipo write FTipo;
  end;

implementation

constructor UsuarioTarefa.Create(const CodUsuario: Integer; const CodTarefa: Integer);
begin
  FCodUsuario := CodUsuario;
  FCodTarefa := CodTarefa;
  FNomeUsuario := '';
  FNomeTarefa := '';
  FTipo := '';
end;

class function UsuarioTarefa.PegarTarefasPorUsuario(const CodUsuario: Integer;
  const Situacao: String = ''): TList<Tarefa>;
var
  Query: TFDQuery;
  Lista: TList<Tarefa>;
begin
  Lista := TList<Tarefa>.Create;

  Query := TFDQuery.Create(nil);
  try
    Query.Connection := Conexao.Tconexao.GetConexao();
    Query.Close;
    Query.SQL.Clear;
    Query.SQL.Add('SELECT');
    Query.SQL.Add('	TAREFA.CODIGO,');
    Query.SQL.Add('	TAREFA.NOME,');
    Query.SQL.Add('	TAREFA.TIPO');
    Query.SQL.Add('FROM TAREFA');
    Query.SQL.Add('JOIN (USUARIO_TAREFA) ON');
    Query.SQL.Add('(USUARIO_TAREFA.COD_TAREFA = TAREFA.CODIGO)');
    Query.SQL.Add('WHERE');
    Query.SQL.Add('	USUARIO_TAREFA.COD_USUARIO = :COD_USUARIO');
    if Situacao <> '' then
    begin
      Query.SQL.Add('	AND TAREFA.TIPO = :SITUACAO');
      Query.ParamByName('SITUACAO').AsString := Situacao;
    end;
    Query.ParamByName('COD_USUARIO').AsInteger := CodUsuario;
    Query.Open;

    while not Query.Eof do
    begin
      Lista.Add(Tarefa.Create(
        Query.FieldByName('codigo').AsInteger,
        Query.FieldByName('nome').AsString,
        Query.FieldByName('tipo').AsString
      ));
      Query.Next;
    end;

    Query.Close;
    Result := Lista;
  finally
    Query.Free;
  end;
end;


function UsuarioTarefa.Salvar: Boolean;
var
  Query: TFDQuery;
begin
  Result := False;
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := Conexao.Tconexao.GetConexao();
    Query.Close;
    Query.SQL.Clear;
    Query.SQL.Add('INSERT INTO usuario_tarefa (cod_usuario, cod_tarefa) ' +
                  'VALUES (:cod_usuario, :cod_tarefa) ' +
                  'ON DUPLICATE KEY UPDATE cod_tarefa = :cod_tarefa');
    Query.ParamByName('cod_usuario').AsInteger := FCodUsuario;
    Query.ParamByName('cod_tarefa').AsInteger := FCodTarefa;
    Query.ExecSQL;
    Result := True;
  finally
    Query.Free;
  end;
end;

end.

