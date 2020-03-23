package com.peizhiwei.community.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.peizhiwei.community.dao.PayTypeDao;
import com.peizhiwei.community.entity.PayType;
import com.peizhiwei.community.service.PayTypeService;

@Service
public class PayTypeServiceImpl implements PayTypeService {
	@Autowired
	PayTypeDao paytypedao;
	/**
	 * 获取所有类别信息
	 */
	@Override
	public List<PayType> getallpaytype() {
		List<PayType> listtype = paytypedao.getallpaytype();
		return listtype;
	}
	/**
	 * 修改类别信息
	 */
	@Override
	public void updatepaytypeinfo(PayType paytype) {
		paytypedao.updatepaytypeinfo(paytype);	
	}
	/**
	 * 删除收费类别信息
	 */
	@Override
	public void deletepaytypeinfo(int payTypeId) {
		paytypedao.deletepaytypeinfo(payTypeId);
	}
	/**
	 * 新增收费类别
	 */
	@Override
	public void insertpaytypeinfo(PayType paytype) {
		paytypedao.insertpaytypeinfo(paytype);
	}
	@Override
	public boolean selectpaytypename(String payTypeName) {
		boolean flag = paytypedao.selectpaytypename(payTypeName);
		return flag;
	}
}
