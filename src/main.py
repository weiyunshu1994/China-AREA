import json
import re
import pymysql
import requests
import xlsxwriter
import xlrd
import pypinyin
from bs4 import BeautifulSoup

##################################
# 功能：保存官方1980到2020间的行政区划数据
##################################
class save_gfdt():
    def __init__(self):
        # 从官方首页http://www.mca.gov.cn/article/sj/xzqh/1980/? 获取到每个年份的URL地址
        # 除2013和2014外, 都是http格式，可直接爬取
        self.url_list_key1 = {
            # "1980": "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708040959.html",
            # "1981": "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708041004.html",
            # "1982": "http://www.mca.gov.cn/article/sj/xzqh/1980/1980/201911180942.html",
            # "1983": "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708160821.html",
            # "1984": "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708220856.html",
            # "1985": "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708220858.html",
            # "1986": "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708220859.html",
            # "1987": "http://www.mca.gov.cn/article/sj/xzqh/1980/1980/201911180950.html",
            # "1988": "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708220903.html",
            # "1989": "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708041017.html",
            # "1990": "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708041018.html",
            # "1991": "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708041020.html",
            # "1992": "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708220910.html",
            # "1993": "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708041023.html",
            # "1994": "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708220911.html",
            # "1995": "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708220913.html",
            # "1996": "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708220914.html",
            # "1997": "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708220916.html",
            # "1998": "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708220918.html",
            # "1999": "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708220921.html",
            # "2000": "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708220923.html",
            # "2001": "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708220925.html",
            # "2002": "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708220927.html",
            # "2003": "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708220928.html",
            # "2004": "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708220930.html",
            # "2005": "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708220935.html",
            # "2006": "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708220936.html",
            # "2007": "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708220939.html",
            # "2008": "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708220941.html",
            # "2009": "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708220943.html",
            # "2010": "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201708220946.html",
            # "2011": "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201707271552.html",
            # "2012": "http://www.mca.gov.cn/article/sj/tjbz/a/201713/201707271556.html",
            "2015": "http://www.mca.gov.cn/article/sj/tjbz/a/2015/201706011127.html",
            "2016": "http://www.mca.gov.cn/article/sj/xzqh/1980/201705/201705311652.html",
            "2017": "http://www.mca.gov.cn/article/sj/xzqh/1980/201803/201803131454.html",
            "2018": "http://www.mca.gov.cn/article/sj/xzqh/1980/201903/201903011447.html",
            "2019": "http://www.mca.gov.cn/article/sj/xzqh/1980/2019/202002281436.html",
            "2020": "http://www.mca.gov.cn/article/sj/xzqh/2020/20201201.html"
        }
        # 2013年和2014年是https格式，需要将文本下载下来再正则匹配
        self.url_list_key2 = {
            "2013": "https://files2.mca.gov.cn/cws/201404/20140404125552372.htm",
            "2014": "https://files2.mca.gov.cn/cws/201502/20150225163817214.html"
        }
        self.workbook = xlsxwriter.Workbook("../data/中国行政区划信息表.xlsx")

    def save_url_list_key1(self):
        for key, value in self.url_list_key1.items():
            print("write {}".format(key))
            res = requests.get(value)
            soup = BeautifulSoup(res.text, features="html.parser")
            code = re.findall(r'[0-9]{6}', soup.text)
            name = re.findall(r'[\u4e00-\u9fa5]{2,15}', soup.text)
            code_list = []
            name_list = []
            for tmp in code:
                code_list.append(tmp)
            for tmp in name:
                name_list.append(tmp)
            worksheet = self.workbook.add_worksheet(key)
            worksheet.activate()
            i = 0
            for tmp in code_list:
                i = i + 1
                worksheet.write_row('A' + str(i), [str(tmp)])
            i = 0
            for tmp in name_list:
                i = i + 1
                worksheet.write_row('B' + str(i), [str(tmp)])
            print("write {} success".format(key))
        self.workbook.close()

    def save_url_list_key2(self):
        data_path = {
            "2013": r"../data/2013年数据.txt",
            "2014": r"../data/2014年数据.txt"
        }
        for key, value in data_path.items():
            print("write {}".format(key))
            with open(value,"r",encoding='utf-8') as f:
                data = f.read()
                code = re.findall(r'[0-9]{6}', data)
                name = re.findall(r'[\u4e00-\u9fa5]{2,15}', data)
            code_list = []
            name_list = []
            for tmp in code:
                code_list.append(tmp)
            for tmp in name:
                name_list.append(tmp)
            worksheet = self.workbook.add_worksheet(key)
            worksheet.activate()
            i = 0
            for tmp in code_list:
                i = i + 1
                worksheet.write_row('A' + str(i), [str(tmp)])
            i = 0
            for tmp in name_list:
                i = i + 1
                worksheet.write_row('B' + str(i), [str(tmp)])
            print("write {} success".format(key))

    def run(self):
        # self.save_url_list_key1()
        self.save_url_list_key2()
        self.workbook.close()


