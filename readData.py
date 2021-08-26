import pymysql

class readData:
    def readData(self):
        # 获取wlw_area中所有数据信息
        SQL_ = "SELECT id,name,parent_id,grade,pinyin,lon,lat FROM wlw_area"
        db_conn = pymysql.connect("daas-stage-msyql.mysql.database.chinacloudapi.cn","oicread@daas-stage-msyql","Kp13&a1pA3mty1?","abb_daas")
        cursor = db_conn.cursor()
        cursor.execute("SELECT id,name,parent_id,grade,pinyin,lon,lat FROM wlw_area")
        data_tuple = cursor.fetchall()