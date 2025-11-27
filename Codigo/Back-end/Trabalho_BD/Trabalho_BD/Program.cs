using MySql.Data.MySqlClient;
using System.Data;
using Microsoft.AspNetCore.Mvc;

var builder = WebApplication.CreateBuilder(args);

string connectionString = "Server=localhost;Port=3306;Database=trabalho_bd;Uid=root;Pwd=Chos241607#;";

builder.Services.AddCors(options => options.AddPolicy("AllowAll", builder => builder.AllowAnyOrigin().AllowAnyMethod().AllowAnyHeader()));
var app = builder.Build();
app.UseCors("AllowAll");

app.MapPost("/api/usuarios", ([FromBody] UsuarioRequest user) => {
    using var conn = new MySqlConnection(connectionString); conn.Open();
    try
    {
        var cmd = new MySqlCommand("INSERT INTO usuarios (nome_usuario, senha, tipo) VALUES (@nome, @senha, @tipo); SELECT LAST_INSERT_ID();", conn);
        cmd.Parameters.AddWithValue("@nome", user.NomeUsuario);
        cmd.Parameters.AddWithValue("@senha", user.Senha);
        cmd.Parameters.AddWithValue("@tipo", user.Tipo);

        int idGerado = Convert.ToInt32(cmd.ExecuteScalar());
        return Results.Ok(new { id = idGerado });
    }
    catch (Exception ex) { return Results.Problem(ex.Message); }
});

app.MapPost("/api/professores", ([FromBody] ProfessorRequest prof) => {
    using var conn = new MySqlConnection(connectionString); conn.Open();
    try
    {
        var cmd = new MySqlCommand("INSERT INTO professores (nome, email, id_usuario) VALUES (@nome, @email, @idUser)", conn);
        cmd.Parameters.AddWithValue("@nome", prof.Nome);
        cmd.Parameters.AddWithValue("@email", prof.Email);
        cmd.Parameters.AddWithValue("@idUser", prof.IdUsuario);
        cmd.ExecuteNonQuery();
        return Results.Ok();
    }
    catch (Exception ex) { return Results.Problem(ex.Message); }
});


app.MapPost("/api/alunos", ([FromBody] AlunoRequest aluno) => {
    using var conn = new MySqlConnection(connectionString); conn.Open();
    int matricula = new Random().Next(100000, 999999);
    var cmd = new MySqlCommand("INSERT INTO Alunos (nome, matricula, email) VALUES (@nome, @matr, @email)", conn);
    cmd.Parameters.AddWithValue("@nome", aluno.Nome);
    cmd.Parameters.AddWithValue("@matr", matricula);
    cmd.Parameters.AddWithValue("@email", aluno.Email);
    cmd.ExecuteNonQuery();
    return Results.Ok(new { matriculaGerada = matricula });
});

app.MapPost("/api/login", ([FromBody] LoginRequest login) => {
    using var conn = new MySqlConnection(connectionString); conn.Open();
    if (login.Tipo == "aluno")
    {
        var cmd = new MySqlCommand("SELECT * FROM Alunos WHERE email = @login AND matricula = @senha", conn);
        cmd.Parameters.AddWithValue("@login", login.Usuario); cmd.Parameters.AddWithValue("@senha", login.Senha);
        using var r = cmd.ExecuteReader(); if (r.Read()) return Results.Ok(new { tipo = "aluno", nome = r["nome"].ToString(), id = r["id_aluno"] });
    }
    else
    {
        var cmd = new MySqlCommand("SELECT * FROM usuarios WHERE nome_usuario = @login AND senha = @senha AND tipo = @tipo", conn);
        cmd.Parameters.AddWithValue("@login", login.Usuario); cmd.Parameters.AddWithValue("@senha", login.Senha); cmd.Parameters.AddWithValue("@tipo", login.Tipo);
        using var r = cmd.ExecuteReader(); if (r.Read()) return Results.Ok(new { tipo = r["tipo"].ToString(), nome = r["nome_usuario"].ToString(), id = r["id_usuario"] });
    }
    return Results.Unauthorized();
});

app.MapGet("/api/professores", () => ExecutarQuery(connectionString, "SELECT p.id_professor, p.nome, p.email FROM professores p"));
app.MapGet("/api/alunos", () => ExecutarQuery(connectionString, "SELECT * FROM Alunos"));
app.MapGet("/api/salas", () => ExecutarQuery(connectionString, "SELECT * FROM Salas"));
app.MapGet("/api/turnos", () => ExecutarQuery(connectionString, "SELECT * FROM Turnos"));
app.MapGet("/api/disciplinas", () => ExecutarQuery(connectionString, "SELECT * FROM disciplinas ORDER BY periodo, nome"));
app.MapGet("/api/avisos", () => ExecutarQuery(connectionString, "SELECT * FROM Avisos ORDER BY data_publicacao DESC"));

app.MapGet("/api/alocacoes", () => {
    string sql = @"
        SELECT 
            a.id_alocacao,
            d.id_disciplina,
            d.nome as disciplina,
            d.periodo,
            p.nome as professor,
            u.nome_usuario as professor_login,
            s.numero as sala,
            t.hora_inicio,
            t.hora_fim,
            a.dia_semana
        FROM Alocacoes a
        JOIN Disciplinas d ON a.id_disciplina = d.id_disciplina
        JOIN Professores p ON a.id_professor = p.id_professor
        LEFT JOIN usuarios u ON p.id_usuario = u.id_usuario
        JOIN Salas s ON a.id_sala = s.id_sala
        JOIN Turnos t ON a.id_turno = t.id_turno
        ORDER BY a.dia_semana, t.hora_inicio";

    return ExecutarQuery(connectionString, sql);
});

