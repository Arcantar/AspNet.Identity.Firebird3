namespace AspNet.Identity.Firebird3;

interface

uses
  Microsoft.AspNet.Identity,
  System;

type
  /// <summary>
  /// Class that implements the ASP.NET Identity
  /// IRole interface
  /// </summary>
  IdentityRole = public class(IRole)
  public
    /// <summary>
    /// Role ID
    /// </summary>
    property Id: String;
    /// <summary>
    /// Role name
    /// </summary>
    property Name: String;
    /// <summary>
    /// Default constructor for Role
    /// </summary>
    constructor;
    /// <summary>
    /// Constructor that takes names as argument
    /// </summary>
    /// <param name="name"></param>
    constructor(name: String);
    constructor(name: String; id: String);
  end;

implementation

constructor IdentityRole;
begin
  Id := Guid.NewGuid().ToString();
end;

constructor IdentityRole(name: String);
begin
  name := name;
end;

constructor IdentityRole(name: String; id: String);
begin
  name := name;
  id := id;
end;








end.



namespace ;

interface

type
  IdentityUser = public class(IUser)
  public
    /// <summary>
    /// User ID
    /// </summary>
    property Id: String;
    /// <summary>
    /// User's name
    /// </summary>
    property UserName: String;
    /// <summary>
    /// Email
    /// </summary>
    property Email: String;
    /// <summary>
    /// True if the email is confirmed, default is false
    /// </summary>
    property EmailConfirmed: Boolean;
    /// <summary>
    /// The salted/hashed form of the user password
    /// </summary>
    property PasswordHash: String;
    /// <summary>
    /// A random value that should change whenever a users credentials have changed (password changed, login removed)
    /// </summary>
    property SecurityStamp: String;
    /// <summary>
    /// PhoneNumber for the user
    /// </summary>
    property PhoneNumber: String;
    /// <summary>
    /// True if the phone number is confirmed, default is false
    /// </summary>
    property PhoneNumberConfirmed: Boolean;
    /// <summary>
    /// Is two factor enabled for the user
    /// </summary>
    property TwoFactorEnabled: Boolean;
    /// <summary>
    /// DateTime in UTC when lockout ends, any time in the past is considered not locked out.
    /// </summary>
    property LockoutEndDateUtc: DateTime;
    /// <summary>
    /// Is lockout enabled for this user
    /// </summary>
    property LockoutEnabled: Boolean;
    /// <summary>
    /// Used to record failures for the purposes of lockout
    /// </summary>
    property AccessFailedCount: Integer;
    /// <summary>
    /// Default constructor
    /// </summary>
    constructor;
    /// <summary>
    /// Constructor that takes user name as argument
    /// </summary>
    /// <param name="userName"></param>
    constructor(userName: String);
  end;

implementation

constructor IdentityUser;
begin
  Id := Guid.NewGuid().ToString();
end;

constructor IdentityUser(userName: String);
begin
  UserName := userName;
end;

end.
