package utilities

import (
	"bytes"
	"encoding/json"
	"fmt"
	"io"
	"io/ioutil"
	"net/http"

	"github.com/astaxie/beego"
)

type BaseHTTPResponseModel struct {
	Data    interface{}
	Status  bool
	Message string
}

func MakeHTTPCall(dataToPost interface{}, relativeUrl string, httpVerb string) (BaseHTTPResponseModel, error) {
	dataToPostReader := convertInterfaceToReader(dataToPost)

	client := &http.Client{}
	req, err := http.NewRequest(httpVerb, beego.AppConfig.String("externalApiBaseUrl")+relativeUrl, dataToPostReader)
	if err != nil {
		return BaseHTTPResponseModel{}, err
	}

	prepareHTTPHeader(req)

	resp, err := client.Do(req)
	if err != nil {
		return BaseHTTPResponseModel{}, err
	}

	defer resp.Body.Close()
	responseBodyBytes, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		return BaseHTTPResponseModel{}, err
	}

	responseBodyString := string(responseBodyBytes)
	fianlResponse, err := HTTPResponseProcessor(responseBodyString)
	if err != nil {
		return BaseHTTPResponseModel{}, err
	}

	return fianlResponse, nil
}

func MakeHTTPGet(relativeUrl string) (BaseHTTPResponseModel, error) {
	client := &http.Client{}
	req, err := http.NewRequest("GET", beego.AppConfig.String("externalApiBaseUrl")+relativeUrl, nil)
	if err != nil {
		return BaseHTTPResponseModel{}, err
	}

	prepareHTTPHeader(req)

	resp, err := client.Do(req)
	if err != nil {
		return BaseHTTPResponseModel{}, err
	}
	if resp.StatusCode == 401 {
		return BaseHTTPResponseModel{Status: false}, nil
	}

	defer resp.Body.Close()
	responseBodyBytes, err := ioutil.ReadAll(resp.Body)
	if err != nil {
		return BaseHTTPResponseModel{}, err
	}

	responseBodyString := string(responseBodyBytes)
	return HTTPResponseProcessor(responseBodyString)
}

func prepareHTTPHeader(request *http.Request) *http.Request {
	request.Header.Add("Authorization", "Bearer "+beego.AppConfig.String("PaystackTestSecretKey"))
	request.Header.Add("Content-Type", "application/json")
	return request
}

func HTTPResponseProcessor(httpResponseValue string) (BaseHTTPResponseModel, error) {
	if len(httpResponseValue) <= 0 {
		return BaseHTTPResponseModel{}, nil
	}
	var extractedResponse map[string]interface{}

	err := json.Unmarshal([]byte(httpResponseValue), &extractedResponse)
	if err != nil {
		return BaseHTTPResponseModel{}, err
	}
	fmt.Println(extractedResponse)

	dataToReturn := BaseHTTPResponseModel{
		Data:    extractedResponse["data"],
		Status:  (extractedResponse["status"]).(bool),
		Message: (extractedResponse["message"]).(string)}

	return dataToReturn, nil
}

func convertInterfaceToReader(input interface{}) io.Reader {
	dataToPostBytes, _ := json.Marshal(input)
	return bytes.NewReader(dataToPostBytes)
}
