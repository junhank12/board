package com.board.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.board.domain.BoardVO;
import com.board.domain.Criteria;
import com.board.domain.PageMaker;
import com.board.domain.ReplyVO;
import com.board.domain.SearchCriteria;
import com.board.service.BoardService;
import com.board.service.ReplyService;

@Controller
@RequestMapping("/board/*")
public class BoardController {
	
	@Inject
	BoardService service;
	
	@Inject
	ReplyService RepService;
	
	// 게시물 작성 GET (해당 페이지에 접속)
	@RequestMapping(value="/write", method=RequestMethod.GET)
	public void getWrite(HttpSession session, Model model) throws Exception {
		Object loginInfo = session.getAttribute("member");

		if(loginInfo == null) {
			model.addAttribute("msg", "login_error");
		}
	}
	
	// 게시물 작성 POST (해당 페이지에서 값을 전송)
	@RequestMapping(value="/write", method=RequestMethod.POST)
	public String postWrite(BoardVO vo) throws Exception {
		
		service.write(vo);
		
		return "redirect:/board/listPageSearch?num=1";
		
	}
	
	// 게시물 조회
	@RequestMapping(value="/view", method=RequestMethod.GET)
	public void getView(@RequestParam("bno") int bno,
						@ModelAttribute("scri") SearchCriteria scri, Model model) throws Exception {
		
		BoardVO vo = service.view(bno);		
		model.addAttribute("view", vo);		
		model.addAttribute("scri", scri);
		
		List<ReplyVO> repList = RepService.readReply(bno);
		model.addAttribute("repList", repList);
	}
	
	// 게시물 수정 (GET)
	@RequestMapping(value = "/modify", method = RequestMethod.GET)
	public void getModify(@RequestParam("bno") int bno,
						  @ModelAttribute("scri") SearchCriteria scri, Model model) throws Exception {
		
		BoardVO vo = service.view(bno);
		
		model.addAttribute("modify", vo);
		model.addAttribute("scri", scri);
		
	}
	
	// 게시물 수정 (POST)
	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public String postModify(BoardVO vo,
			@ModelAttribute("scri") SearchCriteria scri, RedirectAttributes rttr) throws Exception {

		service.modify(vo);
		
		rttr.addAttribute("page", scri.getPage());
		rttr.addAttribute("perPageNum", scri.getPerPageNum());
		rttr.addAttribute("searchType", scri.getSearchType());
		rttr.addAttribute("keyword", scri.getKeyword());
		
		return "redirect:/board/listSearch";
	}
	
	// 게시물 삭제 (GET)
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public void getDelete(@RequestParam("bno") int bno,
						  @ModelAttribute("scri") SearchCriteria scri, Model model) throws Exception {
	  
		model.addAttribute("delete", bno);
		model.addAttribute("scri", scri);
	}
	
	// 게시물 삭제 (POST)
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public String postDelete(@RequestParam("bno") int bno,
			@ModelAttribute("scri") SearchCriteria scri, RedirectAttributes rttr) throws Exception {

		service.delete(bno);
		
		rttr.addAttribute("page", scri.getPage());
		rttr.addAttribute("perPageNum", scri.getPerPageNum());
		rttr.addAttribute("searchType", scri.getSearchType());
		rttr.addAttribute("keyword", scri.getKeyword());
		
		return "redirect:/board/listSearch";

	}
	
	// 게시물 목록
	@RequestMapping(value="/list", method=RequestMethod.GET)
	public void getList(Model model) throws Exception {
		
		List<BoardVO> list = service.list();
		
		model.addAttribute("list", list);
		
	}

	// 게시물 목록 + 페이징 추가
	@RequestMapping(value = "/listPage", method = RequestMethod.GET)
	public void listPage(@ModelAttribute("cri") Criteria cri, Model model) throws Exception {
		
		List<BoardVO> list = service.listPage(cri);
		model.addAttribute("list", list);
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		pageMaker.setTotalCount(service.listCount());
		model.addAttribute("pageMaker", pageMaker);
	}
	
	
	// 게시물 목록 + 페이징 추가 + 검색
	@RequestMapping(value = "/listSearch", method = RequestMethod.GET)
	public void listSearch(@ModelAttribute("scri") SearchCriteria scri, Model model) throws Exception {			
		
		List<BoardVO> list = service.listSearch(scri);
		model.addAttribute("list", list);
		
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(service.countSearch(scri));
		model.addAttribute("pageMaker", pageMaker);
	}
	
	// 댓글 작성
	@RequestMapping(value = "/replyWrite", method = RequestMethod.POST)
	public String replyWrite(ReplyVO vo, SearchCriteria scri, RedirectAttributes rttr) throws Exception {

		RepService.writeReply(vo);
		
		rttr.addAttribute("bno", vo.getBno());
		rttr.addAttribute("page", scri.getPage());
		rttr.addAttribute("perPageNum", scri.getPerPageNum());
		rttr.addAttribute("searchType", scri.getSearchType());
		rttr.addAttribute("keyword", scri.getKeyword());
	 
		return "redirect:/board/view"; 
	}
	
	// 댓글 수정 GET
	@RequestMapping(value = "/replyUpdate", method = RequestMethod.GET)
	public void getReplyUpdate(@RequestParam("rno") int rno,
							   @ModelAttribute("scri") SearchCriteria scri, Model model) throws Exception {
		
		ReplyVO vo = RepService.readReplySelect(rno);
		
		model.addAttribute("readReply", vo);
		model.addAttribute("scri", scri);
	}
	
	// 댓글 수정 POST
	@RequestMapping(value = "/replyUpdate", method = RequestMethod.POST)
	public String replyUpdate(ReplyVO vo, SearchCriteria scri, RedirectAttributes rttr) throws Exception {
		
		RepService.replyUpdate(vo);
		
		rttr.addAttribute("bno", vo.getBno());
		rttr.addAttribute("page", scri.getPage());
		rttr.addAttribute("perPageNum", scri.getPerPageNum());
		rttr.addAttribute("searchType", scri.getSearchType());
		rttr.addAttribute("keyword", scri.getKeyword());
		
		return "redirect:/board/view";
	}

	// 댓글 삭제 GET
	@RequestMapping(value = "/replyDelete", method = RequestMethod.GET)
	public void getReplyDelete(@RequestParam("rno") int rno,
							   @ModelAttribute("scri") SearchCriteria scri, Model model) throws Exception {
		
		ReplyVO vo = RepService.readReplySelect(rno);
		
		model.addAttribute("readReply", vo);
		model.addAttribute("scri", scri);
	}
	
	// 댓글 삭제 POST
	@RequestMapping(value = "/replyDelete", method = RequestMethod.POST)
	public String replyDelete(ReplyVO vo, SearchCriteria scri, RedirectAttributes rttr) throws Exception {
		
		RepService.replyDelete(vo);
		
		rttr.addAttribute("bno", vo.getBno());
		rttr.addAttribute("page", scri.getPage());
		rttr.addAttribute("perPageNum", scri.getPerPageNum());
		rttr.addAttribute("searchType", scri.getSearchType());
		rttr.addAttribute("keyword", scri.getKeyword());
		
		return "redirect:/board/view";
	}	
}