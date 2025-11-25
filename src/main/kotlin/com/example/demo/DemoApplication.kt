package com.example.demo

import org.slf4j.LoggerFactory
import org.springframework.beans.factory.annotation.Value
import org.springframework.boot.CommandLineRunner
import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication

@SpringBootApplication
class DemoApplication (

): CommandLineRunner {
    @Value("\${app.random_key}")
    lateinit var randomKey: String
    @Value("\${app.secret_key}")
    lateinit var secretKey: String
    @Value("\${app.secret_var}")
    lateinit var secretVar: String
    private val logger = LoggerFactory.getLogger(this::class.java)
    override fun run(vararg args: String) {
        logger.info("RANDOM_KEY: $randomKey")
        logger.info("SECRET_KEY: $secretKey")
        logger.info("SECRET_VAR: $secretVar")
    }

}

fun main(args: Array<String>) {
    runApplication<DemoApplication>(*args)
}
