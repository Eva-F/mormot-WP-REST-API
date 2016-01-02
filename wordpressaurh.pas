unit wordpressaurh;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,  Vcl.Menus, Vcl.StdCtrls, mORMotUI,
  Vcl.Grids,mormot,WPRESTAPI,WPRESTAPIModels, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    DrawGrid: TDrawGrid;
    Label3: TLabel;
    Label4: TLabel;
    Panel1: TPanel;
    Label5: TLabel;
    EditWPUsername: TEdit;
    Label6: TLabel;
    EditWPdescription: TEdit;
    ButtonChangeWPDescription: TButton;
    Panel2: TPanel;
    Label2: TLabel;
    EditWPRestAPI: TEdit;
    ButtonWPUsers: TButton;
    Panel3: TPanel;
    Label7: TLabel;
    Panel4: TPanel;
    Label8: TLabel;
    Label9: TLabel;
    EditWooUsername: TEdit;
    EditWoolastname: TEdit;
    ButtonChangeWooLastname: TButton;
    EditWooRestApi: TEdit;
    ButtonWooCustomers: TButton;
    Panel5: TPanel;
    Label1: TLabel;
    EditWPFilterValue: TEdit;
    ComboBoxWP: TComboBox;
    ButtonWPAddFilter: TButton;
    ButtonWPClearFilter: TButton;
    LabelWPFilter: TLabel;
    Panel6: TPanel;
    Label10: TLabel;
    LabelWooFilter: TLabel;
    EditWooFilterValue: TEdit;
    ComboBoxWoo: TComboBox;
    ButtonWooAddFilter: TButton;
    ButtonWooClearFilter: TButton;
    ButtonCreateUser: TButton;
    Memo1: TMemo;
    ButtonWooCreateCustomer: TButton;
    Label11: TLabel;
    Panel7: TPanel;
    MemoError: TMemo;
    procedure FormDestroy(Sender: TObject);
    procedure ButtonWPUsersClick(Sender: TObject);
    procedure ButtonWooCustomersClick(Sender: TObject);
    procedure ButtonChangeWPDescriptionClick(Sender: TObject);
    procedure ButtonChangeWooLastnameClick(Sender: TObject);
    procedure ButtonWPClearFilterClick(Sender: TObject);
    procedure ButtonWPAddFilterClick(Sender: TObject);
    procedure ButtonWooClearFilterClick(Sender: TObject);
    procedure ButtonWooAddFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButtonCreateUserClick(Sender: TObject);
    procedure ButtonWooCreateCustomerClick(Sender: TObject);
  private
    { Private declarations }
     fGrid: TSQLTableToGrid;
     fWoo: TWOOCommerce;
     fWooClient : TSQLWooClient;
     fWooCustomer : TSQLWooCustomer;
     fWP: TWPRESTAPI1_0_3LEGS ;
     fWPClient : TSQLWPClient;
     fWPUser : TSQLRESTAPIUser;
     fWPFilter , fWooFilter : string;

     procedure fillGrid(pTable: TSQLTable);
     function  CheckError(pResponseStr:string): boolean;
     function getFiltersStr(pFilter: string):string;

  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
 uses   SynCommons,chimera.JSON;

 procedure TForm1.fillGrid(pTable: TSQLTable);
 var lTable :TSQLTable;
 begin
    if assigned(fGrid) then
      freeAndNil(fGrid);
    lTable := TSQLTable.create(pTable.QuerySQL);
    lTable.assign(pTable);
    fGrid := TSQLTableToGrid.Create(DrawGrid,lTable,nil);
    fGrid.SetAlignedByType(sftCurrency,alRight);
    fGrid.SetFieldFixedWidth(100);
    fGrid.FieldTitleTruncatedNotShownAsHint := true;
    DrawGrid.Options := DrawGrid.Options-[goRowSelect];
end;


procedure TForm1.FormCreate(Sender: TObject);
begin
  fWPFilter := '{"search":"*eva*"}';
  fWooFilter := '{"role":"subscriber"}';
  LabelWPFilter.Caption := fWPFilter;
  LabelWooFilter.Caption := fWooFilter;

end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  freeAndNil(fGrid);
  if assigned(fWooCustomer) then freeAndNil(fWooCustomer);
  if assigned(fWoo) then freeAndNil(fWoo);
  if assigned(fWPUser) then freeAndNil(fWPUser);
  if assigned(fWP) then freeAndNil(fWP);

end;

procedure TForm1.ButtonChangeWPDescriptionClick(Sender: TObject);
begin
  if assigned( fWPUser) then
  begin
    fWPUser.FillRewind;
    while fWPUser.FillOne do
    begin
      if fWPUser.username=EditWPUsername.text then
      begin
        fWPUser.description := EditWPdescription.text;
        fWPClient.Update(fWPUser);
      end;
    end ;
    if not CheckError(fWPClient.JSONStr) then
      fillGrid(fWPUser.FillContext.Table);

  end
  else
    MemoError.Lines.text := 'WP users aren''t read';


end;


function  TForm1.CheckError(pResponseStr:string): boolean;
var
    lJSON   : IJSONObject;
    lJSONA   : IJSONArray;
    P :  PUTF8Char;
