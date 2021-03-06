package com.peizhiwei.community.admin.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.peizhiwei.community.admin.entity.BuildingInfo;
import com.peizhiwei.community.admin.entity.HouseInfo;

public interface BuildingInfoDao {
	/**
	 * 分页查询所有楼栋信息
	 * @return
	 */
	List<BuildingInfo> pagegetallbuildinginfo(Map<String, Object> params);
	/**
	 * 查询楼栋总数
	 */
	long count();
	/**
	 * 查询所有楼栋信息
	 */
	List<BuildingInfo> getallbuildinginfo();
	/**
	 * 根据楼房编号判断数据库中是否已存在该编号
	 * @param buildNumber
	 * @return
	 */
	int selectnumberisnull(String buildNumber);
	/**
	 * 修改楼栋信息
	 * @param buildinginfo
	 */
	void changebuildinfo(BuildingInfo buildinginfo);
	/**
	 * 查询这栋楼是否有住户
	 * @param buildId
	 * @return
	 */
	boolean selectbuildhouseisowner(int buildId);
	/**
	 * 删除这栋楼的信息
	 * @param buildId
	 */
	void deletebuildinfo(int buildId);
	/**
	 * 在删除楼栋信息的同时，若该楼栋中没有住户，则根据楼栋信息的id删除该楼栋的所有房间
	 * @param buildId
	 */
	void deletehouseinfoofbuild(int buildId);
	/**
	 * 插入一条楼栋信息
	 * @param buildinginfo
	 */
	void insertbuildinfo(BuildingInfo buildinginfo);
	/**
	 * 在增加楼栋信息的同时批量插入房间信息
	 * @param houseinfolist
	 */
	void inserthouseinfolist(@Param("houseinfolist")List<HouseInfo> houseinfolist);
	/**
	 * 通过id查询楼栋编号
	 * @param buildId
	 * @return
	 */
	String selectbuildnumber(int buildId);
	/**
	 * 根据楼栋编号模糊查询楼栋信息
	 * @param buildNumber
	 * @return
	 */
	List<BuildingInfo> selectlikebuildinginfo(@Param("buildNumber")String buildNumber,@Param("params")Map<String, Object> params);
	/**
	 * 模糊查询的总记录数
	 * @return
	 */
	long likecount(@Param("buildNumber")String buildNumber);
}
