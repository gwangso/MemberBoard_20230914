package com.icia.board.repository;

import com.icia.board.dto.BoardDTO;
import com.icia.board.dto.BoardFileDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class BoardRepository {
    @Autowired
    private SqlSessionTemplate sql;

    public BoardDTO save(BoardDTO boardDTO) {
        sql.insert("Board.save", boardDTO);
        return boardDTO;
    }

    public void saveFile(BoardFileDTO boardFileDTO) {
        sql.insert("Board.saveFile", boardFileDTO);
    }

    public List<BoardDTO> findAll(Map<String, Integer> pagingParams) {
        return sql.selectList("Board.findAll",pagingParams);
    }

    public BoardDTO findById(Long id) {
        return sql.selectOne("Board.findById", id);
    }

    public List<BoardFileDTO> findFileById(Long boardId) {
        return sql.selectList("Board.findFileById", boardId);
    }

    public void updateHits(Long id) {
        sql.update("Board.updateHits",id);
    }

    public void delete(Long id) {
        sql.delete("Board.delete",id);
    }

    public void update(BoardDTO boardDTO) {
        sql.update("Board.update",boardDTO);
    }

    public void deleteFile(String storedFileName) {
        sql.delete("Board.deleteFile", storedFileName);
    }

    public int countFile(Long boardId) {
        return sql.selectOne("Board.countFile", boardId);
    }

    public List<BoardDTO> searchList(Map<String, Object> searchParams) {
        return sql.selectList("Board.searchList", searchParams);
    }

    public int boardCount() {
        return sql.selectOne("Board.count");
    }

    public int searchBoardCount(Map<String, String> searchParams) {
        return sql.selectOne("Board.searchCount", searchParams);
    }
}