##############################################
# 功能：从腾讯地图的接口获取设备信息，并将其写到数据库当中
##############################################
class save_txdt:
    def __init__(self):
        self.file_name = "腾讯地图.xlsx"
        self.sheet_name = "腾讯地图"
        self.URL= "https://apis.map.qq.com/ws/district/v1/list?key=ZDVBZ-ONQKW-KK4R5-RHOJI-T5USF-TSB6J"

    def read_txdt_area(self):
        resp = requests.get(self.URL)
        data = resp.json()
        data1 = data["result"]
        area = []
        for i in data1[0]:
            pinyin = ""
            for j in i["pinyin"]:
                pinyin = pinyin + j
            grade_id = self.grade(i["id"])
            parent_id = self.parent(i["id"], grade_id)
            tmp = [i["id"], i["fullname"], parent_id, grade_id, pinyin, i["location"]["lat"], i["location"]["lng"]]
            area.append(tmp)
        for i in data1[1]:
            pinyin = ""
            for j in i["pinyin"]:
                pinyin = pinyin + j
            grade_id = self.grade(i["id"])
            parent_id = self.parent(i["id"], grade_id)
            tmp = [i["id"], i["fullname"], parent_id, grade_id, pinyin, i["location"]["lat"], i["location"]["lng"]]
            area.append(tmp)
        for i in data1[2]:
            grade_id = self.grade(i["id"])
            parent_id = self.parent(i["id"], grade_id)
            tmp = [i["id"], i["fullname"], parent_id, grade_id, "", i["location"]["lat"], i["location"]["lng"]]
            area.append(tmp)

        workbook = xlsxwriter.Workbook(self.file_name)
        worksheet1 = workbook.add_worksheet(self.sheet_name)
        worksheet1.activate()
        title = ["ID", "名称"]
        worksheet1.write_row('A1', title)
        i = 2
        for j in area:
            insertData = j
            row = 'A' + str(i)
            worksheet1.write_row(row, insertData)
            i += 1
        workbook.close()

    def grade(self,str):
        if (len(str) != 6):
            print("error")
        if (str[2:6] == "0000"):
            return 1
        if ((str[2:4] != "00") and str[4:6] == "00"):
            return 2
        if (str[4:6] != "00"):
            return 3

    def parent(self,num, grade_id):
        if grade_id == 1:
            return 0
        if grade_id == 2:
            return num[0:2] + "0000"
        if grade_id == 3:
            return num[0:4] + "00"


