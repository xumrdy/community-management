package com.peizhiwei.community.admin.web;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.peizhiwei.community.admin.entity.HouseInfo;
import com.peizhiwei.community.admin.entity.HouseOwner;
import com.peizhiwei.community.admin.entity.JspResult;
import com.peizhiwei.community.admin.entity.PayInfoSum;
import com.peizhiwei.community.admin.service.HouseInfoService;
import com.peizhiwei.community.admin.service.HouseOwnerService;
import com.peizhiwei.community.admin.service.PayInfoSumService;

@RequestMapping("houseownerinfo")
@Controller
public class HouseOwnerController {
	@Autowired
	HouseOwnerService houseownerservice;
	@Autowired
	HouseInfoService houseinfoservice;
	@Autowired
	PayInfoSumService payinfosumservice;
	
	/**
	 * ���ڸ�ʽ����ÿһ������ʵ��������һ��ע�⣬������������һ����䣬�������Ա�֤��̨��ҳ��佻�������ڸ�ʽ�Ǳ�׼�ģ�����Ҫ�ٽ��и�ʽ��
	 * @param binder
	 */
	@InitBinder
	public void initBinder(ServletRequestDataBinder binder) {
		binder.registerCustomEditor(Date.class, new CustomDateEditor(new SimpleDateFormat("yyyy-MM-dd"), true));
	}
	
	/**
	 * ��ȡ����ҵ����Ϣ
	 * @return
	 */
	@RequestMapping("getallhouseownerinfo")
	@ResponseBody
	public List<HouseOwner> getallhouseownerinfo(){
		List<HouseOwner> listhouseownerinfo=houseownerservice.getallhouseownerinfo();
		return listhouseownerinfo;
	}
	
	@RequestMapping("/getallonlyhouseownername")
	@ResponseBody
	public List<HouseOwner> getallonlyhouseownername(){
		List<HouseOwner> listonlyhouseownername = houseownerservice.getallonluhouseownername();
		return listonlyhouseownername;
	}
	
	/**
	 * ����ҵ����Ϣ
	 * @param ownerId
	 * @param ownerName
	 * @param ownerSex
	 * @param ownerPhone
	 * @param ownerBirthday
	 * @param ownerIdCard
	 * @param ownerNativePlace
	 * @param ownerWorkPlace
	 * @return
	 */
	@RequestMapping("/updatehouseownerinfo")
	@ResponseBody
	public JspResult updatehouseownerinfo(
			@RequestParam(value = "ownerId",required = false)Integer ownerId,
			@RequestParam(value = "ownerName",required = false)String ownerName,
			@RequestParam(value = "ownerSex",required = false)int ownerSex,
			@RequestParam(value = "ownerPhone",required = false)String ownerPhone,
			@RequestParam(value = "ownerBirthday",required = false)Date ownerBirthday,
			@RequestParam(value = "ownerIdCard",required = false)String ownerIdCard,
			@RequestParam(value = "ownerNativePlace",required = false)String ownerNativePlace,
			@RequestParam(value = "ownerWorkPlace",required = false)String ownerWorkPlace) {
		HouseOwner houseowner=new HouseOwner();
		houseowner.setOwnerId(ownerId);
		houseowner.setOwnerName(ownerName);
		houseowner.setOwnerSex(ownerSex);
		houseowner.setOwnerPhone(ownerPhone);
		houseowner.setOwnerBirthday(ownerBirthday);
		houseowner.setOwnerIdCard(ownerIdCard);
		houseowner.setOwnerNativePlace(ownerNativePlace);
		houseowner.setOwnerWorkPlace(ownerWorkPlace);
		houseownerservice.updatehouseownerinfo(houseowner);
		JspResult rs = new JspResult();
		rs.setFlag(true);
		rs.setMsg("�޸ĳɹ�");
		return rs;
	}
	/**
	 * ����ҵ����Ϣ
	 * @param ownerName
	 * @param houseNumber
	 * @param ownerSex
	 * @param ownerPhone
	 * @param ownerBirthday
	 * @param ownerIdCard
	 * @param ownerNativePlace
	 * @param ownerWorkPlace
	 * @return
	 */
	@RequestMapping("inserthouseownerinfo")
	@ResponseBody
	public JspResult inserthouseownerinfo(
			@RequestParam(value = "ownerName",required = false)String ownerName,
			@RequestParam(value = "houseNumber",required = false)String houseNumber,
			@RequestParam(value = "ownerSex",required = false)int ownerSex,
			@RequestParam(value = "ownerPhone",required = false)String ownerPhone,
			@RequestParam(value = "ownerBirthday",required = false)Date ownerBirthday,
			@RequestParam(value = "ownerIdCard",required = false)String ownerIdCard,
			@RequestParam(value = "ownerNativePlace",required = false)String ownerNativePlace,
			@RequestParam(value = "ownerWorkPlace",required = false)String ownerWorkPlace) {
		HouseOwner houseownerinfo = new HouseOwner();
		HouseInfo houseinfo= new HouseInfo();
		JspResult rs = new JspResult();
		try {
			houseownerinfo.setOwnerName(ownerName);
			houseinfo.setHouseId(houseinfoservice.gethouseidaccordinghousenumber(houseNumber));
			houseownerinfo.setHouseInfo(houseinfo);
			
			houseownerinfo.setOwnerSex(ownerSex);
			houseownerinfo.setOwnerPhone(ownerPhone);
			houseownerinfo.setOwnerPassword("000000");
			houseownerinfo.setOwnerBirthday(ownerBirthday);
			houseownerinfo.setOwnerIdCard(ownerIdCard);
			houseownerinfo.setOwnerNativePlace(ownerNativePlace);
			houseownerinfo.setOwnerWorkPlace(ownerWorkPlace);
			houseownerservice.inserthouseownerinfo(houseownerinfo);//����ҵ��
			//����ҵ��ʱ���ڷ�����Ϣ��������ҵ��id,��סʱ�䣨Ĭ��Ϊϵͳ��ǰʱ�䣩
			HouseInfo updatehouseinfo= new HouseInfo();
			updatehouseinfo.setHouseInTime(new Date());
			updatehouseinfo.setHouseId(houseinfoservice.gethouseidaccordinghousenumber(houseNumber));
			HouseOwner houseowner=new HouseOwner();
			houseowner.setOwnerId(houseownerinfo.getOwnerId());//��ȡ�ո����ӵ�ҵ��id
			updatehouseinfo.setHouseOwner(houseowner);
			houseinfoservice.updatehouseinfoofownerid(updatehouseinfo);
			//����ҵ����ͬʱ�ڽɷ���Ϣ���ܱ������Ӹ�ҵ���Ľɷѻ�����Ϣ
			PayInfoSum payinfosum = new PayInfoSum();
			HouseOwner paysumfoowner = new HouseOwner();
			paysumfoowner.setOwnerId(houseownerinfo.getOwnerId());//�ո����ӵ�ҵ��id
			payinfosum.setHouseOwner(paysumfoowner);
			payinfosumservice.insertpayinfosum(payinfosum);
			
			rs.setFlag(true);
			rs.setMsg("���ӳɹ�");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return rs;
	}
	/**
	 * ҵ��Ǩ����ͬʱɾ����ͥ��Ա��Ϣ�ͳ�λ��Ϣ
	 * @return
	 */
	@RequestMapping("/deleteowner")
	@ResponseBody
	public JspResult deleteowner(Integer ownerId) {
		JspResult rs = new JspResult();
		try {
			houseownerservice.deleteowner(ownerId);
			rs.setFlag(true);
			rs.setMsg("Ǩ���ɹ���");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return rs;
	}
	
}