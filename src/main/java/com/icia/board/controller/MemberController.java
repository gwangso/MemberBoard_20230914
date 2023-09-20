package com.icia.board.controller;

import com.icia.board.dto.MemberDTO;
import com.icia.board.dto.MemberFileDTO;
import com.icia.board.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("/member")
public class MemberController {
    @Autowired
    private MemberService memberService;

    @GetMapping("/save")
    public String save(){
        return "member/memberSave";
    }

    @PostMapping("/duplicate")
    public @ResponseBody int duplicate(@RequestParam("memberEmail") String memberEmail){
        MemberDTO memberDTO = memberService.findByEmail(memberEmail);
        if(memberDTO==null){
            return 1;
        }else{
            return 0;
        }
    }

    @PostMapping("/save")
    public String save(@ModelAttribute MemberDTO memberDTO) throws IOException {
        memberService.save(memberDTO);
        return "member/login";
    }

    @GetMapping("/login")
    public String login(@RequestParam(value="url",required = false) String url,
                        Model model){
        model.addAttribute("url",url);
        return "member/login";
    }

    @PostMapping("/login")
    public String login(@ModelAttribute MemberDTO memberDTO,
                        @RequestParam(value="url",required = false) String url,
                        HttpSession session){
        MemberDTO result = memberService.login(memberDTO);
        if(result!=null){
            session.setAttribute("member", result);
            if (url.equals("")){
                return "index";
            }else{
                return "redirect:"+url;
            }
        }else {
            return "redirect:/member/login?url="+url;
        }
    }

    @GetMapping("/logout")
    public String logout(@RequestParam(value="pathname",required = false) String pathname,
                         @RequestParam(value="parameter",required = false) String parameter,
                         HttpSession session){
        session.removeAttribute("member");
        String url = pathname+parameter;
        if (pathname.equals("/board/saave")) {
            return "redirect:/";
        }else if (pathname.equals("/member/detail")) {
            return "redirect:/";
        }else if (pathname.equals("/member/update")) {
            return "redirect:/";
        }else if (pathname.equals("/member/list")){
            return "redirect:/";
        }else {
            return "redirect:"+url;
        }
    }

    @GetMapping("/list")
    public String list(Model model){
        List<MemberDTO> memberDTOList = memberService.findAll();
        model.addAttribute("memberList", memberDTOList);
        return "member/memberList";
    }

    @GetMapping("/delete")
    public String delete(@RequestParam("id") Long id){
        memberService.delete(id);
        return "redirect:/member/list";
    }

    @GetMapping("/detail")
    public String detail(@RequestParam("id") Long id,
                         Model model){
        MemberDTO memberDTO = memberService.findById(id);
        model.addAttribute("member",memberDTO);
        MemberFileDTO memberFileDTO = memberService.findFileById(id);
        model.addAttribute("memberFile", memberFileDTO);
        return "member/memberDetail";
    }

    @GetMapping("/update")
    public String update(@RequestParam("id") Long id,
                         Model model){
        MemberDTO memberDTO = memberService.findById(id);
        model.addAttribute("member", memberDTO);
        MemberFileDTO memberFileDTO = memberService.findFileById(id);
        model.addAttribute("memberFile", memberFileDTO);

        return "member/memberUpdate";
    }

    @PostMapping("/update")
    public String update(@ModelAttribute MemberDTO memberDTO) throws IOException {
        System.out.println(memberDTO);
        memberService.update(memberDTO);
        return "redirect:/member/detail?id="+memberDTO.getId();
    }
}
