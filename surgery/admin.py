from django.contrib import admin
import nested_admin
from surgery.models import PatientBasic,CHA2DS2VACsEvaluation,HASBLEdEvaluation,UCG,TEE,InSurgery,Ablation,LAA,Antiarrhythmic,Anticoagulant,SurgeryMethod,AblationType,PreCheck,FollowTEE,FollowTTE,SurgeryFollow

class ModifiedTabInline(nested_admin.nested.NestedTabularInline):
    extra = 1
    max_num = 1
    can_delete = False

class cha2ds2vacsInline(ModifiedTabInline):
    model = CHA2DS2VACsEvaluation
    verbose_name = u'CHA2DS2-VACs评分'
    verbose_name_plural = verbose_name

class hasbledInline(ModifiedTabInline):
    model = HASBLEdEvaluation
    verbose_name_plural = u'HAS-BLED评分'
    verbose_name = verbose_name_plural

class UCGInline(ModifiedTabInline):
    model = UCG
    verbose_name_plural = u'UCG'

class TEEInline(ModifiedTabInline):
    model = TEE
    verbose_name_plural = u'TEE'


class AblationInline(ModifiedTabInline):
    model = Ablation
    verbose_name_plural = u'消融'

class LAAInline(ModifiedTabInline):
    model = LAA
    verbose_name_plural = u'左心耳封堵'

class PreCheckInline(ModifiedTabInline):
    model = PreCheck
    inlines = [UCGInline, TEEInline]
    verbose_name_plural = u'术前检查'
    verbose_name = verbose_name_plural


class InSurgeryInline(ModifiedTabInline):
    model = InSurgery
    inlines = [AblationInline, LAAInline]
    verbose_name_plural = u'术中信息'
    verbose_name = verbose_name_plural

class FollowTEEInline(ModifiedTabInline):
    model = FollowTEE

class FollowTTEInline(ModifiedTabInline):
    model = FollowTTE

class SurgeryFollowInline(nested_admin.nested.NestedTabularInline):
    model = SurgeryFollow
    inlines = [FollowTTEInline,FollowTEEInline]
    verbose_name = u'术后随访'
    verbose_name_plural = verbose_name
    extra = 4
    max_num = 4
    #can_delete = False

class PatientAdmin(nested_admin.nested.NestedModelAdmin):
    inlines = [cha2ds2vacsInline,hasbledInline,InSurgeryInline,PreCheckInline,SurgeryFollowInline]
    fieldsets = (
        (u'基本信息',{'fields':(('registerId','name','idstr'),('gender','age','phone',))}),
        ("1", {"classes": ("placeholder cha2ds2vacsevaluation_set-group",), "fields" : ()}),
        ("2", {"classes": ("placeholder hasbledevaluation_set-group",), "fields" : ()}),
#        [u'术前检查-UCG', {'fields':('LV','LA','RV','RA','EF')}],
#        [u'术前检查-TEE',{'fields':('hasThrombus','laa0Diameter')}],
        ('',{'fields':('af','otherDisease','lifeQualityScore')}),
        (u'术前检查',{"classes": ("placeholder precheck_set-group",), "fields" : ()}),
        ('',{'fields':(('opDate','opType','opMethod',),)}),
        (u'术中信息',{"classes": ("placeholder insurgery_set-group",), "fields" : ()}),
        (u'术后用药',{'fields': ('anticoagulant', 'antiarrhythmic',)}),
        (u'术后随访',{"classes": ("placeholder surgeryfollow_set-group",), "fields" : ()}),

    )
    filter_horizontal = (
    #    'anticoagulant', 'antiarrhythmic',
    )
    list_display = (
        'registerId', 'name','idstr','gender','age','phone','af',
    )

    verbose_name = u'患者信息'
    verbose_name_plural = u'患者信息'


# Register your models here.
class MyAdminSite(admin.AdminSite):
    site_header = u'信息统计'  # 此处设置页面显示标题
    site_title = u'手术信息统计系统'  # 此处设置页面头部标题
 
admin_site = MyAdminSite(name='stat')
#admin.site.register(PatientBasic,PatientAdmin)
admin_site.register(PatientBasic,PatientAdmin)
admin_site.register(SurgeryMethod)
admin_site.register(AblationType)
admin_site.register(Anticoagulant)
admin_site.register(Antiarrhythmic)
#admin.site.register([SurgeryType])
