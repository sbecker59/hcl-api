package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"net/http"

	"github.com/gorilla/mux"
	"github.com/hashicorp/hcl/v2/hclwrite"
)

func homePage(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Welcome to the HCL Format !")
}

func format(w http.ResponseWriter, r *http.Request) {
	in, _ := ioutil.ReadAll(r.Body)
	fmt.Fprintf(w, string(hclwrite.Format([]byte(in))))
}

func handleRequests() {

	myRouter := mux.NewRouter().StrictSlash(true)
	myRouter.HandleFunc("/", homePage)
	myRouter.HandleFunc("/format", format).Methods("POST")

	if err := http.ListenAndServe(":3000", myRouter); err != nil {
		log.Fatal(err)
	}
}

func main() {
	handleRequests()
}
