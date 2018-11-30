from django.contrib import admin
import nested_admin
from surgery.models import PatientBasic,CHA2DS2VACsEvaluation,HASBLEdEvaluation,UCG,TEE,InSurgery,Ablation,LAA

class ModifiedTabInline(nested_admin.nested.NestedTabularInline):
    extra = 1
    max_num = 1
    can_delete = False

class cha2ds2vacsInline(ModifiedTabInline):
    model = CHA2DS2VACsEvaluation

class hasbledInline(ModifiedTabInline):
    model = HASBLEdEvaluation

class UCGInline(ModifiedTabInline):
    model = UCG

class TEEInline(ModifiedTabInline):
    model = TEE


class AblationInline(ModifiedTabInline):
    model = Ablation

class LAAInline(ModifiedTabInline):
    model = LAA

class InSurgeryInline(ModifiedTabInline):
    model = InSurgery
    inlines = [AblationInline, LAAInline]

class PatientAdmin(nested_admin.nested.NestedModelAdmin):
    inlines = [cha2ds2vacsInline,hasbledInline,UCGInline,TEEInline,InSurgeryInline,]
    fieldsets = (
        (u'基本信息',{'fields':(('registerId','name','idstr'),('gender','age','phone',))}),
        ("1", {"classes": ("placeholder cha2ds2vacsevaluation_set-group",), "fields" : ()}),
        ("2", {"classes": ("placeholder hasbledevaluation_set-group",), "fields" : ()}),
#        [u'术前检查-UCG', {'fields':('LV','LA','RV','RA','EF')}],
#        [u'术前检查-TEE',{'fields':('hasThrombus','laa0Diameter')}],
        ('',{'fields':('af','otherDisease','lifeQualityScore')}),
        (u'术前检查',{"classes": ("placeholder ucg_set-group",), "fields" : ()}),
        (u'术前检查',{"classes": ("placeholder tee_set-group",), "fields" : ()}),
        ('',{'fields':(('opDate','opType','opMethod',),)}),
        (u'术中信息',{"classes": ("placeholder insurgery_set-group",), "fields" : ()}),
        (u'术后用药',{'fields': (('anticoagulant', 'antiarrhythmic'),)})

    )
# Register your models here.
admin.site.register(PatientBasic,PatientAdmin)
#admin.site.register([SurgeryType])
