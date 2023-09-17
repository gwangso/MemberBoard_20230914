package com.icia.board.dto;

import lombok.Data;

@Data
public class MemberFileDTO {
    private Long id;
    private String originalFileName;
    private String storedFileName;
    private Long memberId;
}
