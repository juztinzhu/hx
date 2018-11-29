from django.contrib import admin
from surgery.models import PatientBasic,CHA2DS2VACsEvaluation,HASBLEdEvaluation,SurgeryInfo,TEE

class ModifiedTabInline(admin.TabularInline):
    extra = 1
    max_num = 1
    can_delete = False

class cha2ds2vacsInline(ModifiedTabInline):
    model = CHA2DS2VACsEvaluation

class hasbledInline(ModifiedTabInline):
    model = HASBLEdEvaluation

class surgeryInfoInline(ModifiedTabInline):
    model = SurgeryInfo

class SurgeryInfoAdmin(admin.ModelAdmin):
    pass

class PatientAdmin(admin.ModelAdmin):
    inlines = [cha2ds2vacsInline, hasbledInline, surgeryInfoInline]
    fieldsets = (
        ['基本信息',{'fields':('registerId','name','idstr','gender','age','phone','af',
        'otherDisease','lifeQualityScore')}],
    )
# Register your models here.
admin.site.register(PatientBasic,PatientAdmin)
admin.site.register(SurgeryInfo,SurgeryInfoAdmin)
admin.site.register([])
