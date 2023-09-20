package com.icia.board.repository;

import com.icia.board.dto.FavoriteDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.Map;

@Repository
public class FavoriteRepository {
    @Autowired
    private SqlSessionTemplate sql;

    public FavoriteDTO read(Map<String, Long> readParams) {
        return sql.selectOne("Favorite.read", readParams);
    }

    public void insert(Map<String, Long> insertParams) {
        sql.insert("Favorite.insert",insertParams);
    }

    public void delete(Map<String, Long> deleteParams) {
        sql.delete("Favorite.delete",deleteParams);
    }
}
