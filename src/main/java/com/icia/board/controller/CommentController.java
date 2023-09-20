package com.icia.board.controller;

import com.icia.board.dto.CommentDTO;
import com.icia.board.service.CommentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/comment")
public class CommentController {
    @Autowired
    private CommentService commentService;

    @PostMapping("/save")
    public ResponseEntity save(@ModelAttribute CommentDTO commentDTO){
        commentService.save(commentDTO);
//        List<CommentDTO> commentDTOList = commentService.findAll(commentDTO.getBoardId());
        return new ResponseEntity<>(true, HttpStatus.OK);
    }

    @GetMapping("/findAll")
    public ResponseEntity findAll(@RequestParam("boardId") Long boardId,
                                  @RequestParam("commentPage") int page){
        List<CommentDTO> commentDTOList = commentService.findAll(boardId, page);
        return new ResponseEntity<>(commentDTOList, HttpStatus.OK);
    }

    @GetMapping("/count")
    public ResponseEntity count(@RequestParam("boardId") Long boardId){
        int total = commentService.count(boardId);
        return new ResponseEntity<>(total,HttpStatus.OK);
    }
}
