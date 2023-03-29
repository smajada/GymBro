import psycopg2

conn = None
try:
	# connect to the PostgreSQL server
	conn = psycopg2.connect(
		host='localhost',
		dbname='GymBro',
		user='postgres',
		password='1234', # insert the password of PgAdmin
		port=5432
	)

	# Creating a cursor with name cur.
	cur = conn.cursor()

	cur.execute(
		"CREATE TABLE blob_datastore (s_no serial, file_name VARCHAR ( 20 ), blob_data bytea)")
	# SQL query to insert data into the database.

	insert_script = '''
		INSERT INTO blob_datastore(s_no,file_name,blob_data) VALUES (%s,%s,%s);
	'''

	# open('File,'rb').read() is used to read the file.
	# where open(File,'rb').read() will return the binary data of the file.
	# psycopg2.Binary(File_in_Bytes) is used to convert the binary data to a BLOB data type.

	BLOB_2 = psycopg2.Binary(
		open('imgs/man-1.jpg', 'rb').read())	 # Image

	# And Finally we pass the above mentioned values to the insert_script variable.
	insert_values = [(2, 'Octa.jpg', BLOB_2)]

	# The execute() method with the insert_script & insert_value as argument.
	for insert_value in insert_values:
		cur.execute(insert_script, insert_value)
		print(insert_value[0], insert_value[1],
			"[Binary Data]", "row Inserted Successfully")
		
	# Close the connection
	cur.close()

except(Exception, psycopg2.DatabaseError) as error:
	print(error)
finally:
	if conn is not None:
		
		# Commit the changes to the database
		conn.commit()