![](https://img.shields.io/badge/microsoft%20azure-0089D6?style=for-the-badge&logo=microsoft-azure&logoColor=white) ![](https://img.shields.io/badge/Microsoft_SQL_Server-CC2927?style=for-the-badge&logo=microsoft-sql-server&logoColor=white)

# Running Microsoft SQL Server in Azure and connecting from personal computer

We will set up a low-scale machine on Azure and install Microsoft SQL Server on this machine, then we will connect to this SQL server remotely.

* 1-) By following this documentation, install an ubuntu server 20.04 machine with at least 3 gb ram. [Documentation, Create a Linux virtual machine in the Azure portal](https://docs.microsoft.com/en-us/azure/virtual-machines/linux/quick-create-portal)

* 2-) After these operations, you need to connect to the machine via SSH connection or Azure, you need to install Microsoft SQL server on the machine, you can install SQL server in a simple way by following the document below. [Documentation, Install SQL Server and create a database on Ubuntu](https://docs.microsoft.com/en-us/sql/linux/quickstart-install-connect-ubuntu?view=sql-server-ver15)

* 3-) If you have completed the SQL server installation process, now we need to make the connection port for SQL server public on our machine. If you do the operations in the picture below, the 1433 port, that is, the Microsoft SQL port, will become active on your machine, which means that a remote computer can be connected to this SQL server.
 ![Screenshot_2021-10-22_11-07-17](https://user-images.githubusercontent.com/54184905/138418363-4fe38312-b6f6-425b-ae30-e665a34960f6.png)

* 4-) Connect to SQL server via Azure Data Studio or DBeaver as in the picture below. Server: PublicIP, User Name: SA, Password: SQL Server Password, Remember Password: True
 
 ![Screenshot_2021-10-22_11-19-39](https://user-images.githubusercontent.com/54184905/138420247-4f9d9a4e-c9db-4d56-a6c6-3194c9ad9abb.png)
 ![Screenshot_2021-10-22_11-20-20](https://user-images.githubusercontent.com/54184905/138420452-d3a1436d-e2cf-4cbe-9986-0c88a23a8327.png)



