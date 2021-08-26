class gf_url:

    # 查看中国最近这些年地理位置的变动
    # 将数据放在数据库中能够更加方便的读取，并且数据库提供了很多自定义的功能
    # 也可以将数据存放在txt，csv，xlsx等位置
    # 任意两年间撤了哪些区域，新增了哪些区域
    def __init__(self):
        self.area_url_2020 = "http://www.mca.gov.cn/article/sj/xzqh/2020/20201201.html"
        self.area_url_2019 = "http://www.mca.gov.cn/article/sj/xzqh/1980/2019/202002281436.html"
        self.area_url_2018 = ""