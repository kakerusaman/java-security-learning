package com.example.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;

@Configuration //設定クラスであることを示す。@Beanで書いたものをspringのコンテナに登録できる
@EnableWebSecurity //springsecurityのWeb向けの機能を有効化する　設定を自動でインポート
public class WebSecurityConfig {

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {

        http
            .authorizeHttpRequests(auth -> {
                auth.requestMatchers("/css/**", "/js/**","/login","/createAccount","/createAccount/complete").permitAll();
                auth.requestMatchers("/register").permitAll();
                auth.requestMatchers("/public/**").permitAll();
                auth.requestMatchers("/admin/**").hasRole("ADMIN");
                auth.anyRequest().authenticated();
            })
            .formLogin(form -> form
                .loginPage("/login")
                .loginProcessingUrl("/login")
                .usernameParameter("userId")
                .defaultSuccessUrl("/mypage", true)
            )
            .logout(logout -> logout
                .logoutSuccessUrl("/login")
            );
        return http.build();
    }

}