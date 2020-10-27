LDFLAGS = -L/usr/local/lib `pkg-config --libs protobuf grpc++`\
					-lgrpc++_reflection\
					-ldl -framework CoreFoundation

CXX = g++
CPPFLAGS += `pkg-config --cflags protobuf grpc`
CXXFLAGS += -std=c++11

TARGET = addressbook
OBJS = addressbook.o addressbook.pb.o

GRPC_CPP_PLUGIN = grpc_cpp_plugin
GRPC_CPP_PLUGIN_PATH ?= `which $(GRPC_CPP_PLUGIN)`

all: $(TARGET)

$(TARGET): $(OBJS)
	@echo "Creating Archive $(TARGET) ..."
	$(CXX) $^ $(LDFLAGS) -o $@

#%.grpc.pb.cc: %.proto
#	protoc --grpc_out=. --plugin=protoc-gen-grpc=$(GRPC_CPP_PLUGIN_PATH) $<

%.pb.cc: %.proto
	protoc --cpp_out=. $<

clean:
	rm -f *.pb.* $(OBJS) $(TARGET)

