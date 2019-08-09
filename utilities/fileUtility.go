package utilities

import (
	"fmt"
	"io/ioutil"
	"log"
	"os"
)

func ReadFileContent(filepath string) string {
	if fileExists(filepath) {
		fileBytes, err := ioutil.ReadFile(filepath)
		if err != nil {
			log.Fatal("Failed to read file: " + filepath + "\nError: " + err.Error())
			return convertFileBytesToString(make([]byte, 0))
		}
		return convertFileBytesToString(fileBytes)
	} else {
		return convertFileBytesToString(make([]byte, 0))
	}
}

func WriteTextToFile(filepath, filecontent string) {
	if fileExists(filepath) {
		file, err := os.OpenFile(filepath, os.O_RDWR, 0644)
		if err != nil {
			fmt.Println(err)
			return
		}
		defer file.Close()

		file.Truncate(0)
		file.Seek(0, 0)
		_, err = file.WriteString(filecontent)
		if err != nil {
			fmt.Println(err)
			return
		}

		err = file.Sync()
		if err != nil {
			fmt.Println(err)
			return
		}
	}
}

func convertFileBytesToString(fileBytes []byte) string {
	return string(fileBytes)
}

func fileExists(filepath string) bool {
	fileInfo, err := os.Stat(filepath)
	if os.IsNotExist(err) {
		file, createFileErr := os.Create(filepath)
		if createFileErr != nil {
			fmt.Println(createFileErr)
			return false
		}
		defer file.Close()
		WriteTextToFile(filepath, "true")
		return true
	}
	return !fileInfo.IsDir()
}