class save_lz:
    def __init__(self):
        self.url = "daas-stage-msyql.mysql.database.chinacloudapi.cn"
        self.user = "oicread@daas-stage-msyql"
        self.password = "Kp13&a1pA3mty1?"
        self.database = "abb_daas"
        self.file_name = "联掌数据.xlsx"
        self.sheet_name = "联掌数据"

    def read_lzdt_area(self):
        db_conn = pymysql.connect(self.url,self.user,self.password,self.database)
        cursor = db_conn.cursor()
        cursor.execute("SELECT id,name,parent_id,grade,pinyin,lon,lat FROM wlw_area")
        data_tuple = cursor.fetchall()
        data_list = []
        for i in data_tuple:
            list_temp = []
            for index in range(len(i)):
                print(type(i[index]))
                if type(i[index]) is int:
                    list_temp.append(str(i[index]))
                else:
                    list_temp.append(i[index])
            data_list.append(list_temp)

        # print(data_list)
        # return data_list
        workbook = xlsxwriter.Workbook(self.file_name)
        worksheet1 = workbook.add_worksheet(self.sheet_name)
        worksheet1.activate()
        title = ["ID", "名称"]
        worksheet1.write_row('A1', title)
        i = 2
        for j in data_list:
            insertData = j
            row = 'A' + str(i)
            worksheet1.write_row(row, insertData)
            i += 1
        workbook.close()


##############################################
# 将sue整理好的拼音数据存放在腾讯地图当中
##############################################
def write_txdt_py():
    tmp = []
    table_tx = []
    table_sue = []
    key_sue = {}
    excel_path_tx = r"腾讯地图.xlsx"
    excel_path_sue = r"地区拼音生成说明_scl.xlsx"
    data_tx = xlrd.open_workbook(excel_path_tx)
    data_sue = xlrd.open_workbook(excel_path_sue)
    sh = data_tx.sheet_by_index(0)
    sh_sue = data_sue.sheet_by_index(0)
    store1 = []
    store2 = []
    for i in range(sh_sue.nrows):
        if i == 0:
            continue
        try:
            print(key_sue[sh_sue.row_values(i)[0]] + "已存在")
            store1.append(sh_sue.row_values(i)[0])
        except:
            print(sh_sue.row_values(i)[0] + "不存在")
            store2.append(sh_sue.row_values(i)[0])
        # store2.append("0")

        key_sue[sh_sue.row_values(i)[0]] = sh_sue.row_values(i)[1]
        # key_sue[sh_sue.row_values(i)[0]] = sh_sue.row_values(i)[1]
        table_sue.append(sh_sue.row_values(i)[0])
    # for i in range(sh_sue.nrows):
    #     if i == 0:
    #         continue


    i = 1
    repeat_m = []
    # for m in table_sue:
    #     print(i,m,key_sue[m])
    #
    #     i = i + 1
    print(i)
    # for i in range(sh.nrows):
    #     if i == 0:
    #         continue
    #     if sh.row_values(i)[1] in table_sue:
    #         sh.row_values(i)[4] = key_sue[sh.row_values(i)[1]]
    #     else:
    #         sh.row_values(i)[4] = ""
    #     table_tx.append(sh.row_values(i))

    # workbook = xlsxwriter.Workbook("腾讯地图2.xlsx")
    # worksheet1 = workbook.add_worksheet("sheet0")
    # worksheet1.activate()
    # title = ["ID", "名称"]
    # worksheet1.write_row('A1', title)
    # i = 2
    # for j in table_tx:
    #     insertData = j
    #     row = 'A' + str(i)
    #     worksheet1.write_row(row, insertData)
    #     i += 1
    # workbook.close()
    #
    # print(table_tx)


