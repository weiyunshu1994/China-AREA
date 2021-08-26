DROP TABLE IF EXISTS `oauth_client_details`;

CREATE TABLE `oauth_client_details` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
   `client_id` varchar(48) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '应用标识',
   `resource_ids` varchar(256) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '资源限定串(逗号分割)',
   `client_secret` varchar(256) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '应用密钥(bcyt) 加密',
   `client_secret_str` varchar(256) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '应用密钥(明文)',
   `scope` varchar(256) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '范围',
   `authorized_grant_types` varchar(256) COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'oauth授权方式(refresh_token,app_password、backend_password、repair_password)',
   `web_server_redirect_uri` varchar(256) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '回调地址',
   `authorities` varchar(256) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '权限',
   `access_token_validity` int(11) DEFAULT NULL COMMENT 'access_token有效期(单位秒)',
   `refresh_token_validity` int(11) DEFAULT NULL COMMENT 'refresh_token有效期(单位秒)',
   `additional_information` varchar(4096) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '附加信息json格式{} ',
   `autoapprove` varchar(256) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '是否自动授权 是-true(默认false,适用于authorization_code模式,设置用户是否自动approval操作,设置true跳过用户确认授权操作页面，直接跳到redirect_uri)',
   `status` tinyint(4) DEFAULT NULL COMMENT '状态：0失效，1有效',
   `if_limit` int(11) DEFAULT '0' COMMENT '是否应用限流',
   `limit_count` int(11) DEFAULT '10000' COMMENT '限流阈值',
   `create_user` int(11) DEFAULT '0' COMMENT '创建人',
   `create_time` datetime DEFAULT NULL COMMENT '创建时间',
   `modify_user` int(11) DEFAULT '0' COMMENT '修改人',
   `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
   PRIMARY KEY (`id`) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = 'oauth_应用信息';

DROP TABLE IF EXISTS `supervisor_community`;

CREATE TABLE `supervisor_community` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
   `supervisor_identity` varchar(100) DEFAULT NULL COMMENT 'PC管理机唯一标识',
   `cert_hash` varchar(50) NOT NULL COMMENT '证书哈希值',
   `cert_serial_number` varchar(50) NOT NULL COMMENT '证书序列号',
   `authority_key_id` varchar(50) NOT NULL COMMENT '授权密钥ID',
   `community_id` int(11) DEFAULT NULL COMMENT '小区id',
   `status` int(11) DEFAULT '2' COMMENT 'PC管理机状态：1-有效；0-停用',
   `create_time` datetime DEFAULT NULL COMMENT '创建时间',
   `update_time` datetime DEFAULT NULL COMMENT '更新时间',
   `username` varchar(100) NOT NULL COMMENT '绑定的用户',
   `user_id` int not null comment '用户id',
   PRIMARY KEY (`id`)
) DEFAULT CHARSET = utf8mb4 COMMENT = 'PC管理机-小区绑定表';

DROP TABLE IF EXISTS `sys_client_service`;

CREATE TABLE `sys_client_service` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
   `client_id` int(11) NOT NULL DEFAULT '0' COMMENT '应用主键ID',
   `service_id` int(11) NOT NULL DEFAULT '0' COMMENT '服务主键ID',
   `create_user` int(11) DEFAULT '0' COMMENT '创建人',
   `create_time` datetime DEFAULT NULL COMMENT '创建时间',
   PRIMARY KEY (`id`) USING BTREE,
   KEY `uk_client_id_1_permission_id_2` (`client_id`, `service_id`) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '系统_应用服务关系表';

DROP TABLE IF EXISTS `sys_menu`;

CREATE TABLE `sys_menu` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
   `parent_id` int(11) NOT NULL DEFAULT '0' COMMENT '上级ID',
   `subsystem_id` int(11) DEFAULT '0' COMMENT '所属子系统',
   `name` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '名称',
   `url` varchar(1024) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '菜单路由',
   `path` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '菜单URL',
   `css` varchar(32) COLLATE utf8mb4_bin DEFAULT '99' COMMENT '样式',
   `sort` int(11) DEFAULT '0' COMMENT '顺序',
   `is_menu` tinyint(4) DEFAULT '1' COMMENT '是否菜单 1 是 2 不是',
   `hidden` tinyint(4) DEFAULT '1' COMMENT '是否隐藏,0 false 1 true',
   `level` tinyint(4) DEFAULT '1' COMMENT '层级(最好不超过3层)',
   `create_user` int(11) DEFAULT '0' COMMENT '创建人',
   `create_time` datetime DEFAULT NULL COMMENT '创建时间',
   `modify_user` int(11) DEFAULT '0' COMMENT '修改人',
   `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
   PRIMARY KEY (`id`) USING BTREE,
   KEY `index_subsystem_id` (`subsystem_id`) USING BTREE,
   KEY `index_parent_id` (`parent_id`) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '系统_菜单表';

DROP TABLE IF EXISTS `sys_menu_permission`;

CREATE TABLE `sys_menu_permission` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
   `menu_id` int(11) NOT NULL COMMENT '菜单ID',
   `permission_id` int(11) NOT NULL COMMENT '权限ID',
   `create_user` int(11) DEFAULT '0' COMMENT '创建人',
   `create_time` datetime DEFAULT NULL COMMENT '创建时间',
   PRIMARY KEY (`id`) USING BTREE,
   KEY `uk_menu_id_1_permission_id_2` (`permission_id`, `menu_id`) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '系统_菜单权限关联表';

DROP TABLE IF EXISTS `sys_notice_push`;

CREATE TABLE `sys_notice_push` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
   `name` varchar(30) COLLATE utf8mb4_bin DEFAULT NULL,
   `subsystem_id` int(11) DEFAULT NULL,
   `subsystem_name_en` varchar(30) COLLATE utf8mb4_bin DEFAULT NULL,
   `create_user` int(11) DEFAULT NULL COMMENT '创建人',
   `create_time` datetime DEFAULT NULL COMMENT '创建时间',
   `modify_user` int(11) DEFAULT NULL COMMENT '修改人',
   `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
   PRIMARY KEY (`id`) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '门户_公告发布子系统表';

DROP TABLE IF EXISTS `sys_notice_push_subitem`;

CREATE TABLE `sys_notice_push_subitem` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
   `sub_id` int(11) DEFAULT NULL,
   `name` varchar(30) COLLATE utf8mb4_bin DEFAULT NULL,
   PRIMARY KEY (`id`) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '门户_子系统选项表';

DROP TABLE IF EXISTS `sys_permission`;

CREATE TABLE `sys_permission` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
   `permission` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '权限标识',
   `name` varchar(1024) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '名称',
   `create_user` int(11) DEFAULT '0' COMMENT '创建人',
   `create_time` datetime DEFAULT NULL COMMENT '创建时间',
   `modify_user` int(11) DEFAULT '0' COMMENT '修改人',
   `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
   PRIMARY KEY (`id`) USING BTREE,
   UNIQUE KEY `uk_permission` (`permission`) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '系统_权限表';

DROP TABLE IF EXISTS `sys_platform_announcement`;

CREATE TABLE `sys_platform_announcement` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
   `title` varchar(200) COLLATE utf8mb4_bin NOT NULL,
   `content` varchar(4000) COLLATE utf8mb4_bin NOT NULL,
   `content_text` varchar(4000) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '纯文本内容',
   `sub_id` int(11) DEFAULT '0',
   `sub_item_id` int(11) DEFAULT NULL COMMENT '子选项id',
   `notice_type` tinyint(4) DEFAULT '1' COMMENT '公告类型 1:普通公告 2:版本升级公告',
   `status` tinyint(4) DEFAULT '0' COMMENT '状态\r\n            0:待发布\r\n            1:已发布\r\n            2:已撤销\r\n            3:已删除\r\n            ',
   `push_user` int(11) DEFAULT '0' COMMENT '发布人',
   `push_time` datetime DEFAULT NULL COMMENT '发布时间',
   `create_user` int(11) DEFAULT '0' COMMENT '创建人',
   `create_time` datetime DEFAULT NULL COMMENT '创建时间',
   `modify_user` int(11) DEFAULT '0' COMMENT '修改人',
   `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
   `is_login_info` tinyint(4) DEFAULT '0' COMMENT '是否登录提醒\r\n            1:是 0;否',
   `back_user` int(11) DEFAULT '0' COMMENT '撤回人员',
   `back_time` datetime DEFAULT NULL COMMENT '撤回时间',
   PRIMARY KEY (`id`) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '门户_平台公告';

DROP TABLE IF EXISTS `sys_role`;

CREATE TABLE `sys_role` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
   `parent_id` int(11) NOT NULL DEFAULT '0' COMMENT '父角色ID',
   `user_type` tinyint(4) NOT NULL DEFAULT '99' COMMENT '用户类型\r\n            0、超级管理员\r\n            1、ABB成员\r\n            2、经销商\r\n            3、物业\r\n            10、APP用户\r\n            ',
   `code` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '角色code',
   `name` varchar(256) COLLATE utf8mb4_bin NOT NULL COMMENT '角色名称',
   `is_system` tinyint(4) NOT NULL DEFAULT '0' COMMENT '系统角色  0:否 1：是',
   `is_share` tinyint(4) NOT NULL DEFAULT '0' COMMENT '通用角色:0、否1、是',
   `agent_id` int(11) NOT NULL DEFAULT '0' COMMENT '经销商ID（合作公司ID）',
   `property_id` int(11) NOT NULL DEFAULT '0' COMMENT '物业ID',
   `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态 1：正常0：失效',
   `memo` varchar(1024) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '角色描述',
   `create_user` int(11) DEFAULT '0' COMMENT '创建人',
   `create_time` datetime DEFAULT NULL COMMENT '创建时间',
   `modify_user` int(11) DEFAULT '0' COMMENT '修改人',
   `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
   `is_verify_sms_code` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否开启验证码登录: 1:是 0:否',
   PRIMARY KEY (`id`) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '系统_角色表';


DROP TABLE IF EXISTS `sys_role_permission`;

CREATE TABLE `sys_role_permission` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
   `role_id` int(11) NOT NULL COMMENT '角色ID',
   `permission_id` int(11) NOT NULL COMMENT '权限ID',
   `create_user` int(11) DEFAULT '0' COMMENT '创建人',
   `create_time` datetime DEFAULT NULL COMMENT '创建时间',
   PRIMARY KEY (`id`) USING BTREE,
   KEY `uk_role_id_1_permission_id_2` (`role_id`, `permission_id`) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '系统_角色权限关系表';

DROP TABLE IF EXISTS `sys_role_user`;

CREATE TABLE `sys_role_user` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
   `role_id` int(11) NOT NULL COMMENT '角色ID',
   `user_id` int(11) NOT NULL COMMENT '用户ID',
   `create_user` int(11) DEFAULT '0' COMMENT '创建人',
   `create_time` datetime DEFAULT NULL COMMENT '创建时间',
   PRIMARY KEY (`id`) USING BTREE,
   UNIQUE KEY `uk_role_id_1_user_id_2` (`role_id`, `user_id`) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '系统_用户角色关系表';

DROP TABLE IF EXISTS `sys_service`;

CREATE TABLE `sys_service` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
   `parent_id` int(11) DEFAULT '0' COMMENT '父id',
   `name` varchar(256) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '名称',
   `path` varchar(256) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '服务路径',
   `sort` int(11) DEFAULT '0' COMMENT '顺序',
   `is_service` tinyint(4) DEFAULT NULL COMMENT '是否服务 1 是 2 不是',
   `create_user` int(11) DEFAULT '0' COMMENT '创建人',
   `create_time` datetime DEFAULT NULL COMMENT '创建时间',
   `modify_user` int(11) DEFAULT '0' COMMENT '修改人',
   `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
   PRIMARY KEY (`id`) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '系统_服务资源';

