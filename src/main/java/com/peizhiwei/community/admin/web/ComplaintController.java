package com.peizhiwei.community.admin.web;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.peizhiwei.community.admin.entity.Admin;
import com.peizhiwei.community.admin.entity.Complaint;
import com.peizhiwei.community.admin.entity.JspResult;
import com.peizhiwei.community.admin.service.ComplaintService;
import com.peizhiwei.community.util.Pager;

@RequestMapping("/complaintinfo")
@Controller
public class ComplaintController {
	@Autowired
	ComplaintService complaintservice;
	/**
	 * 日期格式，在每一个日期实体上添加一个注解，再在这里添加一下语句，这样可以保证后台和页面间交互的日期格式是标准的，不需要再进行格式化
	 * @param binder
	 */
	@InitBinder
	public void initBinder(ServletRequestDataBinder binder) {
		binder.registerCustomEditor(Date.class, new CustomDateEditor(new SimpleDateFormat("yyyy-MM-dd"), true));
	}
	/**
	 * 分页获取所有投诉信息
	 * @return
	 */
	@RequestMapping("/pagegetallcomplaintinfo")
	@ResponseBody
	public Pager<Complaint> pagegetallcomplaintinfo(int page,int size){
		Pager<Complaint> listcomplaint = complaintservice.pagegetallcomplaintinfo(page, size);
		return listcomplaint;
	}
	/**
	 * 获取所有投诉信息
	 * @return
	 */
	@RequestMapping("/getallcomplaintinfo")
	@ResponseBody
	public List<Complaint> getallcomplaintinfo(){
		List<Complaint> listcomplaint = new ArrayList<Complaint>();
		try {
			listcomplaint=complaintservice.getallcomplaintinfo();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return listcomplaint;
	}
	/**
	 * 受理投诉信息
	 * @return
	 */
	@RequestMapping("/acceptance")
	@ResponseBody
	public JspResult acceptance(Integer complaintId,HttpSession session) {
		JspResult rs = new JspResult();
		Complaint complaint = new Complaint();
		try {
			Object adminsession = session.getAttribute("admin");
			Admin admin = (Admin) adminsession;
			complaint.setAdmin(admin);
			complaint.setComplaintId(complaintId);
			complaintservice.acceptancecomplaint(complaint);
			rs.setFlag(true);
			rs.setMsg("已受理");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return rs;
	}
	/**
	 * 已解决投诉信息，修改投诉状态为2已解决
	 * @param complaintId
	 * @return
	 */
	@RequestMapping("/settled")
	@ResponseBody
	public JspResult settled(Integer complaintId,HttpSession session) {
		JspResult rs = new JspResult();
		Complaint complaint = new Complaint();
		try {
			Object adminsession = session.getAttribute("admin");
			Admin admin = (Admin) adminsession;
			if(admin.getAdminId()!=complaintservice.getcomplaintinfo(complaintId)) {
				rs.setFlag(false);
				rs.setMsg("您不是受理人，无权执行此操作");
			}else {
				complaint.setComplaintId(complaintId);
				complaint.setComplaintSettleTime(new Date());
				complaintservice.settledcomplaint(complaint);
				rs.setFlag(true);
				rs.setMsg("已解决");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return rs;
	}
	/**
	 * 根据投诉信息id删除投诉信息
	 * @param complaintId
	 * @return
	 */
	@RequestMapping("/deletecomplaint")
	@ResponseBody
	public JspResult deletecomplaint(Integer complaintId) {
		JspResult rs = new JspResult();
		complaintservice.deletecomplaint(complaintId);
		rs.setFlag(true);
		rs.setMsg("删除成功！");
		return rs;
	}
	/**
	 * 模糊查询投诉信息，(投诉人，楼栋编号，单元号，房间号，投诉原因)
	 * @param ownerName
	 * @param buildNumber
	 * @param houseUnit
	 * @param houseNumber
	 * @param complaintReason
	 * @return
	 */
	@RequestMapping("/getcomplaintinfolike")
	@ResponseBody
	public Pager<Complaint> getcomplaintinfolike(
			@RequestParam(value = "ownerName",required = false)String ownerName,
			@RequestParam(value = "buildNumber",required = false)String buildNumber,
			@RequestParam(value = "houseUnit",required = false)String houseUnit,
			@RequestParam(value = "houseNumber",required = false)String houseNumber,
			@RequestParam(value = "complaintReason",required = false)String complaintReason,
			@RequestParam(value = "page",required = false)int page,
			@RequestParam(value = "size",required = false)int size){
		Pager<Complaint> pagecomplaintinfo = complaintservice.getcomplaintinfolike(ownerName, buildNumber, houseUnit, houseNumber, complaintReason, page, size);
		return pagecomplaintinfo;
	}
	/**
	 * 批量删除投诉信息
	 * @param listcomplaintId
	 * @return
	 */
	@RequestMapping("/checkdelete")
	@ResponseBody
	public JspResult checkdelete(@RequestBody String[] listcomplaintId){
		JspResult rs = new JspResult();
		complaintservice.checkdelete(listcomplaintId);
		rs.setFlag(true);
		rs.setMsg("已全部删除！");
		return rs;
	}
}
