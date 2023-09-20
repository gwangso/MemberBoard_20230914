package com.icia.board.controller;

import com.icia.board.dto.FavoriteDTO;
import com.icia.board.service.FavoriteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/favorite")
public class FavoriteController {
    @Autowired
    private FavoriteService favoriteService;

    @GetMapping("/read")
    public @ResponseBody int read(@RequestParam("boardId") Long boardId,
                                  @RequestParam("memberId") Long memberId){
        FavoriteDTO favoriteDTO = favoriteService.read(boardId,memberId);
        if (favoriteDTO != null){
            return 1;
        }else{
            return 0;
        }
    }

    @PostMapping("/insert")
    public ResponseEntity insert(@RequestParam("boardId") Long boardId,
                                 @RequestParam("memberId") Long memberId){
        favoriteService.insert(boardId,memberId);
        return new ResponseEntity<>(HttpStatus.OK);
    }
    @PostMapping("/delete")
    public ResponseEntity delete(@RequestParam("boardId") Long boardId,
                                 @RequestParam("memberId") Long memberId){
        favoriteService.delete(boardId,memberId);
        return new ResponseEntity<>(HttpStatus.OK);
    }


}
