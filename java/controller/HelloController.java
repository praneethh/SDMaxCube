package controller;

import models.Tempe;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.mashape.unirest.http.HttpResponse;
import com.mashape.unirest.http.JsonNode;
import com.mashape.unirest.http.Unirest;
import com.mashape.unirest.http.exceptions.UnirestException;

@Controller
public class HelloController {

@RequestMapping(value="/home1",method=RequestMethod.GET)
public ModelAndView printHllo(Model model){	

	return new ModelAndView("fresh","edoString",new Tempe());	
}

@RequestMapping(value="/home",method=RequestMethod.GET)
public String printHello(Model model){	

	return "Assignment2";	
}

@RequestMapping(value="/restservice",method=RequestMethod.POST)
public String getInputs(Model model, @RequestParam("inp-length") String inpValue1,@RequestParam("output-units") String inpType1) throws UnirestException{	
	String inpType = inpType1;
	String stanType = "meters";
	String inpValue=inpValue1;
	String tempResult,stanInpValue,finalResult,volume;
	//stanInpValue=restService(inpType,stanType,inpValue);
	
	//tempResult=getSide(stanInpValue);
	tempResult=getSide(inpValue);
	//finalResult=restService(stanType,inpType,tempResult);
	//volume=getVolume(finalResult);
	volume=getVolume(tempResult);
	model.addAttribute("volume",volume);
	model.addAttribute("side", tempResult);
	model.addAttribute("len",inpValue);
	model.addAttribute("type",inpType);
	return "FinalResult";	
}
public String restService(String from,String to,String Value) throws UnirestException
{
	HttpResponse<JsonNode> response = Unirest.post("https://community-neutrino-currency-conversion.p.mashape.com/convert")
			.header("X-Mashape-Key", "TXMOW2ow3EmshbvLgXasCNndj5w9p12g81FjsnYHZTfJS5tfm4")
			.header("Content-Type", "application/x-www-form-urlencoded")
			.header("Accept", "application/json")
			.field("from-type", from)			
			.field("from-value", Value)
			.field("to-type", to)
			.asJson();		
		org.json.JSONObject obj1 = response.getBody().getObject();
	return	obj1.get("result").toString();	
}



@RequestMapping(value="/chetan",method=RequestMethod.POST)
public String test(@ModelAttribute("edoString") Tempe tempe)
{
	System.out.println(tempe.getFcity());
	System.out.println(tempe.getFname());
	return "result";	
}

public String getSide(String tempResult)
{
	Double temp=Double.parseDouble(tempResult);
	temp=temp/12;
	return temp.toString();	
}
public String getVolume(String finalResult)
{
	Double temp=Double.parseDouble(finalResult);
	temp=temp*temp*temp;
	return temp.toString();	
}
}
