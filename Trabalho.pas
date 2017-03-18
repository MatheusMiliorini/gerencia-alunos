Program trabalho;

//Cursos
type curso_rec = record
  sigla : string;
  nome	:	string;
end;
type cursos_array = array[1..20] of curso_rec;

//Alunos
type aluno_rec = record
  codigo : integer;
  nome	:	string;
  sigla_curso	:	string;
  frequencia	:	real;
  materias : array[1..5] of string;
  medias	:	array[1..5] of real;
end;
type alunos_array = array[1..20] of aluno_rec;

//Variáveis
var cursos : cursos_array;
var alunos : alunos_array;
q_cursos, q_alunos, i, op, v_codigo : integer;
rodando :	boolean;

procedure ListarMenu();
begin
  writeln('-----------------------');
  writeln('| Escolha sua opção:  |');
  writeln('| 1. Listar cursos.   |');
  writeln('| 2. Cadastrar curso. |');
  writeln('| 3. Remover curso.   |');
  writeln('| 4. Listar alunos.   |');
  writeln('| 5. Cadastrar aluno. |');
  writeln('| 6. Remover aluno.   |');
  writeln('|                     |');
  writeln('| 0. Sair	      |');
  writeln('-----------------------');
end;

procedure CadastrarAluno (var lista:alunos_array;lista_cursos:cursos_array);
var curso_inserido : string;
i:integer;
valido : boolean;
begin
  if q_cursos <> 0 then
  begin
    valido:= false;
    q_alunos:=q_alunos+1;
    v_codigo := v_codigo+1;
    lista[q_alunos].codigo := v_codigo;
    writeln('Nome completo do aluno:');
    readln(lista[q_alunos].nome);
    writeln('Sigla do curso:');
    while valido <> true do
    begin
      readln(curso_inserido);
      for i:=1 to q_cursos do
      //Valida o curso
      if curso_inserido = lista_cursos[i].sigla then
      begin
        valido := true;
        lista[q_alunos].sigla_curso := curso_inserido;
      end;
      if valido = false then
      writeln('Curso não localizado no banco de dados!');
      //Fim da validação
    end;
    writeln('Frequencia total do aluno:');
    readln(lista[q_alunos].frequencia);
    writeln('Insira as 5 matérias com sua média em seguida (enter):');
    for i:=1 to 5 do
    begin
      readln(lista[q_alunos].materias[i]);
      readln(lista[q_alunos].medias[i]);
    end;
  end
  else
  writeln('Ainda não há cursos criados!');
end;

procedure ListarAlunos(lista:alunos_array);
var i, j : integer;
begin
  for i:=1 to q_alunos do
  begin
    writeln('Codigo: ',lista[i].codigo);
    writeln('Nome: ',lista[i].nome);
    writeln('Curso: ',lista[i].sigla_curso);
    writeln('Frequencia: ',lista[i].frequencia:2:0);
    writeln('Matérias:');
    for j:=1 to 5 do
    writeln('Nome: ',lista[i].materias[j],'   Média: ',lista[i].medias[j]:2:0);
    writeln();
    writeln();
  end;
end;

procedure RemoverAluno(var lista:alunos_array);
var cod, j : integer;
begin
  if q_alunos = 0 then
  writeln('Lista de alunos vazia, não há o que remover!')
  else
  begin
    writeln('Insira o código do aluno a ser removido:');
    readln(cod);
    //Valida se o código não é maior que a quantidade de alunos
    if cod > q_alunos then
    writeln('Não há aluno com esse código!') {Termina a validação}
    else
    begin
      for i:=cod to q_alunos do
      begin
        lista[i].codigo := lista[i+1].codigo;
        lista[i].nome := lista[i+1].nome;
        lista[i].sigla_curso := lista[i+1].sigla_curso;
        for j:=1 to 5 do
        lista[i].materias[j] := lista[i+1].materias[j];
        for j:=1 to 5 do
        lista[i].medias[j] := lista[i+1].medias[j];
      end;
      q_alunos := q_alunos-1;
    end;
  end;
end;

procedure CadastrarCurso(var lista:cursos_array);
var trocou, cadastrar : boolean;
tmp, curso : string;
i	:	integer;
begin
  cadastrar := true;
  q_cursos := q_cursos+1;
  writeln('Insira a sigla do curso: ');
  readln(curso);
  //Checa se o curso já existe no "banco de dados"
  for i:=1 to q_cursos do
  if lista[i].sigla = curso then
  begin
    cadastrar := false;
    writeln('Curso já cadastrado! Operação cancelada...');
  end;
  //Fim da checagem
  if cadastrar = true then
  begin
    lista[q_cursos].sigla := curso;
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
  end
  else
  q_cursos := q_cursos-1; {Isso está aqui para caso a sigla já esteja cadastrada... Gambiarra talvez?}
end;

procedure RemoverCurso (var lista:cursos_array);
var n, i : integer;
begin
  if q_cursos = 0 then
  writeln('Ainda não há cursos listados!')
  else
  begin
    write('Insira o índice a ser removido: ');
    readln(n);
    for i:=n to q_cursos do
    begin
      lista[i].sigla := lista[i+1].sigla;
      lista[i].nome := lista[i+1].nome;
    end;
    q_cursos := q_cursos-1;
  end;
end;

procedure ListarCursos(lista:cursos_array);
var i : integer;
begin
  for i:= 1 to q_cursos do
  begin
    write(i,'. Sigla: ',lista[i].sigla,'   Nome: ',lista[i].nome);
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
    else if (op = 3) then
    RemoverCurso(cursos)
    else if (op = 4) then
    ListarAlunos(alunos)
    else if (op = 5) then
    CadastrarAluno(alunos,cursos)
    else if (op = 6) then
    RemoverAluno(alunos)
    else if (op = 0) then
    rodando:=false;
  end;
End.