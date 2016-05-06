namespace AspNet.Identity.Firebird3;

interface

uses
  Microsoft.AspNet.Identity,
  System.Collections.Generic;

type
  /// <summary>
  /// Class that represents the UserLogins table in the FirebirdSQL Database
  /// </summary>
  UserLoginsTable = public class
  private
    var _database: FBDatabase;
  public
    /// <summary>
    /// Constructor that takes a FBDatabase instance
    /// </summary>
    /// <param name="database"></param>
    constructor(database: FBDatabase);
    /// <summary>
    /// Deletes a login from a user in the UserLogins table
    /// </summary>
    /// <param name="user">User to have login deleted</param>
    /// <param name="login">Login to be deleted from user</param>
    /// <returns></returns>
    method Delete(user: IdentityUser; login: UserLoginInfo): Integer;
    /// <summary>
    /// Deletes all Logins from a user in the UserLogins table
    /// </summary>
    /// <param name="userId">The user's id</param>
    /// <returns></returns>
    method Delete(userId: String): Integer;
    /// <summary>
    /// Inserts a new login in the UserLogins table
    /// </summary>
    /// <param name="user">User to have new login added</param>
    /// <param name="login">Login to be added</param>
    /// <returns></returns>
    method Insert(user: IdentityUser; login: UserLoginInfo): Integer;
    /// <summary>
    /// Return a userId given a user's login
    /// </summary>
    /// <param name="userLogin">The user's login info</param>
    /// <returns></returns>
    method FindUserIdByLogin(userLogin: UserLoginInfo): String;
    /// <summary>
    /// Returns a list of user's logins
    /// </summary>
    /// <param name="userId">The user's id</param>
    /// <returns></returns>
    method FindByUserId(userId: String): List<UserLoginInfo>;
  end;

implementation
uses 
  System.Data;

constructor UserLoginsTable(database: FBDatabase);
begin
  _database := database;
end;

method UserLoginsTable.Delete(user: IdentityUser; login: UserLoginInfo): Integer;
begin
  var commandText: String := 'Delete from UserLogins where UserId = @userId and LoginProvider = @loginProvider and ProviderKey = @providerKey';
  var parameters: Dictionary<String, Object> := new Dictionary<String, Object>();
  parameters.Add('UserId', user.Id);
  parameters.Add('loginProvider', login.LoginProvider);
  parameters.Add('providerKey', login.ProviderKey);
  exit _database.Execute(commandText, parameters);
end;

method UserLoginsTable.Delete(userId: String): Integer;
begin
  var commandText: String := 'Delete from UserLogins where UserId = @userId';
  var parameters: Dictionary<String, Object> := new Dictionary<String, Object>();
  parameters.Add('UserId', userId);
  exit _database.Execute(commandText, parameters);
end;

method UserLoginsTable.Insert(user: IdentityUser; login: UserLoginInfo): Integer;
begin
  var commandText: String := 'Insert into UserLogins (LoginProvider, ProviderKey, UserId) values (@loginProvider, @providerKey, @userId)';
  var parameters: Dictionary<String, Object> := new Dictionary<String, Object>();
  parameters.Add('loginProvider', login.LoginProvider);
  parameters.Add('providerKey', login.ProviderKey);
  parameters.Add('userId', user.Id);
  exit _database.Execute(commandText, parameters);
end;

method UserLoginsTable.FindUserIdByLogin(userLogin: UserLoginInfo): String;
begin
  var commandText: String := 'Select UserId from UserLogins where LoginProvider = @loginProvider and ProviderKey = @providerKey';
  var parameters: Dictionary<String, Object> := new Dictionary<String, Object>();
  parameters.Add('loginProvider', userLogin.LoginProvider);
  parameters.Add('providerKey', userLogin.ProviderKey);
  exit _database.GetStrValue(commandText, parameters);
end;

method UserLoginsTable.FindByUserId(userId: String): List<UserLoginInfo>;
begin
  var logins: List<UserLoginInfo> := new List<UserLoginInfo>();
  var commandText: String := 'Select * from UserLogins where UserId = @userId';
  var parameters: Dictionary<String, Object> := new Dictionary<String, Object>();
  parameters.Add('@userId', userId);
  var row : IDataReader := _database.QueryToReader(commandText, parameters);
  while row.Read do begin
    var login := new UserLoginInfo(row['LoginProvider'].ToString, row['ProviderKey'].ToString);
    logins.Add(login);
  end;
  exit logins;
end;

end.
