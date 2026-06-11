package com.example.controller;

import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;


@RestController
public class ProductController {
    
    /*
    商品一覧画面の表示
    ゆくゆくは商品をジャンルごとで表示するなどのSort機能を作成することを考えたい
    */
    @GetMapping("/showProductList")
    // 絞り込みのジャンルを取得したいデフォルトはデフォルト一覧画面
    public String showProductList(@RequestParam(defaultValue = "findAll") String list){

        // DB内から全権取得する処理
            
        // それをフロント側が見やすいように整形する処理

        return "respons";
    }
}
