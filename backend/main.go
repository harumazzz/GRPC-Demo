package main

import (
	pb "interview_app/greeter"
	"log"
	"net"

	"golang.org/x/net/context"
	"google.golang.org/grpc"
)

type Server struct {
	pb.GreeterServer
}

func (s *Server) SayHello(ctx context.Context, in *pb.HelloRequest) (*pb.HelloResponse, error) {
	log.Println("Received: " + in.Message)
	return &pb.HelloResponse{Message: "Hello, " + in.Message}, nil
}

func main() {
	lis, err := net.Listen("tcp", ":50051")
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}
	grpcServer := grpc.NewServer()
	pb.RegisterGreeterServer(grpcServer, &Server{})
	log.Println("Server is running on port 50051...")
	if err := grpcServer.Serve(lis); err != nil {
		log.Fatalf("failed to serve: %v", err)
	}
}
