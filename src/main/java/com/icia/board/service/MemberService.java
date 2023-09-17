package com.icia.board.service;

import com.icia.board.dto.MemberDTO;
import com.icia.board.dto.MemberFileDTO;
import com.icia.board.repository.MemberRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

@Service
public class MemberService {
    @Autowired
    private MemberRepository memberRepository;

    public MemberDTO findByEmail(String memberEmail) {
        return memberRepository.findByEmail(memberEmail);
    }

    public void save(MemberDTO memberDTO) throws IOException {
        // 정보를 저장하면서 생성된 id값을 포함한 MemberDTO를 가져옴
        MemberDTO savedMember = memberRepository.save(memberDTO);;
        // memberDTO에 저장된 프로파일사진을 가져옴
        MultipartFile memberProfile = memberDTO.getMemberProfile();
        // 사진이 첨부되지 않았으면 그냥 종료
        // 사진이 첨부되었으면(isEmpty()가 아닌경우) memberFileDTO생성
        if(!memberProfile.isEmpty()) {
            // originalFileName 가져오기
            String originalFileName = memberProfile.getOriginalFilename();
            // 무작위 수 출력
            UUID uuid = UUID.randomUUID();
            String pid = uuid.toString().substring(0,15);
            // 저장용 이름 생성
            String storedFileName = pid + "-" + originalFileName;
            // memberFileDTO 형성
            MemberFileDTO memberFileDTO = new MemberFileDTO();
            memberFileDTO.setMemberId(savedMember.getId());
            memberFileDTO.setOriginalFileName(originalFileName);
            memberFileDTO.setStoredFileName(storedFileName);
            // 이미지파일 저장경로 생성
            String savePath = "D:\\spring_img\\profile\\"+storedFileName;
            // 이미지파일 저장
            memberProfile.transferTo(new File(savePath));
            // 데이터베이스에 memberFileDTO 내용 저장
            memberRepository.saveProFile(memberFileDTO);
        }
    }

    public MemberDTO login(MemberDTO memberDTO) {
        return memberRepository.login(memberDTO);
    }

    public List<MemberDTO> findAll() {
        return memberRepository.findAll();
    }

    public void delete(Long id) {
        memberRepository.delete(id);
    }

    public MemberDTO findById(Long id) {
        return memberRepository.findById(id);
    }

    public MemberFileDTO findFileById(Long memberId) {
        return memberRepository.findFileById(memberId);
    }

    public void update(MemberDTO memberDTO) {
        
    }
}
