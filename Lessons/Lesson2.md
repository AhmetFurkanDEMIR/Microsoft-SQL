# Microsoft SQL Data Types

In SQL Server, each column, local variable, expression, and parameter has a related data type. A data type is an attribute that specifies the type of data that the object can hold: integer data, character data, monetary data, date and time data, binary strings, and so on.


|   Data type categories    | 
|---------------------------|
|  Exact numerics           |
| Approximate numerics      | 
| Date and time             |
| Character strings         |
| Unicode character strings |
| Binary strings            |
| Other data types          |

**Exact numerics**

|   Data type     | Explanation  |
|------------|--------------|
|  bigint           | Storage:8 Bytes, The bigint data type is intended for use when integer values might exceed the range that is supported by the int data type.     |
| int      | Storage:4 Bytes ,The int data type is the primary integer data type in SQL Server. |
| numeric           | Numeric data types that have fixed precision and scale. Decimal and numeric are synonyms and can be used interchangeably. |
| bit         | An integer data type that can take a value of 1, 0, or NULL. |
| decimal | An exact fixed-point number. The total number of digits is specified in size. The number of digits after the decimal point is specified in the d parameter. The maximum number for size is 65. The maximum number for d is 30. The default value for size is 10. The default value for d is 0. |
| money            | Storage:8 bytes, The money and smallmoney data types are accurate to a ten-thousandth of the monetary units that they represent. For Informatica, the money and smallmoney data types are accurate to a one-hundredth of the monetary units that they represent.|
| smallmoney          | Storage:4 bytes |
| smallint          | Storage:2 Bytes, -2^15 (-32,768) to 2^15-1 (32,767) |
| tinyint        | Storage:1 Bytes, 0 to 255|

**Approximate numerics**

|   Data type     | Explanation  |
|------------|--------------|
|  float           | Storge:Depends on the value of n, Approximate-number data types for use with floating point numeric data. Floating point data is approximate; therefore, not all values in the data type range can be represented exactly. The ISO synonym for real is float(24).     |
| real | Storage:4 Bytes |

**Date and time**

|   Data type     | Explanation  |
|------------|--------------|
|  date           | Storage: 3 bytes, A date. Format: YYYY-MM-DD. The supported range is from '1000-01-01' to '9999-12-31'     |
| datetime     | Storage: 8 bytes, A date and time combination. Format: YYYY-MM-DD hh:mm:ss. The supported range is from '1000-01-01 00:00:00' to '9999-12-31 23:59:59'. Adding DEFAULT and ON UPDATE in the column definition to get automatic initialization and updating to the current date and time |
| datetime2           | Storage: 6-8 bytes, From January 1, 0001 to December 31, 9999 with an accuracy of 100 nanoseconds |
| datetimeoffset       | Storage: 8-10 bytes, The same as datetime2 with the addition of a time zone offset |
| smalldatetime | Storage: 4 bytes, From January 1, 1900 to June 6, 2079 with an accuracy of 1 minute |
| time | Storage: 3-5 bytes, Store a time only to an accuracy of 100 nanoseconds |

**Character strings**

|   Data type     | Explanation  |
|------------|--------------|
|  char           |  	A FIXED length string (can contain letters, numbers, and special characters). The size parameter specifies the column length in characters - can be from 0 to 255. Default is 1     |
| varchar      | A VARIABLE length string (can contain letters, numbers, and special characters). The size parameter specifies the maximum column length in characters - can be from 0 to 65535 |
| text          | Holds a string with a maximum length of 65,535 bytes |

**Unicode character strings**

|   Data type     | Explanation  |
|------------|--------------|
|  nchar           |  	Fixed width Unicode string, 4.000 characters, 	Defined width x 2     |
| nvarchar      | Variable width Unicode string, 4.000 characters |
| ntext          | Variable width Unicode string, 2GB of text data |

**Binary strings**

|   Data type     | Explanation  |
|------------|--------------|
|  binary           | Fixed width binary string, 8.000 bytes     |
| varbinary     |  	Variable width binary string, 8.000 bytes |
| image           | Variable width binary string, 2GB |

**Other data types**

|   Data type     | Explanation  |
|------------|--------------|
|  cursor           | Stores a reference to a cursor used for database operations   |
| hierarchyid      | The hierarchyid data type is a variable length, system data type. Use hierarchyid to represent position in a hierarchy. A column of type hierarchyid does not automatically represent a tree. It is up to the application to generate and assign hierarchyid values in such a way that the desired relationship between rows is reflected in the values.  |
| sql_variant    | Stores up to 8,000 bytes of data of various data types, except text, ntext, and timestamp |
| Spatial Geometry Types         | The planar spatial data type, geometry, is implemented as a common language runtime (CLR) data type in SQL Server. This type represents data in a Euclidean (flat) coordinate system. SQL Server supports a set of methods for the geometry spatial data type. These methods include methods on geometry that are defined by the Open Geospatial Consortium (OGC) standard and a set of Microsoft extensions to that standard. |
| table | Stores a result-set for later processing |
| rowversion           | Is a data type that exposes automatically generated, unique binary numbers within a database. rowversion is generally used as a mechanism for version-stamping table rows. The storage size is 8 bytes. The rowversion data type is just an incrementing number and does not preserve a date or a time. To record a date or time, use a datetime2 data type. |
| uniqueidentifier  | Stores a globally unique identifier (GUID) |
| xml          | Stores XML formatted data. Maximum 2GB |
| Spatial Geography Types       | The geography spatial data type, geography, is implemented as a .NET common language runtime (CLR) data type in SQL Server. This type represents data in a round-earth coordinate system. The SQL Server geography data type stores ellipsoidal (round-earth) data, such as GPS latitude and longitude coordinates.|

**Resources**

* https://docs.microsoft.com/en-us/sql/t-sql/data-types/data-types-transact-sql?view=sql-server-ver15

* https://www.w3schools.com/sql/sql_datatypes.asp


