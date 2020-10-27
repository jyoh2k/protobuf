LDFLAGS = -L/usr/local/lib `pkg-config --libs protobuf`\
		  -ldl

CXX = g++
CPPFLAGS += `pkg-config --cflags protobuf`
CXXFLAGS += -std=c++11

TARGET = addressbook
OBJS = addressbook.pb.o addressbook.o

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CXX) $^ $(LDFLAGS) -o $@

%.pb.cc: %.proto
	protoc --cpp_out=. $<

clean:
	rm -f *.pb.* $(OBJS) $(TARGET)

