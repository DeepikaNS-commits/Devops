package main

import "fmt"
import "net/http"
import "log"

func handler(w http.ResponseWriter, r *http.Request) {
    fmt.Fprintf(w, "Hello from Docker!")
    fmt.Println("Received request:", r.URL.Path)
    log.Println("Server starting on :8080")
}

func main() {
    fmt.Println("Starting server on :8080")
    http.HandleFunc("/", handler)
    if err := http.ListenAndServe(":8080", nil); err != nil {
        fmt.Println("Error:", err)
    }
}
