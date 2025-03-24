unit FrmUsuario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Imaging.pngimage;

type
  TFormUsuario = class(TForm)
    GroupBoxPrincipal: TGroupBox;
    EditCodUsuario: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    EditNome: TEdit;
    ComboBoxSituacao: TComboBox;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    EditSenha: TEdit;
    EditConfirmaSenha: TEdit;
    ButtonSair: TButton;
    ButtonLimpar: TButton;
    ButtonExcluir: TButton;
    ButtonSalvar: TButton;
    ImageUsuario: TImage;
    procedure ButtonSairClick(Sender: TObject);
    procedure ButtonSalvarClick(Sender: TObject);
    procedure ButtonLimparClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EditCodUsuarioExit(Sender: TObject);
    procedure ButtonExcluirClick(Sender: TObject);
    procedure ImageUsuarioClick(Sender: TObject);
  private
    function ValidaDados: TStringList;
    function ConverteDireito: String;
    procedure LimpaForm(const LimpaCod: Boolean = true);
  public
    { Public declarations }
  end;

var
  FormUsuario: TFormUsuario;

implementation

{$R *.dfm}

uses TUsuario, frmPesquisaUsuario;

procedure TFormUsuario.ButtonExcluirClick(Sender: TObject);
var
  fUsuario: Usuario;
begin
  if Trim(EditCodUsuario.Text) <> '' then
  begin
    if Application.MessageBox('Deseja realmente excluir esse usúario?', 'Atenção', MB_YESNO+MB_ICONQUESTION) = mrYes then
    begin
      fUsuario := Usuario.Create;
      try
        fUsuario.Codigo := StrToIntDef(EditCodUsuario.Text,0);
        if fUsuario.Excluir then
        begin
          Application.MessageBox('Usúario Excluido com sucesso!', 'Informação', MB_OK+MB_ICONINFORMATION);
          LimpaForm;
          if EditCodUsuario.CanFocus then
            EditCodUsuario.SetFocus;
        end
        else
          Application.MessageBox('Erro ao excluir o usúario.', 'Erro', MB_OK+MB_ICONERROR);
      finally
        fUsuario.Free;
      end;
    end;
  end;
end;

procedure TFormUsuario.ButtonLimparClick(Sender: TObject);
begin
  LimpaForm;
end;

procedure TFormUsuario.ButtonSairClick(Sender: TObject);
begin
  close;
end;

procedure TFormUsuario.ButtonSalvarClick(Sender: TObject);
var
  fResultValida: TStringList;
  fUsuario: Usuario;
begin
  fResultValida := ValidaDados();

  if fResultValida.Count >= 1 then
  begin
    Application.MessageBox(PChar(fResultValida.Text), 'Atenção', MB_OK + MB_ICONWARNING);
    Exit;
  end;

  fUsuario := Usuario.Create(StrToInt(EditCodUsuario.Text),
                             EditNome.Text,
                             ConverteDireito,
                             EditSenha.Text);
  try
    if fUsuario.Salvar then
    begin
      Application.MessageBox('Usúario salvo com sucesso!', 'Informação', MB_OK+MB_ICONINFORMATION);
      LimpaForm;
    end
    else
      Application.MessageBox('Erro ao salvar usúario.', 'Erro', MB_OK+MB_ICONERROR);
  finally
     fUsuario.Free;
  end;
end;

function TFormUsuario.ConverteDireito: String;
begin
  case ComboBoxSituacao.ItemIndex of
    0: Result := 'O';
    1: Result := 'S';
  end;
end;

procedure TFormUsuario.EditCodUsuarioExit(Sender: TObject);
var
  fUsuario: Usuario;
begin
  LimpaForm(false);
  if Trim(EditCodUsuario.Text) <> '' then
  begin
    fUsuario := Usuario.BuscarPorCodigo(StrToIntDef(EditCodUsuario.Text,0));
    if fUsuario <> nil then
    begin
      EditNome.Text := fUsuario.Nome;
      if fUsuario.Direito = 'O' then
        ComboBoxSituacao.ItemIndex := 0
      else
        ComboBoxSituacao.ItemIndex := 1;
      EditSenha.Text := fUsuario.Senha;
    end;
  end;
end;

procedure TFormUsuario.FormShow(Sender: TObject);
begin
  LimpaForm;
end;

procedure TFormUsuario.ImageUsuarioClick(Sender: TObject);
var
  frmPesquisa : TTfrmPesquisaUsuario;
begin
  frmPesquisa := TTfrmPesquisaUsuario.Create(self);
  try
    frmPesquisa.ShowModal;
    if not (frmPesquisa.CodUsuario = 0) then
      EditCodUsuario.Text := IntToStr(frmPesquisa.CodUsuario);
    EditCodUsuarioExit(EditCodUsuario);
  finally
    frmPesquisa.Free;
  end;
end;

procedure TFormUsuario.LimpaForm(const LimpaCod: Boolean = true);
begin
  if LimpaCod then
    EditCodUsuario.Text := IntToStr(Usuario.PegaMaxCodigo);

  EditNome.Clear;
  ComboBoxSituacao.ItemIndex := 0;
  EditSenha.Clear;
  EditConfirmaSenha.Clear;
end;

function TFormUsuario.ValidaDados: TStringList;
begin
  Result := TStringList.Create;

  try
    if Trim(EditCodUsuario.Text) = '' then
      Result.Add('* Campo [código] obrigatório!');
    if Trim(EditNome.Text) = '' then
      Result.Add('* Campo [nome] obrigatório!');
    if Trim(EditSenha.Text) = '' then
      Result.Add('* Campo [senha] obrigatória!');
    if Trim(EditConfirmaSenha.Text) = '' then
      Result.Add('* Campo [confirmar senha] obrigatória!');
    if Trim(EditSenha.Text) <> Trim(EditConfirmaSenha.Text) then
      Result.Add('* Senha não conferem!');
  except
    on E: Exception do
      Result.Free;
  end;
end;

end.
