namespace AspNet.Identity.Firebird3;

interface

uses
  System,
  System.Collections.Generic;

type
  /// <summary>
  /// Class that represents the Users table in the FirebirdSQL Database
  /// </summary>
  UserTable<TUser> = public class
  where TUser  is IdentityUser;
  private
    var _database: FBDatabase;
  public
    /// <summary>
    /// Constructor that takes a FBDatabase instance
    /// </summary>
    /// <param name="database"></param>
    constructor(database: FBDatabase);
    /// <summary>
    /// Returns the user's name given a user id
    /// </summary>
    /// <param name="userId"></param>
    /// <returns></returns>
    method GetUserName(userId: String): String;
    /// <summary>
    /// Returns a User ID given a user name
    /// </summary>
    /// <param name="userName">The user's name</param>
    /// <returns></returns>
    method GetUserId(userName: String): String;
    /// <summary>
    /// Returns an TUser given the user's id
    /// </summary>
    /// <param name="userId">The user's id</param>
    /// <returns></returns>
    method GetUserById(userId: String): TUser;
    /// <summary>
    /// Returns a list of TUser instances given a user name
    /// </summary>
    /// <param name="userName">User's name</param>
    /// <returns></returns>
    method GetUserByName(userName: String): List<TUser>;
    method GetUserByEmail(email: String): List<TUser>;
    /// <summary>
    /// Return the user's password hash
    /// </summary>
    /// <param name="userId">The user's id</param>
    /// <returns></returns>
    method GetPasswordHash(userId: String): String;
    /// <summary>
    /// Sets the user's password hash
    /// </summary>
    /// <param name="userId"></param>
    /// <param name="passwordHash"></param>
    /// <returns></returns>
    method SetPasswordHash(userId: String; passwordHash: String): Integer;
    /// <summary>
    /// Returns the user's security stamp
    /// </summary>
    /// <param name="userId"></param>
    /// <returns></returns>
    method GetSecurityStamp(userId: String): String;
    /// <summary>
    /// Inserts a new user in the Users table
    /// </summary>
    /// <param name="user"></param>
    /// <returns></returns>
    method Insert(user: TUser): Integer;
  private
    /// <summary>
    /// Deletes a user from the Users table
    /// </summary>
    /// <param name="userId">The user's id</param>
    /// <returns></returns>
    method Delete(userId: String): Integer;
  public
    /// <summary>
    /// Deletes a user from the Users table
    /// </summary>
    /// <param name="user"></param>
    /// <returns></returns>
    method Delete(user: TUser): Integer;
    /// <summary>
    /// Updates a user in the Users table
    /// </summary>
    /// <param name="user"></param>
    /// <returns></returns>
    method Update(user: TUser): Integer;
  end;

implementation

uses 
  System.Data;

constructor UserTable<TUser>(database: FBDatabase);
begin
  _database := database;
end;

method UserTable<TUser>.GetUserName(userId: String): String;
begin
  var commandText: String := 'Select Name from Users where Id = @id';
  var parameters: Dictionary<String, Object> := new Dictionary<String, Object>();
  parameters.Add('@id', userId);
  exit _database.GetStrValue(commandText, parameters);
end;

method UserTable<TUser>.GetUserId(userName: String): String;
begin
  var commandText: String := 'Select Id from Users where UserName = @name';
  var parameters: Dictionary<String, Object> := new Dictionary<String, Object>();
  parameters.Add('@name', userName);
  exit _database.GetStrValue(commandText, parameters);
end;

method UserTable<TUser>.GetUserById(userId: String): TUser;
begin
  var user: TUser := nil;
  var commandText: String := 'Select * from Users where Id = @id';
  var parameters: Dictionary<String, Object> := new Dictionary<String, Object>();
  parameters.Add('@id', userId);
  var row : IDataReader := _database.QueryToReader(commandText, parameters);
  while row.Read do begin
    user := TUser(Activator.CreateInstance(typeOf(TUser)));
    user.Id := row['Id'].ToString;
    user.UserName := row['UserName'].ToString;
    user.PasswordHash := if String.IsNullOrEmpty(row['PasswordHash'].ToString) then nil else row['PasswordHash'].ToString;
    user.SecurityStamp := if String.IsNullOrEmpty(row['SecurityStamp'].ToString) then nil else row['SecurityStamp'].ToString;
    user.Email := if String.IsNullOrEmpty(row['Email'].ToString) then nil else row['Email'].ToString;
    user.EmailConfirmed := if row['EmailConfirmed'].ToString = '1' then true else false;
    user.PhoneNumber := if String.IsNullOrEmpty(row['PhoneNumber'].ToString) then nil else row['PhoneNumber'].ToString;
    user.PhoneNumberConfirmed := if row['PhoneNumberConfirmed'].ToString = '1' then true else false;
    user.LockoutEnabled := if row['LockoutEnabled'].ToString = '1' then true else false;
    user.TwoFactorEnabled := if row['TwoFactorEnabled'].ToString = '1' then true else false;
    user.LockoutEndDateUtc := if String.IsNullOrEmpty(row['LockoutEndDateUtc'].ToString) then DateTime.Now else DateTime.Parse(row['LockoutEndDateUtc'].ToString);
    user.AccessFailedCount := if String.IsNullOrEmpty(row['AccessFailedCount'].ToString) then 0 else Integer.Parse(row['AccessFailedCount'].ToString);
  end;
  exit user;
