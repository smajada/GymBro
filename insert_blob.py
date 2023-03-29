import psycopg2

conn = None
try:
	# connect to the PostgreSQL server
	conn = psycopg2.connect(
		host='localhost',
		dbname='GymBro',
		user='postgres',
		password='1234', #insert the password of PgAdmin
		port=5432
	)

	# Creating a cursor with name cur.
	cur = conn.cursor()
	cur.execute(
		"UPDATE courses SET published_date = '2020-08-01' WHERE course_id = 3;")
	# SQL query to insert data into the database.
	insert_script = '''
		INSERT INTO blob_datastore(s_no,file_name,blob_data) VALUES (%s,%s,%s);
	'''

	# open('File,'rb').read() is used to read the file.
	# where open(File,'rb').read() will return the binary data of the file.
	# psycopg2.Binary(File_in_Bytes) is used to convert the binary data to a BLOB data type.

	BLOB_1 = psycopg2.Binary(
		open('imgs/man-1.jpg', 'rb').read())	 # Image
	BLOB_2 = psycopg2.Binary(
		open('imgs/man-2.jpg', 'rb').read())	 # Image
	BLOB_3 = psycopg2.Binary(
		open('imgs/woman-3.jpg', 'rb').read())	 # Image
	BLOB_4 = psycopg2.Binary(
		open('imgs/woman-4.jpg', 'rb').read())	 # Image

	# And Finally we pass the above mentioned values to the insert_script variable.
	insert_values = [(2, 'man-2.jpg', BLOB_2), (1, 'man-1.jpg', BLOB_1), (3, 'woman-3.jpg', BLOB_3), (4, 'woman-4.jpg', BLOB_4)]

	# The execute() method with the insert_script & insert_value as argument.
	for insert_value in insert_values:
		cur.execute(insert_script, insert_value)
		print(insert_value[0], insert_value[1],
			"[Binary Data]", "row Inserted Successfully")

	# SQL query to fetch data from the database.
	cur.execute('SELECT * FROM BLOB_DataStore')

	# open(file,'wb').write() is used to write the binary data to the file.
	for row in cur.fetchall():
		BLOB = row[2]
		open("new"+row[1], 'wb').write(BLOB)
		print(row[0], row[1], "BLOB Data is saved in Current Directory")

	# Close the connection
	cur.close()

except(Exception, psycopg2.DatabaseError) as error:
	print(error)
finally:
	if conn is not None:
		
		# Commit the changes to the database
		conn.commit()