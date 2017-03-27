Program trabalho;

//Cursos
type curso_rec = record
  sigla : string;
  nome	:	string;
  q_alunos : integer;
end;
type cursos_array = array[1..20] of curso_rec;

//Alunos
type aluno_rec = record
  codigo : integer;
  nome	:	string;
  sigla_curso	:	string;
  q_materias : integer;
  frequencia	:	array[1..50] of real;
  materias : array[1..50] of string;
  medias	:	array[1..50] of real;
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

procedure CadastrarAluno (var lista:alunos_array;var lista_cursos:cursos_array; var qt_alunos : integer; qt_cursos : integer; var indice_codigo : integer);
var curso_inserido : string;
i:integer;
valido : boolean;
begin
  if qt_cursos <> 0 then
  begin
    valido:= false;
    qt_alunos:=qt_alunos+1;
    indice_codigo := indice_codigo+1;
    lista[qt_alunos].codigo := indice_codigo;
    writeln('Nome completo do aluno:');
    readln(lista[qt_alunos].nome);
    writeln('Sigla do curso:');
    while valido <> true do
    begin
      readln(curso_inserido);
      for i:=1 to qt_cursos do
      //Valida o curso
      if curso_inserido = lista_cursos[i].sigla then
      begin
        valido := true;
        lista[qt_alunos].sigla_curso := curso_inserido;
        lista_cursos[i].q_alunos := lista_cursos[i].q_alunos+1;
      end;
      if valido = false then
      writeln('Curso não localizado no banco de dados!');
      //Fim da validação
    end;
    writeln('Quantidade de matérias do aluno:');
    readln(lista[qt_alunos].q_materias);
    writeln('Insira as matérias com sua média e frequencia em seguida (enter):');
    for i:=1 to lista[qt_alunos].q_materias do
    begin
      write('Matéria: ');
      readln(lista[qt_alunos].materias[i]);
      write('Média: ');
      readln(lista[qt_alunos].medias[i]);
      write('Frequência: ');
      readln(lista[qt_alunos].frequencia[i]);
    end;
  end
  else
  writeln('Ainda não há cursos criados!');
end;

procedure ListarAlunos(lista:alunos_array;lista_cursos:cursos_array; qt_alunos : integer);
var i, j : integer;
begin
  if qt_alunos = 0 then
  writeln('Lista de alunos vazia!')
  else
  begin
    for i:=1 to qt_alunos do
    begin
      writeln('Codigo: ',lista[i].codigo);
      writeln('Nome: ',lista[i].nome);
      writeln('Curso: ',lista[i].sigla_curso);
      writeln('Matérias:');
      for j:=1 to lista[i].q_materias do
      writeln('Nome: ',lista[i].materias[j],'   Média: ',lista[i].medias[j]:0:2,'   Frequencia: ',lista[i].frequencia[j]:0:2);
      writeln();
    end;
  end;
end;

procedure RemoverAluno(var lista:alunos_array; var lista_cursos:cursos_array; var qt_alunos : integer; qt_cursos : integer);
var i, cod, j, k : integer;
sigla_aluno_deletar : string;
begin
  if qt_alunos = 0 then
  writeln('Lista de alunos vazia, não há o que remover!')
  else
  begin
    writeln('Insira o código do aluno a ser removido:');
    readln(cod);
    if cod = 0 then
    writeln('Zero não é um valor válido para essa operação!')
    else
    begin
      for i:=1 to qt_alunos do
      if lista[i].codigo = cod then
      begin
        sigla_aluno_deletar := lista[i].sigla_curso;
        for j:=1 to qt_cursos do
        begin
          if lista_cursos[j].sigla = sigla_aluno_deletar then
          lista_cursos[j].q_alunos := lista_cursos[j].q_alunos-1;
        end;
        for j:=i to qt_alunos do
        begin
          lista[j].q_materias := lista[j+1].q_materias; {Pega a quantidade de matérias do próximo indice}
          lista[j].codigo := lista[j+1].codigo;
          lista[j].nome := lista[j+1].nome;
          lista[j].sigla_curso := lista[j+1].sigla_curso;
          for k:=1 to lista[j+1].q_materias do
          lista[j].frequencia[k] := lista[j+1].frequencia[k];
          for k:=1 to lista[j+1].q_materias do
          lista[j].materias[k] := lista[j+1].materias[k];
          for k:=1 to lista[j+1].q_materias do
          lista[j].medias[k] := lista[j+1].medias[k];
        end;
        qt_alunos := qt_alunos-1;
      end;
    end;
  end;
