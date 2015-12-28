// *****************************************************************************
//
// chimera.json;
//
// JSON Chimera project for Delphi
//
// Copyright (c) 2012 by Sivv LLC, All Rights Reserved
//
// Information about this product can be found at
// http://arcana.sivv.com/chimera
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//
// *****************************************************************************

unit chimera.json;

interface

uses System.SysUtils, System.Classes;

type
{$SCOPEDENUMS ON}

  TJSONValueType = (&string, number, &array, &object, boolean, null, code);

  IJSONObject = interface;
  IJSONArray = interface;

  PMultiValue = ^TMultiValue;
  TMultiValue = record
    ValueType : TJSONValueType;
    StringValue : string;
    NumberValue : Double;
    IntegerValue : Int64;
    ObjectValue : IJSONObject;
    ArrayValue : IJSONArray;
    constructor Initialize(const Value : String); overload;
    constructor Initialize(const Value : Double); overload;
    constructor Initialize(const Value : Int64); overload;
    constructor Initialize(const Value : Boolean); overload;
    constructor Initialize(const Value : IJSONObject); overload;
    constructor Initialize(const Value : IJSONArray); overload;
    constructor Initialize(const Value : Variant); overload;
    constructor Initialize(const Value : PMultiValue); overload;
    function InitializeNull : TMultiValue;
    constructor InitializeCode(const Value : String);
    function AsJSON : string; overload;
    procedure AsJSON(var Result : string); overload;
    function ToVariant : Variant;
  end;

  IJSONArray = interface(IInterface)
    ['{2D496737-5D01-4332-B2C2-7328772E3587}']
    function GetRaw(const idx: integer): PMultiValue;
    function GetBoolean(const idx: integer): Boolean;
    function GetCount: integer;
    function GetNumber(const idx: integer): Double;
    function GetInteger(const idx: integer): Int64;
    function GetItem(const idx: integer): Variant;
    function GetString(const idx: integer): string;
    function GetObject(const idx: integer): IJSONObject;
    function GetArray(const idx: integer): IJSONArray;
    function GetType(const idx: integer): TJSONValueType;
    procedure SetRaw(const idx: integer; const Value: PMultiValue);
    procedure SetBoolean(const idx: integer; const Value: Boolean);
    procedure SetCount(const Value: integer);
    procedure SetNumber(const idx: integer; const Value: Double);
    procedure SetInteger(const idx: integer; const Value: Int64);
    procedure SetItem(const idx: integer; const Value: Variant);
    procedure SetString(const idx: integer; const Value: string);
    procedure SetArray(const idx: integer; const Value: IJSONArray);
    procedure SetObject(const idx: integer; const Value: IJSONObject);
    procedure SetType(const idx: integer; const Value: TJSONValueType);

    procedure Add(const value : string); overload;
    procedure Add(const value : double); overload;
    procedure Add(const value : int64); overload;
    procedure Add(const value : boolean); overload;
    procedure Add(const value : IJSONArray); overload;
    procedure Add(const value : IJSONObject); overload;
    procedure Add(const value : Variant); overload;
    procedure Add(const value : PMultiValue); overload;
    procedure AddNull;
    procedure AddCode(const value : string);

    function AsJSON : string; overload;
    procedure AsJSON(var Result : string); overload;

    procedure Each(proc : TProc<string>); overload;
    procedure Each(proc : TProc<double>); overload;
    procedure Each(proc : TProc<int64>); overload;
    procedure Each(proc : TProc<boolean>); overload;
    procedure Each(proc : TProc<IJSONObject>); overload;
    procedure Each(proc : TProc<IJSONArray>); overload;
    procedure Each(proc : TProc<Variant>); overload;

    property Raw[const idx : integer] : PMultiValue read GetRaw write SetRaw;
    property Strings[const idx : integer] : string read GetString write SetString;
    property Numbers[const idx : integer] : Double read GetNumber write SetNumber;
    property Integers[const idx : integer] : Int64 read GetInteger write SetInteger;
    property Booleans[const idx : integer] : Boolean read GetBoolean write SetBoolean;
    property Objects[const idx : integer] : IJSONObject read GetObject write SetObject;
    property Arrays[const idx : integer] : IJSONArray read GetArray write SetArray;
    property Items[const idx : integer] : Variant read GetItem write SetItem; default;
    property Types[const idx : integer] : TJSONValueType read GetType write SetType;
    property Count : integer read GetCount write SetCount;
  end;

  IJSONObject = interface(IInterface)
    ['{D99D532B-A21C-4135-9DF5-0FFC8538CED4}']
    function GetRaw(const name: string): PMultiValue;
    function GetHas(const name : string): Boolean;
    function GetBoolean(const name : string): Boolean;
    function GetCount: integer;
    function GetNumber(const name : string): Double;
    function GetInteger(const name : string): Int64;
    function GetItem(const name : string): Variant;
    function GetString(const name : string): string;
    function GetObject(const name : string): IJSONObject;
    function GetArray(const name : string): IJSONArray;
    function GetType(const name : string): TJSONValueType;
    function GetName(const idx : integer): string;
    procedure SetRaw(const name: string; const Value: PMultiValue);
    procedure SetBoolean(const name : string; const Value: Boolean);
    procedure SetNumber(const name : string; const Value: Double);
    procedure SetInteger(const name : string; const Value: Int64);
    procedure SetItem(const name : string; const Value: Variant);
    procedure SetString(const name : string; const Value: string);
    procedure SetArray(const name : string; const Value: IJSONArray);
    procedure SetObject(const name : string; const Value: IJSONObject);
    procedure SetType(const name : string; const Value: TJSONValueType);

    procedure Each(proc : TProc<string, string>); overload;
    procedure Each(proc : TProc<string, double>); overload;
    procedure Each(proc : TProc<string, int64>); overload;
    procedure Each(proc : TProc<string, boolean>); overload;
    procedure Each(proc : TProc<string, IJSONObject>); overload;
    procedure Each(proc : TProc<string, IJSONArray>); overload;
    procedure Each(proc : TProc<string, Variant>); overload;
    procedure Each(proc : TProc<string, PMultiValue>); overload;

    procedure Add(const name : string; const value : string); overload;
    procedure Add(const name : string; const value : double); overload;
    procedure Add(const name : string; const value : Int64); overload;
    procedure Add(const name : string; const value : boolean); overload;
    procedure Add(const name : string; const value : IJSONArray); overload;
    procedure Add(const name : string; const value : IJSONObject); overload;
    procedure Add(const name : string; const value : Variant); overload;
    procedure Add(const name : string; const value : PMultiValue); overload;
    procedure AddNull(const name : string);
    procedure DeleteItem(const name : string);
    procedure AddCode(const name : string; const value : string);
    function AsJSON : string; overload;
    procedure AsJSON(var Result : string); overload;

    property Raw[const name : string] : PMultiValue read GetRaw write SetRaw;
    property Strings[const name : string] : string read GetString write SetString;
    property Numbers[const name : string] : Double read GetNumber write SetNumber;
    property Integers[const name : string] : Int64 read GetInteger write SetInteger;
    property Booleans[const name : string] : Boolean read GetBoolean write SetBoolean;
    property Objects[const name : string] : IJSONObject read GetObject write SetObject;
    property Arrays[const name : string] : IJSONArray read GetArray write SetArray;
    property Items[const name : string] : Variant read GetItem write SetItem; default;
    property Types[const name : string] : TJSONValueType read GetType write SetType;
    property Count : integer read GetCount;
    property Names[const idx : integer] : string read GetName;
    property Has[const name : string] : boolean read GetHas;
  end;