DROP TABLE IF EXISTS `sys_subsystem`;

CREATE TABLE `sys_subsystem` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
   `code` varchar(100) COLLATE utf8mb4_bin NOT NULL COMMENT 'code',
   `name` varchar(256) COLLATE utf8mb4_bin NOT NULL COMMENT '名称',
   `url` varchar(1024) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '子系统url',
   `create_user` int(11) DEFAULT '0' COMMENT '创建人',
   `create_time` datetime DEFAULT NULL COMMENT '创建时间',
   `modify_user` int(11) DEFAULT '0' COMMENT '修改人',
   `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
   PRIMARY KEY (`id`) USING BTREE,
   UNIQUE KEY `uk_code` (`code`) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '系统_子系统表';

DROP TABLE IF EXISTS `sys_user`;

CREATE TABLE `sys_user` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
   `login_name` varchar(100) COLLATE utf8mb4_bin NOT NULL COMMENT '登录账号',
   `passwd` varchar(1024) COLLATE utf8mb4_bin NOT NULL COMMENT '登陆密码',
   `passwd_ot` datetime NOT NULL COMMENT '密码过期时间',
   `name` varchar(100) COLLATE utf8mb4_bin NOT NULL COMMENT '用户名称',
   `mobile_phone` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '手机号',
   `user_type` int(11) NOT NULL DEFAULT '99' COMMENT '用户类型\r\n            0、超级管理员\r\n            1、ABB成员\r\n            2、经销商\r\n            3、物业',
   `agent_id` int(11) NOT NULL DEFAULT '0' COMMENT '经销商ID（合作公司ID）',
   `property_id` int(11) NOT NULL DEFAULT '0' COMMENT '物业ID',
   `account_type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '账号类型:1、主账号2、子账号',
   `login_repair` tinyint(4) NOT NULL DEFAULT '0' COMMENT '允许登录维保App：0、不允许1、允许',
   `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态\r\n            0:停用\r\n            1:有效 \r\n            ',
   `create_user` int(11) DEFAULT '0' COMMENT '创建人',
   `create_time` datetime DEFAULT NULL COMMENT '创建时间',
   `modify_user` int(11) DEFAULT '0' COMMENT '修改人',
   `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
   PRIMARY KEY (`id`) USING BTREE,
   UNIQUE KEY `uk_login_name` (`login_name`) USING BTREE,
   KEY `idx_agent_id_1_property_id_2` (`agent_id`, `property_id`) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '系统_用户表';

DROP TABLE IF EXISTS `sys_user_community`;

CREATE TABLE `sys_user_community` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
   `user_id` int(11) NOT NULL COMMENT '用户id',
   `community_id` int(11) NOT NULL COMMENT '小区id',
   PRIMARY KEY (`id`) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '门户_用户小区关系（小区授权账号）';

DROP TABLE IF EXISTS `sys_user_history_pwd`;

CREATE TABLE `sys_user_history_pwd` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
   `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
   `passwd` varchar(1024) COLLATE utf8mb4_bin NOT NULL COMMENT '登陆密码',
   `create_user` int(11) NOT NULL DEFAULT '0' COMMENT '创建人',
   `create_time` datetime NOT NULL COMMENT '创建时间',
   PRIMARY KEY (`id`) USING BTREE,
   KEY `index_user_id` (`user_id`) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '系统_用户历史密码表';

DROP TABLE IF EXISTS `sys_user_read_announcement`;

CREATE TABLE `sys_user_read_announcement` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
   `user_id` int(11) DEFAULT '0' COMMENT '用户id',
   `announcement_id` int(11) DEFAULT '0' COMMENT '公告id',
   `last_read_time` date DEFAULT NULL COMMENT '最近阅读时间',
   `read_cnt` int(11) DEFAULT '0' COMMENT '阅读数',
   PRIMARY KEY (`id`) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '门户_用户阅读公告数据表';

DROP TABLE IF EXISTS `sys_user_role_subsystem`;

CREATE TABLE `sys_user_role_subsystem` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
   `user_type` tinyint(4) NOT NULL DEFAULT '99' COMMENT '用户类型\r\n            0、超级管理员\r\n            1、ABB成员\r\n            2、经销商\r\n            3、物业\r\n            10、APP用户\r\n            ',
   `is_system` tinyint(4) NOT NULL DEFAULT '0' COMMENT '系统角色  0:否 1：是',
   `subsystem_id` int(11) NOT NULL DEFAULT '0' COMMENT '子系统',
   PRIMARY KEY (`id`) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '门户_角色与子系统关系(sql脚本管理，不进行界面操作)\r\n用于角色配置子系统菜单功能';

DROP TABLE IF EXISTS `wlw_agent`;

CREATE TABLE `wlw_agent` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
   `name` varchar(100) COLLATE utf8mb4_bin NOT NULL COMMENT '经销商名称',
   `contacts` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '联系人',
   `address` varchar(200) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '联系地址',
   `phone` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '联系方式',
   `remarks` varchar(1000) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '备注',
   `status` tinyint(4) DEFAULT '1' COMMENT '状态1:有效 0:停用',
   `admin_login_name` varchar(100) COLLATE utf8mb4_bin NOT NULL DEFAULT '' COMMENT '管理员登录账号',
   `create_user` int(11) DEFAULT '0' COMMENT '创建人',
   `create_time` datetime DEFAULT NULL COMMENT '创建时间',
   `modify_user` int(11) DEFAULT '0' COMMENT '修改人',
   `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
   `admin_id` int(11) DEFAULT '0' COMMENT '管理员账号ID',
   PRIMARY KEY (`id`) USING BTREE,
   UNIQUE KEY `uk_admin_login_name` (`admin_login_name`) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '物联网_经销商（合作公司）';

DROP TABLE IF EXISTS `wlw_apk_group`;

CREATE TABLE `wlw_apk_group` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
   `eq_model` int(11) NOT NULL DEFAULT '1' COMMENT '机型：取字典1001',
   `name_cn` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '分组名称',
   `name_en` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '分组标识',
   `apk_id` int(11) DEFAULT '0' COMMENT 'APK升级包ID',
   `switch_status` tinyint(4) DEFAULT '0' COMMENT '分组开关：1、开启 0、关闭',
   `memo` varchar(2000) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '备注',
   `create_user` int(11) DEFAULT '0' COMMENT '创建人',
   `create_time` datetime DEFAULT NULL COMMENT '创建时间',
   `modify_user` int(11) DEFAULT '0' COMMENT '修改人',
   `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
   PRIMARY KEY (`id`) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '物联网_设备APK升级分组';

DROP TABLE IF EXISTS `wlw_apk_group_member`;

CREATE TABLE `wlw_apk_group_member` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
   `apk_group_id` int(11) NOT NULL DEFAULT '0' COMMENT 'APK升级分组ID',
   `serial_number` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '设备串号',
   PRIMARY KEY (`id`) USING BTREE,
   KEY `Index_1` (`apk_group_id`) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '物联网_设备APK升级分组成员表';

DROP TABLE IF EXISTS `wlw_app_user`;

CREATE TABLE `wlw_app_user` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
   `open_id` varchar(32) COLLATE utf8mb4_bin NOT NULL COMMENT 'OpenId',
   `nick_name` varchar(100) COLLATE utf8mb4_bin NOT NULL COMMENT '用户昵称',
   `login_name` varchar(100) COLLATE utf8mb4_bin NOT NULL COMMENT '登录账号',
   `passwd` varchar(256) COLLATE utf8mb4_bin NOT NULL COMMENT '登陆密码',
   `mobile_phone` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '手机号',
   `sip_num` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'sip账号',
   `sip_num_pwd` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'sip密码',
   `head_key` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '头像Key',
   `head_hash` varchar(256) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '头像哈希值',
   `is_fictitious` tinyint(4) DEFAULT '0' COMMENT '是否虚拟账号：0、否1、是',
   `is_activate` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否激活：0、未激活1、已激活',
   `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态：0、停用1、有效 ',
   `create_user` int(11) DEFAULT '0' COMMENT '创建人',
   `create_time` datetime DEFAULT NULL COMMENT '创建时间',
   `modify_user` int(11) DEFAULT '0' COMMENT '修改人',
   `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
   PRIMARY KEY (`id`) USING BTREE,
   KEY `Index_1` (`login_name`) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '物联网_App用户表';

DROP TABLE IF EXISTS `wlw_app_user_history_pwd`;

CREATE TABLE `wlw_app_user_history_pwd` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
   `app_user_id` int(11) NOT NULL DEFAULT '0' COMMENT 'App用户ID',
   `passwd` varchar(1024) COLLATE utf8mb4_bin NOT NULL COMMENT '登陆密码',
   `create_user` int(11) NOT NULL DEFAULT '0' COMMENT '创建人',
   `create_time` datetime NOT NULL COMMENT '创建时间',
   PRIMARY KEY (`id`) USING BTREE,
   KEY `index_user_id` (`app_user_id`) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '物联网_App用户历史密码表';

DROP TABLE IF EXISTS `wlw_app_user_identity`;

CREATE TABLE `wlw_app_user_identity` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增Id',
   `app_user_id` int(11) NOT NULL DEFAULT '0' COMMENT 'App用户ID',
   `name` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '姓名',
   `gender` tinyint(4) DEFAULT NULL COMMENT '性别：0、女1、男',
   `birthday` varchar(10) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '出生日期（yyyy-MM-dd）',
   `id_number` varchar(18) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '身份证号',
   `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
   PRIMARY KEY (`id`) USING BTREE,
   KEY `Index_1` (`app_user_id`) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '物联网_App用户_身份信息';

