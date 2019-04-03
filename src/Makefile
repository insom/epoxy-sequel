DEPS_PATH=../deps
MARIADB_PATH=$(DEPS_PATH)/mariadb-client-library/mariadb_client
MARIADB_IDIR=$(MARIADB_PATH)/include
MARIADB_LDIR=$(MARIADB_PATH)/libmariadb
SQLITE3_DIR=$(DEPS_PATH)/sqlite3/sqlite3

GIT_VERSION := $(shell git describe --long --tags)
IDIRS=-I../include -I$(MARIADB_IDIR) -I$(SQLITE3_DIR) -I/usr/include/luajit-2.1/
LDIRS=-L$(MARIADB_LDIR)
MYLIBS=-Wl,--export-dynamic -lconfig -ldaemon -ljemalloc -lconfig++ -lre2 -lpcrecpp -lpcre -lmariadbclient -Wl,-Bdynamic -lpthread -lm -lz -lrt -lcrypto -lssl -ldl -lluajit-5.1 $(EXTRALINK)
MYCFLAGS=$(IDIRS) $(OPTZ) $(DEBUG) -Wall -DGITVERSION=\"$(GIT_VERSION)\" $(NOJEM)
MYCXXFLAGS=-std=c++11 $(MYCFLAGS)

ODIR= obj

EXECUTABLE=proxysql

_OBJ = main.o proxysql_global.o c_tokenizer.o
OBJ = $(patsubst %,$(ODIR)/%,$(_OBJ))
_OBJ_CXX = ProxySQL_GloVars.oo network.oo debug.oo configfile.oo Query_Cache.oo SpookyV2.oo MySQL_Authentication.oo gen_utils.oo sqlite3db.oo mysql_connection.oo MySQL_HostGroups_Manager.oo mysql_data_stream.oo MySQL_Thread.oo MySQL_Session.oo MySQL_Protocol.oo mysql_backend.oo Query_Processor.oo ProxySQL_Admin.oo MySQL_Monitor.oo MySQL_Logger.oo thread.oo MySQL_PreparedStatement.oo SQLite3_Server.oo ProxySQL_Statistics.oo
OBJ_CXX = $(patsubst %,$(ODIR)/%,$(_OBJ_CXX))

default: $(EXECUTABLE)

proxysql: $(ODIR) $(OBJ) $(OBJ_CXX)
	$(CXX) -o $@ $(SQLITE3_DIR)/sqlite3.o $(OBJ) $(OBJ_CXX) $(MYCXXFLAGS) $(CXXFLAGS) $(LDIRS) $(LIBS) $(LDFLAGS) $(MYLIBS)

$(ODIR):
	mkdir $(ODIR)

%.ko: %.cpp
	$(CXX) -fPIC -c -o $@ $< $(MYCXXFLAGS) $(CXXFLAGS)

$(ODIR)/%.o: %.c
	$(CC) -fPIC -c -o $@ $< $(MYCFLAGS) $(CFLAGS)

$(ODIR)/%.o: %.cpp
	$(CXX) -c -o $@ $< $(MYCXXFLAGS) $(CXXFLAGS)

$(ODIR)/%.oo: %.cpp
	$(CXX) -fPIC -c -o $@ $< $(MYCXXFLAGS) $(CXXFLAGS)

clean:
	rm -f *.pid $(ODIR)/*.o *~ core $(EXECUTABLE)
