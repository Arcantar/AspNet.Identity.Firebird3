namespace AspNet.Identity.Firebird3;

interface

uses
  System.Collections.Generic;

type
  /// <summary>
  /// Class that represents the UserRoles table in the FirebirdSQL Database
  /// </summary>
  UserRolesTable = public class
  private
    var _database: FBDatabase;
  public
    /// <summary>
    /// Constructor that takes a FBDatabase instance
    /// </summary>
    /// <param name="database"></param>
    constructor(database: FBDatabase);
    /// <summary>
    /// Returns a list of user's roles
    /// </summary>
    /// <param name="userId">The user's id</param>
    /// <returns></returns>
    method FindByUserId(userId: String): List<String>;
    /// <summary>
    /// Deletes all roles from a user in the UserRoles table
    /// </summary>
    /// <param name="userId">The user's id</param>
    /// <returns></returns>
    method Delete(userId: String): Integer;
    /// <summary>
    /// Inserts a new role for a user in the UserRoles table
    /// </summary>
    /// <param name="user">The User</param>
    /// <param name="roleId">The Role's id</param>
    /// <returns></returns>
    method Insert(user: IdentityUser; roleId: String): Integer;
  end;

implementation

uses 
  System.Data;

constructor UserRolesTable(database: FBDatabase);
begin
  _database := database;
end;

method UserRolesTable.FindByUserId(userId: String): List<String>;
begin
  var roles: List<String> := new List<String>();
  var commandText: String := 'Select Roles.Name from UserRoles, Roles where UserRoles.UserId = @userId and UserRoles.RoleId = Roles.Id';
  var parameters: Dictionary<String, Object> := new Dictionary<String, Object>();
  parameters.Add('@userId', userId);
  var row : IDataReader := _database.QueryToReader(commandText, parameters);
  while row.Read do begin
    roles.Add(row['Name'].ToString);
  end;
  exit roles;
end;

method UserRolesTable.Delete(userId: String): Integer;
begin
  var commandText: String := 'Delete from UserRoles where UserId = @userId';
  var parameters: Dictionary<String, Object> := new Dictionary<String, Object>();
  parameters.Add('UserId', userId);
  exit _database.Execute(commandText, parameters);
end;

method UserRolesTable.Insert(user: IdentityUser; roleId: String): Integer;
begin
  var commandText: String := 'Insert into UserRoles (UserId, RoleId) values (@userId, @roleId)';
  var parameters: Dictionary<String, Object> := new Dictionary<String, Object>();
  parameters.Add('userId', user.Id);
  parameters.Add('roleId', roleId);
  exit _database.Execute(commandText, parameters);
end;

end.
