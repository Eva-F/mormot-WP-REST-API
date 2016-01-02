object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 675
  ClientWidth = 1077
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    1077
    675)
  PixelsPerInch = 96
  TextHeight = 13
  object Label3: TLabel
    Left = 8
    Top = 8
    Width = 102
    Height = 13
    Caption = 'TEST WP REST API'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 8
    Top = 216
    Width = 138
    Height = 13
    Caption = 'TEST Woocommerce API'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label11: TLabel
    Left = 8
    Top = 406
    Width = 168
    Height = 13
    Caption = 'New user/customer (as JSON)'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object DrawGrid: TDrawGrid
    Left = 560
    Top = 0
    Width = 517
    Height = 675
    Align = alRight
    Anchors = [akLeft, akTop, akRight, akBottom]
    ColCount = 1
    FixedCols = 0
    RowCount = 1
    FixedRows = 0
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 4
    Top = 69
    Width = 550
    Height = 68
    Alignment = taLeftJustify
    Caption = 'Updating'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    VerticalAlignment = taAlignTop
    object Label5: TLabel
      Left = 47
      Top = 16
      Width = 47
      Height = 13
      Alignment = taRightJustify
      Caption = 'username'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label6: TLabel
      Left = 42
      Top = 41
      Width = 52
      Height = 13
      Alignment = taRightJustify
      Caption = 'description'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object EditWPUsername: TEdit
      Left = 100
      Top = 11
      Width = 298
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = 'Eva'
    end
    object EditWPdescription: TEdit
      Left = 100
      Top = 38
      Width = 298
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Text = 'blablablaa'
    end
    object ButtonChangeWPDescription: TButton
      Left = 405
      Top = 36
      Width = 140
      Height = 25
      Caption = 'Change user description'
      TabOrder = 2
      OnClick = ButtonChangeWPDescriptionClick
    end
    object ButtonCreateUser: TButton
      Left = 404
      Top = 9
      Width = 140
      Height = 25
      Caption = 'Create user '
      TabOrder = 3
      OnClick = ButtonCreateUserClick
    end
  end
  object Panel2: TPanel
    Left = 4
    Top = 27
    Width = 550
    Height = 41
    Alignment = taLeftJustify
    Caption = 'Reading'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    VerticalAlignment = taAlignTop
    object Label2: TLabel
      Left = 30
      Top = 16
      Width = 64
      Height = 13
      Alignment = taRightJustify
      Caption = 'settings json '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object EditWPRestAPI: TEdit
      Left = 100
      Top = 12
      Width = 298
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = 'WPRESTAPI.json'
    end
    object ButtonWPUsers: TButton
      Left = 405
      Top = 10
      Width = 140
      Height = 25
      Caption = 'get WP users'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = ButtonWPUsersClick
    end
  end
  object Panel3: TPanel
    Left = 4
    Top = 235
    Width = 550
    Height = 41
    Alignment = taLeftJustify
    Caption = 'Reading'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    VerticalAlignment = taAlignTop
    object Label7: TLabel
      Left = 30
      Top = 16
      Width = 64
      Height = 13
      Alignment = taRightJustify
      Caption = 'settings json '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object EditWooRestApi: TEdit
      Left = 98
      Top = 12
      Width = 298
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = 'WooRESTAPI.json'
    end
    object ButtonWooCustomers: TButton
      Left = 405
      Top = 11
      Width = 140
      Height = 25
      Caption = 'get Woo Customers'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = ButtonWooCustomersClick
    end
  end
  object Panel4: TPanel
    Left = 4
    Top = 277
    Width = 550
    Height = 68
    Alignment = taLeftJustify
    Caption = 'Updating'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    VerticalAlignment = taAlignTop
    object Label8: TLabel
      Left = 47
      Top = 16
      Width = 47
      Height = 13
      Alignment = taRightJustify
      Caption = 'username'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 45
      Top = 41
      Width = 49
      Height = 13
      Alignment = taRightJustify
      Caption = 'last_name'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object EditWooUsername: TEdit
      Left = 100
      Top = 11
      Width = 298
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = 'Eva'
    end
    object EditWoolastname: TEdit
      Left = 100
      Top = 38
      Width = 298
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Text = 'blablablaa'
    end
    object ButtonChangeWooLastname: TButton
      Left = 405
      Top = 36
      Width = 140
      Height = 25
      Caption = 'Change customer lastname'
      TabOrder = 2
      OnClick = ButtonChangeWooLastnameClick
    end
    object ButtonWooCreateCustomer: TButton
      Left = 405
      Top = 7
      Width = 140
      Height = 25
      Caption = 'Create customer'
      TabOrder = 3
      OnClick = ButtonWooCreateCustomerClick
    end
  end
  object Panel5: TPanel
    Left = 4
    Top = 137
    Width = 550
    Height = 53
    Alignment = taLeftJustify
    Caption = 'Filtering'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    VerticalAlignment = taAlignTop
    object Label1: TLabel
      Left = 72
      Top = 10
      Width = 22
      Height = 13
      Alignment = taRightJustify
      Caption = 'filter'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      OnClick = ButtonChangeWooLastnameClick
    end
    object LabelWPFilter: TLabel
      Left = 100
      Top = 33
      Width = 3
      Height = 13
    end
    object EditWPFilterValue: TEdit
      Left = 207
      Top = 6
      Width = 192
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = '*Eva*'
    end
    object ComboBoxWP: TComboBox
      Left = 100
      Top = 6
      Width = 98
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemIndex = 0
      ParentFont = False
      TabOrder = 1
      Text = 'search'
      Items.Strings = (
        'search'
        'number'
        'orderby')
    end
    object ButtonWPAddFilter: TButton
      Left = 405
      Top = 6
      Width = 69
      Height = 25
      Caption = 'Add Filter'
      TabOrder = 2
      OnClick = ButtonWPAddFilterClick
    end
    object ButtonWPClearFilter: TButton
      Left = 475
      Top = 6
      Width = 69
      Height = 25
      Caption = 'clear Filter'
      TabOrder = 3
      OnClick = ButtonWPClearFilterClick
    end
  end
  object Panel6: TPanel
    Left = 4
    Top = 346
    Width = 550
    Height = 54
    Alignment = taLeftJustify
    Caption = 'Filtering'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    VerticalAlignment = taAlignTop
    object Label10: TLabel
      Left = 72
      Top = 10
      Width = 22
      Height = 13
      Alignment = taRightJustify
      Caption = 'filter'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      OnClick = ButtonChangeWooLastnameClick
    end
    object LabelWooFilter: TLabel
      Left = 100
      Top = 33
      Width = 3
      Height = 13
    end
    object EditWooFilterValue: TEdit
      Left = 207
      Top = 6
      Width = 192
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = '200'
    end
    object ComboBoxWoo: TComboBox
      Left = 100
      Top = 6
      Width = 98
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      Text = 'limit'
      Items.Strings = (
        'limit'
        'role')
    end
    object ButtonWooAddFilter: TButton
      Left = 405
      Top = 6
      Width = 69
      Height = 25
      Caption = 'Add Filter'
      TabOrder = 2
      OnClick = ButtonWooAddFilterClick
    end
    object ButtonWooClearFilter: TButton
      Left = 476
      Top = 6
      Width = 69
      Height = 25
      Caption = 'clear Filter'
      TabOrder = 3
      OnClick = ButtonWooClearFilterClick
    end
  end
  object Memo1: TMemo
    Left = 4
    Top = 425
    Width = 550
    Height = 144
    Lines.Strings = (
      '')
    ScrollBars = ssVertical
    TabOrder = 7
  end
  object Panel7: TPanel
    Left = 4
    Top = 575
    Width = 550
    Height = 92
    Alignment = taLeftJustify
    Anchors = [akLeft, akTop, akBottom]
    Caption = 'Errors'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    VerticalAlignment = taAlignTop
    DesignSize = (
      550
      92)
    object MemoError: TMemo
      Left = 38
      Top = 0
      Width = 500
      Height = 88
      Anchors = [akLeft, akTop, akRight, akBottom]
      Lines.Strings = (
        '')
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
end