DROP TABLE IF EXISTS `wlw_app_user_identity_grant`;

CREATE TABLE `wlw_app_user_identity_grant` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增Id',
   `app_user_id` int(11) NOT NULL DEFAULT '0' COMMENT 'App用户ID',
   `community_id` int(11) NOT NULL COMMENT '小区ID',
   PRIMARY KEY (`id`) USING BTREE,
   KEY `Index_1` (`app_user_id`) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '物联网_App用户_身份信息授权表';

DROP TABLE IF EXISTS `wlw_app_user_key`;

CREATE TABLE `wlw_app_user_key` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
   `app_user_id` int(11) NOT NULL DEFAULT '0' COMMENT 'App用户ID',
   `app_key` text COLLATE utf8mb4_bin COMMENT 'App公钥',
   `app_key_hash` varchar(256) COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'App公钥哈希值',
   `applet_key` text COLLATE utf8mb4_bin COMMENT '小程序公钥',
   `applet_key_hash` varchar(256) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '小程序公钥哈希值',
   PRIMARY KEY (`id`) USING BTREE,
   KEY `Index_1` (`app_user_id`) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '物联网_App用户证书信息';

DROP TABLE IF EXISTS `wlw_app_user_opening`;

CREATE TABLE `wlw_app_user_opening` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
   `app_user_id` int(11) NOT NULL DEFAULT '0' COMMENT 'App用户ID',
   `community_id` int(11) NOT NULL DEFAULT '0' COMMENT '小区ID',
   `deadline` varchar(10) COLLATE utf8mb4_bin NOT NULL COMMENT '有效截止日期',
   PRIMARY KEY (`id`) USING BTREE,
   KEY `Index_1` (`app_user_id`, `community_id`) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '物联网_App用户人脸识别开通表';

DROP TABLE IF EXISTS `wlw_app_user_third`;

CREATE TABLE `wlw_app_user_third` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增Id',
   `app_user_id` int(11) NOT NULL DEFAULT '0' COMMENT 'App用户ID',
   `wx_open_id` varchar(32) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '微信openid',
   `wx_unionid` varchar(32) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '微信unionid',
   `zfb_user_id` varchar(32) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '支付宝user_id',
   PRIMARY KEY (`id`) USING BTREE,
   UNIQUE KEY `uk_app_user_id` (`app_user_id`) USING BTREE,
   KEY `idx_wx_open_id` (`wx_open_id`) USING BTREE,
   KEY `idx_wx_unionid` (`wx_unionid`) USING BTREE,
   KEY `idx_zfb_user_id` (`zfb_user_id`) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '物联网_App用户-第三方账号信息';

DROP TABLE IF EXISTS `wlw_area`;

CREATE TABLE `wlw_area` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
   `name` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '地区名称',
   `parent_id` int(11) DEFAULT '0' COMMENT '父ID',
   `grade` tinyint(4) DEFAULT '0' COMMENT '层级：1、省2、市3、区',
   `pinyin` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '拼音',
   `lon` varchar(30) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '经度',
   `lat` varchar(30) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '纬度',
   `create_user` int(11) DEFAULT '0' COMMENT '创建人',
   `create_time` datetime DEFAULT NULL COMMENT '创建时间',
   `modify_user` int(11) DEFAULT '0' COMMENT '修改人',
   `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
   PRIMARY KEY (`id`) USING BTREE,
   KEY `Index_1` (`parent_id`, `grade`) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '物联网_地区数据表';

DROP TABLE IF EXISTS `wlw_card`;

CREATE TABLE `wlw_card` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
   `property_id` int(11) NOT NULL DEFAULT '0' COMMENT '物业ID',
   `community_id` int(11) NOT NULL DEFAULT '0' COMMENT '小区ID',
   `card_type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '卡类型\r\n            1：住户卡\r\n            2：物业卡',
   `card_num` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '卡号',
   `card_class` tinyint(4) DEFAULT '0' COMMENT '卡分类\r\n            0：未定义 \r\n            1：IC卡 \r\n            2：ID卡 \r\n            3：NFC卡 \r\n            4：身份证  \r\n            5：CPU卡',
   `card_data` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '卡内数据，只有cpu卡才有卡内数据',
   `app_user_id` int(11) DEFAULT '0' COMMENT 'App用户ID',
   `term_start` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '有效期开始',
   `term_end` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '有效期结束',
   `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态:0、停用1、正常',
   `create_user` int(11) DEFAULT '0' COMMENT '创建人',
   `create_time` datetime DEFAULT NULL COMMENT '创建时间',
   `modify_user` int(11) DEFAULT '0' COMMENT '修改人',
   `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
   PRIMARY KEY (`id`) USING BTREE,
   KEY `Index_1` (`property_id`, `community_id`) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '物联网_卡数据表';

DROP TABLE IF EXISTS `wlw_card_grant`;

CREATE TABLE `wlw_card_grant` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
   `card_id` int(11) NOT NULL DEFAULT '0' COMMENT '卡ID',
   `community_id` int(11) NOT NULL DEFAULT '0' COMMENT '小区ID',
   `partition_id` int(11) NOT NULL DEFAULT '0' COMMENT '分区ID',
   `tenement_id` int(11) NOT NULL DEFAULT '0' COMMENT '楼宇ID',
   `unit_id` int(11) NOT NULL DEFAULT '0' COMMENT '单元ID',
   PRIMARY KEY (`id`) USING BTREE,
   KEY `Index_1` (`card_id`) USING BTREE,
   KEY `Index_2` (
      `community_id`,
      `partition_id`,
      `tenement_id`,
      `unit_id`
   ) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '物联网_卡授权范围表';

DROP TABLE IF EXISTS `wlw_client_certificate`;

CREATE TABLE `wlw_client_certificate` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
   `client_type` varchar(50) NOT NULL COMMENT '客户端类型：住户App:com.abb.oic.client.daas.userapp 维保App:com.abb.oic.client.daas.maintainapp PC管理机:com.abb.oic.client.fros.pcmanager',
   `client_accounts_id` int(11) DEFAULT NULL COMMENT '客户端账号ID',
   `serial_number` varchar(100) NOT NULL COMMENT '证书序列号',
   `auth_key_id` varchar(50) NOT NULL COMMENT '授权密钥ID',
   `public_key` text NOT NULL COMMENT '公钥',
   `public_key_digest` varchar(100) NOT NULL COMMENT '公钥摘要',
   `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态：0、吊销1、正常',
   `reason` varchar(50) DEFAULT NULL COMMENT '吊销原因',
   PRIMARY KEY (`id`) USING BTREE,
   KEY `Index_1` (`client_type`) USING BTREE,
   KEY `Index_2` (`public_key_digest`) USING BTREE
) DEFAULT CHARSET = utf8mb4 ROW_FORMAT = DYNAMIC COMMENT = '物联网_客户端证书管理';

DROP TABLE IF EXISTS `wlw_commission`;

CREATE TABLE `wlw_commission` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
   `abb_ratio` decimal(3, 2) NOT NULL DEFAULT '1.00' COMMENT 'ABB提成比例',
   `agent_id` int(11) NOT NULL DEFAULT '0' COMMENT '经销商ID',
   `agent_ratio` decimal(3, 2) NOT NULL DEFAULT '0.00' COMMENT '经销商提成比例',
   `property_id` int(11) NOT NULL DEFAULT '0' COMMENT '物业ID',
   `property_ratio` decimal(3, 2) NOT NULL DEFAULT '0.00' COMMENT '物业提成比例',
   `create_user` int(11) DEFAULT '0' COMMENT '创建人',
   `create_time` datetime DEFAULT NULL COMMENT '创建时间',
   `modify_user` int(11) DEFAULT '0' COMMENT '修改人',
   `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
   PRIMARY KEY (`id`) USING BTREE,
   KEY `Index_1` (`property_id`) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '物联网_收费分成表';

DROP TABLE IF EXISTS `wlw_community`;

