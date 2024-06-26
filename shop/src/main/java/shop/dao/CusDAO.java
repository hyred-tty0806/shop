package shop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import shop.Common;
import shop.Model;


public class CusDAO {
	
	public static HashMap<String, Object> selectLoginOneByIdPw(HashMap<Integer, Object> qryParamMap) throws Exception{
		HashMap<String, Object> resultMap = null;
		Model model = new Model();
		String qry = 
				"SELECT"
					+ " id,"
					+ " name,"
					+ " birth,"
					+ " gender,"
					+ " update_date"
					+ " create_date"
				+ " FROM customer"
				+ " WHERE 1=1"
					+ " AND id = ?"
					+ " AND pw = PASSWORD(?)";
		String[] qryNameArr = {"id", "name", "birth", "gender"};		
		resultMap = model.listOneQry(qry, qryNameArr, qryParamMap);
		return resultMap;
	}
	public static HashMap<String, Object> selectGoodsOneByNo(HashMap<Integer, Object> qryParamMap) throws Exception{
		HashMap<String, Object> resultMap = null;
		Model model = new Model();
		String qry = 
				"SELECT goods_no goodsNo,"
				+ "category,"
				+ "goods_title goodsTitle,"
				+ "goods_content goodsContent,"
				+ "goods_price goodsPrice,"
				+ "goods_amount goodsAmount,"
				+ "filename "
				+ "FROM goods "
				+ "where 1 = 1 "
				+ "AND goods_no = ?"; 
		String[] qryNameArr = {"goodsNo", "category", "goodsTitle"
				, "goodsContent", "goodsPrice", "goodsAmount", "filename"};		
		resultMap = model.listOneQry(qry, qryNameArr, qryParamMap);
		return resultMap;
	}
	
	public static int selectEmpListCntOne() throws Exception {
		Model model = new Model();
		int result = 0;
		String qry = "select COUNT(*) cnt from emp";
		String[] qryNameArr = {"cnt"};
		result = Integer.parseInt(""+model.listOneQry(qry, qryNameArr, new HashMap<>()).get("cnt"));
		return result;
	}
	public static int insertCus(HashMap<Integer, Object> qryParamMap) throws Exception {
		Model model = new Model();
		String qry = 
				"INSERT INTO"
					+ " customer (id, pw, name, birth, gender)"
					+ " VALUES(?, PASSWORD(?), ?, ?, ?)";
		return model.addQry(qry, qryParamMap);
	}
}
