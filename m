Return-Path: <prvs=566751c09=Stanislav.Nijnikov@wdc.com>
X-Google-Smtp-Source: AH8x224fjhWJIdoXO5e4ERJNSXCVjie6R3DMZ2d99uKkyIgKpJJdlkjiW8hRsEQ7SdJPxwwX1vg1
ARC-Seal: i=1; a=rsa-sha256; t=1517747353; cv=none;
        d=google.com; s=arc-20160816;
        b=sZXg/0T/SiHxrqqj1JEmj8PJyBs7iVroj/c6409r4yEnVmWGqLN2zwcPa0owRjmpTS
         LXwtMK7K004xr6AaBtlpQaFqSQ6OfZkFb1fJzGV/As8Ce40KYBPYwNrvSj5fPMvuNF/7
         ECJFVFI1RgORxrWiLZUP9+0OcQP1g3SrrBgw0TR1HnXEeHRFNnbNYRJjBpkh7DsTzKBX
         PlG5281Ugpqh3x9iyypdyo7hzhacHb1noSMvz+u1Dh13S3oywgBQop7pjl/bHE+bQ1VO
         LyEzsGLaLk2wP6Za9hCsNUjmkmdl5UM2QlFUkgvf+dapFOnWKjJSuaPWRlg8NfJy+DhI
         giSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:wdcipoutbound:content-language:accept-language
         :in-reply-to:references:message-id:date:thread-index:thread-topic
         :subject:cc:to:from:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=1M13GQQCJ7qtuhXRLvZdQfiKjoMN6NStpnu/EoBxNo0=;
        b=gfuo2tXdslG/zvfVjjly92Z/WcXdyLWGTaDHzTpWUlRVMoaOX9QX0YKPqDrp0t/5CQ
         cFiHreACwmD+pwZK2tYF0O9FS6OE4aLkbkQXFLarmSzNy9RAsYzAwG7R3HmjlaW8PsaP
         MwtTQlnrR4bq4kf0VgQN7m7Yo09P8cmSYlKM6vrIYoontvDWdTbxpHqLr5mQbGfmYcVk
         XDHEq7R7ueqEw29V2HfGInM3380HuKY+BM4ZW8yDy3bNSzPLkbMkScySE8bCWArzrYk5
         oJYbCTKg7QL/Fsb958GJhdKXmJZ9EQxdAQ4n0b9dNgo4pLRyDIHLenrx5JhQR5RXBvER
         gJpQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=fWcoSCOw;
       dkim=pass header.i=@sharedspace.onmicrosoft.com header.s=selector1-wdc-com header.b=X17xUjX/;
       spf=pass (google.com: domain of prvs=566751c09=stanislav.nijnikov@wdc.com designates 216.71.154.42 as permitted sender) smtp.mailfrom=prvs=566751c09=Stanislav.Nijnikov@wdc.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=fWcoSCOw;
       dkim=pass header.i=@sharedspace.onmicrosoft.com header.s=selector1-wdc-com header.b=X17xUjX/;
       spf=pass (google.com: domain of prvs=566751c09=stanislav.nijnikov@wdc.com designates 216.71.154.42 as permitted sender) smtp.mailfrom=prvs=566751c09=Stanislav.Nijnikov@wdc.com
X-IronPort-AV: E=Sophos;i="5.46,458,1511798400";
   d="scan'208";a="70449170"
From: Stanislav Nijnikov <Stanislav.Nijnikov@wdc.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jaegeuk@kernel.org" <jaegeuk@kernel.org>, Alex Lemberg
	<Alex.Lemberg@wdc.com>
Subject: RE: [PATCH v4 01/10] ufs: sysfs: attribute group for existing sysfs
 entries.
Thread-Topic: [PATCH v4 01/10] ufs: sysfs: attribute group for existing sysfs
 entries.
