from django.db import models

# Create your models here.
class PatientBasic(models.Model):
    def __str__(self):
        return self.name+'|'+self.idstr
    name = models.CharField(u'姓名',max_length=20)
    idstr = models.CharField(u'身份证号',max_length=20)
    registerId = models.CharField(u'住院号',max_length=20)
    GENDER = (
        ('M',u'男'),
        ('F',u'女')
    )
    gender = models.CharField(u'性别',max_length=1, choices = GENDER)
    age = models.IntegerField(u'年龄')
    phone = models.CharField(u'联系方式',max_length=64)
    #physical = models.OneToOneField(PatientPhysical, on_delete=models.CASCADE)
    AFIB = (
        ('ps','PsAF'),
        ('lps','LPsAF'),
        ('p','PAF'),        
    )
    af = models.CharField(u'房颤类型', max_length=4, choices = AFIB)
    otherDisease = models.CharField(u'其他疾病', max_length=255)
    lifeQualityScore = models.IntegerField(u'生活质量评分')

class PatientAttribute(models.Model):
    patient = models.ForeignKey(PatientBasic, on_delete = models.CASCADE)

class CHA2DS2VACsEvaluation(PatientAttribute):    
    c1 = models.IntegerField(u'C充血性心衰/左心功能不全')
    h = models.IntegerField(u'H高血压')
    a1 = models.IntegerField(u'A年龄>=75岁')
    d = models.IntegerField(u'D糖尿病')
    s = models.IntegerField(u'S中风/TIA/血栓史')
    v = models.IntegerField(u'V血管病变')
    a2 = models.IntegerField(u'A年龄65~74岁')
    c2 = models.IntegerField(u'C性别为女')
    total = models.IntegerField(u'总分')

class HASBLEdEvaluation(PatientAttribute):
    h = models.IntegerField(u'H高血压')
    a = models.IntegerField(u'A肾和肝功能异常')
    s = models.IntegerField(u'S卒中')
    b = models.IntegerField(u'S出血')
    l = models.IntegerField(u'LINR易变')
    e = models.IntegerField(u'E年龄>65岁')
    d = models.IntegerField(u'D药物或酒精(各1分)')
    total = models.IntegerField(u'总分')
   
class SurgeryType(models.Model):
    OPTYPE = (
        ('rf','RF'),
        ('laac','LAAC')
    )
    opType = models.CharField(max_length=8, choices = OPTYPE)

class SurgeryInfo(PatientAttribute):
    #ucg
    LV = models.IntegerField()
    LA = models.IntegerField()
    RV = models.IntegerField()
    RA = models.IntegerField()
    EF = models.IntegerField()
    #tee
    hasThrombus = models.BooleanField(u'是否有血栓')
    laa0Diameter = models.IntegerField(u'0LAA开口直径')
    laa0Depth = models.IntegerField(u'0LAA开口深度')
    laa45Diameter = models.IntegerField(u'45开口直径')
    laa45Depth = models.IntegerField(u'45开口深度')
    laa90Diameter = models.IntegerField(u'90开口直径')
    laa90Depth = models.IntegerField(u'90开口深度')
    laa135Diameter = models.IntegerField(u'135开口直径')
    laa135Depth = models.IntegerField(u'135开口深度')
    #
    opDate = models.DateField(u'手术日期')
    opType = models.ManyToManyField(SurgeryType)

class PreCheck(PatientAttribute):
    pass



    