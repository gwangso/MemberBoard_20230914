package com.icia.board.controller;

import com.icia.board.dto.BoardDTO;
import com.icia.board.dto.BoardFileDTO;
import com.icia.board.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("/board")
public class BoardController {
    @Autowired
    private BoardService boardService;

    @GetMapping("/save")
    public String save(HttpSession session){
        if(session.getAttribute("member")==null){
            return "redirect:/member/login";
        }else {
            return "board/boardSave";
        }
    }

    @PostMapping("/save")
    public String save(@ModelAttribute BoardDTO boardDTO) throws IOException {
        boardService.save(boardDTO);
        return "redirect:/board/list";
    }

    @GetMapping("/list")
    public String findAll(Model model){
        List<BoardDTO> boardDTOList = boardService.findAll();
        model.addAttribute("boardList", boardDTOList);
        return "board/boardList";
    }

    @GetMapping("/detail")
    public String findById(@RequestParam("id") Long id,
                           Model model){
        BoardDTO boardDTO = boardService.findById(id);
        model.addAttribute("board", boardDTO);
        boardService.updateHits(id);
        List<BoardFileDTO> boardFileDTOList = boardService.findFileById(id);
        model.addAttribute("boardFileList", boardFileDTOList);
        return "board/boardDetail";
    }

    @GetMapping("/delete")
    public String delete(@RequestParam("id") Long id){
        boardService.delete(id);
        return "redirect:/board/list";
    }

    @GetMapping("/update")
    public String update(@RequestParam("id") Long id,
                         Model model){
        BoardDTO boardDTO = boardService.findById(id);
        model.addAttribute("board", boardDTO);
        boardService.updateHits(id);
        List<BoardFileDTO> boardFileDTOList = boardService.findFileById(id);
        model.addAttribute("boardFileList", boardFileDTOList);
        return "board/boardUpdate";
    }

    @PostMapping("/update")
    public String update(@ModelAttribute BoardDTO boardDTO,
                         @RequestParam(value = "deleteFileList", required = false) List<String> deleteFileList) throws IOException {
        System.out.println(boardDTO);
        System.out.println(deleteFileList);

        boardService.update(boardDTO,deleteFileList);
        return "redirect:/board/detail?id="+boardDTO.getId();
    }
}