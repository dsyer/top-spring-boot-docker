package com.example.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.actuate.trace.http.InMemoryHttpTraceRepository;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@RestController
public class DemoApplication {

	@GetMapping("/")
	public String home() {
		return "Hello World!";
	}

	public static void main(String[] args) {
		SpringApplication.run(DemoApplication.class, args);
	}

	@Bean
	public InMemoryHttpTraceRepository traceRepository() {
		return new InMemoryHttpTraceRepository();
	}
}