CREATE TABLE `wlw_community` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
   `name` varchar(100) COLLATE utf8mb4_bin NOT NULL COMMENT '名称',
   `province_id` int(11) NOT NULL DEFAULT '0' COMMENT '省ID',
   `city_id` int(11) NOT NULL DEFAULT '0' COMMENT '市ID',
   `county_id` int(11) NOT NULL DEFAULT '0' COMMENT '区ID',
   `agent_id` int(11) NOT NULL DEFAULT '0' COMMENT '经销商ID（合作公司ID）',
   `property_id` int(11) NOT NULL DEFAULT '0' COMMENT '所属物业ID',
   `address` varchar(200) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '小区地址',
   `type` tinyint(4) DEFAULT '1' COMMENT '小区类型\r\n            1:自有小区（经销商运营）\r\n            2:合作公司小区',
   `lon` varchar(30) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '经度',
   `lat` varchar(30) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '纬度',
   `status` tinyint(4) DEFAULT '1' COMMENT '状态\r\n            1:有效 \r\n            0:停用',
   `create_user` int(11) DEFAULT '0' COMMENT '创建人',
   `create_time` datetime DEFAULT NULL COMMENT '创建时间',
   `modify_user` int(11) DEFAULT '0' COMMENT '修改人',
   `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
   PRIMARY KEY (`id`) USING BTREE,
   KEY `Index_1` (`property_id`) USING BTREE,
   KEY `Index_2` (`agent_id`) USING BTREE,
   KEY `Index_3` (`province_id`, `city_id`, `county_id`) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '物联网_小区表';
 alter table wlw_community add `vaule_add_type` tinyint(4) NOT NULL DEFAULT '1' COMMENT '增值服务类型: 0-无增值服务(保留)，1-需用户购买，2-默认为用户开通' after `type`;
 alter table wlw_community modify `type` tinyint default 1 null comment '小区类型: 1-自有小区（经销商运营）2:-合作公司小区 3-FROS小区';

DROP TABLE IF EXISTS `wlw_community_config`;

CREATE TABLE `wlw_community_config` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
   `community_id` int(11) NOT NULL DEFAULT '0' COMMENT '小区ID',
   `room_rule` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '房间号规则:d数字，a字母【A-J】',
   `system_audit` tinyint(4) DEFAULT '0' COMMENT '系统审核钥匙：0、关1、开',
   `pro_cs_phone` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '物业客服电话',
   `ope_phone` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '运维人员电话',
   `id_collection` tinyint(4) DEFAULT NULL COMMENT '身份证采集开关0:关1:开',
   `face_switch` tinyint(4) DEFAULT '0' COMMENT '人脸识别开关0:关1:开',
   `living_switch` tinyint(4) DEFAULT '0' COMMENT '活体检测开关0：关 1：开',
   `holder_audit` tinyint(4) DEFAULT '1' COMMENT '户主审核住户权限0:关1：开',
   `card_gb` varchar(200) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '门禁卡背景图Key',
   `call_rule` tinyint(4) DEFAULT '0' COMMENT '围墙呼叫规则：1：单元地址 房间号#  2：单元地址#房间号',
   `modify_user` int(11) DEFAULT '0' COMMENT '修改人',
   `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
   PRIMARY KEY (`id`) USING BTREE,
   KEY `Index_1` (`community_id`) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '物联网_小区配置表';

DROP TABLE IF EXISTS `wlw_community_count`;

CREATE TABLE `wlw_community_count` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
   `agent_id` int(11) DEFAULT NULL COMMENT '经销商id',
   `property_id` int(11) DEFAULT NULL COMMENT '物业id',
   `community_id` int(11) DEFAULT NULL COMMENT '小区id',
   `room_cnt` int(11) DEFAULT NULL COMMENT '房间数量',
   `eq_cnt` int(11) DEFAULT NULL COMMENT '设备数量',
   `resident_cnt` int(11) DEFAULT NULL COMMENT '住户数',
   `card_cnt` int(11) DEFAULT NULL COMMENT '卡数量',
   `face_cnt` int(11) DEFAULT NULL COMMENT '人脸开通数',
   PRIMARY KEY (`id`) USING BTREE,
   KEY `IDX_AGENT_PROPERTY_COMMUNITY` (`agent_id`, `property_id`, `community_id`) USING BTREE
) DEFAULT CHARSET = utf8mb4 ROW_FORMAT = COMPACT COMMENT = '物联网_小区资源统计表';

DROP TABLE IF EXISTS `wlw_community_point`;

CREATE TABLE `wlw_community_point` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
   `province_id` int(11) DEFAULT '0' COMMENT '省ID',
   `city_id` int(11) DEFAULT '0' COMMENT '市ID',
   `county_id` int(11) DEFAULT '0' COMMENT '区ID',
   `community_id` int(11) DEFAULT '0' COMMENT '小区ID',
   `partition_id` int(11) DEFAULT '0' COMMENT '分区ID',
   `tenement_id` int(11) DEFAULT '0' COMMENT '楼宇ID',
   `unit_id` int(11) DEFAULT '0' COMMENT '单元ID',
   `point_type` tinyint(4) DEFAULT '0' COMMENT '点位类型：1、小区围墙2、分区围墙3、单元楼',
   `name` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '点位名称',
   `lon` varchar(30) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '经度',
   `lat` varchar(30) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '纬度',
   `face_similarity` tinyint(4) DEFAULT '75' COMMENT '人脸识别开门阈值0-100',
   `brightness` int(11) DEFAULT '50' COMMENT '屏幕亮度0-100',
   `media_vol` int(11) DEFAULT '0' COMMENT '媒体播放音量 0-15，默认0',
   `voice_vol` int(11) DEFAULT '4' COMMENT '语音对话音量 0-5，默认5',
   PRIMARY KEY (`id`) USING BTREE,
   KEY `Index_1` (`province_id`, `city_id`, `county_id`) USING BTREE,
   KEY `Index_2` (
      `community_id`,
      `partition_id`,
      `tenement_id`,
      `unit_id`,
      `point_type`
   ) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '物联网_小区点位表';

DROP TABLE IF EXISTS `wlw_community_sku`;

CREATE TABLE `wlw_community_sku` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
   `community_id` int(11) NOT NULL DEFAULT '0' COMMENT '小区ID',
   `type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '类型：1、人脸通2、视频通',
   `price` int(11) NOT NULL COMMENT '单价',
   `month_type` tinyint(4) NOT NULL DEFAULT '1' COMMENT '月数:\r\n            0、永久\r\n            1、1个月\r\n            2、3个月\r\n            3、6个月\r\n            4、12个月\r\n            5、24个月\r\n            6、36个月',
   `months` tinyint(4) NOT NULL DEFAULT '1' COMMENT '自然月数：实际自然月数',
   `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态:0、停用1、启用',
   `create_user` int(11) NOT NULL DEFAULT '0' COMMENT '创建人',
   `create_time` datetime NOT NULL COMMENT '创建时间',
   PRIMARY KEY (`id`) USING BTREE,
   KEY `Index_1` (`community_id`, `type`) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '物联网_小区增值业务SKU';

DROP TABLE IF EXISTS `wlw_complaint_order`;

CREATE TABLE `wlw_complaint_order` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
   `property_id` int(11) NOT NULL DEFAULT '0' COMMENT '物业ID',
   `community_id` int(11) NOT NULL DEFAULT '0' COMMENT '小区ID',
   `content` varchar(300) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '投诉内容',
   `create_user` int(11) DEFAULT '0' COMMENT '投诉人ID',
   `create_time` datetime DEFAULT NULL COMMENT '投诉时间',
   `pic_keys` varchar(600) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '投诉照片Keys，多个Key以英文逗号分割',
   `status` int(11) DEFAULT '0' COMMENT '处理状态0:待处理1:已处理',
   `solve_content` varchar(300) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '处理方案',
   `solver_user` int(11) DEFAULT NULL COMMENT '处理人ID',
   `solve_time` datetime DEFAULT NULL COMMENT '处理时间',
   PRIMARY KEY (`id`) USING BTREE,
   KEY `Index_1` (`property_id`, `community_id`) USING BTREE,
   KEY `Index_2` (`create_user`) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '物联网_物业投诉';

DROP TABLE IF EXISTS `wlw_dict`;

CREATE TABLE `wlw_dict` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
   `type` int(11) NOT NULL DEFAULT '0' COMMENT '类型：\r\n            1001、设备机型\r\n            1002、设备尺寸',
   `dict_key` int(11) NOT NULL DEFAULT '0' COMMENT '关键字',
   `dict_value` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '字典值',
   `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态：\r\n            0、失效\r\n            1、正常',
   `create_user` int(11) DEFAULT '0' COMMENT '创建人',
   `create_time` datetime DEFAULT NULL COMMENT '创建时间',
   `modify_user` int(11) DEFAULT '0' COMMENT '修改人',
   `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
   `link_id` int(11) DEFAULT '0' COMMENT '关联id',
   `config_json` varchar(1000) COLLATE utf8mb4_bin DEFAULT '{}' COMMENT '配置参数json字符串（eg: { "key1" : "value1", "key2" : "value2"  }',
   `remark` varchar(1000) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '备注',
   PRIMARY KEY (`id`) USING BTREE,
   KEY `i_dict_type_status` (`type`, `status`) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '物联网_字典表';

DROP TABLE IF EXISTS `wlw_eq_apk`;

CREATE TABLE `wlw_eq_apk` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
   `package_name` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '包名(com.xx.xxx)',
   `version_code` varchar(10) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '版本号Code(2016070501)',
   `version_name` varchar(10) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '版本名称(1.0.0)',
   `content` varchar(3000) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '更新内容',
   `package_key` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '升级包Key',
   `package_sign` varchar(500) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '升级包签名',
   `status` tinyint(4) DEFAULT NULL COMMENT '状态0:未发布1:已发布2:已下线3:稳定版本',
   `upload_user` int(11) DEFAULT '0' COMMENT '上传人ID',
   `upload_time` datetime DEFAULT NULL COMMENT '上传时间',
   `publish_user` int(11) DEFAULT '0' COMMENT '发布人ID',
   `publish_time` datetime DEFAULT NULL COMMENT '发布时间',
   `offline_user` int(11) DEFAULT '0' COMMENT '下线人ID',
   `offline_time` datetime DEFAULT NULL COMMENT '下线时间',
   PRIMARY KEY (`id`) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '物联网_设备APK升级包管理';

DROP TABLE IF EXISTS `wlw_eq_apk_models`;

CREATE TABLE `wlw_eq_apk_models` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
   `apk_id` int(11) NOT NULL DEFAULT '0' COMMENT 'APK升级包ID',
   `eq_model` int(11) NOT NULL DEFAULT '1' COMMENT '机型：取字典1001',
   `eq_model_name` varchar(30) COLLATE utf8mb4_bin NOT NULL COMMENT '机型名称',
   PRIMARY KEY (`id`) USING BTREE,
   KEY `Index_1` (`apk_id`) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '物联网_设备APK升级包可用机型';

