package com.peizhiwei.community.admin.service;

import java.util.List;

import com.peizhiwei.community.admin.entity.PayInfoDetails;
import com.peizhiwei.community.admin.entity.PayInfoSum;
import com.peizhiwei.community.util.Pager;

public interface PayInfoSumService {
	/**
	 * 获取所有汇总信息
	 * @return
	 */
	Pager<PayInfoSum> pagegetallpayinfosum(int page,int size);
	/**
	 * 获取所有汇总信息
	 * @return
	 */
	List<PayInfoSum> getallpayinfosum();
	/**
	 * 在插入业主的同时插入业主汇总信息
	 * @param payinfosum
	 */
	void insertpayinfosum(PayInfoSum payinfosum);
	/**
	 * 更新缴费汇总信息
	 * @param payinfosum
	 */
	void updatepayinfosum();
	/**
	 * 一键缴费
	 * @param payinfodetails
	 */
	void updatepayinfodetailsstate(PayInfoDetails payinfodetails);
	/**
	 * 根据业主id删除该业主的缴费汇总信息
	 * @param ownerId
	 */
	void deletepayinfosumofowner(int ownerId);
	/**
	 * 批量缴费
	 * @param listpayinfodetails
	 */
	void batchpaid(List<PayInfoDetails> listpayinfodetails);
	/**
	 * 查询所有欠费的缴费汇总信息
	 * @return
	 */
	Pager<PayInfoSum> selectpayinfodetailsaccordingispaid(int page,int size);
	/**
	 * 查询所有不欠费的缴费汇总信息
	 * @return
	 */
	Pager<PayInfoSum> selectpayinfodetailsaccordingnotpaid(int page,int size);
}