Thread-Index: AQHTm3fxo1n5KlULckmz1QORVYth36OPxRSAgARmIJA=
Date: Sun, 4 Feb 2018 12:29:06 +0000
Message-ID: <DM2PR0401MB097509D74E03449B0FA616249AFF0@DM2PR0401MB0975.namprd04.prod.outlook.com>
References: <1517501746-19075-1-git-send-email-stanislav.nijnikov@wdc.com>
 <1517501746-19075-2-git-send-email-stanislav.nijnikov@wdc.com>
 <20180201165923.GA12838@kroah.com>
In-Reply-To: <20180201165923.GA12838@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Stanislav.Nijnikov@wdc.com;
x-originating-ip: [212.25.79.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM2PR0401MB1038;7:1rdvheBSgr7i40XteL/cYKV9k+rZiAnVaQHAY5v5w4W4OvmUx4j+is/NhdNKqSH11QOYZFvddFOAizo6aDcnIX5H1WJOCALdxlxzXUm/jcLS/gMJd6A210qI6RltoxMWw25RW8uVPUm4+OqqYDVHI0LnMYvUbeZjcxMjHfSRP0CJ8Val15Ii9zQqW8O/s2w5WJsK5n3wTR2g0GBGfpB4LeeI9n+T3AfmwSOrZE4TgBVyDAEt1ytbUI1W31sGQL6i;20:rtvqyH7749YuNr9RGTa8Wx272sAggcUlQeNpDc/WvXI9fpU/qzitOsI6CVgKPOX8KXCYDpGYgXvghidD28ONYv1/Nkj+d257H8lSsKVf0tkOf09Kv2g0LCFX01dMS5KTVXbriZcADDG7+bsbdporG3Y6Yp7cRAQ+PNqsbMAKcSM=
x-ms-exchange-antispam-srfa-diagnostics: SSOS;SSOR;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 24f7adf5-da21-44a1-428a-08d56bcae294
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:DM2PR0401MB1038;
x-ms-traffictypediagnostic: DM2PR0401MB1038:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <DM2PR0401MB1038CF0F15BDEFF62B8D54D69AFF0@DM2PR0401MB1038.namprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(6041288)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:DM2PR0401MB1038;BCL:0;PCL:0;RULEID:;SRVR:DM2PR0401MB1038;
x-forefront-prvs: 05739BA1B5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39380400002)(396003)(39860400002)(366004)(13464003)(189003)(199004)(316002)(74316002)(305945005)(66066001)(105586002)(6116002)(5660300001)(3846002)(106356001)(25786009)(7736002)(4326008)(102836004)(6506007)(8936002)(3280700002)(3660700001)(76176011)(7696005)(68736007)(72206003)(478600001)(81166006)(81156014)(59450400001)(53546011)(97736004)(6246003)(2950100002)(2906002)(14454004)(8676002)(54906003)(6916009)(5250100002)(6436002)(2900100001)(229853002)(53936002)(99286004)(33656002)(26005)(186003)(9686003)(55016002)(86362001)(2004002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM2PR0401MB1038;H:DM2PR0401MB0975.namprd04.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:3;A:1;LANG:en;
x-microsoft-antispam-message-info: 230RlVTzA/SudLfrESshYVg9oqXkqL/zMEoiA3ULJto+z/KIEoVwJ8s8S6+Uxj+YEiZKbT0TG/Cvis4F6pRXwQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24f7adf5-da21-44a1-428a-08d56bcae294
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2018 12:29:06.8444
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR0401MB1038
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591215918423132169?=
X-GMAIL-MSGID: =?utf-8?q?1591473449577996452?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



> -----Original Message-----
> From: Greg KH [mailto:gregkh@linuxfoundation.org]
> Sent: Thursday, February 1, 2018 6:59 PM
> To: Stanislav Nijnikov <Stanislav.Nijnikov@wdc.com>
> Cc: linux-scsi@vger.kernel.org; linux-kernel@vger.kernel.org;
> jaegeuk@kernel.org; Alex Lemberg <Alex.Lemberg@wdc.com>
> Subject: Re: [PATCH v4 01/10] ufs: sysfs: attribute group for existing sy=
sfs
> entries.
>=20
> On Thu, Feb 01, 2018 at 06:15:37PM +0200, Stanislav Nijnikov wrote:
> > This patch introduces attribute group to show existing sysfs entries.
> >
> > Signed-off-by: Stanislav Nijnikov <stanislav.nijnikov@wdc.com>
> > ---
> >  drivers/scsi/ufs/Makefile    |   3 +-
> >  drivers/scsi/ufs/ufs-sysfs.c | 164
> > +++++++++++++++++++++++++++++++++++++++++++
> >  drivers/scsi/ufs/ufs-sysfs.h |  22 ++++++
> >  drivers/scsi/ufs/ufshcd.c    | 156 ++---------------------------------=
-----
> >  drivers/scsi/ufs/ufshcd.h    |   2 +
> >  5 files changed, 194 insertions(+), 153 deletions(-)  create mode
> > 100644 drivers/scsi/ufs/ufs-sysfs.c  create mode 100644
> > drivers/scsi/ufs/ufs-sysfs.h
> >
> > diff --git a/drivers/scsi/ufs/Makefile b/drivers/scsi/ufs/Makefile
> > index 9310c6c..918f579 100644
> > --- a/drivers/scsi/ufs/Makefile
> > +++ b/drivers/scsi/ufs/Makefile
> > @@ -3,6 +3,7 @@
> >  obj-$(CONFIG_SCSI_UFS_DWC_TC_PCI) +=3D tc-dwc-g210-pci.o ufshcd-
> dwc.o
> > tc-dwc-g210.o
> >  obj-$(CONFIG_SCSI_UFS_DWC_TC_PLATFORM) +=3D tc-dwc-g210-pltfrm.o
> > ufshcd-dwc.o tc-dwc-g210.o
> >  obj-$(CONFIG_SCSI_UFS_QCOM) +=3D ufs-qcom.o
> > -obj-$(CONFIG_SCSI_UFSHCD) +=3D ufshcd.o
> > +obj-$(CONFIG_SCSI_UFSHCD) +=3D ufshcd-core.o ufshcd-core-objs :=3D
> > +ufshcd.o ufs-sysfs.o
> >  obj-$(CONFIG_SCSI_UFSHCD_PCI) +=3D ufshcd-pci.o
> >  obj-$(CONFIG_SCSI_UFSHCD_PLATFORM) +=3D ufshcd-pltfrm.o diff --git
> > a/drivers/scsi/ufs/ufs-sysfs.c b/drivers/scsi/ufs/ufs-sysfs.c new file
> > mode 100644 index 0000000..cc68a90
> > --- /dev/null
> > +++ b/drivers/scsi/ufs/ufs-sysfs.c
> > @@ -0,0 +1,164 @@
> > +//SPDX-License-Identifier: GPL-2.0-only //Copyright (C) 2018 Western
> > +Digital Corporation //This program is free software; you can
> > +redistribute it and/or modify it //under the terms of the GNU General
> > +Public License as published by the //Free Software Foundation;
> > +version 2.
> > +//
> > +//This program is distributed in the hope that it will be useful, but
> > +//WITHOUT ANY WARRANTY; without even the implied warranty of
> > +//MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> GNU
> > +//General Public License for more details.
>=20
> No need to put the whole "This program" crud in the file here if you have=
 the
> SPDX line already.  We are going through the kernel tree and removing all=
 of
> the 700+ different ways we have this boilerplate code in the tree, please=
 do
> not add new ones.
>=20
> Also, please put a ' ' after "//", it just looks ugly like this, don't yo=
u think so?
>=20
> Please fix this for all of the files you add in this patch series.
>=20
> > +#include <linux/err.h>
> > +#include <linux/string.h>
> > +
> > +#include "ufs-sysfs.h"
> > +
> > +static const char *ufschd_uic_link_state_to_string(
> > +			enum uic_link_state state)
> > +{
> > +	switch (state) {
> > +	case UIC_LINK_OFF_STATE:	return "OFF";
> > +	case UIC_LINK_ACTIVE_STATE:	return "ACTIVE";
> > +	case UIC_LINK_HIBERN8_STATE:	return "HIBERN8";
> > +	default:			return "UNKNOWN";
> > +	}
> > +}
> > +
> > +static const char *ufschd_ufs_dev_pwr_mode_to_string(
> > +			enum ufs_dev_pwr_mode state)
> > +{
> > +	switch (state) {
> > +	case UFS_ACTIVE_PWR_MODE:	return "ACTIVE";
> > +	case UFS_SLEEP_PWR_MODE:	return "SLEEP";
> > +	case UFS_POWERDOWN_PWR_MODE:	return "POWERDOWN";
> > +	default:			return "UNKNOWN";
> > +	}
> > +}
> > +
> > +static inline ssize_t ufs_sysfs_pm_lvl_store(struct device *dev,
> > +					     struct device_attribute *attr,
> > +					     const char *buf, size_t count,
> > +					     bool rpm)
> > +{
> > +	struct ufs_hba *hba =3D dev_get_drvdata(dev);
> > +	unsigned long flags, value;
> > +
> > +	if (kstrtoul(buf, 0, &value))
> > +		return -EINVAL;
> > +
> > +	if (value >=3D UFS_PM_LVL_MAX)
> > +		return -EINVAL;
> > +
> > +	spin_lock_irqsave(hba->host->host_lock, flags);
> > +	if (rpm)
> > +		hba->rpm_lvl =3D value;
> > +	else
> > +		hba->spm_lvl =3D value;
> > +	spin_unlock_irqrestore(hba->host->host_lock, flags);
> > +	return count;
> > +}
> > +
> > +static ssize_t rpm_lvl_show(struct device *dev,
> > +		struct device_attribute *attr, char *buf) {
> > +	struct ufs_hba *hba =3D dev_get_drvdata(dev);
> > +	int curr_len;
> > +	u8 lvl;
> > +
> > +	curr_len =3D snprintf(buf, PAGE_SIZE,
> > +			    "\nCurrent Runtime PM level [%d] =3D> dev_state
> [%s] link_state [%s]\n",
> > +			    hba->rpm_lvl,
> > +			    ufschd_ufs_dev_pwr_mode_to_string(
> > +				ufs_pm_lvl_states[hba-
> >rpm_lvl].dev_state),
> > +			    ufschd_uic_link_state_to_string(
> > +				ufs_pm_lvl_states[hba-
> >rpm_lvl].link_state));
> > +
> > +	curr_len +=3D snprintf((buf + curr_len), (PAGE_SIZE - curr_len),
> > +			     "\nAll available Runtime PM levels info:\n");
> > +	for (lvl =3D UFS_PM_LVL_0; lvl < UFS_PM_LVL_MAX; lvl++)
> > +		curr_len +=3D snprintf((buf + curr_len), (PAGE_SIZE - curr_len),
> > +				     "\tRuntime PM level [%d] =3D> dev_state
> [%s] link_state [%s]\n",
> > +				    lvl,
> > +				    ufschd_ufs_dev_pwr_mode_to_string(
> > +					ufs_pm_lvl_states[lvl].dev_state),
> > +				    ufschd_uic_link_state_to_string(
> > +					ufs_pm_lvl_states[lvl].link_state));
> > +
>=20
> sysfs if "one value per file", not "random text that someone has to parse=
 per
> file" please.
>=20
> Huge hint, if you ever care about checking the size of the sysfs buffer y=
ou are
> writing into, you are doing something really really wrong.
>=20
Hi Greg
It's the existing code, added by:
commit 09690d5a6ae1b7e4cb5ac429c311b99d09352c12
Author: subhashj@codeaurora.org <subhashj@codeaurora.org>
Date:   Thu Dec 22 18:41:00 2016 -0800

    scsi: ufs: provide sysfs attribute to select the PM level
   =20
    This patch provides the sysfs attribute to choose the power management
    level for UFS runtime and system suspend.
   =20
    Reviewed-by: Sujit Reddy Thumma <sthumma@codeaurora.org>
    Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
    Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

I just moved it to an another file and changed the sysfs entries creation b=
y
Jaegeuk Kim' request. At the moment the entry shows the PM level, the devic=
e
state, the link state and all possible PM levels. Do you want me to change =
it?

>=20
> > +	return curr_len;
> > +}
> > +
> > +static ssize_t rpm_lvl_store(struct device *dev,
> > +		struct device_attribute *attr, const char *buf, size_t count) {
> > +	return ufs_sysfs_pm_lvl_store(dev, attr, buf, count, true); }
> > +
> > +static ssize_t spm_lvl_show(struct device *dev,
> > +		struct device_attribute *attr, char *buf) {
> > +	struct ufs_hba *hba =3D dev_get_drvdata(dev);
> > +	int curr_len;
> > +	u8 lvl;
> > +
> > +	curr_len =3D snprintf(buf, PAGE_SIZE,
> > +			    "\nCurrent System PM level [%d] =3D> dev_state
> [%s] link_state [%s]\n",
> > +			    hba->spm_lvl,
> > +			    ufschd_ufs_dev_pwr_mode_to_string(
> > +				ufs_pm_lvl_states[hba-
> >spm_lvl].dev_state),
> > +			    ufschd_uic_link_state_to_string(
> > +				ufs_pm_lvl_states[hba-
> >spm_lvl].link_state));
> > +
> > +	curr_len +=3D snprintf((buf + curr_len), (PAGE_SIZE - curr_len),
> > +			     "\nAll available System PM levels info:\n");
> > +	for (lvl =3D UFS_PM_LVL_0; lvl < UFS_PM_LVL_MAX; lvl++)
> > +		curr_len +=3D snprintf((buf + curr_len), (PAGE_SIZE - curr_len),
> > +				     "\tSystem PM level [%d] =3D> dev_state
> [%s] link_state [%s]\n",
> > +				    lvl,
> > +				    ufschd_ufs_dev_pwr_mode_to_string(
> > +					ufs_pm_lvl_states[lvl].dev_state),
> > +				    ufschd_uic_link_state_to_string(
> > +					ufs_pm_lvl_states[lvl].link_state));
> > +
>=20
> Same here, this output is not ok.
>=20
Same here.

> > +	return curr_len;
> > +}
> > +
> > +static ssize_t spm_lvl_store(struct device *dev,
> > +		struct device_attribute *attr, const char *buf, size_t count) {
> > +	return ufs_sysfs_pm_lvl_store(dev, attr, buf, count, false); }
> > +
> > +static DEVICE_ATTR_RW(rpm_lvl);
> > +static DEVICE_ATTR_RW(spm_lvl);
> > +
> > +static struct attribute *ufs_sysfs_ufshcd_attrs[] =3D {
> > +	&dev_attr_rpm_lvl.attr,
> > +	&dev_attr_spm_lvl.attr,
> > +	NULL
> > +};
> > +
> > +static const struct attribute_group ufs_sysfs_default_group =3D {
> > +	.attrs =3D ufs_sysfs_ufshcd_attrs,
> > +};
> > +
> > +static const struct attribute_group *ufs_sysfs_groups[] =3D {
> > +	&ufs_sysfs_default_group,
> > +	NULL,
> > +};
>=20
> ATTRIBUTE_GROUPS() macro?
>=20
> > +void ufs_sysfs_add_nodes(struct device *dev) {
> > +	int ret;
> > +
> > +	ret =3D sysfs_create_groups(&dev->kobj, ufs_sysfs_groups);
> > +	if (ret)
> > +		dev_err(dev,
> > +			"%s: sysfs groups creation failed (err =3D %d)\n",
> > +			__func__, ret);
>=20
> Why not return 'ret' so you can do something with it?

The existing in the driver functions that create the sysfs entries do nothi=
ng on
failure, just error message. So I just keep the same logic.

>=20
> thanks,
>=20
> greg k-h

Thank you.
Stanislav
