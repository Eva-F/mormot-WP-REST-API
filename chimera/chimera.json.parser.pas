// *****************************************************************************
//
// chimera.json.parser;
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

unit chimera.json.parser;

interface

uses System.SysUtils, System.Classes, System.Generics.Collections,
  System.Types, System.Rtti, chimera.json;

type
{$SCOPEDENUMS ON}
{$OVERFLOWCHECKS OFF}
{$RANGECHECKS OFF}

  EParseException = class(Exception)

  end;

  TParser = class(TObject)
  const
    Operators : set of AnsiChar = [ '{', '}', '[', ']', ',', '"', ':'];
  type
    TParseToken = (&String, Colon, OpenObject, CloseObject, OpenArray, CloseArray, Comma, EOF, MaxOp, Value);
  private
    FFmt : TFormatSettings;
    FText : string;
    FTextLength : integer;
    FIndex : integer;
    FToken : TParseToken;
    FTokenValue : TMultiValue;
    FOperatorStack : TStack<TParseToken>;
    FValueStack : TStack<TMultiValue>;
    function GetToken : boolean;
    function ParseArray: IJSONArray;
    function ParseObject: IJSONObject;
  protected
    function OperatorToStr(Token : TParseToken) : string;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function Execute(const AText : string) : IJSONObject;
    class function Parse(const AText : string) : IJSONObject;
  end;

implementation

uses System.Character, System.Variants;

{ TParser }

constructor TParser.Create;
begin
  inherited Create;
  FOperatorStack := TStack<TParseToken>.Create;
  FValueStack := TStack<TMultiValue>.Create;
  FFmt := TFormatSettings.Create('en-us');
end;

destructor TParser.Destroy;
begin
  FOperatorStack.Free;
  FValueStack.Free;
  inherited;
end;

function TParser.OperatorToStr(Token : TParseToken) : string;
begin
  case Token of
    TParser.TParseToken.String:
      Result := 'String';
    TParser.TParseToken.Colon:
      Result := 'Colon';
    TParser.TParseToken.OpenObject:
      Result := 'OpenObject';
    TParser.TParseToken.CloseObject:
      Result := 'CloseObject';
    TParser.TParseToken.OpenArray:
      Result := 'OpenArray';
    TParser.TParseToken.CloseArray:
      Result := 'CloseArray';
    TParser.TParseToken.Comma:
      Result := 'Comma';
    TParser.TParseToken.EOF:
      Result := 'EOF';
    TParser.TParseToken.MaxOp:
      Result := 'MaxOp';
    TParser.TParseToken.Value:
      Result := 'Value';
  end;
end;

function TParser.GetToken: boolean;
var
  s, str : String;
  d : Double;
  b : boolean;
  i, idx : integer;
  iStart, iLen : integer;
  lDec : char;
