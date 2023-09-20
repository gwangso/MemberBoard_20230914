package com.icia.board.service;

import com.icia.board.dto.CommentDTO;
import com.icia.board.repository.CommentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class CommentService {
    @Autowired
    private CommentRepository commentRepository;

    public void save(CommentDTO commentDTO) {
        commentRepository.save(commentDTO);
    }

    public List<CommentDTO> findAll(Long boardId, int page) {
        Map<String, Object> commentParams = new HashMap<>();
        int start = (page-1)*5;
        commentParams.put("boardId",boardId);
        commentParams.put("start", start);
        return commentRepository.findAll(commentParams);
    }

    public int count(Long boardId) {
        return commentRepository.count(boardId);
    }
}
