package com.icia.board.service;

import com.icia.board.dto.FavoriteDTO;
import com.icia.board.repository.FavoriteRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class FavoriteService {
    @Autowired
    private FavoriteRepository favoriteRepository;

    public FavoriteDTO read(Long boardId, Long memberId) {
        Map<String, Long> readParams = new HashMap<>();
        readParams.put("boardId", boardId);
        readParams.put("memberId", memberId);
        return favoriteRepository.read(readParams);
    }

    public void insert(Long boardId, Long memberId) {
        Map<String, Long> insertParams = new HashMap<>();
        insertParams.put("boardId", boardId);
        insertParams.put("memberId", memberId);
        favoriteRepository.insert(insertParams);
    }

    public void delete(Long boardId, Long memberId) {
        Map<String, Long> deleteParams = new HashMap<>();
        deleteParams.put("boardId", boardId);
        deleteParams.put("memberId", memberId);
        favoriteRepository.delete(deleteParams);
    }
}