##############################################
# 功能：查找重名的区域，并将其列出来
# 背景：sue统计每个地区及其拼音之后，使用区域名和拼音的
#      方式存储在excel表中，但区域名有重的，这里找出重
#      名的区域并将其列出来
# 输入：
##############################################
def list_repeat_area():
    # 存放字典
    key_sue = {}
    # 存放重复的地名
    store1 = []
    # 存放不重复的地名
    store2 = []
    excel_path_sue = r"地区拼音生成说明_scl.xlsx"
    data_sue = xlrd.open_workbook(excel_path_sue)
    sh_sue = data_sue.sheet_by_index(0)
    for i in range(sh_sue.nrows):
        if i == 0:
            continue
        try:
            print(key_sue[sh_sue.row_values(i)[0]] + "已存在")
            store1.append(sh_sue.row_values(i)[0])
        except:
            print(sh_sue.row_values(i)[0] + "不存在")
            store2.append(sh_sue.row_values(i)[0])
        key_sue[sh_sue.row_values(i)[0]] = sh_sue.row_values(i)[1]
    # 将有重复的地名存入数据库excel当中
    file_name = "重复的地名.xlsx"
    workbook = xlsxwriter.Workbook(file_name)
    worksheet1 = workbook.add_worksheet("sheet1")
    worksheet1.activate()

    title = ["重复地名", "非重复地名"]
    worksheet1.write_row('A1', title)

    row_num = 2
    for insertData in store1:
        row = 'A' + str(row_num)
        worksheet1.write_row(row, [insertData])
        row_num += 1
    row_num = 2
    for insertData in store2:
        row = 'B' + str(row_num)
        worksheet1.write_row(row, [insertData])
        row_num += 1
    workbook.close()


# 功能：从联掌数据库中获取区域信息
def read_lz_area():
    db_conn = pymysql.connect("daas-stage-msyql.mysql.database.chinacloudapi.cn","oicread@daas-stage-msyql","Kp13&a1pA3mty1?","abb_daas")
    cursor = db_conn.cursor()
    cursor.execute("SELECT id,name,parent_id,grade,pinyin,lon,lat FROM wlw_area")
    data_tuple = cursor.fetchall()
    data_list = []
    for i in data_tuple:
        list_temp = []
        for index in range(len(i)):
            print(type(i[index]))
            if type(i[index]) is int:
                list_temp.append(str(i[index]))
            else:
                list_temp.append(i[index])
        data_list.append(list_temp)
    # print(data_list)
    return data_list


# 功能：从官网中获取区域信息
def read_cn_area():
    url = "http://www.mca.gov.cn/article/sj/xzqh/2020/20201201.html"
    res = requests.get(url)
    print(res.text)
    # print("h")


##############################
# 功能：比较两个列表中不同的元素
# 输入：
#   area_1：数据1，列表形式
#   area_2: 数据2，列表形式
#   n：比较第n列
# 输出:
#   存在area_1中，但不存在于area_2当中的数据，返回area_1对应的列表
##############################
def diff(area_1,area_2,n):
    diff_list = []
    for i in area_1:
        is_have = 0
        for j in area_2:
            if i[n] == j[n]:
                is_have = 1
                break
        if is_have == 0:
            diff_list.append(i)
    print(diff_list)
    xw_toExcel(diff_list,"联掌数据.xlsx")


# 存储数据到excel
def xw_toExcel(data,fileName):
    workbook =xlsxwriter.Workbook(fileName)
    worksheet1 = workbook.add_worksheet("sheet2")
    worksheet1.activate()
    title = ["ID","名称"]
    worksheet1.write_row('A1',title)
    i = 2
    for j in data:
        insertData = j
        row = 'A' + str(i)
        worksheet1.write_row(row,[insertData])
        i +=1
    workbook.close()


