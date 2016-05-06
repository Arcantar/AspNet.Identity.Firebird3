namespace AspNet.Identity.Firebird3;

interface

uses
  System,
  System.Collections.Generic;

type
  /// <summary>
  /// Class that represents the Role table in the FirebirdSQL Database
  /// </summary>
  RoleTable = public class
  private
    var _database: FBDatabase;
  public
    /// <summary>
    /// Constructor that takes a FBDatabase instance
    /// </summary>
    /// <param name="database"></param>
    constructor(database: FBDatabase);
    /// <summary>
    /// Deltes a role from the Roles table
    /// </summary>
    /// <param name="roleId">The role Id</param>
    /// <returns></returns>
    method Delete(roleId: String): Integer;
    /// <summary>
    /// Inserts a new Role in the Roles table
    /// </summary>
    /// <param name="roleName">The role's name</param>
    /// <returns></returns>
    method Insert(role: IdentityRole): Integer;
    /// <summary>
    /// Returns a role name given the roleId
    /// </summary>
    /// <param name="roleId">The role Id</param>
    /// <returns>Role name</returns>
    method GetRoleName(roleId: String): String;
    /// <summary>
    /// Returns the role Id given a role name
    /// </summary>
    /// <param name="roleName">Role's name</param>
    /// <returns>Role's Id</returns>
    method GetRoleId(roleName: String): String;
    /// <summary>
    /// Gets the IdentityRole given the role Id
    /// </summary>
    /// <param name="roleId"></param>
    /// <returns></returns>
    method GetRoleById(roleId: String): IdentityRole;
    /// <summary>
    /// Gets the IdentityRole given the role name
    /// </summary>
    /// <param name="roleName"></param>
    /// <returns></returns>
    method GetRoleByName(roleName: String): IdentityRole;
    method Update(role: IdentityRole): Integer;
  end;

implementation

constructor RoleTable(database: FBDatabase);
begin
  _database := database;
end;

method RoleTable.Delete(roleId: String): Integer;
begin
  var commandText: String := 'Delete from Roles where Id = @id';
  var parameters: Dictionary<String, Object> := new Dictionary<String, Object>();
  parameters.&Add('@id', roleId);
  exit _database.Execute(commandText, parameters);
end;

method RoleTable.Insert(role: IdentityRole): Integer;
begin
  var commandText: String := 'Insert into Roles (Id, Name) values (@id, @name)';
  var parameters: Dictionary<String, Object> := new Dictionary<String, Object>();
  parameters.&Add('@name', role.Name);
  parameters.&Add('@id', role.Id);
  exit _database.Execute(commandText, parameters);
end;

method RoleTable.GetRoleName(roleId: String): String;
begin
  var commandText: String := 'Select Name from Roles where Id = @id';
  var parameters: Dictionary<String, Object> := new Dictionary<String, Object>();
  parameters.Add('@id', roleId);
  exit _database.GetStrValue(commandText, parameters);
end;

method RoleTable.GetRoleId(roleName: String): String;
begin
  var roleId: String := nil;
  var commandText: String := 'Select Id from Roles where Name = @name';
  var parameters: Dictionary<String, Object> := new Dictionary<String, Object>();
  parameters.Add('@name', roleName);
  var &result := _database.QueryValue(commandText, parameters);
  if &result <> nil then begin
    exit Convert.ToString(&result);
  end;
  exit roleId;
end;

method RoleTable.GetRoleById(roleId: String): IdentityRole;
begin
  var roleName := GetRoleName(roleId);
  var role: IdentityRole := nil;
  if roleName <> nil then begin
    role := new IdentityRole(roleName, roleId);
  end;
  exit role;
end;

method RoleTable.GetRoleByName(roleName: String): IdentityRole;
begin
  var roleId:= GetRoleId(roleName);
  var role: IdentityRole := nil;
  if roleId <> nil then begin
    role := new IdentityRole(roleName, roleId);
  end;
  exit role;
end;

method RoleTable.Update(role: IdentityRole): Integer;
begin
  var commandText: String := 'Update Roles set Name = @name where Id = @id';
  var parameters: Dictionary<String, Object> := new Dictionary<String, Object>();
  parameters.&Add('@id', role.Id);
  exit _database.Execute(commandText, parameters);
end;

end.
