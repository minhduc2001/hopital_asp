using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebAppYte.Models;
using OfficeOpenXml;
using OfficeOpenXml.FormulaParsing.Excel.Functions.RefAndLookup;
using OfficeOpenXml.Table;
using System.Web.Http.Results;
using System.Xml.Linq;
using System.IO;

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
        public ActionResult ExprotExcel(DateTime startDate, DateTime endDate)
        {
            string templatePath = Server.MapPath("~/Content/Template.xlsx");

            
            List<NguoiDung> nguoiDungs = db.NguoiDungs.Where(d => d.tendn == "admin").ToList();
            List<DatLich> datLiches = db.DatLiches.Where(d => d.ngaydat >= startDate && d.ngaydat <= endDate && d.trangthai == 2).ToList();


            List<ExportExcelTemplate> template = new List<ExportExcelTemplate>();
            

            foreach(DatLich datlich in datLiches)
            {
                ExportExcelTemplate exportExcelTemplate = new ExportExcelTemplate
                {
                    chinhanh = datlich.CaKham.NguoiDung.ChiNhanh.diachi,
                    bacsi = datlich.CaKham.NguoiDung.hoten,
                    khoa = datlich.CaKham.NguoiDung.Khoa.tenkhoa,
                    tenbenhnhan = datlich.hoten,
                    ngaysinh = ((DateTime)datlich.ngaysinh).ToString("dd/MM/yyyy"),
                    ngaykham =((DateTime)datlich.CaKham.ngaykham).ToString("dd/MM/yyyy"),
                    cakham = datlich.CaKham.ca,
                    trangthai = datlich.trangthai.Value,
                    sodienthoai = datlich.sdt
       
                };

                template.Add(exportExcelTemplate);
            }

            TExportExcelTemplate exportExcel = new TExportExcelTemplate
            {
                datas = template,
                username = nguoiDungs[0].hoten,
                start_date = startDate.ToString("dd/MM/yyyy"),
                end_date = endDate.ToString("dd/MM/yyyy")
            };

            //var fileBytes = System.IO.File.ReadAllBytes("path_to_your_excel_file.xlsx"); 
            //return File(fileBytes, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", "filename.xlsx");
            return Json(exportExcel);
        }

        [HttpPost, ActionName("thongkesoluongcakham")]
        public ActionResult ThongKeSoLuongCaKham(DateTime startDate, DateTime endDate)
        {
            List<DatLich> datLiches = db.DatLiches.Where(d => d.ngaydat >= startDate && d.ngaydat <= endDate && (d.trangthai == 1 || d.trangthai == 2)).ToList();
            int soluongdakham = 0;
            int soluongchuakham = 0;
            List<int> result = new List<int>();
            foreach (DatLich datLich in datLiches)
            {
                if (datLich.trangthai == 1)
                {
                    soluongchuakham += 1;
                }
                else soluongdakham += 1;
            }


            result.Add(soluongdakham);
            result.Add(soluongchuakham);
            return Json(result);
        }

        [HttpPost, ActionName("thongkesoluongcakhamtheobacsi")]
        public ActionResult ThongKeSoLuongCaKhamTheoBacSi(DateTime startDate, DateTime endDate)
        {
            List<DatLich> datLiches = db.DatLiches
                .Where(d => d.ngaydat >= startDate && d.ngaydat <= endDate && d.trangthai == 2)
                .ToList();

            List<NguoiDung> nguoiDungs =db.NguoiDungs.ToList();
            
            Dictionary<string, int> myDictionary = new Dictionary<string, int>();
            foreach (NguoiDung nguoiDung in nguoiDungs)
            {
                myDictionary.Add(nguoiDung.hoten.Trim() + " - " + nguoiDung.tendn.Trim(), 0);
            }
            foreach (DatLich datLich in datLiches)
            {
                if(myDictionary.ContainsKey(datLich.CaKham.NguoiDung.hoten.Trim() + " - " + datLich.CaKham.NguoiDung.tendn.Trim()))
                { 
                    myDictionary[datLich.CaKham.NguoiDung.hoten.Trim() + " - " + datLich.CaKham.NguoiDung.tendn.Trim()]++;
                }
            }

            var array = myDictionary.Select(kvp => new { bacsi = kvp.Key, soluong = kvp.Value }).ToArray();
            return Json(array);
        }
    }

    class ExportExcelTemplate
    {
        public int stt;
        public string chinhanh;
        public string bacsi;
        public string khoa;
        public string tenbenhnhan;
        public string ngaysinh;
        public string sodienthoai;
        public string ngaykham;
        public string cakham;
        public int trangthai;
    }

    class TExportExcelTemplate
    {
        public List<ExportExcelTemplate> datas;
        public string username;
        public string start_date;
        public string end_date;

    }
}