unit DataModule;

{$mode ObjFPC}{$H+}

interface

uses
  SynCommons,
  mORMot;

type
  TSQLProdutos = class(TSQLRecord)
    private
      // fSeqProduto : integer;
      fDescricao : RawUTF8;
      fCodigoBarras :RawUTF8;
    published
      // property SeqProduto: integer  read fSeqProduto write fSeqProduto stored AS_UNIQUE;
      property Descricao: RawUTF8 index 120 read fDescricao write fDescricao;
      property CodigoBarras : RawUTF8 index 14 read fCodigoBarras write fCodigoBarras stored AS_UNIQUE;
  end;

function CreateDataModule : TSQLModel;

implementation

function CreateDataModule : TSQLModel;
begin
  result := TSQLModel.Create([TSQLProdutos]);
end;

end.

