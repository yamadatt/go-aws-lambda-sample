package main

import (
	"context"
	"fmt"
	"log"

	"github.com/aws/aws-lambda-go/lambda"
	"github.com/aws/aws-sdk-go/aws"
	"github.com/aws/aws-sdk-go/aws/session"
	"github.com/aws/aws-sdk-go/service/s3"
)

type MyEvent struct {
	Name string `json:"name"`
}

type Response struct {
	Response string `json:"response"`
}

func Handler(ctx context.Context, event MyEvent) (Response, error) {
	msg := fmt.Sprintf("Welcome %s", event.Name)
	log.Println(msg)
	response := Response{
		Response: msg,
	}

	return response, nil
}

func main() {

	// lambda.Start(Handler)
	lambda.Start(hello)
}

func hello() (string, error) {
	sess, err := session.NewSession(&aws.Config{
		Region: aws.String("ap-northeast-1")},
	)

	// Create S3 service client
	svc := s3.New(sess)

	result, err := svc.ListBuckets(&s3.ListBucketsInput{})
	if err != nil {
		log.Println("Failed to list buckets", err)
		return "err", nil
	}

	log.Println("Buckets:")

	for _, bucket := range result.Buckets {
		log.Printf("%s : %s\n", aws.StringValue(bucket.Name), bucket.CreationDate)
	}

	return "Hello World!201805", nil
}
