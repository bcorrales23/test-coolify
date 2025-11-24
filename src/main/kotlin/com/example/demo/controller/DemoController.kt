package com.example.demo.controller

import org.springframework.beans.factory.annotation.Value
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RestController

@RestController
class DemoController {
    @Value("\${app.random_key}")
    lateinit var randomKey: String
    @Value("\${app.secret_key}")
    lateinit var secretKey: String
    @Value("\${app.secret_var}")
    lateinit var secretVar: String

    @GetMapping("/")
    fun helloWorld(): String {
        return "hello world: $randomKey | $secretKey | $secretVar"
    }
}