def read_from_excel():
    table = []
    excel_path = r"腾讯地图.xlsx"
    data = xlrd.open_workbook(excel_path)
    print("The number of worksheets is {0}".format(data.nsheets))
    print("Worksheet names:{0}".format(data.sheet_names()))
    sh = data.sheet_by_index(0)
    print("{0} {1} {2}".format(sh.name,sh.nrows,sh.ncols))
    print("Cell D30 is  {0}".format(sh.cell_value(rowx=29,colx=1)))
    for i in range(sh.nrows):
        table.append(sh.row_values(i))
    print(table)

    # data1 = data.sheets()[0]
    # tables = []

    # excel_path2 = "C:\\Users\\CNALWEI\\Desktop\\笔记\\公司subject\\DaaS各个微服务说明\\abb-service-base\\地名拼音说明_scl\\地区拼音生成说明_scl.xlsx"
    # data_path2 = xlrd.open_workbook(excel_path2)
    # data2_path2 = data_path2.sheets()[0]
    # tables_path2 = {}
    # tables_path2_name = []
    # for rown in range(data2_path2.nrows):
    #     # array = [data2_path2.cell_value(rown,0),data2_path2.cell_value(rown,1)]
    #     # tables_path2.append(array)
    #     if rown==0:
    #         continue
    #     tables_path2[data2_path2.cell_value(rown,0)] = data2_path2.cell_value(rown,1)
    #     tables_path2_name.append(data2_path2.cell_value(rown,0))

    # for rown in range(data1.nrows):
    #     if data1.cell_value(rown,1) in tables_path2_name:
    #         array = [int(data1.cell_value(rown,0)),data1.cell_value(rown,1),int(data1.cell_value(rown,2)),
    #                  int(data1.cell_value(rown,3)),tables_path2[data1.cell_value(rown,1)],data1.cell_value(rown,5),
    #                  data1.cell_value(rown,6)]
    #     else:
    #         array = [int(data1.cell_value(rown, 0)), data1.cell_value(rown, 1), int(data1.cell_value(rown, 2)),
    #                  int(data1.cell_value(rown, 3)), tables_path2[data1.cell_value(rown, 1)], data1.cell_value(rown, 5),
    #                  data1.cell_value(rown, 6)]
    #
    #     tables.append(array)
    # print(tables)


def generate_area():
    pass

def test():
    key= {}
    key["a"] = 1
    key["b"] = 2
    key["c"] = 3
    for i in ["a","b","c","d","e"]:
        try:
            print(key[i])
        except:
            print("he")


def test2():
    file_name = "重复的地名.xlsx"
    workbook = xlsxwriter.Workbook(file_name)
    worksheet1 = workbook.add_worksheet("sheet1")
    worksheet1.activate()

    title = ["重复地名", "非重复地名"]
    worksheet1.write_row('A1', title)

    row_num = 2
    row = 'A' + str(row_num)
    # 这里需要放一个队列
    worksheet1.write_row(row, ["insertData"])
    workbook.close()


def test3():
    URL = "http://www.mca.gov.cn/article/sj/xzqh/2020/20201201.html"
    resp = requests.get(URL)
    data = resp.text
    print(data)


def write_to_sql():
    # 读取表格信息
    f = open("../data/ABB区域信息更新SQL.txt",'a',encoding='utf-8')
    table = []
    excel_path = r"../data/ABB区域信息更新 - 副本.xlsx"
    data = xlrd.open_workbook(excel_path)
    # print("The number of worksheets is {0}".format(data.nsheets))
    # print("Worksheet names:{0}".format(data.sheet_names()))
    sh = data.sheet_by_index(0)
    # print("{0} {1} {2}".format(sh.name, sh.nrows, sh.ncols))
    # print("Cell D30 is  {0}".format(sh.cell_value(rowx=29, colx=1)))
    for i in range(sh.nrows):
        table.append(sh.row_values(i))
        line = '(' + str(int(sh.row_values(i)[0])) + ",'" + \
               sh.row_values(i)[1] + '\',' + \
               str(int(sh.row_values(i)[2])) + ',' + \
               str(int(sh.row_values(i)[3])) + ',\'' +\
               sh.row_values(i)[4] + '\',\'' + \
               str(sh.row_values(i)[5]) + '\',\''+\
               str(sh.row_values(i)[6]) + '\','+\
               "0,NULL,0,NULL)," + '\n'
        f.writelines(line)
    print(table)
    f.close()


