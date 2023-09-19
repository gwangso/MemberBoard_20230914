package com.icia.board.service;

import com.icia.board.dto.BoardDTO;
import com.icia.board.dto.BoardFileDTO;
import com.icia.board.repository.BoardRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.List;

@Service
public class BoardService {
    @Autowired
    private BoardRepository boardRepository;

    public void save(BoardDTO boardDTO) throws IOException {
        if(boardDTO.getBoardFiles().isEmpty()){
            boardDTO.setFileAttached(0);
            boardRepository.save(boardDTO);
        }else {
            boardDTO.setFileAttached(1);
            BoardDTO saveBoard = boardRepository.save(boardDTO);
            for(MultipartFile boardFile : boardDTO.getBoardFiles()){
                BoardFileDTO boardFileDTO = new BoardFileDTO();
                String originalFileName = boardFile.getOriginalFilename();
                String storedFileName = System.currentTimeMillis() + "_" + originalFileName;
                boardFileDTO.setBoardId(saveBoard.getId());
                boardFileDTO.setOriginalFileName(originalFileName);
                boardFileDTO.setStoredFileName(storedFileName);

                String savePath = "D:\\spring_img\\board_img\\"+storedFileName;
                boardFile.transferTo(new File(savePath));

                boardRepository.saveFile(boardFileDTO);
            }
        }
    }

    public List<BoardDTO> findAll() {
        return boardRepository.findAll();
    }

    public BoardDTO findById(Long id) {
        return boardRepository.findById(id);
    }

    public List<BoardFileDTO> findFileById(Long boardId) {
        return boardRepository.findFileById(boardId);
    }

    public void updateHits(Long id) {
        boardRepository.updateHits(id);
    }

    public void delete(Long id) {
        boardRepository.delete(id);
    }

    public void update(BoardDTO boardDTO, List<String> deleteFileList) throws IOException {
        for(String storedFileName : deleteFileList){
            boardRepository.deleteFile(storedFileName);
            File file = new File("D:\\spring_img\\board_img\\"+storedFileName);
            file.delete();
        }
        int countFile = boardRepository.countFile(boardDTO.getId());

        if(boardDTO.getBoardFiles().isEmpty() && countFile==0) {
            boardDTO.setFileAttached(0);
            boardRepository.update(boardDTO);
        }else if (boardDTO.getBoardFiles().isEmpty() && countFile!=1) {
            boardDTO.setFileAttached(1);
            boardRepository.update(boardDTO);
        }else {
            boardDTO.setFileAttached(1);
            boardRepository.update(boardDTO);
            for (MultipartFile boardFile : boardDTO.getBoardFiles()){
                BoardFileDTO boardFileDTO = new BoardFileDTO();
                String originalFileName = boardFile.getOriginalFilename();
                String storedFileName = System.currentTimeMillis() + "_" + originalFileName;
                boardFileDTO.setBoardId(boardDTO.getId());
                boardFileDTO.setOriginalFileName(originalFileName);
                boardFileDTO.setStoredFileName(storedFileName);

                String savePath = "D:\\spring_img\\board_img\\"+storedFileName;
                boardFile.transferTo(new File(savePath));

                boardRepository.saveFile(boardFileDTO);
            }
        }
    }
}
