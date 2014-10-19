unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdExplicitTLSClientServerBase, IdFTP,IniFiles, Vcl.Samples.Gauges, JvTimer,
  JvComponentBase, JvTrayIcon, Vcl.AppEvnts, UniProvider, InterBaseUniProvider,
  Data.DB, DBAccess, Uni, Vcl.FileCtrl, MemDS, JvChangeNotify, JvDriveCtrls,ShellApi;

type
  TForm1 = class(TForm)
    IdFTP1: TIdFTP;
    ListBox1: TListBox;
    btnLer: TBitBtn;
    Gauge1: TGauge;
    JvTimer1: TJvTimer;
    JvTrayIcon1: TJvTrayIcon;
    ApplicationEvents1: TApplicationEvents;
    conSIAC: TUniConnection;
    IbFbProvider: TInterBaseUniProvider;
    qrPed: TUniQuery;
    qrPedID_EMPRESA: TIntegerField;
    qrPedID_PEDIDO: TIntegerField;
    qrPedVENDEDOR: TIntegerField;
    qrPedCLIENTE: TStringField;
    qrPedDATA: TDateTimeField;
    qrPedSERIE: TStringField;
    qrPedFORMAPAGTO: TIntegerField;
    qrPedOBSERVACAO: TStringField;
    qrPedVTOTAL: TFloatField;
    qrPedSTATUS: TStringField;
    spPed: TUniStoredProc;
    qrAux: TUniQuery;
    qrItens: TUniQuery;
    qrItensID_EMPRESA: TIntegerField;
    qrItensID_PEDIDO: TIntegerField;
    qrItensID_ITEM: TIntegerField;
    qrItensPRODUTO: TIntegerField;
    qrItensQTDE: TFloatField;
    qrItensPRECO: TFloatField;
    spItens: TUniStoredProc;
    FileListBox1: TJvFileListBox;
    qrPedNUM_PEDIDO_MOBILE: TStringField;
    qrPedNUMNF: TStringField;
    procedure LeConfiguracao;
    procedure FormCreate(Sender: TObject);
    procedure btnLerClick(Sender: TObject);
    procedure IdFTP1WorkBegin(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCountMax: Int64);
    procedure IdFTP1Work(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCount: Int64);
    procedure JvTimer1Timer(Sender: TObject);
    procedure ApplicationEvents1Minimize(Sender: TObject);
    procedure JvTrayIcon1Click(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImportarArquivosTXT;
    function RetornaClientePeloCNPJ(pCNPJ: string): Integer;
    procedure JvTimer2Timer(Sender: TObject);
  private
    { Private declarations }
  public
    bytesToTransfer: integer;
    xPorta : Integer;
    xEndereco,xUsuario,xSenha,xCaminhoOrigem,xCaminhoDestino : string;
    xCaminhoFDB : string;
    xEmpresa : Integer;
    xUsaCNPJ,xImportaArquivos,xCaminhoSiac,xImportaDireto : string;

  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.ApplicationEvents1Minimize(Sender: TObject);
begin
  Hide;
  JvTrayIcon1.Active := True;
end;



procedure TForm1.btnLerClick(Sender: TObject);
var
  indice: integer;
  zArqExecutar : string;
begin
  try
   // JvTimer1.Enabled := False;
    btnLer.Enabled := False;

    //efetua a conexão ao FTP
    if IdFTP1.Connected then
      IdFTP1.Disconnect;
    IdFTP1.Connect();
    IdFTP1.DirectoryListing.DirectoryName := xCaminhoOrigem;
    //lista todos os arquivos do tipo .exe do ftp no ListBox1
    IdFTP1.List(ListBox1.Items,'*.txt',false);

    //se não houverem arquivos, aborta
    if ListBox1.Items.Count = 0 then
      begin
        JvTimer1.Enabled := False;
        JvTimer1.Enabled := True;

        Exit;
      end;
      //Abort;

    //para cada ítem do ListBox1
    for indice:=0 to ListBox1.Items.Count -1 do
    begin
      try
        //marca o ítem selecionado
        ListBox1.Selected[indice] := true;
        //captura o tamanho do arquivo para a varíavel global
        bytesToTransfer := IdFTP1.Size(ListBox1.Items.Strings[indice]);
        //inicia a transferência do arquivo
        IdFTP1.Get(ListBox1.Items.Strings[indice],IncludeTrailingPathDelimiter(xCaminhoDestino) + ListBox1.Items.Strings[indice], True,False);
        IdFTP1.Delete(ListBox1.Items.Strings[indice]);
      except
        on e:exception do
          showmessage(e.Message);
      end;
    end;

  finally
    //desconecta
    IdFTP1.Disconnect;
    btnLer.Enabled   := True;
    jvtimer1.Enabled := false;
    jvtimer1.Enabled := True;
    zArqExecutar := IncludeTrailingPathDelimiter(xCaminhoSiac)+ 'smart.exe';
    try

      if (FileExists(zArqExecutar)) and (AnsiUpperCase(xImportaDireto)='S') then
        ShellExecute(Handle,'open',PChar(zArqExecutar),'',PChar(xCaminhoSiac),WS_MAXIMIZEBOX);

    Except
      on E: Exception do
        begin

          Application.MessageBox (PChar( 'Falha ao executar smart.exe' +#13+#10+
               'Classe: ' + E.ClassName +#13+#10+
               'Erro: ' + E.Message), 'Erro', MB_OK + MB_ICONERROR);
        end;
    end;

    if ((AnsiUpperCase(xImportaArquivos)='S')) then
      ImportarArquivosTXT;

  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  if not FileExists(IncludeTrailingPathDelimiter(ExtractFilePath(Application.ExeName))+ 'ftpsiac.ini') then
    begin
      Application.MessageBox( 'Arquivo de configuração ftpsiac.ini não encontrado!','Atenção',MB_OK + MB_ICONINFORMATION);
      Exit;
    end;
  LeConfiguracao;
  JvTimer1.Enabled := True;

  try
    conSIAC.Close;
    conSIAC.Database := xCaminhoFDB;
    conSIAC.Connect;

  except
    on E: Exception do
    begin
      Gauge1.ForeColor := clRed;
      Application.MessageBox (PChar( 'Falha ao conectar FDB SIAC.' +#13+#10+
               'Classe: ' + E.ClassName +#13+#10+
               'Erro: ' + E.Message), 'Erro', MB_OK + MB_ICONERROR);
    end;
  end;


end;

procedure TForm1.IdFTP1Work(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Int64);
begin
   //incrementa o Gauge
  Gauge1.Progress := AWorkCount;
end;

procedure TForm1.IdFTP1WorkBegin(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCountMax: Int64);

begin
  //limpa a barra de progresso
  Gauge1.Progress := 0;
  //define o tamanho máximo para o Gauge
  if AWorkCountMax > 0 then
    Gauge1.MaxValue := AWorkCountMax
  else
    Gauge1.MaxValue := bytesToTransfer;
end;

procedure TForm1.ImportarArquivosTXT;
var
  zConta,zConta2,zContLinha,zQtdeDetalhe,zDifDetalhe: Integer;
  zMestre : Integer;
  zArq,zLinha : string;
  zLista,zListaTemp : TStringList;
begin
  zLista := TStringList.Create;
  FileListBox1.Directory := xCaminhoDestino;
  FileListBox1.FileName := '*.txt';
  FileListBox1.Update;
  For zConta:= 0 to Pred(FileListBox1.Items.Count) do
    Begin
      zArq := IncludeTrailingPathDelimiter(xCaminhoDestino) +  FileListBox1.Items.Strings[zConta];
      Try
        zLista.LoadFromFile(zArq);
        Trim(zLista.Text);

        qrPed.Close;
        qrPed.Open;
        zListaTemp := TStringList.Create;
        qrItens.Close;
        qrItens.Open;



            zLinha := zLista[zContLinha];
            zListaTemp.Delimiter := ';';
            zListaTemp.DelimitedText := zLinha;
            zQtdeDetalhe :=  zListaTemp.Count;
            qrPed.Append;
            qrPedID_EMPRESA.AsInteger         := xEmpresa;
            qrPedNUM_PEDIDO_MOBILE.AsString  :=zListaTemp[0];
            qrPedVENDEDOR.AsInteger           := StrToInt(zListaTemp[1]);
            qrPedDATA.AsString                := Copy(zListaTemp[2],1,2) + '/' + Copy(zListaTemp[2],3,2) + '/' + Copy(zListaTemp[2],5,4);
            qrPedSERIE.AsString               := zListaTemp[3];
            if xUsaCNPJ= 'S' then
              qrPedCLIENTE.AsInteger          := RetornaClientePeloCNPJ(zListaTemp[4])
            else
              qrPedCLIENTE.AsInteger          := StrToInt(zListaTemp[4]);
            qrPedFORMAPAGTO.AsInteger         := StrToInt(zListaTemp[5]);
            qrPedOBSERVACAO.AsString          := zListaTemp[6];
            qrPedVTOTAL.AsFloat               := StrToFloat( StringReplace(zListaTemp[7],'.',',',[rfReplaceAll]));
            spPed.Close;
            spPed.ParamByName('PEMPRESA').AsInteger := xEmpresa;
            spPed.ExecProc;
            qrPedID_PEDIDO.AsInteger :=spPed.ParamByName('ZULTIMO').AsInteger  + 1;
            spPed.Close;
            qrPed.Post;

            zDifDetalhe := zQtdeDetalhe - 10 ;
            zConta2 := 9;

            while (zConta2 < (zQtdeDetalhe -1 )) do
              begin
                qrItens.Append;
                qrItensID_EMPRESA.AsInteger := xEmpresa;
                qrItensID_PEDIDO.AsInteger  := qrPedID_PEDIDO.AsInteger;
                spItens.Close;
                spItens.ParamByName('PEMPRESA').AsInteger := xEmpresa;
                spItens.ParamByName('PPEDIDO').AsInteger  := qrPedID_PEDIDO.AsInteger;
                spItens.ExecProc;
                qrItensID_ITEM.AsInteger    := spItens.ParamByName('ZULTIMO').AsInteger  + 1;
                qrItensPRODUTO.AsInteger    :=  StrToInt(zListaTemp[zConta2]);
                qrItensQTDE.AsFloat         :=  StrToFloat(StringReplace(zListaTemp[zConta2+1],'.',',',[rfReplaceAll]));
                qrItensPRECO.AsFloat        :=  StrToFloat(StringReplace(zListaTemp[zConta2+2],'.',',',[rfReplaceAll]));
                qrItens.Post;
                zConta2 := zConta2 + 3;
              end;

        qrPed.Close;
        qrItens.Close;


      Except
        on E: Exception do
          begin
            Application.MessageBox (PChar( 'Erro Lendo Arquivo txt.' +#13+#10+
               'Classe: ' + E.ClassName +#13+#10+
               'Erro: ' + E.Message), 'Erro', MB_OK + MB_ICONERROR);
               Exit;
          end;

      End;
      FreeAndNil(zLista);
      FreeAndNil(zListaTemp);
      DeleteFile(zArq);
      FileListBox1.Update;
    end;
end;

procedure TForm1.JvTimer1Timer(Sender: TObject);
begin

  btnLer.OnClick(btnLer);
end;

procedure TForm1.JvTimer2Timer(Sender: TObject);
begin
  ImportarArquivosTXT;
end;

procedure TForm1.JvTrayIcon1Click(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Form1.Show;
  JvTrayIcon1.Active := False;
end;

procedure TForm1.LeConfiguracao;
var
  IniFile    : String;
  Ini        : TIniFile;

begin
  IniFile := ExtractFilePath(Application.ExeName)+ 'ftpsiac.ini' ;
  Ini := TIniFile.Create( IniFile );
  try

    xEndereco       := Ini.ReadString( 'Config', 'Endereco'  , '');
    xUsuario        := Ini.ReadString( 'Config', 'Usuario'  , '');
    xSenha          := Ini.ReadString( 'Config', 'Pass'  , '');
    xPorta          := Ini.ReadInteger( 'Config', 'Porta'  ,0 );
    xCaminhoOrigem  := Ini.ReadString( 'Config', 'Diretorio'  , '/');
    xCaminhoDestino := Ini.ReadString( 'Config', 'Destino'  , '/');
    xCaminhoFDB     := Ini.ReadString( 'Config', 'CaminhoFDB'  , 'c:\Siac\Dados');
    xEmpresa        := Ini.ReadInteger( 'Config', 'Empresa'  ,1 );
    xUsaCNPJ        := Ini.ReadString( 'Config', 'UsarCNPJ'  , 'N');
    xImportaArquivos := Ini.ReadString( 'Config', 'ImportarArquivos'  , 'N');
    xImportaDireto     :=Ini.ReadString( 'Config', 'ImportaDireto'  , '');
    xCaminhoSiac     :=Ini.ReadString( 'Config', 'CaminhoSiac'  , '');
    FileListBox1.Directory := xCaminhoDestino;


    if IdFTP1.Connected then IdFTP1.Disconnect;
    IdFTP1.Host        := xEndereco;
    IdFTP1.Username    := xUsuario;
    IdFTP1.Password    := xSenha;
    IdFTP1.Port        := xPorta;
    IdFTP1.Passive     := True;

  finally
      FreeAndNil(Ini);
  end;




end;

function TForm1.RetornaClientePeloCNPJ(pCNPJ: string): Integer;
begin
  qrAux.Close;
  qrAux.SQL.Clear;
  qrAux.SQL.Add('SELECT ID_CLIENTE FROM CLIENTES WHERE');
  if Length(pCNPJ) > 11 then
    qrAux.SQL.Add( ' CNPJ='+ #39 + pCNPJ + #39)
  else
    qrAux.SQL.Add( ' CPF='+ #39 + pCNPJ + #39);
  qrAux.Open;
  Result := qrAux.FieldByName('ID_CLIENTE').AsInteger;
  qrAux.Close;

end;

end.