function JSON(const src : string = '') : IJSONObject;
function JSONArray : IJSONArray;
function FormatJSON(const src : string; Indent : byte = 3) : string;
function JSONEncode(const str : string) : string;
function JSONDecode(const str : string) : string;
function StringIsJSON(const str : string) : boolean;

implementation

uses System.Variants, System.Generics.Collections, chimera.json.parser,
  System.StrUtils;

type
  TJSONArray = class(TInterfacedObject, IJSONArray)
  private // IJSONArray
    function GetBoolean(const idx: integer): Boolean;
    function GetCount: integer;
    function GetNumber(const idx: integer): Double;
    function GetInteger(const idx: integer): Int64;
    function GetItem(const idx: integer): Variant;
    function GetString(const idx: integer): string;
    function GetObject(const idx: integer): IJSONObject;
    function GetArray(const idx: integer): IJSONArray;
    function GetType(const idx: integer): TJSONValueType;
    function GetRaw(const idx: integer): PMultiValue;
    procedure SetBoolean(const idx: integer; const Value: Boolean);
    procedure SetCount(const Value: integer);
    procedure SetNumber(const idx: integer; const Value: Double);
    procedure SetInteger(const idx: integer; const Value: Int64);
    procedure SetItem(const idx: integer; const Value: Variant);
    procedure SetString(const idx: integer; const Value: string);
    procedure SetArray(const idx: integer; const Value: IJSONArray);
    procedure SetObject(const idx: integer; const Value: IJSONObject);
    procedure SetType(const idx: integer; const Value: TJSONValueType);
    procedure SetRaw(const idx: integer; const Value: PMultiValue);
  private
    FValues : TList<PMultiValue>;
    procedure EnsureSize(const idx : integer);
  public // IJSONArray
    procedure Each(proc : TProc<string>); overload;
    procedure Each(proc : TProc<double>); overload;
    procedure Each(proc : TProc<int64>); overload;
    procedure Each(proc : TProc<boolean>); overload;
    procedure Each(proc : TProc<IJSONObject>); overload;
    procedure Each(proc : TProc<IJSONArray>); overload;
    procedure Each(proc : TProc<Variant>); overload;

    procedure Add(const value : string); overload;
    procedure Add(const value : double); overload;
    procedure Add(const value : boolean); overload;
    procedure Add(const value : Int64); overload;
    procedure Add(const value : IJSONArray); overload;
    procedure Add(const value : IJSONObject); overload;
    procedure Add(const value : Variant); overload;
    procedure Add(const value : PMultiValue); overload;
    procedure AddNull;
    procedure AddCode(const value : string);
    function AsJSON : string; overload;
    procedure AsJSON(var Result : string); overload;

    property Strings[const idx : integer] : string read GetString write SetString;
    property Numbers[const idx : integer] : Double read GetNumber write SetNumber;
    property Integers[const idx : integer] : Int64 read GetInteger write SetInteger;
    property Booleans[const idx : integer] : Boolean read GetBoolean write SetBoolean;
    property Objects[const idx : integer] : IJSONObject read GetObject write SetObject;
    property Arrays[const idx : integer] : IJSONArray read GetArray write SetArray;
    property Items[const idx : integer] : Variant read GetItem write SetItem; default;
    property Types[const idx : integer] : TJSONValueType read GetType write SetType;
    property Count : integer read GetCount write SetCount;
    property Raw[const idx: integer] : PMultiValue read GetRaw write SetRaw;
  public
    constructor Create; virtual;
    destructor Destroy; override;
  end;

  TJSONObject = class(TInterfacedObject, IJSONObject)
  private // IJSONObject
    function GetBoolean(const name : string): Boolean;
    function GetCount: integer;
    function GetNumber(const name : string): Double;
    function GetInteger(const name : string): Int64;
    function GetItem(const name : string): Variant;
    function GetString(const name : string): string;
    function GetObject(const name : string): IJSONObject;
    function GetArray(const name : string): IJSONArray;
    function GetType(const name : string): TJSONValueType;
    function GetName(const idx : integer): string;
    procedure SetBoolean(const name : string; const Value: Boolean);
    procedure SetNumber(const name : string; const Value: Double);
    procedure SetInteger(const name : string; const Value: Int64);
    procedure SetItem(const name : string; const Value: Variant);
    procedure SetString(const name : string; const Value: string);
    procedure SetArray(const name : string; const Value: IJSONArray);
    procedure SetObject(const name : string; const Value: IJSONObject);
    procedure SetType(const name : string; const Value: TJSONValueType);
    function GetHas(const name: string): boolean;
    function GetRaw(const name: string): PMultiValue;
    procedure SetRaw(const name: string; const Value: PMultiValue);
  private
    FValues : TDictionary<string, PMultiValue>;
    procedure DisposeOfValue(Sender: TObject; const Item: PMultiValue; Action: TCollectionNotification);
  public  // IJSONObject
    procedure Each(proc : TProc<string, string>); overload;
    procedure Each(proc : TProc<string, double>); overload;
    procedure Each(proc : TProc<string, int64>); overload;
    procedure Each(proc : TProc<string, boolean>); overload;
    procedure Each(proc : TProc<string, IJSONObject>); overload;
    procedure Each(proc : TProc<string, IJSONArray>); overload;
    procedure Each(proc : TProc<string, Variant>); overload;
    procedure Each(proc : TProc<string, PMultiValue>); overload;

    procedure Add(const name : string; const value : string); overload;
    procedure Add(const name : string; const value : double); overload;
    procedure Add(const name : string; const value : Int64); overload;
    procedure Add(const name : string; const value : boolean); overload;
    procedure Add(const name : string; const value : IJSONArray); overload;
    procedure Add(const name : string; const value : IJSONObject); overload;
    procedure Add(const name : string; const value : Variant); overload;
    procedure Add(const name : string; const value : PMultiValue); overload;
    procedure AddNull(const name : string);
    procedure DeleteItem(const name : string);
    procedure AddCode(const name : string; const value : string);
    function AsJSON : string; overload;
    procedure AsJSON(var Result : string); overload;

    property Strings[const name : string] : string read GetString write SetString;
    property Numbers[const name : string] : Double read GetNumber write SetNumber;
    property Integers[const name : string] : Int64 read GetInteger write SetInteger;
    property Booleans[const name : string] : Boolean read GetBoolean write SetBoolean;
    property Objects[const name : string] : IJSONObject read GetObject write SetObject;
    property Arrays[const name : string] : IJSONArray read GetArray write SetArray;
    property Items[const name : string] : Variant read GetItem write SetItem; default;
    property Types[const name : string] : TJSONValueType read GetType write SetType;
    property Count : integer read GetCount;
    property Names[const idx : integer] : string read GetName;
    property Has[const name : string] : boolean read GetHas;
    property Raw[const name : string] : PMultiValue read GetRaw write SetRaw;
  public
    constructor Create; virtual;
    destructor Destroy; override;
  end;

