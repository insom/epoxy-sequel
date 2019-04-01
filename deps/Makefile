default: mariadb_client sqlite3
.PHONY: default

mariadb-client-library/mariadb_client/include/my_config.h:
	cd mariadb-client-library && rm -rf mariadb-connector-c-2.3.1
	cd mariadb-client-library && tar -zxf mariadb-connector-c-2.3.1-src.tar.gz
	cd mariadb-client-library/mariadb_client && cmake .
	cd mariadb-client-library/mariadb_client && patch libmariadb/libmariadb.c < ../libmariadb.c.patch
	cd mariadb-client-library/mariadb_client && patch libmariadb/net.c < ../net.c.patch
	cd mariadb-client-library/mariadb_client && patch libmariadb/mysql_async.c < ../mysql_async.c.patch
	cd mariadb-client-library/mariadb_client && patch libmariadb/password.c < ../password.c.patch
	cd mariadb-client-library/mariadb_client && patch include/mysql_com.h < ../mysql_com.h.patch
	cd mariadb-client-library/mariadb_client && patch include/mysql.h < ../mysql.h.patch
	cd mariadb-client-library/mariadb_client && patch libmariadb/my_alloc.c < ../my_alloc.c.patch
	cd mariadb-client-library/mariadb_client && patch libmariadb/my_charset.c < ../my_charset.c.patch
	cd mariadb-client-library/mariadb_client && patch libmariadb/my_stmt.c < ../my_stmt.c.patch
	cd mariadb-client-library/mariadb_client && patch libmariadb/my_stmt_codec.c < ../my_stmt_codec.c.patch
	cd mariadb-client-library/mariadb_client && CC=${CC} CXX=${CXX} ${MAKE}

mariadb_client: mariadb-client-library/mariadb_client/include/my_config.h

sqlite3/sqlite3/sqlite3.o:
	cd sqlite3 && rm -rf sqlite-amalgamation-3190200
	cd sqlite3 && tar -zxf sqlite-amalgamation-3190200.tar.gz
	cd sqlite3/sqlite3 && patch sqlite3.c < ../from_unixtime.patch
	cd sqlite3/sqlite3 && ${CC} ${MYCFLAGS} -c -o sqlite3.o sqlite3.c -DSQLITE_ENABLE_MEMORY_MANAGEMENT

sqlite3: sqlite3/sqlite3/sqlite3.o

cleanpart:
	cd mariadb-client-library && rm -rf mariadb-connector-c-2.3.1
	cd sqlite3/sqlite3 && rm -rf *
.PHONY: cleanpart

cleanall:
	cd mariadb-client-library && rm -rf mariadb-connector-c-2.3.1
	cd sqlite3/sqlite3 && rm -rf * || true
.PHONY: cleanall

