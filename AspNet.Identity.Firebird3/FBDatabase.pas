namespace AspNet.Identity.Firebird3;

interface

uses
  FirebirdSql.Data.FirebirdClient,
  System,
  System.Collections.Generic,
  System.Configuration,
  System.Data,
  System.Threading;

type
  /// <summary>
  /// Class that encapsulates a FirebirdSQL Database connections
  /// and CRUD operations
  /// </summary>
  FBDatabase = public class(IDisposable)  //todo connection pool and cache fabric
  private
    var _connectionstring : String;
  public
    /// Default constructor which uses the "DefaultConnection" connectionString
    /// </summary>
    constructor;
    /// <summary>
    /// Constructor which takes the connection string name
    /// </summary>
    /// <param name="connectionStringName"></param>
    constructor(connectionStringName: String);
    /// <summary>
    /// Executes a non-query FBDatabase statement
    /// </summary>
    /// <param name="commandText">The FBDatabase query to execute</param>
    /// <param name="parameters">Optional parameters to pass to the query</param>
    /// <returns>The count of records affected by the FBDatabase statement</returns>
  public
    /// <summary>
    /// Helper method to return query a string value
    /// </summary>
    /// <param name="commandText">The FBDatabase query to execute</param>
    /// <param name="parameters">Parameters to pass to the FBDatabase query</param>
    /// <returns>The string value resulting from the query</returns>
    property connectionString :String read _connectionstring; 

    method Dispose;
  end;

implementation

constructor FBDatabase;
begin
    _connectionstring := ConfigurationManager.ConnectionStrings['DefaultConnection'].ConnectionString;

end;

constructor FBDatabase(connectionStringName: String);
begin
  _connectionstring := ConfigurationManager.ConnectionStrings[connectionStringName].ConnectionString;

end;






method FBDatabase.Dispose;
begin
end;



end.
