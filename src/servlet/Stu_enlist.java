package servlet;
/*
 * 学生报名活动
 */
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import cn.edu.hnuc.volunteer_Sys.util.act_enlist;
import cn.edu.hnuc.volunteer_Sys.util.info_Query;

@WebServlet("/Stu_enlist")
public class Stu_enlist extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public Stu_enlist() {
        super();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");

        int userid = cn.edu.hnuc.volunteer_Sys.util.checkLogin.checkL(request,
                response);
        StringBuilder sb = new StringBuilder();
        // 只有学生才能报名
        if (userid == 1) {
            // 获取学生id
            int stu_id = info_Query.stuAutQuery((String) request.getSession().getAttribute("stu_account")).getStu_id();
            int act_id;
            try {
                act_id = Integer.parseInt(request.getParameter("act_id"));
                int msg = act_enlist.enlist(stu_id, act_id);
                switch (msg) {
                    case 1:
                        sb.append("报名成功！");
                        break;
                    case 2:
                        sb.append("你已报名！");
                        break;
                    case 3:
                        sb.append("该活动报名已满！");
                        break;
                    default:
                        sb.append("报名失败");
                        break;
                }
            } catch (Exception e) {
                sb.append("error");
            }
        } else {
            sb.append("error");
        }
        PrintWriter pw;
        pw = response.getWriter();
        pw.print(sb.toString());
        pw.close();
    }

}