end;

method UserTable<TUser>.GetUserByName(userName: String): List<TUser>;
begin
  var users: List<TUser> := new List<TUser>();
  var commandText: String := 'Select * from Users where UserName collate fr_ca_ci_ai = @name';
  var parameters: Dictionary<String, Object> := new Dictionary<String, Object>();
  parameters.Add('@name', userName);
  var row : IDataReader := _database.QueryToReader(commandText, parameters);
  while row.Read do begin
    var user: TUser :=  TUser(Activator.CreateInstance(typeOf(TUser)));
    user.Id := row['Id'].ToString;
    user.UserName := row['UserName'].ToString;
    user.PasswordHash := if String.IsNullOrEmpty(row['PasswordHash'].ToString) then nil else row['PasswordHash'].ToString;
    user.SecurityStamp := if String.IsNullOrEmpty(row['SecurityStamp'].ToString) then nil else row['SecurityStamp'].ToString;
    user.Email := if String.IsNullOrEmpty(row['Email'].ToString) then nil else row['Email'].ToString;
    user.EmailConfirmed := if row['EmailConfirmed'].ToString = '1' then true else false;
    user.PhoneNumber := if String.IsNullOrEmpty(row['PhoneNumber'].ToString) then nil else row['PhoneNumber'].ToString;
    user.PhoneNumberConfirmed := if row['PhoneNumberConfirmed'].ToString = '1' then true else false;
    user.LockoutEnabled := if row['LockoutEnabled'].ToString = '1' then true else false;
    user.TwoFactorEnabled := if row['TwoFactorEnabled'].ToString = '1' then true else false;
    user.LockoutEndDateUtc := if String.IsNullOrEmpty(row['LockoutEndDateUtc'].ToString) then DateTime.Now else DateTime.Parse(row['LockoutEndDateUtc'].ToString);
    user.AccessFailedCount := if String.IsNullOrEmpty(row['AccessFailedCount'].ToString) then 0 else Integer.Parse(row['AccessFailedCount'].ToString);
    users.Add(user as TUser);
  end;
  exit users;
end;

method UserTable<TUser>.GetUserByEmail(email: String): List<TUser>;
begin
  var users: List<TUser> := new List<TUser>();
  var commandText: String := 'Select * from Users where EMAIL collate fr_ca_ci_ai = @email';
  var parameters: Dictionary<String, Object> := new Dictionary<String, Object>();
  parameters.Add('@email', email);
  var row : IDataReader := _database.QueryToReader(commandText, parameters);
  while row.Read do begin
    var user: TUser :=  TUser(Activator.CreateInstance(typeOf(TUser)));
    user.Id := row['Id'].ToString;
    user.UserName := row['UserName'].ToString;
    user.PasswordHash := if String.IsNullOrEmpty(row['PasswordHash'].ToString) then nil else row['PasswordHash'].ToString;
    user.SecurityStamp := if String.IsNullOrEmpty(row['SecurityStamp'].ToString) then nil else row['SecurityStamp'].ToString;
    user.Email := if String.IsNullOrEmpty(row['Email'].ToString) then nil else row['Email'].ToString;
    user.EmailConfirmed := if row['EmailConfirmed'].ToString = '1' then true else false;
    user.PhoneNumber := if String.IsNullOrEmpty(row['PhoneNumber'].ToString) then nil else row['PhoneNumber'].ToString;
    user.PhoneNumberConfirmed := if row['PhoneNumberConfirmed'].ToString = '1' then true else false;
    user.LockoutEnabled := if row['LockoutEnabled'].ToString = '1' then true else false;
    user.TwoFactorEnabled := if row['TwoFactorEnabled'].ToString = '1' then true else false;
    user.LockoutEndDateUtc := if String.IsNullOrEmpty(row['LockoutEndDateUtc'].ToString) then DateTime.Now else DateTime.Parse(row['LockoutEndDateUtc'].ToString);
    user.AccessFailedCount := if String.IsNullOrEmpty(row['AccessFailedCount'].ToString) then 0 else Integer.Parse(row['AccessFailedCount'].ToString);
    users.Add(user as TUser);
  end;
  exit users;
