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

  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
 uses   chimera.JSON;

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
    fillGrid(fWPUser.FillContext.Table);

  end
  else
    showmessage('WP users aren''t read')


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
    fillGrid(fWooCustomer.FillContext.Table);
  end
  else
    showmessage('WooCustomers aren''t read')

end;

procedure TForm1.ButtonWooAddFilterClick(Sender: TObject);

var lFilters : IJSONObject;
begin
  lFilters := JSON(fWooFilter);
  lFilters[ComboBoxWoo.Items[ComboBoxWoo.itemindex]] := EditWooFilterValue.Text;
  fWooFilter :=  lFilters.AsJSON;
  LabelWooFilter.Caption := fWooFilter;
end;

procedure TForm1.ButtonWooClearFilterClick(Sender: TObject);
begin
  fWooFilter := '';
  LabelWooFilter.Caption := fWooFilter;

end;

procedure TForm1.ButtonWooCustomersClick(Sender: TObject);
var lFilters,lWooFilters : IJSONObject;
    i : integer;
begin
  try
    if assigned(fWooCustomer) then freeAndNil(fWooCustomer);
    if assigned(fWoo) then freeAndNil(fWoo);

    fWoo := TWOOCommerce.create(EditWooRestApi.text);
    fWoo.Connect;
  // see for available filters  at https://woothemes.github.io/woocommerce-rest-api-docs/#parameters ; https://woothemes.github.io/woocommerce-rest-api-docs/#pagination

    lFilters := JSON;
    lWooFilters := JSON(fWooFilter);
    for i := 0 to lWooFilters.Count - 1 do
      fWoo.AddFilter(lFilters,lWooFilters.Names[i],lWooFilters.strings[lWooFilters.Names[i]]);

    fWooClient := TSQLWooClient(fWoo.getWAPIClient('customers',lFilters.asJSON));

    fWooCustomer := TSQLWooCustomer.CreateAndFillPrepare(fWooClient,'',[]);

    if assigned(fWooCustomer) and assigned(fWooCustomer.FillContext) then
      fillGrid(fWooCustomer.FillContext.Table);
  finally
  end;

end;

procedure TForm1.ButtonWPUsersClick(Sender: TObject);
var lFilters,lWPFilters : IJSONObject;
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

    lFilters := JSON;
    lWPFilters := JSON(fWPFilter);
    for i := 0 to lWPFilters.Count - 1 do
      fWP.AddFilter(lFilters,lWPFilters.Names[i],lWPFilters.strings[lWPFilters.Names[i]]);


    fWPClient := TSQLWPClient(fWP.getWAPIClient('users', lFilters.asJSON));
    // lFilters.asJSON = '{"search":"*eva*","orderby":"username}'
    fWPUser := TSQLRESTAPIUser.CreateAndFillPrepare(fWPClient,'',[]);
    if assigned(fWPUser) and assigned(fWPUser.FillContext) then
      fillGrid(fWPUser.FillContext.Table);
  finally
  end;

end;


end.
