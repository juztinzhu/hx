from django.apps import AppConfig
from django.contrib.admin.apps import AdminConfig

class SurgeryConfig(AppConfig):
    name = 'surgery'
    verbose_name = u'左心耳封堵手术患者信息统计'

#class MyAdminConfig(AdminConfig):
    #default_site = 'surgery.admin.MyAdminSite'
