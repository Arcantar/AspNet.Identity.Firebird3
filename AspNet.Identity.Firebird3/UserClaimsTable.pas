namespace AspNet.Identity.Firebird3;

interface

uses
  System.Collections.Generic,
  System.Security.Claims;

type
  /// <summary>
  /// Class that represents the UserClaims table in the FirebirdSQL Database
  /// </summary>
  UserClaimsTable = public class
  private
    var _database: FBDatabase;
  public
    /// <summary>
    /// Constructor that takes a FBDatabase instance
    /// </summary>
    /// <param name="database"></param>
    constructor(database: FBDatabase);
    /// <summary>
    /// Returns a ClaimsIdentity instance given a userId
    /// </summary>
    /// <param name="userId">The user's id</param>
    /// <returns></returns>
    method FindByUserId(userId: String): ClaimsIdentity;
    /// <summary>
    /// Deletes all claims from a user given a userId
    /// </summary>
    /// <param name="userId">The user's id</param>
    /// <returns></returns>
    method Delete(userId: String): Integer;
    /// <summary>
    /// Inserts a new claim in UserClaims table
    /// </summary>
    /// <param name="userClaim">User's claim to be added</param>
    /// <param name="userId">User's id</param>
    /// <returns></returns>
    method Insert(userClaim: Claim; userId: String): Integer;
    /// <summary>
    /// Deletes a claim from a user
    /// </summary>
    /// <param name="user">The user to have a claim deleted</param>
    /// <param name="claim">A claim to be deleted from user</param>
    /// <returns></returns>
    method Delete(user: IdentityUser; claim: Claim): Integer;
  end;

implementation

constructor UserClaimsTable(database: FBDatabase);
begin
  _database := database;
end;

method UserClaimsTable.FindByUserId(userId: String): ClaimsIdentity;
begin
  var claims: ClaimsIdentity := new ClaimsIdentity();
  var commandText: String := 'Select * from UserClaims where UserId = @userId';
  var parameters: Dictionary<String, Object> := new Dictionary<String, Object>();
  parameters.Add('@UserId', userId);
  var rows := _database.Query(commandText, parameters);
  for each row in rows do begin
    var claim: Claim := new Claim(row['ClaimType'], row['ClaimValue']);
    claims.AddClaim(claim);
  end;
  exit claims;
end;

method UserClaimsTable.Delete(userId: String): Integer;
begin
  var commandText: String := 'Delete from UserClaims where UserId = @userId';
  var parameters: Dictionary<String, Object> := new Dictionary<String, Object>();
  parameters.Add('userId', userId);
  exit _database.Execute(commandText, parameters);
end;

method UserClaimsTable.Insert(userClaim: Claim; userId: String): Integer;
begin
  var commandText: String := 'Insert into UserClaims (ClaimValue, ClaimType, UserId) values (@value, @type, @userId)';
  var parameters: Dictionary<String, Object> := new Dictionary<String, Object>();
  parameters.Add('value', userClaim.Value);
  parameters.Add('type', userClaim.&Type);
  parameters.Add('userId', userId);
  exit _database.Execute(commandText, parameters);
end;

method UserClaimsTable.Delete(user: IdentityUser; claim: Claim): Integer;
begin
  var commandText: String := 'Delete from UserClaims where UserId = @userId and @ClaimValue = @value and ClaimType = @type';
  var parameters: Dictionary<String, Object> := new Dictionary<String, Object>();
  parameters.Add('userId', user.Id);
  parameters.Add('value', claim.Value);
  parameters.Add('type', claim.&Type);
  exit _database.Execute(commandText, parameters);
end;

end.
