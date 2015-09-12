package controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller

public class HelloController {

@RequestMapping(value="/hellos",method=RequestMethod.GET)
public String printHello(Model model){
	model.addAttribute("rod","Hello Spring MVC I'm back");
	return "ento";
	
}
	
}