end;

procedure CadastrarCurso(var lista:cursos_array; var qt_cursos : integer);
var trocou, cadastrar : boolean;
tmp, curso : string;
i, tmp_q_alunos	:	integer;
begin
  cadastrar := true;
  qt_cursos := qt_cursos+1;
  writeln('Insira a sigla do curso: ');
  readln(curso);
  //Checa se o curso já existe no "banco de dados"
  for i:=1 to qt_cursos do
  if lista[i].sigla = curso then
  begin
    cadastrar := false;
    writeln('Curso já cadastrado! Operação cancelada...');
  end;
  //Fim da checagem
  if cadastrar = true then
  begin
    lista[qt_cursos].sigla := curso;
    writeln('Insira o nome do curso: ');
    readln(lista[qt_cursos].nome);
    
    //Ordenar
    if qt_cursos > 1 then
    begin
      i:=qt_cursos;
      trocou := true;
      while (trocou = true) and (i > 1) do
      begin
        trocou := false;
        if lista[i].sigla < lista[i-1].sigla then
        begin
          tmp := lista[i].sigla; //passa a sigla
          lista[i].sigla := lista[i-1].sigla;
          lista[i-1].sigla := tmp;
          tmp := lista[i].nome; //Passa o nome
          lista[i].nome := lista[i-1].nome;
          lista[i-1].nome := tmp;
          tmp_q_alunos := lista[i].q_alunos; //Passa a quantidade de alunos (aqui tava o bug!)
          lista[i].q_alunos := lista[i-1].q_alunos;
          lista[i-1].q_alunos := tmp_q_alunos;
          i:=i-1;
          trocou := true;
        end;
      end;
    end;
  end
  else
  qt_cursos := qt_cursos-1; //Isso está aqui para caso a sigla já esteja cadastrada... Gambiarra talvez?
end;

procedure RemoverCurso (var lista:cursos_array; var qt_cursos : integer);
var n, i : integer;
begin
  if qt_cursos = 0 then
  writeln('Ainda não há cursos cadastrados!')
  else
  begin
    write('Insira o índice a ser removido: ');
    readln(n);
    if (n > qt_cursos) or (n = 0) then
    writeln('Índice inválido! Abortando operação...')
    else
    begin
      if lista[n].q_alunos <> 0 then
      writeln('Há alunos nesse curso! Remova todos antes de deletá-lo. Abortando operação...')
      else
      begin
        for i:=n to qt_cursos do
        begin
          lista[i].sigla := lista[i+1].sigla;
          lista[i].nome := lista[i+1].nome;
          lista[i].q_alunos := lista[i+1].q_alunos; //Aqui também estava dando o bug
        end;
        qt_cursos := qt_cursos-1;
      end;
    end;
  end;
end;

procedure ListarCursos(lista:cursos_array; qt_cursos : integer);
var i : integer;
begin
  if qt_cursos = 0 then
  writeln('Ainda não há cursos cadastrados!')
  else
  for i:= 1 to qt_cursos do
  writeln(i,'. Sigla: ',lista[i].sigla,'   Nome: ',lista[i].nome);
end;


Begin
  rodando := true;
  while rodando = true do
  begin
    ListarMenu();
    readln(op);
    if (op = 1) then
    ListarCursos(cursos,q_cursos)
    else if (op = 2) then
    CadastrarCurso(cursos,q_cursos)
    else if (op = 3) then
    RemoverCurso(cursos,q_cursos)
    else if (op = 4) then
    ListarAlunos(alunos,cursos,q_alunos)
    else if (op = 5) then
    CadastrarAluno(alunos,cursos,q_alunos,q_cursos,v_codigo)
    else if (op = 6) then
    RemoverAluno(alunos,cursos,q_alunos,q_cursos)
    else if (op = 0) then
    rodando:=false;
    readkey;
    clrscr;
  end;
End.