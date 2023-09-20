package com.icia.board.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class FavoriteDTO {
    private Long boardId;
    private Long memberId;
    private String registeredDate;
}