DROP TABLE IF EXISTS `wlw_eq_mcu`;

CREATE TABLE `wlw_eq_mcu` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
   `package_name` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '包名(com.xx.xxx)',
   `version_code` varchar(10) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '版本号Code(2016070501)',
   `version_name` varchar(10) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '版本名称(1.0.0)',
   `content` varchar(3000) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '更新内容',
   `package_key` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '升级包Key',
   `package_sign` varchar(500) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '升级包签名',
   `status` tinyint(4) DEFAULT NULL COMMENT '状态0:未发布1:已发布2:已下线3:稳定版本',
   `upload_user` int(11) DEFAULT '0' COMMENT '上传人ID',
   `upload_time` datetime DEFAULT NULL COMMENT '上传时间',
   `publish_user` int(11) DEFAULT '0' COMMENT '发布人ID',
   `publish_time` datetime DEFAULT NULL COMMENT '发布时间',
   `offline_user` int(11) DEFAULT '0' COMMENT '下线人ID',
   `offline_time` datetime DEFAULT NULL COMMENT '下线时间',
   PRIMARY KEY (`id`) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '物联网_设备MCU升级包管理';

DROP TABLE IF EXISTS `wlw_eq_mcu_models`;

CREATE TABLE `wlw_eq_mcu_models` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
   `mcu_id` int(11) NOT NULL DEFAULT '0' COMMENT 'MCU升级包ID',
   `eq_model` int(11) NOT NULL DEFAULT '1' COMMENT '机型：取字典1001',
   `eq_model_name` varchar(30) COLLATE utf8mb4_bin NOT NULL COMMENT '机型名称',
   PRIMARY KEY (`id`) USING BTREE,
   KEY `Index_1` (`mcu_id`) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '物联网_设备MCU升级包可用机型';

DROP TABLE IF EXISTS `wlw_eq_rom`;

CREATE TABLE `wlw_eq_rom` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
   `package_name` varchar(100) COLLATE utf8mb4_bin NOT NULL COMMENT '包名(com.xx.xxx)',
   `package_type` tinyint(4) NOT NULL COMMENT '升级包类型（升级类型）：0、差分包1、完整包',
   `version_code` varchar(10) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '升级包版本号Code(2016070501)',
   `version_name` varchar(10) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '升级包版本名称(1.0.0)',
   `diff_version_code` varchar(10) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '差分基础版本号Code(2020070501)，可差分升级该版本的版本号',
   `diff_version_name` varchar(10) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '差分基础版本名称(1.0.0)',
   `content` varchar(3000) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '更新内容',
   `package_key` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '升级包Key',
   `package_sign` varchar(500) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '升级包签名',
   `status` tinyint(4) DEFAULT NULL COMMENT '状态0:未发布1:已发布2:已下线3:稳定版本',
   `upload_user` int(11) DEFAULT '0' COMMENT '上传人ID',
   `upload_time` datetime DEFAULT NULL COMMENT '上传时间',
   `publish_user` int(11) DEFAULT '0' COMMENT '发布人ID',
   `publish_time` datetime DEFAULT NULL COMMENT '发布时间',
   `offline_user` int(11) DEFAULT '0' COMMENT '下线人ID',
   `offline_time` datetime DEFAULT NULL COMMENT '下线时间',
   PRIMARY KEY (`id`) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '物联网_设备ROM升级包管理';

DROP TABLE IF EXISTS `wlw_eq_rom_models`;

CREATE TABLE `wlw_eq_rom_models` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
   `rom_id` int(11) NOT NULL DEFAULT '0' COMMENT 'ROM升级包ID',
   `eq_model` int(11) NOT NULL DEFAULT '1' COMMENT '机型：取字典1001',
   `eq_model_name` varchar(30) COLLATE utf8mb4_bin NOT NULL COMMENT '机型名称',
   PRIMARY KEY (`id`) USING BTREE,
   KEY `Index_1` (`rom_id`) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '物联网_设备ROM升级包可用机型';

DROP TABLE IF EXISTS `wlw_equipment`;

CREATE TABLE `wlw_equipment` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
   `community_point_id` int(11) DEFAULT NULL COMMENT '小区点位ID',
   `serial_number` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '设备串号',
   `eq_model` tinyint(4) DEFAULT '0' COMMENT '机型（待定）',
   `sip_num` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'sip号',
   `sip_num_pwd` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'sip密码',
   `mcu_ver` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'MCU版本',
   `rom_ver` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'ROM版本',
   `apk_ver` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'APK版本',
   `net_mode` tinyint(4) DEFAULT '0' COMMENT '网络接入方式 0:无网络1:2G  2:3G 3:4G 4:以太网 5:wifi',
   `bt_mac` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '蓝牙MAC',
   `online` tinyint(4) DEFAULT '0' COMMENT '在线状态：0、离线1、在线',
   `pk_digest` text COLLATE utf8mb4_bin COMMENT '公钥摘要',
   `remark` text COLLATE utf8mb4_bin COMMENT '备注',
   `status` tinyint(4) DEFAULT '1' COMMENT '状态\r\n            1:有效 \r\n            2:停用',
   `create_user` int(11) DEFAULT '0' COMMENT '创建人',
   `create_time` datetime DEFAULT NULL COMMENT '创建时间',
   `modify_user` int(11) DEFAULT '0' COMMENT '修改人',
   `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
   PRIMARY KEY (`id`) USING BTREE,
   KEY `Index_1` (`community_point_id`) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '物联网_设备表';

DROP TABLE IF EXISTS `wlw_equipment_auth`;

CREATE TABLE `wlw_equipment_auth` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
   `serial_number` varchar(100) COLLATE utf8mb4_bin NOT NULL COMMENT '设备串号',
   `public_key` text COLLATE utf8mb4_bin COMMENT '设备公钥',
   `public_key_digest` text COLLATE utf8mb4_bin COMMENT '设备公钥摘要',
   PRIMARY KEY (`id`) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '物联网_设备认证';

DROP TABLE IF EXISTS `wlw_equipment_version`;

CREATE TABLE `wlw_equipment_version` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
   `equipment_id` int(11) NOT NULL COMMENT '设备ID',
   `room_version_eq` int(11) NOT NULL DEFAULT '0' COMMENT '房间版本设备端',
   `room_version_server` int(11) NOT NULL DEFAULT '0' COMMENT '房间版本服务端',
   `room_qty_eq` int(11) NOT NULL DEFAULT '0' COMMENT '房间数量设备端',
   `room_qty_server` int(11) NOT NULL DEFAULT '0' COMMENT '房间数量服务端',
   `resident_version_eq` int(11) NOT NULL DEFAULT '0' COMMENT '住户版本设备端',
   `resident_version_server` int(11) NOT NULL DEFAULT '0' COMMENT '住户版本服务端',
   `resident_qty_eq` int(11) NOT NULL DEFAULT '0' COMMENT '住户数量设备端',
   `resident_qty_server` int(11) NOT NULL DEFAULT '0' COMMENT '住户数量服务端',
   `card_version_eq` int(11) NOT NULL DEFAULT '0' COMMENT '卡版本设备端',
   `card_version_server` int(11) NOT NULL DEFAULT '0' COMMENT '卡版本服务端',
   `card_qty_eq` int(11) NOT NULL DEFAULT '0' COMMENT '卡数量设备端',
   `card_qty_server` int(11) NOT NULL DEFAULT '0' COMMENT '卡数量服务端',
   `pwd_version_eq` int(11) NOT NULL DEFAULT '0' COMMENT '密码版本设备端',
   `pwd_version_server` int(11) NOT NULL DEFAULT '0' COMMENT '密码版本服务端',
   `pwd_qty_eq` int(11) NOT NULL DEFAULT '0' COMMENT '密码数量设备端',
   `pwd_qty_server` int(11) NOT NULL DEFAULT '0' COMMENT '密码数量服务端',
   `eq_upload_time` datetime DEFAULT NULL COMMENT '设备端上传时间',
   `server_calc_time` datetime DEFAULT NULL COMMENT '服务端计算时间',
   PRIMARY KEY (`id`) USING BTREE,
   KEY `Index_1` (`equipment_id`) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '物联网_设备数据版本表';

DROP TABLE IF EXISTS `wlw_face_grant`;

CREATE TABLE `wlw_face_grant` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
   `serial_number` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '设备串号',
   `agent_id` int(11) NOT NULL DEFAULT '0' COMMENT '经销商ID（合作公司ID）',
   `property_id` int(11) NOT NULL DEFAULT '0' COMMENT '物业ID',
   `community_id` int(11) NOT NULL DEFAULT '0' COMMENT '小区ID',
   `create_user` int(11) DEFAULT '0' COMMENT '授权人',
   `create_time` datetime DEFAULT NULL COMMENT '授权时间',
   `is_activate` tinyint(4) DEFAULT '0' COMMENT '是否已激活：1、是0、否',
   `activate_time` datetime DEFAULT NULL COMMENT '激活时间',
   `file_key` varchar(300) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '激活文件 key',
   `file_hash` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '激活文件哈希值',
   `first_activate_time` datetime DEFAULT NULL,
   PRIMARY KEY (`id`) USING BTREE,
   KEY `Index_1` (`agent_id`, `property_id`, `community_id`) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '物联网_人脸识别设备授权表';

DROP TABLE IF EXISTS `wlw_face_pic`;

CREATE TABLE `wlw_face_pic` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
   `app_user_id` int(11) NOT NULL DEFAULT '0' COMMENT 'App用户ID',
   `face_pic_key` varchar(100) NOT NULL COMMENT '人脸照片Key',
   `feature` text COMMENT '人脸特征值',
   `feature_hash` varchar(512) DEFAULT NULL COMMENT '人脸特征值哈希',
   `feature_mask` text COMMENT '人脸特征值（戴口罩）',
   PRIMARY KEY (`id`)
) DEFAULT CHARSET = utf8mb4 COMMENT = '物联网_人脸识别照片采集表';

DROP TABLE IF EXISTS `wlw_face_sync`;

CREATE TABLE `wlw_face_sync` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
   `app_user_id` int(11) NOT NULL DEFAULT '0' COMMENT 'App用户ID',
   `community_id` int(11) NOT NULL COMMENT '小区ID',
   `equipment_id` int(11) NOT NULL COMMENT '设备ID',
   `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态：0、未同步1、已同步',
   `fail_reason` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '失败原因',
   PRIMARY KEY (`id`) USING BTREE,
   KEY `Index_1` (`community_id`, `app_user_id`) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '物联网_App用户人脸同步状态表';

