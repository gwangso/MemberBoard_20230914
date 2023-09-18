package com.icia.board.repository;

import com.icia.board.dto.MemberDTO;
import com.icia.board.dto.MemberFileDTO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class MemberRepository {
    @Autowired
    private SqlSessionTemplate sql;

    public MemberDTO findByEmail(String memberEmail) {
        MemberDTO memberDTO = sql.selectOne("Member.duplicate", memberEmail);
        return memberDTO;
    }

    public MemberDTO save(MemberDTO memberDTO) {
        sql.insert("Member.save", memberDTO);
        return memberDTO;
    }

    public void saveProFile(MemberFileDTO memberFileDTO) {
        sql.insert("Member.saveFile", memberFileDTO);
    }

    public MemberDTO login(MemberDTO memberDTO) {
        return sql.selectOne("Member.login", memberDTO);
    }

    public List<MemberDTO> findAll() {
        return sql.selectList("Member.findAll");
    }

    public void delete(Long id) {
        sql.delete("Member.delete", id);
    }

    public MemberDTO findById(Long id) {
        return sql.selectOne("Member.findById",id);
    }

    public MemberFileDTO findFileById(Long memberId) {
        return sql.selectOne("Member.findFileById",memberId);
    }

    public void update(MemberDTO memberDTO) {
        sql.update("Member.updateMember", memberDTO);
    }

    public void updateProfile(MemberFileDTO memberFileDTO) {
        sql.update("Member.updateProfile", memberFileDTO);
    }
}
