Program trabalho;

type curso_rec = record
  sigla : string;
  nome	:	string;
end;
type cursos_array = array[1..20] of curso_rec;

var cursos : cursos_array;
q_cursos, i, op : integer;
rodando :	boolean;

procedure ListarMenu();
begin
  writeln('-----------------------');
  writeln('| Escolha sua opção:  |');
  writeln('| 1. Listar cursos.   |');
  writeln('| 2. Cadastrar curso. |');
  writeln('| 0. Sair	      |');
  writeln('-----------------------');
end;

procedure CadastrarCurso(var lista:cursos_array);
var trocou : boolean;
tmp : string;
i	:	integer;
begin
  q_cursos := q_cursos+1;
  writeln('Insira a sigla do curso: ');
  readln(lista[q_cursos].sigla);
  writeln('Insira o nome do curso: ');
  readln(lista[q_cursos].nome);
  
  //Ordenar
  if q_cursos > 1 then
  begin
  	i:=q_cursos;
  	trocou := true;
    while (trocou = true) and (i > 1) do
    begin
    	trocou := false;
      if lista[i].sigla < lista[i-1].sigla then
      begin
        tmp := lista[i].sigla;
        lista[i].sigla := lista[i-1].sigla;
        lista[i-1].sigla := tmp;
        tmp := lista[i].nome;
        lista[i].nome := lista[i-1].nome;
        lista[i-1].nome := tmp;
        i:=i-1;
        trocou := true;
      end;
    end;
  end;
end;

procedure ListarCursos(var lista:cursos_array);
var i : integer;
begin
  for i:= 1 to q_cursos do
  begin
    write('Sigla: ',lista[i].sigla,'   Nome: ',lista[i].nome);
    writeln();
  end;
end;


Begin
  rodando := true;
  while rodando = true do
  begin
    ListarMenu();
    readln(op);
    if (op = 1) then
    ListarCursos(cursos)
    else if (op = 2) then
    CadastrarCurso(cursos)
    else if (op = 0) then
    rodando:=false;
  end;
End.