DROP TABLE IF EXISTS `wlw_file_backup`;

CREATE TABLE `wlw_file_backup` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
   `community_id` int(11) NOT NULL COMMENT '备份所属小区id',
   `type` tinyint(4) NOT NULL COMMENT '备份类型: 1-自动备份，2-手动备份',
   `content` varchar(256) COLLATE utf8mb4_general_ci COMMENT '备份描述信息',
   `file_key` varchar(100) NOT NULL COLLATE utf8mb4_bin COMMENT '文件索引key',
   `file_size` bigint(11) COMMENT '文件大小',
   `file_hash` varchar(100) COLLATE utf8mb4_bin COMMENT '文件hash值',
   `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态: 0-未确认, 1-已确认上传完成',
   `create_user` int(11) DEFAULT '0' COMMENT '创建人',
   `create_time` datetime COMMENT '创建时间',
   `modify_user` int(11) DEFAULT '0' COMMENT '修改人',
   `modify_time` datetime COMMENT '修改时间',
   PRIMARY KEY (`id`),
   UNIQUE KEY `uk_file_key` (`file_key`)
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '备份文件表';

DROP TABLE IF EXISTS `wlw_max_no`;

CREATE TABLE `wlw_max_no` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增Id',
   `type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '类型：1、sip号码生成最大值',
   `max_value` int(11) NOT NULL DEFAULT '1' COMMENT '最大值',
   PRIMARY KEY (`id`)
) DEFAULT CHARSET = utf8mb4 COMMENT = '物联网_编号最大值';

DROP TABLE IF EXISTS `wlw_mcu_group`;

CREATE TABLE `wlw_mcu_group` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
   `eq_model` int(11) NOT NULL DEFAULT '1' COMMENT '机型：取字典1001',
   `name_cn` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '分组名称',
   `name_en` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '分组标识',
   `mcu_id` int(11) DEFAULT '0' COMMENT 'MCU升级包ID',
   `switch_status` tinyint(4) DEFAULT '0' COMMENT '分组开关：1、开启 0、关闭',
   `memo` varchar(2000) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '备注',
   `create_user` int(11) DEFAULT '0' COMMENT '创建人',
   `create_time` datetime DEFAULT NULL COMMENT '创建时间',
   `modify_user` int(11) DEFAULT '0' COMMENT '修改人',
   `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
   PRIMARY KEY (`id`) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '物联网_设备MCU升级分组';

DROP TABLE IF EXISTS `wlw_mcu_group_member`;

CREATE TABLE `wlw_mcu_group_member` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
   `mcu_group_id` int(11) NOT NULL DEFAULT '0' COMMENT 'MCU分组ID',
   `serial_number` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '设备串号',
   PRIMARY KEY (`id`) USING BTREE,
   KEY `Index_1` (`mcu_group_id`) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '物联网_设备MCU升级分组成员表';

DROP TABLE IF EXISTS `wlw_notice_temp`;

CREATE TABLE `wlw_notice_temp` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
   `community_id` int(11) NOT NULL DEFAULT '0' COMMENT '小区ID',
   `title` varchar(200) COLLATE utf8mb4_bin NOT NULL COMMENT '标题',
   `content` text COLLATE utf8mb4_bin COMMENT '内容',
   `create_user` int(11) DEFAULT '0' COMMENT '创建人',
   `create_time` datetime DEFAULT NULL COMMENT '创建时间',
   `modify_user` int(11) DEFAULT '0' COMMENT '修改人',
   `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
   PRIMARY KEY (`id`) USING BTREE,
   KEY `Index_1` (`community_id`) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '物联网_公告模板表';

DROP TABLE IF EXISTS `wlw_partition`;

CREATE TABLE `wlw_partition` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
   `community_id` int(11) NOT NULL DEFAULT '0' COMMENT '社区ID',
   `name` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '楼宇名称',
   `partition_number` int(11) DEFAULT '0' COMMENT '分区编号',
   `status` tinyint(4) DEFAULT '1' COMMENT '状态\r\n            1:有效 \r\n            0:停用',
   `create_user` int(11) DEFAULT '0' COMMENT '创建人',
   `create_time` datetime DEFAULT NULL COMMENT '创建时间',
   `modify_user` int(11) DEFAULT '0' COMMENT '修改人',
   `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
   PRIMARY KEY (`id`) USING BTREE,
   KEY `Index_1` (`community_id`) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '物联网_分区表';

DROP TABLE IF EXISTS `wlw_property`;

CREATE TABLE `wlw_property` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
   `agent_id` int(11) NOT NULL DEFAULT '0' COMMENT '经销商ID（合作公司ID）',
   `name` varchar(100) COLLATE utf8mb4_bin NOT NULL COMMENT '物业名称',
   `contacts` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '联系人',
   `address` varchar(200) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '联系地址',
   `phone` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '联系方式',
   `remarks` varchar(1000) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '备注',
   `status` tinyint(4) DEFAULT '1' COMMENT '状态1:有效 0:停用',
   `create_user` int(11) DEFAULT '0' COMMENT '创建人',
   `create_time` datetime DEFAULT NULL COMMENT '创建时间',
   `modify_user` int(11) DEFAULT '0' COMMENT '修改人',
   `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
   `admin_id` int(11) DEFAULT '0' COMMENT '管理员账号ID',
   PRIMARY KEY (`id`) USING BTREE,
   KEY `Index_1` (`agent_id`) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '物联网_物业表';

DROP TABLE IF EXISTS `wlw_property_notice`;

CREATE TABLE `wlw_property_notice` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
   `property_id` int(11) NOT NULL DEFAULT '0' COMMENT '物业ID',
   `community_id` int(11) NOT NULL DEFAULT '0' COMMENT '小区ID',
   `title` varchar(200) COLLATE utf8mb4_bin NOT NULL COMMENT '标题',
   `content` text COLLATE utf8mb4_bin COMMENT '内容',
   `status` tinyint(4) DEFAULT '0' COMMENT '状态：0、未发布1、已发布',
   `create_user` int(11) DEFAULT '0' COMMENT '发布人',
   `create_time` datetime DEFAULT NULL COMMENT '发布时间',
   `modify_user` int(11) DEFAULT '0' COMMENT '修改人',
   `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
   PRIMARY KEY (`id`) USING BTREE,
   KEY `Index_1` (`property_id`, `community_id`) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '物业公告表';

DROP TABLE IF EXISTS `wlw_property_pm`;

CREATE TABLE `wlw_property_pm` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
   `property_id` int(11) NOT NULL DEFAULT '0' COMMENT '物业ID',
   `community_id` int(11) NOT NULL DEFAULT '0' COMMENT '小区ID',
   `title` varchar(200) NOT NULL COMMENT '标题',
   `content` text COMMENT '内容',
   `room_id` int(11) NOT NULL DEFAULT '0' COMMENT '房间ID',
   `app_user_id` int(11) NOT NULL DEFAULT '1' COMMENT '接收对象ID',
   `status` tinyint(4) DEFAULT '1' COMMENT '状态：0、未发布1、已发布',
   `create_user` int(11) DEFAULT '0' COMMENT '发布人',
   `create_time` datetime DEFAULT NULL COMMENT '发布时间',
   `modify_user` int(11) DEFAULT '0' COMMENT '修改人',
   `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
   PRIMARY KEY (`id`),
   KEY `Index_1` (`property_id`),
   KEY `Index_2` (`app_user_id`)
) DEFAULT CHARSET = utf8mb4 COMMENT = '物联网_物业私信表';

DROP TABLE IF EXISTS `wlw_repair_order`;

CREATE TABLE `wlw_repair_order` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '自增ID',
   `property_id` int(11) NOT NULL DEFAULT '0' COMMENT '物业ID',
   `community_id` int(11) NOT NULL DEFAULT '0' COMMENT '小区ID',
   `content` varchar(300) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '报修内容',
   `create_time` datetime DEFAULT NULL COMMENT '报修时间',
   `create_user` int(11) DEFAULT '0' COMMENT '报修人ID',
   `pic_keys` varchar(600) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '报修照片Keys，多个Key以英文逗号分割',
   `status` int(11) DEFAULT '0' COMMENT '处理状态0:待处理1:已处理',
   `solve_content` varchar(300) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '处理方案',
   `solver_user` int(11) DEFAULT NULL COMMENT '处理人ID',
   `solve_time` datetime DEFAULT NULL COMMENT '处理时间',
   PRIMARY KEY (`id`) USING BTREE,
   KEY `Index_1` (`property_id`, `community_id`) USING BTREE,
   KEY `Index_2` (`create_user`) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '物联网_物业报修';

DROP TABLE IF EXISTS `wlw_resident`;

