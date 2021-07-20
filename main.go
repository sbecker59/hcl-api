package main

import (
	"fmt"
	"io/ioutil"
	"log"
	"net/http"

	"github.com/hashicorp/hcl2/hclwrite"
	muxtrace "gopkg.in/DataDog/dd-trace-go.v1/contrib/gorilla/mux"
	"gopkg.in/DataDog/dd-trace-go.v1/ddtrace/tracer"
)

func homePage(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Welcome to the HCL Format !")
}

func format(w http.ResponseWriter, r *http.Request) {
	in, _ := ioutil.ReadAll(r.Body)
	fmt.Fprintf(w, string(hclwrite.Format([]byte(in))))
}

func handleRequests() {

	myRouter := muxtrace.NewRouter().StrictSlash(true)
	myRouter.HandleFunc("/", homePage)
	myRouter.HandleFunc("/format", format).Methods("POST")

	if err := http.ListenAndServe(":3000", myRouter); err != nil {
		log.Fatal(err)
	}
}

func main() {
	tracer.Start()
	defer tracer.Stop()

	handleRequests()
}
