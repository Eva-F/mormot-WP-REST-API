unit WPRESTAPIModels;
Interface

uses
  Classes,SysUtils,
  SynCommons,
  mORMot

  ;

type
  TSQLWPConnection = class(TSQLRecord)
  protected
    fServer: RawUTF8;
    fPort: RawUTF8;
    fRestAPI : RawUTF8;
    fWPOauth: RawUTF8;
    fHTTPS: boolean;
    fConsumerKey: RawUTF8;
    fConsumerKeySecret: RawUTF8;
    fURL:RawUTF8;
    fAccessToken: RawUTF8;
    fAccessTokenSecret: RawUTF8;
    fWPUser:RawUTF8;
    fWPPassword:RawUTF8;
    fExpirated :tDateTime;
    fRESTAPIVersion :RawUTF8;
  published
    property Server: RawUTF8 read fServer write fServer;
    property Port: RawUTF8 read fPort write fPort;
    property RestAPI: RawUTF8 read fRestAPI write fRestAPI;
    property WPOauth: RawUTF8 read fWPOauth write fWPOauth;
    property HTTPS: boolean read fHTTPS write fHTTPS;
    property ConsumerKey: RawUTF8 read fConsumerKey write fConsumerKey;
    property ConsumerKeySecret: RawUTF8 read fConsumerKeySecret write fConsumerKeySecret;
    property URL: RawUTF8 read fURL write fURL;
    property AccessToken: RawUTF8 read fAccessToken write fAccessToken;
    property AccessTokenSecret: RawUTF8 read fAccessTokenSecret write fAccessTokenSecret;
    property WPUser: RawUTF8 read fWPUser write fWPUser;
    property WPPassword: RawUTF8 read fWPPassword write fWPPassword;
    property Expirated: tDateTime read fExpirated write fExpirated;
    property RESTAPIVersion: RawUTF8 read fRESTAPIVersion write fRESTAPIVersion;
  end;

  TSQLRESTAPIUser = class(TSQLRecord)
  protected
    fusername: RawUTF8;
    fname: RawUTF8;
    ffirst_name: RawUTF8;
    fnickname: RawUTF8;
    fslug: RawUTF8;
    fURL: RawUTF8;
    favatar: RawUTF8;
    fdescription: RawUTF8;
    fregistered: TModTime;
    femail: RawUTF8;
    fpassword: RawUTF8;

//  ...
  published
    property username: RawUTF8 read fusername write fusername;
    property name: RawUTF8 read fname write fname;
    property first_name: RawUTF8 read ffirst_name write ffirst_name;
    property nickname: RawUTF8 read fnickname write fnickname;
    property slug: RawUTF8 read fslug write fslug;
    property URL: RawUTF8 read fURL write fURL;
    property avatar: RawUTF8 read favatar write favatar;
    property description: RawUTF8 read fdescription write fdescription;
    property registered: TModTime read fregistered write fregistered;
    property email: RawUTF8 read femail write femail;
    property password: RawUTF8 read fpassword write fpassword;
  end;


TSQLWooCustomer = Class(TSQLRecord)
  protected
    fcreated_at: TDateTime;
    femail: RawUTF8;
    ffirst_name: RawUTF8;
    flast_name: RawUTF8;
    fusername: RawUTF8;
    fpassword: RawUTF8;
    flast_order_id: integer;
    flast_order_date: TDateTime;
    forders_count: integer;
    ftotal_spent: integer;
    favatar_url: RawUTF8;
//    ...
published
    property created_at: TDateTime read fcreated_at write fcreated_at;
    property email: RawUTF8 read femail write femail;
    property first_name: RawUTF8 read ffirst_name write ffirst_name;
    property last_name: RawUTF8 read flast_name write flast_name;
    property username: RawUTF8 read fusername write fusername;
    property password: RawUTF8 read fpassword write fpassword;
    property last_order_id: integer read flast_order_id write flast_order_id;
    property last_order_date: TDateTime read flast_order_date write flast_order_date;
    property orders_count: integer read forders_count write forders_count;
    property total_spent: integer read ftotal_spent write ftotal_spent;
    property avatar_url: RawUTF8 read favatar_url write favatar_url;
end;

implementation




end.
