from django.db import models

# Create your models here.

class SurgeryMethod(models.Model):
    class Meta:
        verbose_name = u'手术方式'
        verbose_name_plural = verbose_name
    OPMETHOD = (
        ('Ensite','Ensite'),
        ('Watchman','Watchman'),
        ('ACP','ACP'),
        ('Carto','Carto')
    )
    name = models.CharField(max_length = 16, choices = OPMETHOD)
    def __str__(self):
        return self.name
    

class Anticoagulant(models.Model):
    class Meta:
        verbose_name = u'抗凝药'
        verbose_name_plural = verbose_name
    name = models.CharField(max_length = 64, )
    def __str__(self):
        return self.name

class Antiarrhythmic(models.Model):
    class Meta:
        verbose_name = u'抗心律失常药'
        verbose_name_plural = verbose_name
    name = models.CharField(max_length = 64,)
    def __str__(self):
        return self.name

class PatientBasic(models.Model):
    class Meta:
        verbose_name = u'患者信息'
        verbose_name_plural = verbose_name

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
    opDate = models.DateField(u'手术日期')
    OPTYPE = (
        ('RF','RF'),
        ('LAAC','LAAC'),
        ('RF+LAAC','RF+LAAC')
    )
    opType = models.CharField(u'手术类型', max_length=8, choices = OPTYPE)
    opMethod = models.ManyToManyField(SurgeryMethod, verbose_name = u'手术方式')
    anticoagulant = models.ManyToManyField(Anticoagulant, verbose_name = u'抗凝药')
    antiarrhythmic = models.ManyToManyField(Antiarrhythmic, verbose_name = u'抗心率失常药')


class PatientAttribute(models.Model):
    patient = models.ForeignKey(PatientBasic, on_delete = models.CASCADE)

class CHA2DS2VACsEvaluation(PatientAttribute):    
    class Meta:
        verbose_name = u'CHA2DS2-VACs评分'
        verbose_name_plural = verbose_name

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
    class Meta:
        verbose_name_plural = u'HAS-BLED评分'
        verbose_name = verbose_name_plural

    h = models.IntegerField(u'H高血压')
    a = models.IntegerField(u'A肾和肝功能异常')
    s = models.IntegerField(u'S卒中')
    b = models.IntegerField(u'S出血')
    l = models.IntegerField(u'LINR易变')
    e = models.IntegerField(u'E年龄>65岁')
    d = models.IntegerField(u'D药物或酒精(各1分)')
    total = models.IntegerField(u'总分')

class PreCheck(PatientAttribute):
    class Meta:
        verbose_name = u'术前检查'
        verbose_name_plural = verbose_name

class TEE(models.Model):
    precheck = models.ForeignKey(PreCheck,on_delete = models.CASCADE)
    hasThrombus = models.BooleanField(u'是否有血栓')
    laa0Diameter = models.IntegerField(u'0LAA开口直径')
    laa0Depth = models.IntegerField(u'0LAA开口深度')
    laa45Diameter = models.IntegerField(u'45开口直径')
    laa45Depth = models.IntegerField(u'45开口深度')
    laa90Diameter = models.IntegerField(u'90开口直径')
    laa90Depth = models.IntegerField(u'90开口深度')
    laa135Diameter = models.IntegerField(u'135开口直径')
    laa135Depth = models.IntegerField(u'135开口深度')

class UCG(models.Model):
    precheck = models.ForeignKey(PreCheck,on_delete = models.CASCADE)
    LV = models.IntegerField(u'LV')
    LA = models.IntegerField()
    RV = models.IntegerField()
    RA = models.IntegerField()
    EF = models.IntegerField()


class InSurgery(PatientAttribute):
    class Meta:
        verbose_name = u'术中信息'
        verbose_name_plural = verbose_name
    pass

class AblationType(models.Model):
    class Meta:
        verbose_name = u'消融术式'
        verbose_name_plural = verbose_name
    ABLATION = (
        ('pvi','PVI'),
        ('tvi', 'TVI'),
        ('mvi','MVI'),
        ('roof','ROOF'),
        ('top',u'顶部线'),
        ('bi',u'二尖瓣峡部线'),
        ('front', u'前壁线'),
        ('base', u'基质改良'),
        ('box','BOX'),
    )
    abType = models.CharField(max_length = 8, choices = ABLATION)
    def __str__(self):
        return self.get_abType_display()


class Ablation(models.Model):
    class Meta:
        verbose_name = u'消融'
        verbose_name_plural = verbose_name
    surgery = models.ForeignKey(InSurgery,on_delete = models.CASCADE)
    opTimes = models.IntegerField(u"房颤手术次数")
    ablationType = models.ManyToManyField(AblationType, verbose_name = u'消融术式')
    isLinear = models.BooleanField(u'是否线性消融')
    isLowVolt = models.BooleanField(u'低电压区')
    HEARTRYTHM = (
        ('sr',u'窦律'),
        ('af',u'房颤'),
    )
    heartRythmAfter = models.CharField(u'消融后心率',max_length=2, choices = HEARTRYTHM, default = '')
    CARDIOVERSION = (
        ('',u''),
        ('e',u'电复律')
    )
    cardioversionType = models.CharField(u'复律',max_length=2,choices = CARDIOVERSION, default = '')
    

class LAA(models.Model):
    class Meta:
        verbose_name = u'左心耳封堵'
        verbose_name_plural = verbose_name
    surgery = models.ForeignKey(InSurgery,on_delete = models.CASCADE)
    xrayLAADiameter = models.IntegerField(u'X光心耳开口直径')
    xrayLAADepth = models.IntegerField(u'X光心耳开口深度')
    teeLAADiameter = models.IntegerField(u'TEE心耳直径')
    teeLAADepth = models.IntegerField(u'TEE心耳深度')
    umbrella = models.IntegerField(u'封堵伞型号')
    releaseTimes = models.IntegerField(u'释放次数')
    succeed = models.BooleanField(u'是否成功')
    branchRemain = models.BooleanField(u'是否有残余分流')

class SurgeryFollow(PatientAttribute):
    class Meta:
        verbose_name = u'术后随访'
        verbose_name_plural = verbose_name
    FOLLOWTIME = (
        ('45d',u'术后45天'),
        ('3m',u'术后3月'),
        ('6m',u'术后6月'),
        ('1y',u'术后1年'),
    )
    date = models.CharField(u'随访日期', max_length = 4, choices = FOLLOWTIME)

class FollowTTE(models.Model):
    class Meta:
        verbose_name = 'TTE'
        verbose_name_plural = verbose_name
    follow = models.ForeignKey(SurgeryFollow, on_delete = models.CASCADE)
    LV = models.IntegerField()
    LA = models.IntegerField()
    RV = models.IntegerField()
    RA = models.IntegerField()
    EF = models.IntegerField()
    MVE = models.IntegerField('MV-E')
    MVA	= models.IntegerField('MV-A')
    TDIE = models.IntegerField('TDI-E\'')
    TDIA = models.IntegerField('TDI-A\'')
    EE = models.IntegerField('E/E\'')

class FollowTEE(models.Model):
    class Meta:
        verbose_name = 'TEE'
        verbose_name_plural = verbose_name
    follow = models.ForeignKey(SurgeryFollow, on_delete = models.CASCADE)
    branchRemain = models.BooleanField(u'有无分流')
    branchWidth = models.IntegerField(u'分流束宽')
    hasThrombus = models.BooleanField(u'有无血栓')

