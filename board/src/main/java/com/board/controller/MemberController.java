package com.board.controller;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.board.domain.MemberVO;
import com.board.service.MemberService;

@Controller
@RequestMapping("/member/*")
public class MemberController {
	
	@Inject
	MemberService service;
	
	// 회원 가입 get
	@RequestMapping(value = "/register", method = RequestMethod.GET)
	public void getRegister() throws Exception {
	}

	// 회원 가입 post
	@RequestMapping(value = "/register", method = RequestMethod.POST)
	public String postRegister(MemberVO vo) throws Exception {
		service.register(vo);
		
		return "redirect:/";
	}
	
	// 로그인
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(MemberVO vo, HttpServletRequest req, RedirectAttributes rttr) throws Exception {
		
		HttpSession session = req.getSession();
	 
		MemberVO login = service.login(vo);

		if(login == null) {
			session.setAttribute("member", null);
			rttr.addFlashAttribute("msg", false);
		} else {
			session.setAttribute("member", login);
		}
		return "redirect:/";
	}
	
	// 로그아웃
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(HttpSession session) throws Exception {
	
		session.invalidate();
		
		return "redirect:/";
	}
	
	// 회원정보 수정 get
	@RequestMapping(value = "/modify", method = RequestMethod.GET)
	public void getModify() throws Exception {
	}
	
	// 회원정보 수정 post
	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public String postModify(HttpSession session, MemberVO vo) throws Exception {
		service.modify(vo);
		
		session.invalidate();
		
		return "redirect:/";
	}
}