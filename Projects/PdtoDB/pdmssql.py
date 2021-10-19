# framework writer @AhmetFurkanDEMIR

import pandas as pd
import numpy as np
import os

class PdMSSQL():

	def __init__(self, conn, cur, fast_executemany, dataCSV, tableName):

		self.clearConsole = lambda: os.system('cls' if os.name in ('nt', 'dos') else 'clear')
		self.clearConsole ()

		# variables
		self.conn = conn
		self.cur = cur

		if fast_executemany == True:

			self.cur.fast_executemany = True

		self.dataCSV=dataCSV
		self.tableName = tableName

		# Function to write .csv file to database
		self.writeDatabase()

	# data type of columns in table
	# **Edit this function according to your own datatypes.**
	def dataTypes(self, dataTyp):

		# dataTyp : data type of incoming column


		if dataTyp == np.float64:

			return "FLOAT"

		elif dataTyp == np.int64:

			return "INT"

		else:

			return "Text"

	def writeDatabase(self):

		# We delete unwanted characters in columns
		self.dataCSV.columns = self.dataCSV.columns.str.translate({ord('/'): None})
		self.dataCSV.columns = self.dataCSV.columns.str.translate({ord(' '): None})
		self.dataCSV.columns = self.dataCSV.columns.str.translate({ord('-'): None})
		self.dataCSV.columns = self.dataCSV.columns.str.translate({ord('.'): None})
		self.dataCSV.columns = self.dataCSV.columns.str.translate({ord('!'): None})
		self.dataCSV.columns = self.dataCSV.columns.str.translate({ord('\''): None})
		self.dataCSV.columns = self.dataCSV.columns.str.translate({ord('?'): None})
		self.dataCSV.columns = self.dataCSV.columns.str.translate({ord('='): None})
		self.dataCSV.columns = self.dataCSV.columns.str.translate({ord(','): None})

		# Columns and data types of columns to be used when creating a table in the database
		columns = list(self.dataCSV.columns)
		dtypes = self.dataCSV.dtypes

		# The command that will be used to create the table in the database 
		SqlCommand = "CREATE TABLE {}(".format(self.tableName)

		# The command skeleton to be used to write the data to the table
		SqlCommandInsert = "INSERT INTO {} VALUES(".format(self.tableName)

		# The loop I use to complete the SQL commands
		for i in range(0,len(columns)):

			if i!=0:

				SqlCommand+=","
				SqlCommandInsert+=","

			SqlCommand+="\n\t{} {}".format(columns[i], self.dataTypes(dtypes[i]))
			SqlCommandInsert+="?"

		SqlCommand+=");"
		SqlCommandInsert+=");"

		self.clearConsole()
		# SQL Querys
		print("\n",SqlCommand)
		print("\n",SqlCommandInsert)

		flag = input("\n\n Do you approve the above commands to be run in the table? (Y/y), (N/n) :")

		if flag=="Y" or flag=="y":

			pass

		else:

			quit()

		# The process of creating the table in the database
		try:

			self.cur.executemany(SqlCommand,[()])
			self.conn.commit()

		except:

			self.clearConsole()
			print("There is already a table in the current name, please change the table name to be created or delete the existing table.")
			quit()


		self.clearConsole()
		# For loop (INSERT) where data, ie rows, are written to the database
		for count, row in enumerate(self.dataCSV.iterrows()):

			data = []
			for i in row[1]:

				if str(i)=="nan":

					i = None

				data.append(i)

			dataTuple = tuple(data)

			try:
				
				self.cur.executemany(SqlCommandInsert,[dataTuple])
				self.conn.commit()

				print(str(count)+" line write operation SUCCESSFUL")

			except:

				print(str(count)+" line write operation WRONG")