begin

  Result := true;
  MemoError.Lines.Clear;
  if pResponseStr = ''  then exit;
  p := Pointer(pResponseStr);
  lJSON := JSON;
  if P^='[' then
  begin
    lJSONA := JSON('{"A":'+  pResponseStr + '}').arrays['A'];
    if lJSONA.Count = 1 then
      lJSON := lJSONA.Objects[0];
  end
  else if P^='{' then
    lJSON := JSON( pResponseStr);

  if lJSON.Count = 0 then
  begin
    memoError.Lines.text :=  pResponseStr;
    exit;  //expects JSON
  end;

  Result := lJSON.Has['errors'] or (lJSON.Has['code'] and lJSON.Has['message']);
  if Result then
    memoError.Lines.text :=  FormatJSON(lJSON.asJSON);

end;

function TForm1.getFiltersStr(pFilter: string):string;
var lFilters,lPFilter : IJSONobject;
    i : integer;
begin
    lFilters := JSON;
    lPFilter := JSON(pFilter);
    for i := 0 to lpFilter.Count - 1 do
      fWP.AddFilter(lFilters,lpFilter.Names[i],lpFilter.strings[lpFilter.Names[i]]);
    result := lFilters.AsJSON;
end;


procedure TForm1.ButtonCreateUserClick(Sender: TObject);
var
    lJSON   : IJSONObject;
begin
  try
    if assigned(fWPUSer) then
      freeAndNil(fWPUser);

    fWPUser := TSQLRESTAPIUser.create;
    fWPUser.username := EditWPUsername.text;
    lJSON := JSON(memo1.lines.text);
    if lJSON.Has['username'] then
      fWPUser.username := lJSON.strings['username'];
    if lJSON.Has['name'] then
      fWPUser.name := lJSON.strings['name'];
    if lJSON.Has['first_name'] then
      fWPUser.first_name := lJSON.strings['first_name'];
    if lJSON.Has['nickname'] then
      fWPUser.nickname := lJSON.strings['nickname'];
    if lJSON.Has['slug'] then
      fWPUser.slug := lJSON.strings['slug'];
    if lJSON.Has['avatar'] then
      fWPUser.avatar := lJSON.strings['avatar'];
    if lJSON.Has['description'] then
      fWPUser.description := lJSON.strings['description'];
    if lJSON.Has['email'] then
      fWPUser.email := lJSON.strings['email'];
    if lJSON.Has['password'] then
      fWPUser.password := lJSON.strings['password'];
    if not assigned(fWPClient) then
    begin
      fWP := TWPRESTAPI1_0_3LEGS.create(EditWPRestAPI.text);
      fWP.Connect;
      fWPClient := TSQLWPClient(fWP.getWAPIClient('users',getFiltersStr(fWPFilter)));
    end;
    fWPClient.Add(fWPUser, true);

    FreeAndNil(fWPUser);

    if  checkError( fWPClient.JSONStr) then exit;

    fWPUser := TSQLRESTAPIUser.CreateAndFillPrepare(fWPClient,'',[]);


    if assigned(fWPUser) and assigned(fWPUser.FillContext) then
        fillGrid(fWPUser.FillContext.Table);
  finally
  end;

end;

procedure TForm1.ButtonWPAddFilterClick(Sender: TObject);
var lFilters : IJSONObject;
begin
  lFilters := JSON(fWPFilter);
  lFilters[ComboboxWP.Items[ComboboxWP.itemindex]] := EditWPFilterValue.Text;
  fWPFilter :=  lFilters.AsJSON;
  LabelWPFilter.Caption := fWPFilter;
end;

procedure TForm1.ButtonWPClearFilterClick(Sender: TObject);
begin
  fWPFilter := '';
  LabelWPFilter.Caption := fWPFilter;
end;

procedure TForm1.ButtonChangeWooLastnameClick(Sender: TObject);
begin
  if assigned( fWooCustomer) then
  begin
    fWooCustomer.FillRewind;

    while fWooCustomer.FillOne do
    begin
      if fWooCustomer.username=EditWooUsername.text then
      begin
        fWooCustomer.last_name := EditWoolastname.Text;
        fWooClient.Update(fWooCustomer);
      end;
    end;
    if not CheckError(fWooClient.JSONStr) then
      fillGrid(fWooCustomer.FillContext.Table);
  end
  else
    MemoError.Lines.text := 'WooCustomers aren''t read';

end;

procedure TForm1.ButtonWooAddFilterClick(Sender: TObject);

var lFilters : IJSONObject;
begin
  lFilters := JSON(fWooFilter);
  if ComboBoxWoo.itemindex = -1 then
   ComboBoxWoo.itemindex := 0;
  lFilters[ComboBoxWoo.Items[ComboBoxWoo.itemindex]] := EditWooFilterValue.Text;
  fWooFilter :=  lFilters.AsJSON;
  LabelWooFilter.Caption := fWooFilter;
end;

procedure TForm1.ButtonWooClearFilterClick(Sender: TObject);
begin
  fWooFilter := '';
  LabelWooFilter.Caption := fWooFilter;

