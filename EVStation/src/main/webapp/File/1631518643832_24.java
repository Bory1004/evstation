package web.project.controller;


import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Random;

import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.multipart.MultipartFile;

import web.project.domain.Board;
import web.project.domain.FrontImg;
import web.project.domain.Host;
import web.project.domain.Img;
import web.project.service.BoardService;
import web.project.service.FrontImgService;
import web.project.service.ImgService;

@SessionAttributes("host")
@Controller
public class BoardController implements ApplicationContextAware {
	
	private WebApplicationContext context = null;
	
	@ModelAttribute("host")
	public Host getHost() {
		return new Host();
	}
	
	@Autowired
	private BoardService boardService;
	@Autowired
	private FrontImgService frontImgService;
	@Autowired
	private ImgService imgService;
	
	@PostMapping("/boardList")
	public String insertBoard(Model model, Board board, Long frontImgNo, @ModelAttribute("host")Host host, List<MultipartFile> frontImg, List<MultipartFile> image) {
		board.setHostid(host.getHostid());
		Board b =  boardService.saveBoard(board);
		List<FrontImg> imgb = frontImgService.viewImg(frontImgNo);
		System.out.println(b.getBoardNum());
		model.addAttribute("place", b);
		model.addAttribute("viewImg",imgb);
		
		//????????? ????????? ?????????
		for (MultipartFile file : frontImg) {
		String path = getFrontPath(file);
		FrontImg fi = new FrontImg();
		fi.setBoardNum(b.getBoardNum());
		fi.setFilename(path);
		fi.setFilePath(path);
		fi.setOrigFilename(file.getOriginalFilename());
		
		//save
		frontImgService.saveFrontImg(fi);
		}
		
		//????????? ?????????
		for (MultipartFile file : image) {
		String path = getImgPath(file);
		Img im = new Img();
		im.setBoardNum(b.getBoardNum());
		im.setFilename(path);
		im.setFilePath(path);
		im.setOrigFilename(file.getOriginalFilename());
				
		//save
		imgService.saveImg(im);
		}
		
		return "redirect:/";
	}
	
	//(?????????)?????? ???????????? ?????? ????????? ??????
	private String getImgPath(MultipartFile image) {
		
		String oriName = image.getOriginalFilename(); //?????? ??? ????????? ?????? ??????
		int index = oriName.lastIndexOf(".");
		String ext = oriName.substring(index+1); //?????? ?????? ????????? ?????? ??????
		Random r = new Random();
		String fileName = System.currentTimeMillis() + "_" + r.nextInt(50) + "." + ext;
	
		String path = context.getServletContext().getRealPath("img/Img/"+fileName); 
    
		try {
			image.transferTo(new File(path));
		}catch(IllegalStateException | IOException e){
			e.printStackTrace();
		}
		
		return "/img/Img/"+fileName;
	}
	
	//(??????????????????)?????? ???????????? ?????? ????????? ??????
	private String getFrontPath(MultipartFile frontImg) {
		
			String oriName = frontImg.getOriginalFilename(); //?????? ??? ????????? ?????? ??????
			int index = oriName.lastIndexOf(".");
			String ext = oriName.substring(index+1); //?????? ?????? ????????? ?????? ??????
			Random r = new Random();
			String fileName = System.currentTimeMillis() + "_" + r.nextInt(50) + "." + ext;
			
			String path = context.getServletContext().getRealPath("img/frontImg/"+fileName); 
			System.out.println(path);
			try {
				frontImg.transferTo(new File(path));
			}catch(IllegalStateException | IOException e){
				e.printStackTrace();
			}
			
        return "/img/frontImg/"+fileName;
     }
	
	//?????? ??????
		@RequestMapping("/viewBoard")
		public String viewBoard(Model model,
				@RequestParam(name="p", defaultValue="1")int pNum, 
				@ModelAttribute("host")Host host) {
			if(host.getHostid() == null) {
				return "login/hostLoginForm";
			}
			Page<Board> pageList = boardService.getBoardList(pNum);
			List<Board> bList = pageList.getContent(); //????????? ???
			int totalCount = pageList.getTotalPages(); //?????? ????????? ???
			model.addAttribute("bList", bList);
			model.addAttribute("totalCount", totalCount);
			
			
			int begin = (pNum-1)/5*5+1; //?????? 2 ????????? ????????? ????????? ???????????? ???
			int end = begin+5-1;
			if(end>totalCount) {
				end = totalCount;
			}
			model.addAttribute("begin", begin);
			model.addAttribute("end", end);
			
			return "host_board/boardList";
		}
		
		@RequestMapping("/viewPost/{boardNum}")
		public String viewPost(Model model, @PathVariable Long boardNum, FrontImg fi) {
			Board view = boardService.viewPost(boardNum);
			model.addAttribute("view",view);
			
			List<FrontImg> fis = frontImgService.viewImg(boardNum);
			model.addAttribute("fis", fis);
			model.addAttribute("fisize", fis.size());
			return "host_board/viewPost";
		}
	
	@Override
    public void setApplicationContext(ApplicationContext applicationContext)
          throws BeansException {
       this.context = (WebApplicationContext) applicationContext;
    }

}
