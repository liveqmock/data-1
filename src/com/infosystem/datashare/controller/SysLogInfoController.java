package com.infosystem.datashare.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.infosystem.datashare.model.SysLogInfo;
import com.infosystem.datashare.service.ISysLogInfoService;

/**
 * 日志管理
 * @author hudaowan
 *
 */
@Controller
@RequestMapping({"sysloginfo"})
public class SysLogInfoController {
   protected Logger log = LoggerFactory.getLogger(getClass());
   
   @Autowired
   private ISysLogInfoService sysLogInfoService;

   @RequestMapping({"list",""})
   public String list(Model model) {
      return "base/sys/user/userList";
   }

   /**
    *@author hudaowan
    *@return
    *        Object
    *@exception
    */
   @RequestMapping("ajax/getData")
   @ResponseBody
   public Object getData(SysLogInfo sysLogInfo,Integer pageIndex, Integer pageSize) {
       System.out.print("ddddd");
       sysLogInfo = new SysLogInfo();
       sysLogInfo.setOperation("11111");
       sysLogInfo.setStatus("dddd");
       sysLogInfo.setModelName("dadads");
       sysLogInfo.setUserId(new Long(1));
       this.sysLogInfoService.addSysLogInfo(sysLogInfo);;
      return null;
   }

   /**
    *@return
    *        String
    *@exception
    */
   @RequestMapping({ "ajax/addFrame" })
   public String addFrame(Model model) {
	  
      return "base/sys/user/addUserFrame";
   }

   /**
    *@author hudaowan
    *@date   2013-9-5 下午1:27:52
    *@param id
    *@param model
    *@return
    *        String
    *@exception
    */
   @RequestMapping({"ajax/editFrame"})
   public String editFrame(String id, Model model) {
	   
	 return "base/sys/user/editUserFrame";
	}

    /**
     *@author hudaowan
     *@param id
     *@param model
     *@return
     *        String
     *@exception
     */
    @RequestMapping("ajax/detailFrame")
    public String detailFrame(String id,Model model) {
    	
     return "base/sys/user/userDetailFrame";
    }

   /**
    *@author hudaowan
    *@param userForm
    *@return
    *        Object
    *@exception
    */
   @RequestMapping("ajax/save")
   @ResponseBody
   public Object save(@ModelAttribute("userForm") SysLogInfo sysLogInfo) {
      return null;
   }

   /**
    * 删除用户信息
    *@author hudaowan
    *@date   2013-9-5 下午1:33:02
    *@param ids
    *@return
    *        Object
    *@exception
    */
   @RequestMapping("ajax/delete")
   @ResponseBody
   public Object delete(String[] ids) {
	   
      return null;
   }

   /**
    * 修改状态
    *@author hudaowan
    *@date   2013-9-8 下午8:56:07
    *@param ids
    *@return
    *        Object
    *@exception
    */
   @RequestMapping("ajax/update/{status}")
   @ResponseBody
   public Object updateStatus(String[] ids,@PathVariable String status){
	  
      return null;
   }
   
}