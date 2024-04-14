using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebAppYte.Models;
using OfficeOpenXml;
using OfficeOpenXml.FormulaParsing.Excel.Functions.RefAndLookup;
using OfficeOpenXml.Table;

namespace WebAppYte.Areas.Admin.Controllers
{
    public class ThongKeController : Controller
    {
        private modelWeb db = new modelWeb();

        public ActionResult Index()
        {
            return View();
        }
        public ActionResult DangXuatAd()
        {
            Session["userAdmin"] = null;
            return RedirectToAction("Index", "HomeAdmin");
        }

        [HttpPost, ActionName("ExportExcel")]
        public ActionResult ExprtExcel(DateTime startDate, DateTime endDate)
        {
            string templatePath = Server.MapPath("~/Content/Template.xlsx");
            //FileInfo templateFile = new FileInfo(templatePath);

            Console.WriteLine(startDate);
            var fileBytes = System.IO.File.ReadAllBytes("path_to_your_excel_file.xlsx"); 
            return File(fileBytes, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", "filename.xlsx");
        }
    }
}