begin
  s := #0;
  while FIndex <= FTextLength do
  begin
    inc(FIndex);
    if CharInSet(FText[FIndex], Operators) then
    begin
      // Is an Operator
      s := FText[FIndex];
      break;
    end else if (FText[FIndex] <= Char($20)) then
      continue
    else if (TCharacter.IsLetterOrDigit(FText[FIndex])) then
    begin
      // Is an identifier or value
      iStart := FIndex;
      iLen := 0;
      SetLength(s,100);
      while (FIndex <= FTextLength) do
      begin
        if ( not CharInSet(FText[FIndex], ['0'..'9', 'A'..'Z','a'..'z','.'])) then //.isLetterOrDigit(FText[FIndex])) and (FText[FIndex] <> FFmt.DecimalSeparator)) then
          break;
        if (FIndex > iStart) then
        begin
          if ( not CharInSet(FText[FIndex-1], ['0'..'9', 'A'..'Z','a'..'z','.'])) then //.isLetterOrDigit(FText[FIndex])) and (FText[FIndex] <> FFmt.DecimalSeparator)) then
        //if (FIndex > iStart) and (( not TCharacter.isLetterOrDigit(FText[FIndex-1])) and (FText[FIndex-1] <> FFmt.DecimalSeparator)) then
            break;
          inc(iLen,2);
          s[ilen-1] := FText[FIndex-1];
          s[ilen] := FText[FIndex];
        end else
        begin
          if (FIndex > 0 ) and CharInSet(FText[FIndex-1], ['-']) then
          begin
            inc(iLen,1);
            s[ilen] := FText[FIndex-1];
            dec(iStart);
          end;
          inc(iLen);
          s[ilen] := FText[FIndex];
        end;
        if iLen >= Length(s)-2 then
          SetLength(s,Length(s)+100);
        inc(FIndex,2); // marginally faster to skip by twos, moreso on big tokens
      end;
      if (FIndex > iStart) and ( not CharInSet(FText[FIndex-1], ['0'..'9', 'A'..'Z','a'..'z','.'])) then //.isLetterOrDigit(FText[FIndex])) and (FText[FIndex] <> FFmt.DecimalSeparator)) then
      //if (FIndex > iStart) and ( not TCharacter.isLetterOrDigit(FText[FIndex-1])) and (FText[FIndex-1] <> FFmt.DecimalSeparator) then
        dec(FIndex)
      else
      begin
        inc(iLen);
        s[iLen] := FText[FIndex-1];
      end;
      Delete(s,iLen+1,High(Integer));
      //s := Copy(FText,iStart,FIndex-iStart);

      dec(FIndex);
      break;
    end;
    // Ignore Everything Else
  end;

  if (s <> #0) and (s <> '') then
  begin
    case s[1] of
      '{': FToken := TParseToken.OpenObject;
      '}': FToken := TParseToken.CloseObject;
      '[': FToken := TParseToken.OpenArray;
      ']': FToken := TParseToken.CloseArray;
      ',': FToken := TParseToken.Comma;
      ':': FToken := TParseToken.Colon;
      '"':
      begin
        FToken := TParseToken.String;
        SetLength(str,FTextLength-FIndex);
        idx := 1;
        for i := FIndex+1 to FTextLength do
        begin
          if (FText[i] = '"') then
          begin
            if (FText[i-1] <> '\') then
              break;
            str[idx-1] := '"';
          end else
          begin
            str[idx] := FText[i];
            inc(idx);
          end;
        end;
        Delete(str,idx,High(Integer));
        FIndex := i;
        FTokenValue.Initialize(str);
      end;
      else
      begin
        FToken := TParseToken.Value;
//        lDec := FormatSettings.DecimalSeparator;
//        FormatSettings.DecimalSeparator := '.';
        if TryStrToFloat(s,d, FFmt) then
          FTokenValue.Initialize(d)
        else if TryStrToBool(s,b) then
          FTokenValue.Initialize(b)
        else if s = 'null' then
          FTokenValue.InitializeNull
        else begin
          FormatSettings.DecimalSeparator := lDec;
          raise EParseException.Create('Unexpected Value');
        end;
//        FormatSettings.DecimalSeparator := lDec;
      end;
    end;
  end else
  begin
    FToken := TParseToken.EOF;
  end;

  Result := False;
end;

function TParser.ParseArray : IJSONArray;
begin
  if FToken <> TParseToken.OpenArray  then
    raise Exception.Create('Array Expected');
  Result := JSONArray;
  GetToken;
  while FToken <> TParseToken.CloseArray do
  begin
    case FToken of
      TParser.TParseToken.String:
        Result.Add(@FTokenValue);
        //Result.Add(FTokenValue.StringValue);
      TParser.TParseToken.OpenObject:
        Result.Add(ParseObject);
      TParser.TParseToken.OpenArray:
        Result.Add(ParseArray);
      TParser.TParseToken.Value:
        case FTokenValue.ValueType of
          TJSONValueType.string:
            Result.Add(FTokenValue.StringValue);
          TJSONValueType.number:
            Result.Add(FTokenValue.NumberValue);
          TJSONValueType.array:
            Result.Add(FTokenValue.ArrayValue);
          TJSONValueType.object:
            Result.Add(FTokenValue.ObjectValue);
          TJSONValueType.boolean:
            Result.Add(FTokenValue.IntegerValue <> 0);
          TJSONValueType.null:
            Result.AddNull;
        end;
      TParser.TParseToken.CloseObject,
      TParser.TParseToken.CloseArray,
      TParser.TParseToken.Comma,
      TParser.TParseToken.EOF,
      TParser.TParseToken.MaxOp,
      TParser.TParseToken.Colon:
        if FToken <> TParseToken.Colon then
          raise Exception.Create('Value Expected');
    end;
    GetToken;
    if not (FToken in [TParseToken.Comma, TParseToken.CloseArray]) then
    begin
      raise Exception.Create('Comma or Close Array Expected');
    end;
    if FToken = TParseToken.Comma then
      GetToken;
  end;
end;

function TParser.ParseObject : IJSONObject;
var
  sName : String;
begin
  if FToken <> TParseToken.OpenObject  then
    raise Exception.Create('Object Expected');
  Result := JSON;
  GetToken;
  while FToken <> TParseToken.CloseObject do
  begin
    if FToken <> TParseToken.String then
      raise Exception.Create('String Expected');
    sName := FTokenValue.StringValue;
    GetToken;
    if FToken <> TParseToken.Colon then
      raise Exception.Create('Colon Expected');
    GetToken;
    case FToken of
      TParser.TParseToken.String:
        Result.Raw[sName] := @FTokenValue;
      TParser.TParseToken.OpenObject:
        Result.Objects[sName] := ParseObject;
      TParser.TParseToken.OpenArray:
        Result.Arrays[sName] := ParseArray;
      TParser.TParseToken.Value:
        case FTokenValue.ValueType of
          TJSONValueType.string:
            Result.Strings[sName] := FTokenValue.StringValue;
          TJSONValueType.number:
            Result.Numbers[sName] := FTokenValue.NumberValue;
          TJSONValueType.array:
            Result.Arrays[sName] := FTokenValue.ArrayValue;
          TJSONValueType.object:
            Result.Objects[sName] := FTokenValue.ObjectValue;
          TJSONValueType.boolean:
            Result.Booleans[sName] := FTokenValue.IntegerValue <> 0;
          TJSONValueType.null:
            Result.AddNull(sName);
        end;
      TParser.TParseToken.CloseObject,
      TParser.TParseToken.CloseArray,
      TParser.TParseToken.Comma,
      TParser.TParseToken.EOF,
      TParser.TParseToken.MaxOp,
      TParser.TParseToken.Colon:
        if FToken <> TParseToken.Colon then
          raise Exception.Create('Value Expected');
    end;
    GetToken;
    if not (FToken in [TParseToken.Comma, TParseToken.CloseObject]) then
    begin
      raise Exception.Create('Comma or Close Object Expected');
    end;
    if FToken = TParseToken.Comma then
      GetToken;
  end;
end;

function TParser.Execute(const AText: string): IJSONObject;
begin
  if Trim(AText) = '' then
  begin
    Result := JSON;
    exit;
  end;

  FIndex := 0;
  FText := AText;
  FTextLength := Length(AText);

  if GetToken then
    exit;
  Result := ParseObject;
end;

class function TParser.Parse(const AText: string): IJSONObject;
var
  p : TParser;
begin
  p := TParser.Create;
  try
    Result := p.Execute(AText);
  finally
    p.Free;
  end;
end;

end.