end;

procedure TForm1.ButtonWooCreateCustomerClick(Sender: TObject);
var lWoocustomer : TSQLWooCustomer;
    lJSON   : IJSONObject;
begin
  try
    lWoocustomer := TSQLWooCustomer.create;
    lWoocustomer.username := EditWPUsername.text;
    lJSON := JSON(memo1.lines.text);
    if lJSON.Has['username'] then
      lWoocustomer.username := lJSON.strings['username'];
    if lJSON.Has['email'] then
      lWoocustomer.email := lJSON.strings['email'];

    if lJSON.Has['last_name'] then
      lWoocustomer.last_name := lJSON.strings['last_name'];
    if lJSON.Has['first_name'] then
      lWoocustomer.first_name := lJSON.strings['first_name'];
    if lJSON.Has['avatar_url'] then
      lWoocustomer.avatar_url := lJSON.strings['avatar_url'];
    if lJSON.Has['password'] then
      lWoocustomer.password := lJSON.strings['password'];
    if not assigned(fWooClient) then
    begin
      fWoo := TWOOCommerce.create(EditWooRestApi.text);
      fWoo.Connect;
      fWooClient := TSQLWooClient(fWoo.getWAPIClient('customers',getFiltersStr(fWooFilter)));
    end;
    fWooClient.Add(lWoocustomer, true);
    if not checkError( fWooClient.JSONStr) then
      fWooCustomer := TSQLWooCustomer.CreateAndFillPrepare(fWooClient,'',[]);

  //  fWooCustomer := TSQLWooCustomer.CreateAndFillPrepare(fWooClient,'',[]);

    if assigned(fWooCustomer) and assigned(fWooCustomer.FillContext) then
      fillGrid(fWooCustomer.FillContext.Table);
  finally
    freeAndNil(lWoocustomer);
  end;


end;

procedure TForm1.ButtonWooCustomersClick(Sender: TObject);
var
    i : integer;
    lJSONA : IJSONArray;
    lVal : string;
begin
  try
    if assigned(fWooCustomer) then freeAndNil(fWooCustomer);
    if assigned(fWoo) then freeAndNil(fWoo);

    fWoo := TWOOCommerce.create(EditWooRestApi.text);
    fWoo.Connect;
  // see for available filters  at https://woothemes.github.io/woocommerce-rest-api-docs/#parameters ; https://woothemes.github.io/woocommerce-rest-api-docs/#pagination

    fWooClient := TSQLWooClient(fWoo.getWAPIClient('customers',getFiltersStr(fWooFilter)));

    fWooCustomer := TSQLWooCustomer.CreateAndFillPrepare(fWooClient,'',[]);
    if not CheckError(fWooClient.JSONStr) then
    begin
      if assigned(fWooCustomer) and assigned(fWooCustomer.FillContext) then
        fillGrid(fWooCustomer.FillContext.Table);
      memo1.lines.clear;
      if JSON(fWooClient.JsonStr).has['customers'] then
      begin
        lJSONA := JSON(fWooClient.JsonStr).arrays['customers'];
        if lJSONA.count > 0  then
        begin
          lVal :=lJSONA.objects[0].asJSON;
          memo1.Lines.text :=  FormatJSON(lVal);
        end;
      end;
    end;
  finally
  end;

end;

procedure TForm1.ButtonWPUsersClick(Sender: TObject);
var lJSON : IJSONObject;
    lJSONa:IJSONArray;
    lVAl : string;
    i : integer;
begin
  try
    if assigned(fWPUser) then freeAndNil(fWPUser);
    if assigned(fWP) then freeAndNil(fWP);

    fWP := TWPRESTAPI1_0_3LEGS.create(EditWPRestAPI.text);
    fWP.Connect;
//   The filter parameter controls the query parameters  - see  http://wp-api.org/#users_retrieve-users
//   possible filters:
//    number - Number of users to retrieve, use -1 for all users. Default is set by the site. (integer)
//    offset - Number of posts to skip. Default is 0. (integer)
//    orderby - Parameter to search by, as per WP_User_Query. Default is “user_login”. (string)
//    order - Order to sort by. Default is “ASC”. (string, “ASC” or “DESC”)
//    search - Keyword to search for. (string)
// GET /users?filter[s]=xxx&filter[orderby]=username


    fWPClient := TSQLWPClient(fWP.getWAPIClient('users', getFiltersStr(fWPFilter)));

    memo1.lines.clear;
    if not CheckError(fWPClient.JSONStr) then
    begin
      // lFilters.asJSON = '{"search":"*eva*","orderby":"username}'
      fWPUser := TSQLRESTAPIUser.CreateAndFillPrepare(fWPClient,'',[]);
      if assigned(fWPUser) and assigned(fWPUser.FillContext) then
        fillGrid(fWPUser.FillContext.Table);
      lJSONA := JSON('{"A":'+fWPClient.JsonStr+'}').Arrays['A'];
      if lJSONA.count > 0  then
      begin
        lVal :=lJSONA.objects[0].asJSON;
        memo1.Lines.text :=  FormatJSON(lVal);
      end;
    end;

  finally
  end;

end;


end.
