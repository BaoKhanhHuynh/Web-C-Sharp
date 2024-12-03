using System.Data;
using Dapper;
using WebApp.Models;
using WebApp.Services;
namespace WebApp.Repositories;

public class MemberRepository : BaseRepository
{
    public MemberRepository(IDbConnection connection) : base(connection) { }
    public Member? Login(LoginModel obj)
    {
        string sql = "SELECT MemberId, Email, Name, GivenName, Surname, Role FROM Member WHERE Email = @Email AND Password = @Password";
        return connection.QuerySingleOrDefault<Member>(sql, new { Email = obj.Eml, Password = Helper.Hash(obj.Pwd) });


    }
    public IEnumerable<Member> GetMembers()
    {
        string sql = "SELECT MemberId, Email, Name, GivenName, Surname, Role FROM Member";
        return connection.Query<Member>(sql);
    }
    public int Add(Member obj)
    {
        return connection.Execute("AddMember", new
        {
            obj.MemberId,
            obj.Email,
            obj.Name,
            obj.Password,
            obj.GivenName,
            obj.Surname
        },
        commandType: CommandType.StoredProcedure);
    }
    public IEnumerable<Member> GetAll()
    {
        var sql = "SELECT * FROM Member";
        return connection.Query<Member>(sql);
    }

    public Member GetById(long memberId)
    {
        var sql = "SELECT * FROM Member WHERE MemberId = @MemberId";
        return connection.QueryFirstOrDefault<Member>(sql, new { MemberId = memberId });
    }
    public void Create(Member Member)
    {
        var sql = "INSERT INTO Member (MemberId, Email, Name, Password, GivenName, Surname) VALUES (@MemberId, @Email, @Name, @Password, @GivenName, @Surname)";
        connection.Execute(sql, Member);
    }
    public void Edit(Member Member)
    {
        var sql = "UPDATE Member SET MemberId = @MemberId , Email = @Email , Name = @Name , Password = @Password , GivenName = @GivenName , Surname = @Surname WHERE MemberId = @MemberId";
        connection.Execute(sql, new { Member.Email, Member.Name, Member.Password, Member.GivenName, Member.Surname, Member.MemberId });
    }
    public void Delete(int id)
    {
        var sql = "DELETE FROM Member WHERE MemberId = @MemberId";
        connection.Execute(sql, new { MemberId = id });
    }

}