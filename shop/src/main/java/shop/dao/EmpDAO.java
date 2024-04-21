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


public class EmpDAO {
	
	public static HashMap<String, String> empLogin(String[] paramsArr, HttpServletRequest request, HttpServletResponse response) throws Exception{
		HashMap<String, String> resultMap = null;
		Common common = new Common();
		Connection conn = null;
		for(String p : paramsArr){
			if(p == null || p == "" || p.equals("null")) {
				System.out.println(p);
				return resultMap;
			}else{
				System.out.println(p + " --> 성공 ");
			}
		};
		String empId = paramsArr[0];
		String empPw = paramsArr[1];
		try {
			conn = common.DBConnection();			
			String sql = "SELECT emp_id empId, grade, emp_name empName, emp_job empJob, hire_date hireDate, active "
					+"FROM EMP WHERE active='ON' AND emp_id = ? AND emp_pw = PASSWORD(?)";
			PreparedStatement stmt = conn.prepareStatement(sql);
			stmt.setString(1, empId);
			stmt.setString(2, empPw);
			ResultSet rs1 = stmt.executeQuery();		
			resultMap = new HashMap<String, String>();
			
		 	if(rs1.next()){
		 		// 세션을 '맵'으로 담기, 들어갈 객체는 empId, empName, grade
		 		resultMap.put("empId", rs1.getString("empId"));
		 		resultMap.put("empName", rs1.getString("empName"));
		 		resultMap.put("grade", rs1.getString("grade"));
		 		String empIdStr = (String)(resultMap.get("empId"));
		 		String empNameStr = (String)(resultMap.get("empName"));
		 		String gradeStr = (String)(resultMap.get("grade"));
		 		System.out.println("empIdStr : " + empIdStr);
		 		System.out.println("empNameStr : " + empNameStr);
		 		System.out.println("gradeStr : " + gradeStr);
			} else{
		 		return resultMap;
			}
		} catch (Exception e) {
			e.printStackTrace();	
			return resultMap;
		}	
		return resultMap;
	}
	
	public static int selectEmpListCntOne() throws Exception {
		Model model = new Model();
		int result = 0;
		String qry = "select COUNT(*) cnt from emp";
		String[] qryNameArr = {"cnt"};
		result =  Integer.parseInt(""+model.listOneQry(qry, qryNameArr, new HashMap<>()).get("cnt"));
		return result;
	}
	
	public static ArrayList<HashMap<String, Object>> selectEmpList(HttpServletRequest request, HashMap<Integer, Object> qryParamMap) throws Exception{
		Model model = new Model();
		String qry = "select emp_id empId, emp_name empName,"
				+ " emp_job empJob, hire_date hireDate, active "
				+ "from emp order by hire_date desc limit ?, ?";
		ArrayList<HashMap<String, Object>> list = model.listQry(qry, new String[] {"empId", "empName", "empJob", "hireDate", "active"}, qryParamMap);
		return list;
	}
	
	
	public static ArrayList<HashMap<String, Object>> selectGoodsList(HttpServletRequest request, HashMap<Integer, Object> qryParamMap) throws Exception{
		Model model = new Model();
		String qry = "SELECT "
				+ "goods_no no, category, emp_id empId, "
				+ "goods_title title, goods_content content, "
				+ "goods_price price, goods_amount amount, filename"
				+" FROM goods WHERE 1 = 1 ";
		ArrayList<HashMap<String, Object>> list = model.listQry(qry, 
				new String[] {
						"no",
						"category",
						"empId",
						"title",
						"content",
						"price",
						"amount",
						"filename"
						}, qryParamMap);
		return list;
	}
	
	
	public static ArrayList<HashMap<String, Object>> selectGooodsListGroupByCategory(HttpServletRequest request, HashMap<Integer, Object> qryParamMap) throws Exception{
		Model model = new Model();
		String qry = "SELECT category, count(*) cnt FROM goods "
				+ "WHERE 1=1 "
				+ " GROUP BY category ORDER BY category ASC";
		ArrayList<HashMap<String, Object>> list = model.listQry(qry, new String[] {"category", "cnt"}, qryParamMap);
		return list;
	}
	public static ArrayList<HashMap<String, Object>> selectCategoryList(HttpServletRequest request, HashMap<Integer, Object> qryParamMap) throws Exception{
		Model model = new Model();
		String qry = "select category from category GROUP BY category ORDER BY category ASC";
		return model.listQry(qry, new String[]{"category"}, qryParamMap);
	}
	
	public static ArrayList<HashMap<String, Object>> selectEmpJobList(HttpServletRequest request, HashMap<Integer, Object> qryParamMap) throws Exception{
		Model model = new Model();
		String qry = "SELECT emp_job empJob "
				+ "FROM emp "
				+ "GROUP BY emp_job "
				+ "ORDER BY emp_job DESC";
		ArrayList<HashMap<String, Object>> list = model.listQry(qry, new String[] {"empJob"}, qryParamMap);
		return list;
	}
	
	public static int insertEmp(HashMap<Integer, Object> qryParamMap) throws SQLException, Exception {
		Model model = new Model();
		int result = 0;
		String qry = "INSERT INTO emp(emp_id, emp_pw, emp_name, emp_job, hire_date"
				+") VALUES (?,PASSWORD(?), ?, ?, ?)";
		return model.addQry(qry, qryParamMap);
	}
	
	
	

}