###################################################
# 功能:读取数据库中的区域信息，判断是是否在新生成的文件当中
#     主要是community中的county_id字段
###################################################
def is_in_newfile(env):
    url = "http://www.mca.gov.cn/article/sj/xzqh/2020/20201201.html"
    res = requests.get(url)
    soup = BeautifulSoup(res.text)
    # cost = re.findall(r'[1-9]+\.?[0-9]*', soup.text)

    if env == "oic":
        db_con = ""
        db_user = ""
        db_pd = ""
        db_name = ""
    elif env == "dev":
        db_con = ""
        db_user = ""
        db_pd = ""
        db_name = ""
    elif env == "stage":
        db_con = ""
        db_user = ""
        db_pd = ""
        db_name = ""
    else:
        print("输入环境错误，请重新输入")

    db_con_aliyun = "www.weimianjin.com:3306"
    db_user_aliyun = "root"
    db_pd_aliyun = "wmj19941014"
    db_name_aliyun = "wmj1994104"

    db_conn = pymysql.connect(db_con,db_user,db_pd,db_name)
    cursor = db_conn.cursor()
    cursor.execute("SELECT id,county_id FROM wlw_community")
    data_tuple = cursor.fetchall()
    data_list = []
    for i in data_tuple:
        tmp = i[1]
        is_have = re.findall(str(tmp), soup.text)
        if len(is_have) == 0:
            data_list.append(i)
    print(data_list)


###################################
# 功能：比较两年间区域信息的变更
# 输入：
#       year1：第一年的年份
#       year2：第二年的年份, year2>year1
# 输出：
#       list1：撤销的区域编码
#       list2：新增的区域编码
###################################
def diff_two_year(year1,year2):
    excel_path_tx = r"../data/中国区域信息表.xlsx"
    data_tx = xlrd.open_workbook(excel_path_tx)
    sh1 = data_tx.sheet_by_name(str(year1))
    data_code_year1 = sh1.col_values(0)
    data_name_year1 = sh1.col_values(1)
    year1_key = {}
    for i in range(len(data_code_year1)):
        year1_key[data_code_year1[i]]= data_name_year1[i]
    sh2 = data_tx.sheet_by_name(str(year2))
    data_code_year2 = sh2.col_values(0)
    data_name_year2 = sh2.col_values(1)
    year2_key = {}
    for i in range(len(data_code_year2)):
        year2_key[data_code_year2[i]] = data_name_year2[i]
    # data_year2中有而data_year1中没有，即新增的区域
    inc_code = list(set(data_code_year2).difference(set(data_code_year1)))
    inc_list = []
    for temp in inc_code:
        inc_list.append([temp,year2_key[temp]])
    # data_year1中有而data_year2中没有，即删除的区域
    del_code = list(set(data_code_year1).difference(set(data_code_year2)))
    del_list = []
    for temp in del_code:
        del_list.append([temp, year1_key[temp]])
    print("相比于{}年，{}删除以下{}个区域".format(year1,year2,len(del_list)))
    for i in del_list:
        print(i)
    # print(del_list)
    print("相比于{}年，{}增加以下{}个区域".format(year1, year2,len(inc_list)))
    for i in inc_list:
        print(i)
    # print(inc_list)


if __name__ == '__main__':
    # diff_two_year(2019,2020)
    save_gfdt().run()
    # write_2013_and_2014()
    # save = save_gfdt()
    # save.write()
    # is_in_newfile("stage")
    # write_to_sql()
    # m = read_gfdt()
    # m.bs()
    # list_repeat_area()
    # test3()
    # write_txdt_py()
    # p = read_lz()
    # p.read_lzdt_area()
    # p = read_txdt()
    # p.read_txdt_area()
    # read_from_excel()
    # 联掌的数据
    # lz_area = read_lz_area()
    # 腾讯地图数据
    # txdt_area = read_txdt_area()
    # xw_toExcel(txdt_area,"腾讯地图.xlsx")
    # 生成全部数据
    # generate_area()
    # grade_id = grade("130800")
    # parent_id = parent("130800", grade_id)
    # print(grade_id)
    # print(parent_id)

    # 比较不同的数据
    # diff(txdt_area,lz_area,0)