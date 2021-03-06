package com.peizhiwei.community.admin.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.peizhiwei.community.admin.dao.FamilyDao;
import com.peizhiwei.community.admin.dao.HouseInfoDao;
import com.peizhiwei.community.admin.dao.HouseOwnerDao;
import com.peizhiwei.community.admin.dao.ParkingDao;
import com.peizhiwei.community.admin.entity.HouseOwner;
import com.peizhiwei.community.admin.service.ComplaintService;
import com.peizhiwei.community.admin.service.HouseOwnerService;
import com.peizhiwei.community.admin.service.PayInfoDetailsService;
import com.peizhiwei.community.admin.service.PayInfoSumService;
import com.peizhiwei.community.admin.service.RepairService;
import com.peizhiwei.community.util.Pager;
@Service
@Transactional(rollbackFor = Exception.class)
public class HouseOwnerServiceImpl implements HouseOwnerService {
	@Autowired
	HouseOwnerDao houseownerdao;
	@Autowired
	FamilyDao familydao;
	@Autowired
	ParkingDao parkingdao;
	@Autowired
	HouseInfoDao houseinfodao;
	@Autowired
	ComplaintService complaintservice;
	@Autowired
	RepairService repairservice;
	@Autowired
	PayInfoDetailsService payinfodetailsservice;
	@Autowired
	PayInfoSumService payinfosumservice;
	
	/**
	 * 分页查询，获取所有业主信息
	 */
	@Override
	public Pager<HouseOwner> pagegetallhouseownerinfo(int page,int size){
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("page", (page-1)*size);
		params.put("size", size);
		List<HouseOwner> listhouseowner = houseownerdao.pagegetallhouseownerinfo(params);
		Pager<HouseOwner> pager = new Pager<HouseOwner>();
		pager.setRows(listhouseowner);
		pager.setTotal(houseownerdao.count());
		return pager;
	}
	
	/**
	 * 获取所有业主信息
	 */
	@Override
	public List<HouseOwner> getallhouseownerinfo() {
		List<HouseOwner> listhouseowner = houseownerdao.getallhouseownerinfo();
		return listhouseowner;
	}
	/**
	 * 更新业主信息
	 */
	@Override
	public void updatehouseownerinfo(HouseOwner houseowner) {
		houseownerdao.updatehouseownerinfo(houseowner);
	}
	/**
	 * 获取所有还有空房间的楼栋编号
	 */
	@Override
	public List<String> getallhavenullhousebuildNumber() {
		List<String> listbuildnumber = houseownerdao.getallhavenullhousebuildNumber();
		return listbuildnumber;
	}
	/**
	 * 根据楼栋编号查询该楼栋中还有空房间的单元
	 */
	@Override
	public List<Integer> getallhavenullhousehouseunit(String buildNumber) {
		List<Integer> listhouseunit = houseownerdao.getallhavenullhousehouseunit(buildNumber);
		return listhouseunit;
	}
	/**
	 * 根据楼栋号，单元号，查询空房间的房间号
	 */
	@Override
	public List<String> getallnullhousehousenumber(String buildNumber, int houseUnit) {
		List<String> listhousenumber = houseownerdao.getallnullhousehousenumber(buildNumber, houseUnit);
		return listhousenumber;
	}
	/**
	 * 根据楼栋编号，单元号，房间号查询该房间是否有人居住
	 */
	@Override
	public int checkhouseisnull(String buildNumber, int houseUnit, String houseNumber) {
		return houseownerdao.checkhouseisnull(buildNumber, houseUnit, houseNumber);
	}
	/**
	 * 新增业主
	 */
	@Override
	public void inserthouseownerinfo(HouseOwner houseownerinfo) {
		houseownerdao.inserthouseownerinfo(houseownerinfo);
	}
	/**
	 * 获取所有业主名称，去掉重复的
	 */
	@Override
	public List<String> getallonluhouseownername() {
		List<String> onluhouseownername = houseownerdao.getallonlyhouseownername();
		return onluhouseownername;
	}
	
	/**
	 * 业主迁出，同时删除家庭成员信息，停车位信息
	 */
	@Override
	@Transactional
	public void deleteowner(int ownerId) {
		try {
			familydao.deletefamilyofowner(ownerId);//先删除该业主的家庭成员信息
			parkingdao.takebackownerofparking(ownerId);//收回该业主的停车位信息
			houseinfodao.updatehouseinfoofowner(ownerId);//将房间信息中该业主的id置为空，入住时间为空，状态置为0待售
			complaintservice.deletecomplaintofowner(ownerId);//删除该业主的所有投诉信息
			repairservice.deleterepairofowner(ownerId);//删除该业主的偶有报修信息
			payinfodetailsservice.deletepayinfodetailsofowner(ownerId);//删除改业主的所有缴费信息
			payinfosumservice.deletepayinfosumofowner(ownerId);//删除该业主的缴费汇总信息
			houseownerdao.deleteowner(ownerId);//删除业主
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	/**
	 * 模糊查询业主信息
	 */
	@Override
	public Pager<HouseOwner> gethouseownerinfolike(String buildNumber, String houseUnit, String houseNumber,
			String ownerName, String ownerPhone,int page,int size) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("page", (page-1)*size);
		params.put("size", size);
		List<HouseOwner> listhouseowner = houseownerdao.gethouseownerinfolike(buildNumber, houseUnit, houseNumber, ownerName, ownerPhone,params);
		Pager<HouseOwner> pager = new Pager<HouseOwner>();
		pager.setRows(listhouseowner);
		pager.setTotal(houseownerdao.likecount(buildNumber, houseUnit, houseNumber, ownerName, ownerPhone));
		return pager;
	}
	
}