CREATE TABLE `wlw_resident` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
   `community_id` int(11) NOT NULL DEFAULT '0' COMMENT '小区ID',
   `partition_id` int(11) NOT NULL DEFAULT '0' COMMENT '分区ID',
   `tenement_id` int(11) NOT NULL DEFAULT '0' COMMENT '楼宇ID',
   `unit_id` int(11) NOT NULL DEFAULT '0' COMMENT '单元ID',
   `room_id` int(11) NOT NULL DEFAULT '0' COMMENT '房间ID',
   `floor` int(11) NOT NULL DEFAULT '0' COMMENT '楼层',
   `app_user_id` int(11) NOT NULL DEFAULT '0' COMMENT 'App用户ID',
   `app_user_name` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '用户名称',
   `holder_user_id` int(11) DEFAULT '0' COMMENT '户主ID',
   `resident_type` tinyint(4) DEFAULT '0' COMMENT '住户身份类型\r\n            1.户主\r\n            2.住户',
   `is_fictitious` tinyint(4) NOT NULL DEFAULT '0' COMMENT '是否虚拟住户：0、否1、是',
   `mobile_phone` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '手机号（App用户更换手机号时，需要同步更新此信息）',
   `sip_num` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'SIP号',
   `sip_group_num` varchar(50) COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'SIP房间集团号',
   `key_status` tinyint(4) DEFAULT '1' COMMENT '钥匙状态 0：关， 1、开',
   `term_start` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '钥匙有效期（开始）:yyyy-MM-dd',
   `term_end` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '钥匙有效期（结束）:yyyy-MM-dd',
   `period_start` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '钥匙有效时段（开始）：HH:mm',
   `period_end` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '钥匙有效时段（结束）：HH:mm',
   `has_face` tinyint(4) DEFAULT '0' COMMENT '是否开通人脸识别：0否1是',
   `face_term` varchar(10) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '人脸识别使用截止日期：yyyy-MM-dd',
   `face_hash` varchar(512) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '人脸特征值哈希值',
   `video_term` varchar(10) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '视频通话使用截止日期：yyyy-MM-dd',
   `app_key_hash` varchar(256) COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'App公钥哈希值',
   `applet_key_hash` varchar(256) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '小程序公钥哈希值',
   `call_switch` tinyint(4) DEFAULT '1' COMMENT '呼叫开关：0、关 1、开',
   PRIMARY KEY (`id`) USING BTREE,
   KEY `Index_1` (
      `community_id`,
      `partition_id`,
      `tenement_id`,
      `unit_id`,
      `room_id`
   ) USING BTREE,
   KEY `Index_2` (`app_user_id`) USING BTREE,
   KEY `Index_3` (`holder_user_id`) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '物联网_住户信息表';

DROP TABLE IF EXISTS `wlw_resident_apply`;