app.MapPost("/api/alocacoes", ([FromBody] AlocacaoRequest req) => {
    using var conn = new MySqlConnection(connectionString); conn.Open();
    var cmd = new MySqlCommand("INSERT INTO Alocacoes (id_disciplina, id_professor, id_sala, id_turno, dia_semana) VALUES (@d, @p, @s, @t, @dia)", conn);
    cmd.Parameters.AddWithValue("@d", req.IdDisciplina); cmd.Parameters.AddWithValue("@p", req.IdProfessor);
    cmd.Parameters.AddWithValue("@s", req.IdSala); cmd.Parameters.AddWithValue("@t", req.IdTurno);
    cmd.Parameters.AddWithValue("@dia", req.DiaSemana ?? "Seg");
    cmd.ExecuteNonQuery(); return Results.Ok();
});

app.MapDelete("/api/alocacoes/{id}", (int id) => {
    using var conn = new MySqlConnection(connectionString); conn.Open();
    new MySqlCommand($"DELETE FROM Alocacoes WHERE id_alocacao={id}", conn).ExecuteNonQuery();
    return Results.Ok();
});

app.MapPost("/api/avisos", ([FromBody] AvisoRequest aviso) => {
    using var conn = new MySqlConnection(connectionString); conn.Open();
    var cmd = new MySqlCommand("INSERT INTO Avisos (titulo, mensagem, data_publicacao) VALUES ('Aviso', @msg, NOW())", conn);
    cmd.Parameters.AddWithValue("@msg", aviso.Texto); cmd.ExecuteNonQuery(); return Results.Ok();
});

app.MapGet("/api/relatorios/1", () => ExecutarQuery(connectionString, @"
    SELECT d.nome AS disciplina, c.nome AS curso, co.nome AS coordenador
    FROM disciplinas d JOIN cursos c ON d.id_curso = c.id_curso
    LEFT JOIN coordenadores co ON c.id_coordenador = co.id_coordenador"));

app.MapGet("/api/relatorios/2", () => ExecutarQuery(connectionString, @"
    SELECT p.nome AS professor, s.numero AS sala, t.nome AS turno, d.nome AS disciplina
    FROM Alocacoes a JOIN professores p ON a.id_professor = p.id_professor
    JOIN salas s ON a.id_sala = s.id_sala JOIN turnos t ON a.id_turno = t.id_turno
    JOIN disciplinas d ON a.id_disciplina = d.id_disciplina"));

app.MapGet("/api/relatorios/3", () => ExecutarQuery(connectionString, @"
    SELECT nome, email FROM professores UNION SELECT nome, email FROM coordenadores"));

app.MapGet("/api/relatorios/4", () => ExecutarQuery(connectionString, @"
    SELECT p.nome, p.email FROM professores p INNER JOIN coordenadores c ON p.email = c.email"));

app.MapGet("/api/relatorios/5", () => ExecutarQuery(connectionString, @"
    SELECT nome, email FROM professores WHERE email NOT IN (SELECT email FROM coordenadores)"));

app.MapGet("/api/relatorios/6", () => ExecutarQuery(connectionString, @"
    SELECT c.nome AS curso, COUNT(d.id_disciplina) AS total_disciplinas
    FROM cursos c LEFT JOIN disciplinas d ON c.id_curso = d.id_curso GROUP BY c.nome"));

app.MapGet("/api/relatorios/7", () => ExecutarQuery(connectionString, @"
    SELECT numero AS sala, capacidade FROM salas WHERE capacidade = (SELECT MAX(capacidade) FROM salas)"));

app.MapGet("/api/relatorios/8", () => ExecutarQuery(connectionString, "SELECT COUNT(*) AS total_professores FROM professores"));

app.MapGet("/api/relatorios/9", () => ExecutarQuery(connectionString, "SELECT nome, email FROM Alunos WHERE nome LIKE 'A%'"));

app.MapGet("/api/relatorios/10", () => ExecutarQuery(connectionString, @"
    SELECT nome, hora_inicio, hora_fim FROM Turnos WHERE hora_inicio BETWEEN '08:00:00' AND '12:00:00'"));

app.MapGet("/api/relatorios/11", () => ExecutarQuery(connectionString, "SELECT * FROM vw_professores_alocados"));

app.MapGet("/api/relatorios/12", () => ExecutarQuery(connectionString, "SELECT AVG(carga_horaria) AS media_carga_horaria FROM disciplinas"));

app.MapGet("/api/relatorios/13", () => ExecutarQuery(connectionString, @"
    SELECT nome AS disciplina FROM disciplinas WHERE id_curso IN (SELECT id_curso FROM cursos)"));

app.MapGet("/api/relatorios/14", () => ExecutarQuery(connectionString, "SELECT * FROM vw_curso_disciplinas"));

app.Run();

static List<Dictionary<string, object>> ExecutarQuery(string connStr, string query)
{
    var list = new List<Dictionary<string, object>>();
    using var conn = new MySqlConnection(connStr); conn.Open();
    using var cmd = new MySqlCommand(query, conn);
    using var reader = cmd.ExecuteReader();
    while (reader.Read())
    {
        var row = new Dictionary<string, object>();
        for (int i = 0; i < reader.FieldCount; i++) row[reader.GetName(i)] = reader.GetValue(i);
        list.Add(row);
    }
    return list;
}

record LoginRequest(string Usuario, string Senha, string Tipo);
record AlocacaoRequest(int IdDisciplina, int IdProfessor, int IdSala, int IdTurno, string? DiaSemana);
record AvisoRequest(string Texto, string Autor);
record UsuarioRequest(string NomeUsuario, string Senha, string Tipo);
record ProfessorRequest(string Nome, string Email, int IdUsuario);
record AlunoRequest(string Nome, string Email);