function StringIsJSON(const str : string) : boolean;
begin
  result := (str <> '') and (str[1] = '{') and (str[length(str)] = '}')
end;

function FormatJSON(const src : string; Indent : Byte = 3) : string;
  function Spaces(var Size : integer; iLevel : integer; indent : byte) : string;
  var
    i: Integer;
  begin
    Size := (iLevel*Indent);
    setlength(result,Size);
    for i := 1 to Size do
      Result[i] := ' ';
  end;
var
  i, iSize,  iLevel : integer;
  sb : TStringBuilder;
  bInString : boolean;
begin
  iLevel := 0;
  sb := TStringBuilder.Create(src);
  try
    i := 0;
    bInString := False;
    while i < sb.length do
    begin
      case sb.Chars[i] of
        '{', '[':
        begin
          if not bInString then
          begin
            inc(iLevel);
            while (i < sb.Length - 1) and (sb.Chars[i+1] = ' ') do
              sb.Remove(i+1,1);
            if not CharInSet(sb.Chars[i],['}',']'])  then
            begin
              sb.Insert(i+1,#13#10+Spaces(iSize, iLevel,Indent));
              inc(i,iSize+2);
            end;
          end;
        end;
        ',':
        begin
          if not bInString then
          begin
            while (i < sb.Length - 1) and (sb.Chars[i+1] = ' ') do
              sb.Remove(i+1,1);
            sb.Insert(i+1,#13#10+Spaces(iSize, iLevel,Indent));
            inc(i,iSize+2);
          end;
        end;
        '"':
        begin
          if (sb.Chars[i-1] <> '/') then
            bInString := not bInString;
        end;
        '}',']':
        begin
          if not bInString then
          begin
            while (i < sb.Length - 1) and (sb.Chars[i+1] = ' ') do
              sb.Remove(i+1,1);
            if not CharInSet(sb.Chars[i-1],['{','['])  then
            begin
              dec(iLevel);
              sb.Insert(i,#13#10+Spaces(iSize, iLevel,Indent));
              inc(i,iSize+2);
            end;
          end;
        end;
      end;
      inc(i);
    end;
    Result := sb.ToString;
  finally
    sb.Free;
  end;
end;

function JSONEncode(const str : string) : string;
var
  i : integer;
begin
  result := str;
  for i := Length(result) downto 1 do
  begin
    case result[i] of
      '"',
      '\',
      '/':
      insert('\',result,i);
      #8: begin
        result[i] := 'b';
        insert('\',result,i);
      end;
      #9: begin
        result[i] := 't';
        insert('\',result,i);
      end;
      #10: begin
        result[i] := 'n';
        insert('\',result,i);
      end;
      #12: begin
        result[i] := 'f';
        insert('\',result,i);
      end;
      #13: begin
        result[i] := 'r';
        insert('\',result,i);
      end;
      else if Ord(Result[i]) > 255 then
      begin
        insert('\u'+IntToHex(Ord(result[i]),4),result,i+1);
        Delete(Result,i,1);
      end;
    end;
  end;
end;

function JSONDecode(const str : string) : string;
var
  i : integer;
  ichar : integer;
begin
  result := str;
  for i := Length(result) downto 2 do
  begin
    if result[i-1] = '\' then
    begin
      case result[i] of
        '"',
        '\',
        '/':
          delete(result,i-1,1);
        'b': begin
          result[i] := #8;
          delete(result,i-1,1);
        end;
        't': begin
          result[i] := #9;
          delete(result,i-1,1);
        end;

        'n': begin
          result[i] := #10;
          delete(result,i-1,1);
        end;
        'f': begin
          result[i] := #12;
          delete(result,i-1,1);
        end;
        'r': begin
          result[i] := #13;
          delete(result,i-1,1);
        end;
        'u': begin
          if TryStrToInt('$'+Copy(result,i+1,4),iChar) then
          begin
            Delete(Result,i-1,6);
            insert(Char(iChar),result, i-1);
          end;
        end;
      end;
    end;
  end;
end;

procedure VerifyType(t1, t2 : TJSONValueType);
begin
  if t1 <> t2 then
    raise Exception.Create('Value is not of required type');
end;

function JSON(const src : string) : IJSONObject;
begin
  if src <> '' then
    Result := TParser.Parse(src)
  else
    Result := TJSONObject.Create;
end;

function JSONArray : IJSONArray;
begin
  Result := TJSONArray.Create;
end;

{ TJSONArray }

procedure TJSONArray.Add(const value: double);
var
  pmv : PMultiValue;
begin
  New(pmv);
  pmv.Initialize(value);
  FValues.Add(pmv);
end;

procedure TJSONArray.Add(const value: string);
var
  pmv : PMultiValue;
begin
  New(pmv);
  pmv.Initialize(value);
  FValues.Add(pmv);
end;

procedure TJSONArray.Add(const value: Variant);
var
  pmv : PMultiValue;
begin
  New(pmv);
  pmv.Initialize(value);
  FValues.Add(pmv);
end;

procedure TJSONArray.Add(const value: boolean);
var
  pmv : PMultiValue;
begin
  New(pmv);
  pmv.Initialize(value);
  FValues.Add(pmv);
end;

procedure TJSONArray.Add(const value: IJSONObject);
var
  pmv : PMultiValue;
begin
  New(pmv);
  pmv.Initialize(value);
  FValues.Add(pmv);
end;

procedure TJSONArray.Add(const value: Int64);
var
  pmv : PMultiValue;
begin
  New(pmv);
  pmv.Initialize(value);
  FValues.Add(pmv);
end;

procedure TJSONArray.Add(const value: IJSONArray);
var
  pmv : PMultiValue;
begin
  New(pmv);
  pmv.Initialize(value);
  FValues.Add(pmv);
end;

procedure TJSONArray.AddNull;
var
  pmv : PMultiValue;
begin
  New(pmv);
  pmv.InitializeNull;
  FValues.Add(pmv);
end;

procedure TJSONArray.AddCode(const value: string);
var
  pmv : PMultiValue;
begin
  New(pmv);
  pmv.InitializeCode(value);
  FValues.Add(pmv);
end;

function TJSONArray.AsJSON: string;
begin
  Result := '';
  AsJSON(Result);
end;

procedure TJSONArray.AsJSON(var Result : string);
var
  i: Integer;
begin
  Result := Result+'[';
  for i := 0 to FValues.Count-1 do
  begin
    if i > 0 then
      Result := Result+',';
    FValues[i].AsJSON(Result);
  end;
  Result := Result+']';
end;

constructor TJSONArray.Create;
begin
  inherited Create;
  FValues := TList<PMultiValue>.Create;
end;

destructor TJSONArray.Destroy;
var
  i: Integer;
begin
  for i := 0 to FValues.Count-1 do
    Dispose(FValues[i]);
  FValues.Free;
  inherited;
end;

procedure TJSONArray.Each(proc: TProc<int64>);
var
  i: Integer;
begin
  for i := 0 to FValues.Count-1 do
    proc(FValues[i].IntegerValue);
end;

procedure TJSONArray.Each(proc: TProc<double>);
var
  i: Integer;
begin
  for i := 0 to FValues.Count-1 do
    proc(FValues[i].NumberValue);
end;

procedure TJSONArray.Each(proc: TProc<string>);
var
  i: Integer;
begin
  for i := 0 to FValues.Count-1 do
    proc(strings[i]);
end;

procedure TJSONArray.Each(proc: TProc<boolean>);
var
  i: Integer;
begin
  for i := 0 to FValues.Count-1 do
    proc(FValues[i].IntegerValue <> 0);
end;

procedure TJSONArray.Each(proc: TProc<Variant>);
var
  i: Integer;
begin
  for i := 0 to FValues.Count-1 do
    proc(FValues[i].ToVariant);
end;

procedure TJSONArray.Each(proc: TProc<IJSONArray>);
var
  i: Integer;
begin
  for i := 0 to FValues.Count-1 do
    proc(FValues[i].ArrayValue);
end;

procedure TJSONArray.Each(proc: TProc<IJSONObject>);
var
  i: Integer;
begin
  for i := 0 to FValues.Count-1 do
    proc(FValues[i].ObjectValue);
end;

procedure TJSONArray.EnsureSize(const idx: integer);
var
  pmv : PMultiValue;
begin
  while FValues.Count <= idx do
  begin
    New(pmv);
    pmv.InitializeNull;
    FValues.Add(pmv);
  end;
end;

function TJSONArray.GetArray(const idx: integer): IJSONArray;
begin
  VerifyType(FValues.Items[idx].ValueType, TJSONValueType.&array);
  Result := FValues.Items[idx].ArrayValue;
end;

function TJSONArray.GetBoolean(const idx: integer): Boolean;
begin
  VerifyType(FValues.Items[idx].ValueType, TJSONValueType.boolean);
  Result := FValues.Items[idx].IntegerValue <> 0;
end;

function TJSONArray.GetCount: integer;
begin
  Result := FValues.Count;
end;

function TJSONArray.GetNumber(const idx: integer): Double;
begin
  VerifyType(FValues.Items[idx].ValueType, TJSONValueType.number);
  Result := FValues.Items[idx].NumberValue;
end;

function TJSONArray.GetInteger(const idx: integer): Int64;
begin
  VerifyType(FValues.Items[idx].ValueType, TJSONValueType.number);
  Result := FValues.Items[idx].IntegerValue;
end;

function TJSONArray.GetItem(const idx: integer): Variant;
begin
  EnsureSize(idx);
  Result := FValues.Items[idx].ToVariant;
end;

function TJSONArray.GetObject(const idx: integer): IJSONObject;
begin
  VerifyType(FValues.Items[idx].ValueType, TJSONValueType.&object);
  Result := FValues.Items[idx].ObjectValue;
end;

function TJSONArray.GetRaw(const idx: integer): PMultiValue;
begin
  Result := FValues.Items[idx];
end;

function TJSONArray.GetString(const idx: integer): string;
begin
  VerifyType(FValues.Items[idx].ValueType, TJSONValueType.string);
  Result := JSONDecode(FValues.Items[idx].StringValue);
end;

function TJSONArray.GetType(const idx: integer): TJSONValueType;
begin
  Result := FValues.Items[idx].ValueType;
end;

procedure TJSONArray.SetArray(const idx: integer; const Value: IJSONArray);
var
  pmv : PMultiValue;
begin
  EnsureSize(idx);
  New(pmv);
  pmv.Initialize(value);
  FValues.Add(pmv);
end;

procedure TJSONArray.SetBoolean(const idx: integer; const Value: Boolean);
var
  pmv : PMultiValue;
begin
  EnsureSize(idx);
  New(pmv);
  pmv.Initialize(value);
  FValues.Add(pmv);
end;

procedure TJSONArray.SetCount(const Value: integer);
begin
  EnsureSize(Value);
  while FValues.Count > Value do
    FValues.Delete(FValues.Count-1);
end;

procedure TJSONArray.SetNumber(const idx: integer; const Value: Double);
var
  pmv : PMultiValue;
begin
  EnsureSize(idx);
  New(pmv);
  pmv.Initialize(value);
  FValues.Add(pmv);
end;

procedure TJSONArray.SetInteger(const idx: integer; const Value: Int64);
var
  pmv : PMultiValue;
begin
  EnsureSize(idx);
  New(pmv);
  pmv.Initialize(value);
  FValues.Add(pmv);
end;

procedure TJSONArray.SetItem(const idx: integer; const Value: Variant);
begin
  EnsureSize(idx);
  FValues.Items[idx].Initialize(Value);
end;

procedure TJSONArray.SetObject(const idx: integer; const Value: IJSONObject);
var
  pmv : PMultiValue;
begin
  EnsureSize(idx);
  New(pmv);
  pmv.Initialize(value);
  FValues.Add(pmv);
end;

procedure TJSONArray.SetRaw(const idx: integer; const Value: PMultiValue);
var
  pmv : PMultiValue;
begin
  EnsureSize(idx);
  New(pmv);
  pmv.Initialize(value);
  FValues.Add(pmv);
end;

procedure TJSONArray.SetString(const idx: integer; const Value: string);
var
  pmv : PMultiValue;
begin
  EnsureSize(idx);
  New(pmv);
  pmv.Initialize(JSONEncode(value));
  FValues.Add(pmv);
end;

procedure TJSONArray.SetType(const idx: integer; const Value: TJSONValueType);
begin
  EnsureSize(idx);
  if Value <> FValues.Items[idx].ValueType then
    case Value of
      TJSONValueType.string:
        FValues.Items[idx].Initialize('');
      TJSONValueType.number:
        FValues.Items[idx].Initialize(0);
      TJSONValueType.array:
        FValues.Items[idx].Initialize(TJSONArray.Create);
      TJSONValueType.object:
        FValues.Items[idx].Initialize(TJSONObject.Create);
      TJSONValueType.boolean:
        FValues.Items[idx].Initialize(False);
      TJSONValueType.null:
        FValues.Items[idx].InitializeNull;
    end;
end;

procedure TJSONArray.Add(const value: PMultiValue);
var
  pmv : PMultiValue;
begin
  New(pmv);
  pmv.Initialize(value);
  FValues.Add(pmv);
end;

{ TJSONObject }

procedure TJSONObject.Add(const name: string; const value: double);
begin
  Numbers[name] := value;
end;

procedure TJSONObject.Add(const name, value: string);
begin
  Strings[name] := value;
end;

procedure TJSONObject.Add(const name: string; const value: boolean);
begin
  Booleans[name] := value;
end;

procedure TJSONObject.Add(const name: string; const value: IJSONObject);
begin
  Objects[name] := value;
end;

procedure TJSONObject.Add(const name: string; const value: Int64);
begin
  Integers[name] := value;
end;

procedure TJSONObject.Add(const name: string; const value: IJSONArray);
begin
  Arrays[name] := value;
end;

procedure TJSONObject.AddNull(const name: string);
var
  pmv : PMultiValue;
begin
  New(pmv);
  pmv.InitializeNull;
  FValues.AddOrSetValue(Name, pmv);
end;

procedure TJSONObject.DeleteItem(const name: string);
begin
  FValues.Remove(Name);
end;

procedure TJSONObject.AddCode(const name, value: string);
var
  pmv : PMultiValue;
begin
  New(pmv);
  pmv.InitializeCode(Value);
  FValues.AddOrSetValue(Name, pmv);
end;

function TJSONObject.AsJSON: string;
begin
  Result := '';
  AsJSON(Result);
end;

procedure TJSONObject.AsJSON(var Result : string);
var
  item : TPair<string, PMultiValue>;
  bFirst : boolean;
begin
  Result := Result+'{';
  bFirst := True;
  for item in FValues do
  begin
    if not bFirst then
      Result := Result +', "'+item.Key+'" : '
    else
      Result := Result+'"'+item.Key+'" : ';
    item.Value.AsJSON(Result);
    bFirst := False;
  end;
  Result := Result+'}';
end;

constructor TJSONObject.Create;
begin
  inherited Create;
  FValues := TDictionary<string, PMultiValue>.Create;
  FValues.OnValueNotify := DisposeOfValue;
end;

destructor TJSONObject.Destroy;
var
  item : TPair<string,PMultiValue>;
begin
  {for item in FValues do
  begin
    Dispose(item.value);
  end;}

  FValues.Free;
  inherited;
end;
procedure TJSONObject.DisposeOfValue(Sender: TObject; const Item: PMultiValue;
  Action: TCollectionNotification);
begin
  if Action = TCollectionNotification.cnRemoved then
    Dispose(Item);
end;

procedure TJSONObject.Each(proc: TProc<string, int64>);
var
  item : TPair<string, PMultiValue>;
begin
  for item in FValues do
    proc(item.Key, item.Value.IntegerValue);
end;

procedure TJSONObject.Each(proc: TProc<string, boolean>);
var
  item : TPair<string, PMultiValue>;
begin
  for item in FValues do
    proc(item.Key, item.Value.IntegerValue <> 0);
end;

procedure TJSONObject.Each(proc: TProc<string, string>);
var
  item : TPair<string, PMultiValue>;
begin
  for item in FValues do
    proc(item.Key, JSONDecode(item.Value.StringValue));
end;

procedure TJSONObject.Each(proc: TProc<string, double>);
var
  item : TPair<string, PMultiValue>;
begin
  for item in FValues do
    proc(item.Key, item.Value.NumberValue);
end;

procedure TJSONObject.Each(proc: TProc<string, Variant>);
var
  item : TPair<string, PMultiValue>;
begin
  for item in FValues do
    proc(item.Key, item.Value.ToVariant);
end;

procedure TJSONObject.Each(proc: TProc<string, PMultiValue>);
var
  item : TPair<string, PMultiValue>;
begin
  for item in FValues do
    proc(item.Key, item.Value);
end;

procedure TJSONObject.Each(proc: TProc<string, IJSONObject>);
var
  item : TPair<string, PMultiValue>;
begin
  for item in FValues do
    proc(item.Key, item.Value.ObjectValue);
end;

procedure TJSONObject.Each(proc: TProc<string, IJSONArray>);
var
  item : TPair<string, PMultiValue>;
begin
  for item in FValues do
    proc(item.Key, item.Value.ArrayValue);
end;

function TJSONObject.GetArray(const name: string): IJSONArray;
begin
  try
    VerifyType(FValues[Name].ValueType, TJSONValueType.&array);
  except
    raise Exception.Create('item not found: "' + name+'"');
  end;
  Result := FValues[Name].ArrayValue;
end;

function TJSONObject.GetBoolean(const name: string): Boolean;
begin
  try
    VerifyType(FValues[Name].ValueType, TJSONValueType.boolean);
  except
    raise Exception.Create('item not found: "' + name+'"');
  end;
  Result := FValues[Name].IntegerValue <> 0;
end;

function TJSONObject.GetCount: integer;
begin
  Result := FValues.Count;
end;

function TJSONObject.GetHas(const name: string): boolean;
begin
  Result := FValues.ContainsKey(name);
end;

function TJSONObject.GetNumber(const name: string): Double;
begin
  try
    VerifyType(FValues[Name].ValueType, TJSONValueType.number);
  except
    raise Exception.Create('item not found: "' + name+'"');
  end;
  Result := FValues[Name].NumberValue;
end;

function TJSONObject.GetInteger(const name: string): Int64;
begin
  try
    VerifyType(FValues[Name].ValueType, TJSONValueType.number);
  except
    raise Exception.Create('item not found: "' + name+'"');
  end;
  Result := FValues[Name].IntegerValue;
end;

function TJSONObject.GetItem(const name: string): Variant;
begin
  Result := FValues[Name].ToVariant;
end;

function TJSONObject.GetName(const idx: integer): string;
begin
  Result := FValues.Keys.ToArray[idx];
end;

function TJSONObject.GetObject(const name: string): IJSONObject;
begin
  try
    VerifyType(FValues[Name].ValueType, TJSONValueType.&object);
  except
    raise Exception.Create('item not found: "' + name+'"');
  end;
  Result := FValues[Name].ObjectValue;
end;

function TJSONObject.GetRaw(const name: string): PMultiValue;
begin
  Result := FValues.Items[name];
end;

function TJSONObject.GetString(const name: string): string;
begin
  try
    VerifyType(FValues[Name].ValueType, TJSONValueType.string);
  except
    raise Exception.Create('item not found: "' + name+'"');
  end;
  Result := JSONDecode(FValues[Name].StringValue);
end;

function TJSONObject.GetType(const name: string): TJSONValueType;
begin
  Result := FValues[Name].ValueType;
end;

{class function TJSONObject.NewValue: PMultiValue;
begin
  //TMonitor.Enter(FCache);
  //try
    if FCache.Count = 0 then
    begin
      New(Result);
    end else
      Result := FCache.Pop;
  //finally
    //TMonitor.Exit(FCache);
  //end;
end;}

procedure TJSONObject.SetArray(const name: string; const Value: IJSONArray);
var
  pmv : PMultiValue;
begin
  New(pmv);
  pmv.Initialize(Value);
  FValues.AddOrSetValue(Name, pmv);
end;

procedure TJSONObject.SetBoolean(const name: string; const Value: Boolean);
var
  pmv : PMultiValue;
begin
  New(pmv);
  pmv.Initialize(Value);
  FValues.AddOrSetValue(Name, pmv);
end;

procedure TJSONObject.SetNumber(const name: string; const Value: Double);
var
  pmv : PMultiValue;
begin
  New(pmv);
  pmv.Initialize(Value);
  FValues.AddOrSetValue(Name, pmv);
end;

procedure TJSONObject.SetInteger(const name: string; const Value: Int64);
var
  pmv : PMultiValue;
begin
  New(pmv);
  pmv.Initialize(Value);
  FValues.AddOrSetValue(Name, pmv);
end;

procedure TJSONObject.SetItem(const name: string; const Value: Variant);
var
  pmv : PMultiValue;
begin
  if not FValues.ContainsKey(name) then
  begin
    New(pmv);
    pmv.Initialize(Value);
    FValues.AddOrSetValue(Name, pmv);
  end else
    FValues[Name].Initialize(Value);
end;

procedure TJSONObject.SetObject(const name: string; const Value: IJSONObject);
var
  pmv : PMultiValue;
begin
  New(pmv);
  pmv.Initialize(Value);
  FValues.AddOrSetValue(Name, pmv);
end;

procedure TJSONObject.SetRaw(const name: string; const Value: PMultiValue);
var
  pmv : PMultiValue;
begin
  New(pmv);
  pmv.Initialize(Value);
  FValues.AddOrSetValue(Name, pmv);
end;

procedure TJSONObject.SetString(const name, Value: string);
var
  pmv : PMultiValue;
begin
  New(pmv);
  pmv.Initialize(JSONEncode(Value));
  FValues.AddOrSetValue(Name, pmv);
end;

procedure TJSONObject.SetType(const name: string; const Value: TJSONValueType);
var
  mv : PMultiValue;
begin
  mv := FValues[name];

  if mv.ValueType <> Value then
  begin
    case Value of
      TJSONValueType.string:
        SetString(Name, '');
      TJSONValueType.number:
        SetNumber(Name, 0);
      TJSONValueType.array:
        SetArray(Name, TJSONArray.Create);
      TJSONValueType.object:
        SetObject(Name, TJSONObject.Create);
      TJSONValueType.boolean:
        SetBoolean(Name, False);
      TJSONValueType.null:
        AddNull(Name);
    end;
  end;
end;

procedure TJSONObject.Add(const name: string; const value: PMultiValue);
begin
  Raw[name] := value;
end;

procedure TJSONObject.Add(const name: string; const value: Variant);
var
  pmv : PMultiValue;
begin
  New(pmv);
  pmv.Initialize(Value);
  FValues.AddOrSetValue(Name, pmv);
end;

{ TMultiValue }

constructor TMultiValue.Initialize(const Value: Double);
begin
  Self.ValueType := TJSONValueType.number;
  Self.NumberValue := Value;
  Self.IntegerValue := Round(Value);
end;

constructor TMultiValue.Initialize(const Value: String);
begin
  Self.ValueType := TJSONValueType.string;
  Self.StringValue := Value;
end;

function TMultiValue.AsJSON: string;
begin
  Result := '';
  AsJSON(Result);
end;

procedure TMultiValue.AsJSON(var result : string);
var
  s : string;
  lDec : char;
begin
  case Self.ValueType of
    TJSONValueType.code:
      Result := Result+Self.StringValue;
    TJSONValueType.string:
    begin
      Result := Result+'"'+Self.StringValue+'"';
    end;
    TJSONValueType.number:
      if (Self.NumberValue = Round(Self.NumberValue)) and
         (Self.NumberValue <> Self.IntegerValue) then
        Result := Result+IntToStr(Self.IntegerValue)
      else begin
//        lDec := FormatSettings.DecimalSeparator;
//        FormatSettings.DecimalSeparator := '.';
        Result := Result+ StringReplace(FormatFloat('0.######################',Self.NumberValue),',','.',[]);
//        FormatSettings.DecimalSeparator := lDec;
      end;
    TJSONValueType.array:
    begin
      Self.ArrayValue.AsJSON(Result);
    end;
    TJSONValueType.object:
      Self.ObjectValue.AsJSON(Result);
    TJSONValueType.boolean:
      if Self.IntegerValue = 1 then
        Result := Result+'true'
      else
        Result := Result+'false';
    TJSONValueType.null:
      Result := Result+'null';
  end;
end;

constructor TMultiValue.Initialize(const Value: IJSONArray);
begin
  Self.ValueType := TJSONValueType.&array;
  Self.ArrayValue := Value;
end;

constructor TMultiValue.Initialize(const Value: Int64);
begin
  Self.ValueType := TJSONValueType.number;
  Self.NumberValue := Value;
  Self.IntegerValue := Value;
end;

constructor TMultiValue.Initialize(const Value: IJSONObject);
begin
  Self.ValueType := TJSONValueType.&object;
  Self.ObjectValue := Value;
end;

function TMultiValue.InitializeNull : TMultiValue;
begin
  Self.ValueType := TJSONValueType.&null;
  Self.ObjectValue := nil;
  Result := Self;
end;

constructor TMultiValue.InitializeCode(const Value: String);
begin
  Self.ValueType := TJSONValueType.code;
  Self.StringValue := Value;
end;

function TMultiValue.ToVariant: Variant;
var
  jsNull : IJSONObject;
begin
  case ValueType of
    TJSONValueType.string:
      result := JSONDecode(StringValue);
    TJSONValueType.number:
      result := NumberValue;
    TJSONValueType.&array:
      result := ArrayValue;
    TJSONValueType.&object:
      result := ObjectValue;
    TJSONValueType.boolean:
      result := IntegerValue <> 0;
    TJSONValueType.null:
    begin
      jsNull := nil;
      result := jsNull;
    end;
  end;
end;

constructor TMultiValue.Initialize(const Value: Boolean);
begin
  Self.ValueType := TJSONValueType.boolean;
  if Value then
    Self.IntegerValue := 1
  else
    Self.IntegerValue := 0;
end;

constructor TMultiValue.Initialize(const Value: Variant);
var
  jso : IJSONObject;
  jsa : IJSONArray;
  d : Double;
  s : string;
  b : Boolean;
  i : integer;
begin
  if VarIsType(Value,varUnknown) then
  begin
    if Supports(Value, IJSONObject, jso) then
    begin
      Initialize(jso)
    end else if Supports(Value, IJSONArray, jsa) then
    begin
      Initialize(jsa);
    end else
      raise Exception.Create('Unknown variant type.');
  end else
    case VarType(Value) of
      varSmallInt,
      varInteger,
      varSingle,
      varDouble,
      varCurrency,
      varShortInt,
      varByte,
      varWord,
      varLongWord,
      varInt64,
      varUInt64:
      begin
        d := VarAsType(Value,varDouble);
        Initialize(d);
      end;

      varDate:
      begin
        Initialize(DateToStr(Value,TFormatSettings.Create('en-us')));
      end;

      varBoolean:
      begin
        b := VarAsType(Value,varBoolean);
        Initialize(b);
      end;

      varOleStr,
      varString,
      varUString:
      begin
        s := VarAsType(Value,varString);
        Initialize(s);
      end;

      varArray:
      begin
        jsa := TJSONArray.Create;
        for i := VarArrayLowBound(Value,1) to VarArrayHighBound(Value,1) do
          jsa[i] := Value[i];

        Initialize(jsa);
      end;

      else
        raise Exception.Create('Unknown variant type.');
    end;
end;

constructor TMultiValue.Initialize(const Value: PMultiValue);
begin
  Self.ValueType := Value.ValueType;
  Self.StringValue := Value.StringValue;
  Self.NumberValue := Value.NumberValue;
  Self.IntegerValue := Value.IntegerValue;
  if Self.ValueTYpe = TJSONValueType.Object then
    Self.ObjectValue := Value.ObjectValue;
  if Self.ValueTYpe = TJSONValueType.Array then
    Self.ArrayValue := Value.ArrayValue;
end;

end.