CREATE TABLE `wlw_resident_apply` (
   `id` int(11) NOT NULL AUTO_INCREMENT,
   `community_id` int(11) NOT NULL DEFAULT '0' COMMENT '社区ID',
   `partition_id` int(11) NOT NULL DEFAULT '0' COMMENT '分区ID',
   `tenement_id` int(11) NOT NULL DEFAULT '0' COMMENT '楼宇ID',
   `unit_id` int(11) NOT NULL DEFAULT '0' COMMENT '单元ID',
   `room_id` int(11) NOT NULL DEFAULT '0' COMMENT '房间ID',
   `resident_type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '申请住户类型：1、户主2、住户',
   `apply_explain` varchar(250) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '申请说明',
   `has_grant` tinyint(4) NOT NULL DEFAULT '0' COMMENT '身份信息授权：0、不同意1、同意',
   `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态：0、待审核1、通过2、不通过',
   `app_user_id` int(11) NOT NULL DEFAULT '0' COMMENT '申请人ID',
   `apply_time` datetime DEFAULT NULL COMMENT '申请时间',
   `audit_resident_type` tinyint(11) DEFAULT '0' COMMENT '审核身份:1、户主2、住户',
   `handle` tinyint(4) DEFAULT '0' COMMENT '审核人：1、物业审核，2、户主审核，3、系统审核',
   `handle_id` int(11) DEFAULT '0' COMMENT '审核人ID',
   `audit_time` datetime DEFAULT NULL COMMENT '审核时间',
   `audit_explain` varchar(250) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '审核说明',
   `allow_sys_audit` tinyint(4) NOT NULL DEFAULT '0' COMMENT '允许系统审核：0、否1、是',
   `sys_audit_time` datetime DEFAULT NULL COMMENT '系统审核时间（申请时间+小区设置系统审核时长）',
   PRIMARY KEY (`id`) USING BTREE,
   KEY `Index_1` (
      `community_id`,
      `partition_id`,
      `tenement_id`,
      `unit_id`,
      `room_id`
   ) USING BTREE,
   KEY `Index_2` (`app_user_id`) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '物联网_住户申请表';

DROP TABLE IF EXISTS `wlw_resident_apply_result`;

CREATE TABLE `wlw_resident_apply_result` (
   `id` int(11) NOT NULL AUTO_INCREMENT,
   `apply_id` int(11) NOT NULL COMMENT '申请ID',
   `community` varchar(250) COLLATE utf8mb4_bin NOT NULL COMMENT '小区名称',
   `room` varchar(250) COLLATE utf8mb4_bin NOT NULL COMMENT '房间：分区-楼宇-单元-房间',
   `app_user_id` int(11) NOT NULL DEFAULT '0' COMMENT '申请人ID',
   `result` tinyint(4) NOT NULL DEFAULT '0' COMMENT '申请结果：0、失败1、成功',
   `handle` tinyint(4) NOT NULL COMMENT '审核人：1、物业审核，2、户主审核，3、系统审核',
   `audit_time` datetime NOT NULL COMMENT '审核时间',
   `audit_explain` varchar(250) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '审核说明',
   PRIMARY KEY (`id`) USING BTREE,
   KEY `Index_1` (`app_user_id`) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '物联网_住户申请结果表';

DROP TABLE IF EXISTS `wlw_resident_invite`;

CREATE TABLE `wlw_resident_invite` (
   `id` int(11) NOT NULL AUTO_INCREMENT,
   `community_id` int(11) NOT NULL DEFAULT '0' COMMENT '小区ID',
   `partition_id` int(11) NOT NULL DEFAULT '0' COMMENT '分区ID',
   `tenement_id` int(11) NOT NULL DEFAULT '0' COMMENT '楼宇ID',
   `unit_id` int(11) NOT NULL DEFAULT '0' COMMENT '单元ID',
   `room_id` int(11) NOT NULL DEFAULT '0' COMMENT '房间ID',
   `resident_type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '邀请住户类型：1、户主2、住户',
   `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态：0、待审核1、通过2、不通过',
   `invited_phone` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '被邀请手机号',
   `invite_time` datetime DEFAULT NULL COMMENT '邀请时间',
   `inviter` tinyint(4) DEFAULT '0' COMMENT '邀请人：1、物业，2、户主',
   `inviter_id` int(11) NOT NULL DEFAULT '0' COMMENT '邀请人ID',
   `audit_time` datetime DEFAULT NULL COMMENT '审核时间',
   `term_start` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '钥匙有效期（开始）：yyyy-MM-dd',
   `term_end` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '钥匙有效期（结束）：yyyy-MM-dd',
   `period_start` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '钥匙有效时段（开始）：HH:mm',
   `period_end` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '钥匙有效时段（结束）：HH:mm',
   PRIMARY KEY (`id`) USING BTREE,
   KEY `Index_1` (
      `community_id`,
      `partition_id`,
      `tenement_id`,
      `unit_id`,
      `room_id`
   ) USING BTREE,
   KEY `Index_2` (`inviter`, `inviter_id`) USING BTREE,
   KEY `Index_3` (`invited_phone`) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '物联网_住户邀请表';

DROP TABLE IF EXISTS `wlw_resident_invite_result`;

CREATE TABLE `wlw_resident_invite_result` (
   `id` int(11) NOT NULL AUTO_INCREMENT,
   `invite_id` int(11) NOT NULL COMMENT '邀请ID',
   `community` varchar(250) COLLATE utf8mb4_bin NOT NULL COMMENT '小区名称',
   `room` varchar(250) COLLATE utf8mb4_bin NOT NULL COMMENT '房间：分区-楼宇-单元-房间',
   `invited_phone` varchar(20) COLLATE utf8mb4_bin NOT NULL COMMENT '被邀请手机号',
   `app_user_id` int(11) NOT NULL DEFAULT '0' COMMENT '邀请人ID',
   `result` tinyint(4) NOT NULL DEFAULT '0' COMMENT '邀请结果：0、失败1、成功',
   `audit_time` datetime NOT NULL COMMENT '审核时间',
   PRIMARY KEY (`id`) USING BTREE,
   KEY `Index_1` (`app_user_id`) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '物联网_住户邀请结果表';

DROP TABLE IF EXISTS `wlw_rom_group`;

CREATE TABLE `wlw_rom_group` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
   `eq_model` int(11) NOT NULL DEFAULT '1' COMMENT '机型：取字典1001',
   `name_cn` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '分组名称',
   `name_en` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '分组标识',
   `rom_id` int(11) DEFAULT '0' COMMENT 'ROM升级包ID',
   `switch_status` tinyint(4) DEFAULT '0' COMMENT '分组开关：1、开启 0、关闭',
   `memo` varchar(2000) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '备注',
   `create_user` int(11) DEFAULT '0' COMMENT '创建人',
   `create_time` datetime DEFAULT NULL COMMENT '创建时间',
   `modify_user` int(11) DEFAULT '0' COMMENT '修改人',
   `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
   PRIMARY KEY (`id`) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '物联网_设备ROM升级分组';

DROP TABLE IF EXISTS `wlw_rom_group_member`;

CREATE TABLE `wlw_rom_group_member` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
   `rom_group_id` int(11) NOT NULL DEFAULT '0' COMMENT 'ROM分组ID',
   `serial_number` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '设备串号',
   PRIMARY KEY (`id`) USING BTREE,
   KEY `Index_1` (`rom_group_id`) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '物联网_设备ROM升级分组成员表';

DROP TABLE IF EXISTS `wlw_room`;

CREATE TABLE `wlw_room` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
   `community_id` int(11) NOT NULL DEFAULT '0' COMMENT '社区ID',
   `partition_id` int(11) NOT NULL DEFAULT '0' COMMENT '分区ID',
   `tenement_id` int(11) NOT NULL DEFAULT '0' COMMENT '楼宇ID',
   `unit_id` int(11) NOT NULL DEFAULT '0' COMMENT '单元ID',
   `name` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '房号',
   `floor` int(11) NOT NULL DEFAULT '0' COMMENT '楼层',
   `sip_num` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'sip号码(波特识别的房间号，虚拟集团号)',
   `urge_switch` tinyint(4) DEFAULT '0' COMMENT '是否催缴;0否、1是',
   `video_term` varchar(10) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '视频通话使用截止日期',
   `call_address` varchar(20) DEFAULT NULL COMMENT '呼叫地址',
   `status` tinyint(4) DEFAULT '1' COMMENT '状态\r\n            1:有效 \r\n            0:停用',
   `create_user` int(11) DEFAULT '0' COMMENT '创建人',
   `create_time` datetime DEFAULT NULL COMMENT '创建时间',
   `modify_user` int(11) DEFAULT '0' COMMENT '修改人',
   `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
   PRIMARY KEY (`id`) USING BTREE,
   KEY `Index_1` (
      `community_id`,
      `partition_id`,
      `tenement_id`,
      `unit_id`
   ) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '物联网_房间表';

DROP TABLE IF EXISTS `wlw_service_order`;

CREATE TABLE `wlw_service_order` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
   `order_num` varchar(50) COLLATE utf8mb4_bin NOT NULL COMMENT '订单号',
   `goods` tinyint(4) NOT NULL DEFAULT '0' COMMENT '服务商品：1、人脸服务2、可视对讲',
   `term` int(11) NOT NULL DEFAULT '1' COMMENT '服务期限（月份数，0表示永久）',
   `price` decimal(8, 2) NOT NULL DEFAULT '0.00' COMMENT '价格',
   `app_user_id` int(11) NOT NULL DEFAULT '0' COMMENT 'App用户ID',
   `benefit_user_id` int(11) NOT NULL DEFAULT '0' COMMENT '受益用户ID',
   `room_id` int(11) NOT NULL DEFAULT '0' COMMENT '房间ID',
   `community_id` int(11) NOT NULL DEFAULT '0' COMMENT '小区ID',
   `abb_ratio` decimal(3, 2) NOT NULL DEFAULT '1.00' COMMENT 'ABB分成比例',
   `abb_amount` decimal(8, 2) NOT NULL DEFAULT '0.00' COMMENT 'ABB分成金额',
   `agent_id` int(11) NOT NULL DEFAULT '0' COMMENT '经销商ID',
   `agent_ratio` decimal(3, 2) NOT NULL DEFAULT '0.00' COMMENT '经销商分成比例',
   `agent_amount` decimal(8, 2) NOT NULL DEFAULT '0.00' COMMENT '物业分成金额',
   `property_id` int(11) NOT NULL DEFAULT '0' COMMENT '物业ID',
   `property_ratio` decimal(3, 2) NOT NULL DEFAULT '0.00' COMMENT '物业分成比例',
   `property_amount` decimal(8, 2) NOT NULL DEFAULT '0.00' COMMENT '物业分成金额',
   `pay_type` tinyint(4) DEFAULT '0' COMMENT '支付类型：1、微信2、支付宝3、苹果内购',
   `status` tinyint(4) NOT NULL DEFAULT '0' COMMENT '状态：0、待支付1、已支付2、支付失败3、超时订单',
   `order_time` datetime DEFAULT NULL COMMENT '下单时间',
   `pay_time` datetime DEFAULT NULL COMMENT '支付时间（订单完成时间）',
   PRIMARY KEY (`id`) USING BTREE,
   KEY `Index_1` (`order_num`) USING BTREE,
   KEY `Index_2` (`agent_id`, `community_id`, `property_id`) USING BTREE,
   KEY `Index_3` (`app_user_id`) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '物联网_增值服务订单表';

DROP TABLE IF EXISTS `wlw_tenement`;

CREATE TABLE `wlw_tenement` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
   `community_id` int(11) NOT NULL DEFAULT '0' COMMENT '小区ID',
   `partition_id` int(11) NOT NULL DEFAULT '0' COMMENT '分区ID',
   `name` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '楼宇名称',
   `tenement_number` int(11) DEFAULT '0' COMMENT '楼栋编号',
   `status` tinyint(4) DEFAULT '1' COMMENT '状态\r\n            1:有效 \r\n            0:停用',
   `create_user` int(11) DEFAULT '0' COMMENT '创建人',
   `create_time` datetime DEFAULT NULL COMMENT '创建时间',
   `modify_user` int(11) DEFAULT '0' COMMENT '修改人',
   `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
   PRIMARY KEY (`id`) USING BTREE,
   KEY `Index_1` (`community_id`, `partition_id`) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '物联网_楼宇表';

DROP TABLE IF EXISTS `wlw_unit`;

CREATE TABLE `wlw_unit` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
   `community_id` int(11) NOT NULL DEFAULT '0' COMMENT '小区ID',
   `partition_id` int(11) NOT NULL DEFAULT '0' COMMENT '分区ID',
   `tenement_id` int(11) NOT NULL DEFAULT '0' COMMENT '楼宇ID',
   `name` varchar(100) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '单元名称',
   `unit_number` int(11) DEFAULT '0' COMMENT '单元编号',
   `call_address` varchar(20) DEFAULT NULL COMMENT '呼叫地址',
   `status` tinyint(4) DEFAULT '1' COMMENT '状态\r\n            1:有效 \r\n            0:停用',
   `create_user` int(11) DEFAULT '0' COMMENT '创建人',
   `create_time` datetime DEFAULT NULL COMMENT '创建时间',
   `modify_user` int(11) DEFAULT '0' COMMENT '修改人',
   `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
   PRIMARY KEY (`id`) USING BTREE,
   KEY `Index_1` (`community_id`, `partition_id`, `tenement_id`) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '物联网_单元表';

DROP TABLE IF EXISTS `wlw_visitor_password`;

CREATE TABLE `wlw_visitor_password` (
   `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
   `community_id` int(11) NOT NULL DEFAULT '0' COMMENT '社区ID',
   `partition_id` int(11) NOT NULL DEFAULT '0' COMMENT '分区ID',
   `tenement_id` int(11) NOT NULL DEFAULT '0' COMMENT '楼宇ID',
   `unit_id` int(11) NOT NULL DEFAULT '0' COMMENT '单元ID',
   `room_id` int(11) NOT NULL DEFAULT '0' COMMENT '房间ID',
   `app_user_id` int(11) NOT NULL DEFAULT '0' COMMENT '用户ID',
   `password` varchar(8) COLLATE utf8mb4_bin NOT NULL COMMENT '密码',
   `type` tinyint(4) NOT NULL DEFAULT '0' COMMENT '类型:1、一次性2、有效期',
   `apply_time` datetime NOT NULL COMMENT '申请时间',
   `deadline` datetime NOT NULL COMMENT '有效截止时间',
   PRIMARY KEY (`id`) USING BTREE,
   KEY `Index_1` (
      `community_id`,
      `partition_id`,
      `tenement_id`,
      `unit_id`,
      `room_id`
   ) USING BTREE,
   KEY `Index_2` (`app_user_id`) USING BTREE
) DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_bin ROW_FORMAT = COMPACT COMMENT = '物联网_访客密码表';

CREATE TABLE `wlw_external_device_model` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(100) NOT NULL COLLATE utf8mb4_bin COMMENT '设备类型名称',
  `create_user` int(11) DEFAULT '0' COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_user` int(11) DEFAULT '0' COMMENT '修改人',
  `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='外部设备类型表';

CREATE TABLE `wlw_external_device` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `model_id` int(11) NOT NULL COMMENT '设备所属类型id',
  `community_id` int(11) NOT NULL COMMENT '设备所属小区id',
  `sn` varchar(32) NOT NULL COLLATE utf8mb4_bin COMMENT '设备序列号',
  `location` varchar(64) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '设备位置',
  `current_version` varchar(32) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '设备当前版本号',
  `description` varchar(512) COLLATE utf8mb4_bin DEFAULT NULL COMMENT '设备信息描述',
  `create_user` int(11) DEFAULT '0' COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_user` int(11) DEFAULT '0' COMMENT '修改人',
  `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_model_id_1_community_id_2_sn_3` (`model_id`,`community_id`,`sn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='外部设备表';

CREATE TABLE `wlw_upgrade_package` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(100) NOT NULL COMMENT '升级包名称',
  `upgrade_type` tinyint(4) NOT NULL COMMENT '升级类型：0-连云设备， 1-代理设备',
  `device_model_id` int(11) NOT NULL COMMENT '设备类型(机型)id',
  `package_type` tinyint(4) NOT NULL COMMENT '升级包类型：0-全量， 1-差分',
  `package_level` varchar(32) NOT NULL COMMENT '升级包层级：如rom、mcu、apk等',
  `package_version` varchar(32) NOT NULL COMMENT '版本号(如1.0.0)',
  `package_description` varchar(512) DEFAULT NULL COMMENT '更新内容',
  `package_key` varchar(64) NOT NULL COMMENT '升级包在对象存储中的索引Key',
  `package_size` bigint(11) NOT NULL COMMENT '升级包文件大小',
  `package_sign` varchar(256) NOT NULL COMMENT '升级包签名',
  `status` tinyint(4) DEFAULT NULL COMMENT '状态: 0-未发布, 1-已发布, 2-已下线',
  `create_user` int(11) DEFAULT '0' COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_user` int(11) DEFAULT '0' COMMENT '修改人',
  `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='升级包管理表';

CREATE TABLE `wlw_upgrade_version_range` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `package_id` int(11) NOT NULL COMMENT '升级包id',
  `min_version` varchar(32) NOT NULL COMMENT '允许升级的最小版本号(如1.0.0)',
  `max_version` varchar(32) NOT NULL COMMENT '允许升级的最大版本号(如2.0.0)',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='升级包版本范围表';


CREATE TABLE `wlw_upgrade_task` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `name` varchar(100) NOT NULL COMMENT '升级任务名称',
  `package_id` int(11) NOT NULL COMMENT '升级包id',
  `status` tinyint(4) DEFAULT NULL COMMENT '状态: 0-关闭, 1-开启',
  `create_user` int(11) DEFAULT '0' COMMENT '创建人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `modify_user` int(11) DEFAULT '0' COMMENT '修改人',
  `modify_time` datetime DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='升级任务表';

CREATE TABLE `wlw_upgrade_task_device` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `task_id` int(11) NOT NULL COMMENT '升级任务id',
  `device_id` int(11) NOT NULL COMMENT '设备id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin COMMENT='升级任务设备表';