end;

method UserTable<TUser>.GetPasswordHash(userId: String): String;
begin
  var commandText: String := 'Select PasswordHash from Users where Id = @id';
  var parameters: Dictionary<String, Object> := new Dictionary<String, Object>();
  parameters.Add('@id', userId);
  var passHash := _database.GetStrValue(commandText, parameters);
  if String.IsNullOrEmpty(passHash) then begin
    exit nil;
  end;
  exit passHash;
end;

method UserTable<TUser>.SetPasswordHash(userId: String; passwordHash: String): Integer;
begin
  var commandText: String := 'Update Users set PasswordHash = @pwdHash where Id = @id';
  var parameters: Dictionary<String, Object> := new Dictionary<String, Object>();
  parameters.Add('@pwdHash', passwordHash);
  parameters.Add('@id', userId);
  exit _database.Execute(commandText, parameters);
end;

method UserTable<TUser>.GetSecurityStamp(userId: String): String;
begin
  var commandText: String := 'Select SecurityStamp from Users where Id = @id';
  var parameters: Dictionary<String, Object> := new Dictionary<String, Object>();
  parameters.Add('@id', userId);
  var &result := _database.GetStrValue(commandText, parameters);
  exit &result;
end;

method UserTable<TUser>.Insert(user: TUser): Integer;
begin
  var commandText: String := 'Insert into Users (UserName, Id, PasswordHash, SecurityStamp,Email,EmailConfirmed,PhoneNumber,PhoneNumberConfirmed, AccessFailedCount,LockoutEnabled,LockoutEndDateUtc,TwoFactorEnabled)'#13#10'                values (@name, @id, @pwdHash, @SecStamp,@email,@emailconfirmed,@phonenumber,@phonenumberconfirmed,@accesscount,@lockoutenabled,@lockoutenddate,@twofactorenabled)';
  var parameters: Dictionary<String, Object> := new Dictionary<String, Object>();
  parameters.Add('@name', user.UserName);
  parameters.Add('@id', user.Id);
  parameters.Add('@pwdHash', user.PasswordHash);
  parameters.Add('@SecStamp', user.SecurityStamp);
  parameters.Add('@email', user.Email);
  parameters.Add('@emailconfirmed', user.EmailConfirmed);
  parameters.Add('@phonenumber', user.PhoneNumber);
  parameters.Add('@phonenumberconfirmed', user.PhoneNumberConfirmed);
  parameters.Add('@accesscount', user.AccessFailedCount);
  parameters.Add('@lockoutenabled', user.LockoutEnabled);
  parameters.Add('@lockoutenddate', user.LockoutEndDateUtc);
  parameters.Add('@twofactorenabled', user.TwoFactorEnabled);
  exit _database.Execute(commandText, parameters);
end;

method UserTable<TUser>.Delete(userId: String): Integer;
begin
  var commandText: String := 'Delete from Users where Id = @userId';
  var parameters: Dictionary<String, Object> := new Dictionary<String, Object>();
  parameters.Add('@userId', userId);
  exit _database.Execute(commandText, parameters);
end;

method UserTable<TUser>.Delete(user: TUser): Integer;
begin
  exit Delete(user.Id);
end;

method UserTable<TUser>.Update(user: TUser): Integer;
begin
  var commandText: String := 'Update Users set UserName = @userName, PasswordHash = @pswHash, SecurityStamp = @secStamp, '#13#10'                Email=@email, EmailConfirmed=@emailconfirmed, PhoneNumber=@phonenumber, PhoneNumberConfirmed=@phonenumberconfirmed,'#13#10'                AccessFailedCount=@accesscount, LockoutEnabled=@lockoutenabled, LockoutEndDateUtc=@lockoutenddate, TwoFactorEnabled=@twofactorenabled  '#13#10'                WHERE Id = @userId';
  var parameters: Dictionary<String, Object> := new Dictionary<String, Object>();
  parameters.Add('@userName', user.UserName);
  parameters.Add('@pswHash', user.PasswordHash);
  parameters.Add('@secStamp', user.SecurityStamp);
  parameters.Add('@userId', user.Id);
  parameters.Add('@email', user.Email);
  parameters.Add('@emailconfirmed', user.EmailConfirmed);
  parameters.Add('@phonenumber', user.PhoneNumber);
  parameters.Add('@phonenumberconfirmed', user.PhoneNumberConfirmed);
  parameters.Add('@accesscount', user.AccessFailedCount);
  parameters.Add('@lockoutenabled', user.LockoutEnabled);
  parameters.Add('@lockoutenddate', user.LockoutEndDateUtc);
  parameters.Add('@twofactorenabled', user.TwoFactorEnabled);
  exit _database.Execute(commandText, parameters);
end;

end.
