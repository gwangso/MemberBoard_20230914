package com.icia.board.repository;

import com.icia.board.dto.CommentDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository

public class CommentRepository {
    @Autowired
    private SqlSessionTemplate sql;
    public void save(CommentDTO commentDTO) {
        sql.insert("Comment.save", commentDTO);
    }

    public List<CommentDTO> findAll(Map<String, Object> commentParams) {
        return sql.selectList("Comment.findAll", commentParams);
    }

    public int count(Long boardId) {
        return sql.selectOne("Comment.count",boardId);
    }

}
