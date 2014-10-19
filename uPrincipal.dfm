object Form1: TForm1
  Left = 279
  Top = 172
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'CLIENTE FTP - SIAC SISTEMAS'
  ClientHeight = 131
  ClientWidth = 397
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Gauge1: TGauge
    Left = 85
    Top = 103
    Width = 302
    Height = 24
    ForeColor = clLime
    Progress = 0
  end
  object ListBox1: TListBox
    Left = 1
    Top = 0
    Width = 386
    Height = 97
    ItemHeight = 13
    TabOrder = 0
  end
  object btnLer: TBitBtn
    Left = 4
    Top = 103
    Width = 75
    Height = 25
    Caption = '&Ler'
    TabOrder = 1
    OnClick = btnLerClick
  end
  object FileListBox1: TJvFileListBox
    Left = 3
    Top = 133
    Width = 384
    Height = 97
    ItemHeight = 13
    TabOrder = 2
    ForceFileExtensions = False
  end
  object IdFTP1: TIdFTP
    OnWork = IdFTP1Work
    OnWorkBegin = IdFTP1WorkBegin
    IPVersion = Id_IPv4
    NATKeepAlive.UseKeepAlive = False
    NATKeepAlive.IdleTimeMS = 0
    NATKeepAlive.IntervalMS = 0
    ProxySettings.ProxyType = fpcmNone
    ProxySettings.Port = 0
    Left = 216
    Top = 48
  end
  object JvTimer1: TJvTimer
    EventTime = tetPost
    Interval = 60000
    OnTimer = JvTimer1Timer
    Left = 256
    Top = 48
  end
  object JvTrayIcon1: TJvTrayIcon
    Active = True
    Animated = True
    Icon.Data = {
      0000010001001010000000002000680400001600000028000000100000002000
      000001002000000000004004000000000000000000000000000000000000FFFF
      FF01FFFFFF01FFFFFF01FFFFFF01FFFFFF01FFFFFF01FFFFFF01FFFFFF01FFFF
      FF01FFFFFF01FFFFFF01FFFFFF01FFFFFF01FFFFFF01FFFFFF01FFFFFF01FFFF
      FF01FFFFFF01FFFFFF01FFFFFF01FFFFFF01FFFFFF01FFFFFF01FFFFFF01FFFF
      FF01FFFFFF01FFFFFF010D850DFF0B9E0CAFFFFFFF01FFFFFF01FFFFFF01FFFF
      FF01FFFFFF01FFFFFF01FFFFFF01FFFFFF01FFFFFF01FFFFFF01FFFFFF01FFFF
      FF01FFFFFF01FFFFFF01009900FF0D850DFF0099009FFFFFFF01FFFFFF01FFFF
      FF01FFFFFF01FFFFFF01FFFFFF01FFFFFF01FFFFFF01FFFFFF010D850DFF0D85
      0DFF0D850DFF0D850DFF0D850DFF88D28AFF0D850DFF00990071FFFFFF01FFFF
      FF01FFFFFF01FFFFFF01FFFFFF01FFFFFF01FFFFFF01FFFFFF01009900FFAAE1
      ADFF5CC563FF55C15BFF4EBD53FF3CB641FF4DBB50FF0D850DFF00990061D4A7
      7EFFC0936DFFBF926CFFBF926CFFBF926CFFBF926CFFBF926CFF009900FFA8E1
      ADFF52C25AFF4ABE51FF42BA48FF3AB640FF37B43CFF55BE58FF0D850DFFEBBE
      92FFF0DBCDFFF9DDC1FFF0DCCEFFF9DDC1FFF0DCCEFFF9DDC1FF009900FFB1E5
      B6FF97DB9CFF97DB9CFF97DB9CFF97DB9CFF5AC25FFF009900FF00990061EBBE
      92FFFBEEE1FFFDEEDFFFFEF3E8FFFEF4E9FFFEF4E9FFF6E4D2FF009900FF0D9E
      0DFF0D9E0DFF0D9E0DFF009900FF97DB9CFF009900FF00990061FFFFFF01EBBE
      92FFE9CEB2FFF0DDC8FFFEF6EEFFFFF6ECFFEED7BFFFE1C19FFFE1C19FFFEED7
      BFFFFFF6ECFFFEF6EEFF009900FF009900FF489629FFFFFFFF01FFFFFF01EBBE
      92FFFFF2E3FFEDD0B2FFE6C9ACFFE8CDB2FFEAD2B9FFFDF5EEFFFDF6EEFFEAD2
      B9FFE8CDB2FFE6C9ACFF009900FF5FBB56FFBF926CFFFFFFFF01FFFFFF01EBBE
      92FFFFF2E3FFF6DFC6FFE2C09BFFF0DDC9FFFFF4E9FFFFF3E6FFFFF4EAFFFFF7
      EFFFF0DDC9FFE2BF9AFFF5DDC2FFFEF0E1FFBF926CFFFFFFFF01FFFFFF01EBBE
      92FFF5E2CDFFE1BF9BFFF7E7D6FFFFF0E1FFFFF1E4FFFFF4E9FFFFF5EBFFFFF6
      ECFFFFF5ECFFF7E7D8FFDFBC96FFF3DEC8FFBF926CFFFFFFFF01FFFFFF01EBBE
      92FFE8CEB3FFFBECDCFFFFECD9FFFFF0E1FFFFF3E7FFFFF5EAFFFFF5ECFFFFF6
      EDFFFFF6EDFFFFF5EBFFFAEDDFFFE6C9ACFFBF926CFFFFFFFF01FFFFFF01EBBE
      92FFF6EDEAFFFFE8D1FFF6EBE5FFFFEEDDFFF6EFEEFFFFF1E2FFF6F0F0FFFFF1
      E3FFF6F0F0FFFFF1E3FFF6EFEFFFFFF1E2FFC49770FFFFFFFF01FFFFFF01EBBE
      92FFEBBE92FFEBBE92FFEBBE92FFEBBE92FFEBBE92FFEBBE92FFEBBE92FFEBBE
      92FFEBBE92FFEBBE92FFEBBE92FFEBBE92FFE8BB90FFFFFFFF01FFFFFF01FFFF
      FF01FFFFFF01FFFFFF01FFFFFF01FFFFFF01FFFFFF01FFFFFF01FFFFFF01FFFF
      FF01FFFFFF01FFFFFF01FFFFFF01FFFFFF01FFFFFF01FFFFFF01FFFFFF010000
      FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000
      FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF0000FFFF}
    IconIndex = 0
    Hint = 'Captura de Pedidos'
    OnClick = JvTrayIcon1Click
    Left = 296
    Top = 48
  end
  object ApplicationEvents1: TApplicationEvents
    OnMinimize = ApplicationEvents1Minimize
    Left = 346
    Top = 48
  end
  object conSIAC: TUniConnection
    ProviderName = 'InterBase'
    Database = 'C:\SIAC\DADOS\DADOS.FDB'
    SpecificOptions.Strings = (
      'InterBase.Charset=WIN1252'
      'InterBase.ClientLibrary=fbclient.dll')
    Username = 'SYSDBA'
    Password = 'masterkey'
    Connected = True
    LoginPrompt = False
    Left = 16
    Top = 8
  end
  object IbFbProvider: TInterBaseUniProvider
    Left = 80
    Top = 8
  end
  object qrPed: TUniQuery
    SQLInsert.Strings = (
      'INSERT INTO PEDIDOS_MOBILE'
      
        '  (ID_EMPRESA, ID_PEDIDO, NUM_PEDIDO_MOBILE, VENDEDOR, CLIENTE, ' +
        'DATA, SERIE, FORMAPAGTO, OBSERVACAO, VTOTAL, STATUS)'
      'VALUES'
      
        '  (:ID_EMPRESA, :ID_PEDIDO, :NUM_PEDIDO_MOBILE, :VENDEDOR, :CLIE' +
        'NTE, :DATA, :SERIE, :FORMAPAGTO, :OBSERVACAO, :VTOTAL, :STATUS)')
    SQLDelete.Strings = (
      'DELETE FROM PEDIDOS_MOBILE'
      'WHERE'
      '  ID_EMPRESA = :Old_ID_EMPRESA AND ID_PEDIDO = :Old_ID_PEDIDO')
    SQLUpdate.Strings = (
      'UPDATE PEDIDOS_MOBILE'
      'SET'
      
        '  ID_EMPRESA = :ID_EMPRESA, ID_PEDIDO = :ID_PEDIDO, NUM_PEDIDO_M' +
        'OBILE = :NUM_PEDIDO_MOBILE, VENDEDOR = :VENDEDOR, CLIENTE = :CLI' +
        'ENTE, DATA = :DATA, SERIE = :SERIE, FORMAPAGTO = :FORMAPAGTO, OB' +
        'SERVACAO = :OBSERVACAO, VTOTAL = :VTOTAL, STATUS = :STATUS'
      'WHERE'
      '  ID_EMPRESA = :Old_ID_EMPRESA AND ID_PEDIDO = :Old_ID_PEDIDO')
    SQLLock.Strings = (
      'SELECT NULL FROM PEDIDOS_MOBILE'
      'WHERE'
      'ID_EMPRESA = :Old_ID_EMPRESA AND ID_PEDIDO = :Old_ID_PEDIDO'
      'FOR UPDATE WITH LOCK')
    SQLRefresh.Strings = (
      
        'SELECT ID_EMPRESA, ID_PEDIDO, NUM_PEDIDO_MOBILE, VENDEDOR, CLIEN' +
        'TE, DATA, SERIE, FORMAPAGTO, OBSERVACAO, VTOTAL, STATUS FROM PED' +
        'IDOS_MOBILE'
      'WHERE'
      '  ID_EMPRESA = :ID_EMPRESA AND ID_PEDIDO = :ID_PEDIDO')
    Connection = conSIAC
    SQL.Strings = (
      'SELECT * FROM PEDIDOS_MOBILE WHERE ID_EMPRESA= :PEMPRESA'
      'AND ID_PEDIDO= :PPEDIDO')
    Left = 13
    Top = 60
    ParamData = <
      item
        DataType = ftInteger
        Name = 'PEMPRESA'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'PPEDIDO'
        ParamType = ptInput
      end>
    object qrPedID_EMPRESA: TIntegerField
      FieldName = 'ID_EMPRESA'
      Required = True
    end
    object qrPedID_PEDIDO: TIntegerField
      FieldName = 'ID_PEDIDO'
      Required = True
    end
    object qrPedVENDEDOR: TIntegerField
      FieldName = 'VENDEDOR'
      Required = True
    end
    object qrPedCLIENTE: TStringField
      FieldName = 'CLIENTE'
      Required = True
      Size = 14
    end
    object qrPedDATA: TDateTimeField
      FieldName = 'DATA'
      Required = True
    end
    object qrPedSERIE: TStringField
      FieldName = 'SERIE'
      Size = 2
    end
    object qrPedFORMAPAGTO: TIntegerField
      FieldName = 'FORMAPAGTO'
      Required = True
    end
    object qrPedOBSERVACAO: TStringField
      FieldName = 'OBSERVACAO'
      Size = 250
    end
    object qrPedVTOTAL: TFloatField
      FieldName = 'VTOTAL'
    end
    object qrPedSTATUS: TStringField
      FieldName = 'STATUS'
      Size = 1
    end
    object qrPedNUM_PEDIDO_MOBILE: TStringField
      FieldName = 'NUM_PEDIDO_MOBILE'
      Required = True
      Size = 25
    end
    object qrPedNUMNF: TStringField
      FieldName = 'NUMNF'
      Size = 6
    end
  end
  object spPed: TUniStoredProc
    StoredProcName = 'SP_PEDIDOS_MOBILE'
    Connection = conSIAC
    Left = 48
    Top = 62
    ParamData = <
      item
        DataType = ftInteger
        Name = 'PEMPRESA'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ZULTIMO'
        ParamType = ptOutput
      end>
    CommandStoredProcName = 'SP_PEDIDOS_MOBILE'
  end
  object qrAux: TUniQuery
    Connection = conSIAC
    Left = 144
    Top = 8
  end
  object qrItens: TUniQuery
    SQLInsert.Strings = (
      'INSERT INTO ITENS_PEDIDO_MOBILE'
      '  (ID_EMPRESA, ID_PEDIDO, ID_ITEM, PRODUTO, QTDE, PRECO)'
      'VALUES'
      '  (:ID_EMPRESA, :ID_PEDIDO, :ID_ITEM, :PRODUTO, :QTDE, :PRECO)')
    SQLDelete.Strings = (
      'DELETE FROM ITENS_PEDIDO_MOBILE'
      'WHERE'
      
        '  ID_EMPRESA = :Old_ID_EMPRESA AND ID_PEDIDO = :Old_ID_PEDIDO AN' +
        'D ID_ITEM = :Old_ID_ITEM')
    SQLUpdate.Strings = (
      'UPDATE ITENS_PEDIDO_MOBILE'
      'SET'
      
        '  ID_EMPRESA = :ID_EMPRESA, ID_PEDIDO = :ID_PEDIDO, ID_ITEM = :I' +
        'D_ITEM, PRODUTO = :PRODUTO, QTDE = :QTDE, PRECO = :PRECO'
      'WHERE'
      
        '  ID_EMPRESA = :Old_ID_EMPRESA AND ID_PEDIDO = :Old_ID_PEDIDO AN' +
        'D ID_ITEM = :Old_ID_ITEM')
    SQLLock.Strings = (
      'SELECT NULL FROM ITENS_PEDIDO_MOBILE'
      'WHERE'
      
        'ID_EMPRESA = :Old_ID_EMPRESA AND ID_PEDIDO = :Old_ID_PEDIDO AND ' +
        'ID_ITEM = :Old_ID_ITEM'
      'FOR UPDATE WITH LOCK')
    SQLRefresh.Strings = (
      
        'SELECT ID_EMPRESA, ID_PEDIDO, ID_ITEM, PRODUTO, QTDE, PRECO FROM' +
        ' ITENS_PEDIDO_MOBILE'
      'WHERE'
      
        '  ID_EMPRESA = :ID_EMPRESA AND ID_PEDIDO = :ID_PEDIDO AND ID_ITE' +
        'M = :ID_ITEM')
    Connection = conSIAC
    SQL.Strings = (
      'SELECT * FROM ITENS_PEDIDO_MOBILE WHERE'
      'ID_EMPRESA= :PEMPRESA'
      'AND ID_PEDIDO= :PPEDIDO'
      'AND ID_ITEM= :PITEM')
    Left = 80
    Top = 60
    ParamData = <
      item
        DataType = ftInteger
        Name = 'PEMPRESA'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'PPEDIDO'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'PITEM'
        ParamType = ptInput
      end>
    object qrItensID_EMPRESA: TIntegerField
      FieldName = 'ID_EMPRESA'
      Required = True
    end
    object qrItensID_PEDIDO: TIntegerField
      FieldName = 'ID_PEDIDO'
      Required = True
    end
    object qrItensID_ITEM: TIntegerField
      FieldName = 'ID_ITEM'
      Required = True
    end
    object qrItensPRODUTO: TIntegerField
      FieldName = 'PRODUTO'
    end
    object qrItensQTDE: TFloatField
      FieldName = 'QTDE'
    end
    object qrItensPRECO: TFloatField
      FieldName = 'PRECO'
    end
  end
  object spItens: TUniStoredProc
    StoredProcName = 'SP_ITENS_PEDIDO_MOBILE'
    Connection = conSIAC
    Left = 114
    Top = 61
    ParamData = <
      item
        DataType = ftInteger
        Name = 'PEMPRESA'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'PPEDIDO'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ZULTIMO'
        ParamType = ptOutput
      end>
    CommandStoredProcName = 'SP_ITENS_PEDIDO_MOBILE'
  end
end
