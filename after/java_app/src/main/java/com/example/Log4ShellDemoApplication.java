package com.example;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.*;
import org.apache.logging.log4j.Logger;
import org.apache.logging.log4j.LogManager;

@SpringBootApplication
@RestController
public class Log4ShellDemoApplication {

    private static final Logger logger = LogManager.getLogger(Log4ShellDemoApplication.class);

    public static void main(String[] args) {
        SpringApplication.run(Log4ShellDemoApplication.class, args);
    }

    @PostMapping("/log")
    public String logInput(@RequestBody String input) {
        if (input.contains("${jndi:")){
            return "Invalid input detected";
        }
        logger.info("User input: " + input);
        return "Logged: " + input;
    }
}
