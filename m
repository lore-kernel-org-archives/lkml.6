Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753308AbeBPGfR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 01:35:17 -0500
Received: from mail-bn3nam01on0069.outbound.protection.outlook.com ([104.47.33.69]:9584
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753285AbeBPGfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 01:35:14 -0500
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 2/8] lightnvm: show generic geometry in sysfs
Thread-Topic: [PATCH 2/8] lightnvm: show generic geometry in sysfs
Thread-Index: AQHTpNPU3FKDI09zP0eaYA7c4W0rPKOlQ2wAgAFTiwA=
Date: Fri, 16 Feb 2018 06:35:12 +0000
Message-ID: <E53B65E9-3D1A-49BB-AA5D-F3D2C4032484@cnexlabs.com>
References: <1518530768-20956-1-git-send-email-javier@cnexlabs.com>
 <1518530768-20956-3-git-send-email-javier@cnexlabs.com>
 <caa2634b-63bf-3a35-ed53-220aab2bd05a@lightnvm.io>
In-Reply-To: <caa2634b-63bf-3a35-ed53-220aab2bd05a@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com;
x-originating-ip: [24.5.37.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR06MB3042;7:TedAc6L/4APPVgTxuI+ugCAglBCY7KDiCQ7E3WKgP5hzCZXQCwEE9hpO2zCg6b+Rno6IKXZEKWhVWv7T1U86Yz7ZP9snAqtOjzGETsHeVIcndudMU1Ddvnw3WUocBF2C+ZC8Il40obmF4XZfxGLqa5/WGL4Tpigohd++DGpYMkkr4Ni6zEB/yXhqYCMHgg2UoLwiayAFUxa4vHqG6a7L52arIFlllyJjPPhjLCZaTqGaKltvbJwY9YAmHlaBLQz7
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 44247b2d-08b6-46e7-2276-08d575076e8a
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7153060)(49563074)(7193020);SRVR:BN6PR06MB3042;
x-ms-traffictypediagnostic: BN6PR06MB3042:
x-microsoft-antispam-prvs: <BN6PR06MB3042484CCDD0378220F3C4A8BACB0@BN6PR06MB3042.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(102415395)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231101)(2400082)(944501161)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:BN6PR06MB3042;BCL:0;PCL:0;RULEID:;SRVR:BN6PR06MB3042;
x-forefront-prvs: 0585417D7B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(39830400003)(396003)(39380400002)(346002)(189003)(199004)(25786009)(4326008)(3846002)(6116002)(6246003)(82746002)(6916009)(2950100002)(6512007)(6436002)(229853002)(186003)(66066001)(97736004)(14454004)(99286004)(478600001)(99936001)(83716003)(86362001)(6486002)(8936002)(33656002)(36756003)(105586002)(81156014)(316002)(2900100001)(7736002)(305945005)(68736007)(2906002)(8676002)(81166006)(54906003)(76176011)(77096007)(26005)(5660300001)(53936002)(102836004)(6506007)(53546011)(3660700001)(3280700002)(106356001)(41533002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR06MB3042;H:BN6PR06MB2626.namprd06.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: Q2fP4HALzc+hbGhQwbs4LCrPtFSGAtmJ70CzYbJ+lfiqYVvMY73TzprWOiWTadfjod0yoEGEDopDnfe11DOuNw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_28767525-53A2-41D6-B123-869EC5AB4AF1";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44247b2d-08b6-46e7-2276-08d575076e8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2018 06:35:12.1779
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR06MB3042
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_28767525-53A2-41D6-B123-869EC5AB4AF1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On 15 Feb 2018, at 02.20, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 02/13/2018 03:06 PM, Javier Gonz=C3=A1lez wrote:
>> From: Javier Gonz=C3=A1lez <javier@javigon.com>
>> Apart from showing the geometry returned by the different identify
>> commands, provide the generic geometry too, as this is the geometry =
that
>> targets will use to describe the device.
>> Signed-off-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
>> ---
>>  drivers/nvme/host/lightnvm.c | 146 =
++++++++++++++++++++++++++++---------------
>>  1 file changed, 97 insertions(+), 49 deletions(-)
>> diff --git a/drivers/nvme/host/lightnvm.c =
b/drivers/nvme/host/lightnvm.c
>> index 97739e668602..7bc75182c723 100644
>> --- a/drivers/nvme/host/lightnvm.c
>> +++ b/drivers/nvme/host/lightnvm.c
>> @@ -944,8 +944,27 @@ static ssize_t nvm_dev_attr_show(struct device =
*dev,
>>  		return scnprintf(page, PAGE_SIZE, "%u.%u\n",
>>  						dev_geo->major_ver_id,
>>  						dev_geo->minor_ver_id);
>> -	} else if (strcmp(attr->name, "capabilities") =3D=3D 0) {
>> -		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.cap);
>> +	} else if (strcmp(attr->name, "clba") =3D=3D 0) {
>> +		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.clba);
>> +	} else if (strcmp(attr->name, "csecs") =3D=3D 0) {
>> +		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.csecs);
>> +	} else if (strcmp(attr->name, "sos") =3D=3D 0) {
>> +		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.sos);
>> +	} else if (strcmp(attr->name, "ws_min") =3D=3D 0) {
>> +		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.ws_min);
>> +	} else if (strcmp(attr->name, "ws_opt") =3D=3D 0) {
>> +		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.ws_opt);
>> +	} else if (strcmp(attr->name, "maxoc") =3D=3D 0) {
>> +		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.maxoc);
>> +	} else if (strcmp(attr->name, "maxocpu") =3D=3D 0) {
>> +		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.maxocpu);
>> +	} else if (strcmp(attr->name, "mw_cunits") =3D=3D 0) {
>> +		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.mw_cunits);
>> +	} else if (strcmp(attr->name, "media_capabilities") =3D=3D 0) {
>> +		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.mccap);
>> +	} else if (strcmp(attr->name, "max_phys_secs") =3D=3D 0) {
>> +		return scnprintf(page, PAGE_SIZE, "%u\n",
>> +				ndev->ops->max_phys_sect);
>>  	} else if (strcmp(attr->name, "read_typ") =3D=3D 0) {
>>  		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.trdt);
>>  	} else if (strcmp(attr->name, "read_max") =3D=3D 0) {
>> @@ -984,19 +1003,8 @@ static ssize_t nvm_dev_attr_show_12(struct =
device *dev,
>>    	attr =3D &dattr->attr;
>>  -	if (strcmp(attr->name, "vendor_opcode") =3D=3D 0) {
>> -		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.vmnt);
>> -	} else if (strcmp(attr->name, "device_mode") =3D=3D 0) {
>> -		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.dom);
>> -	/* kept for compatibility */
>> -	} else if (strcmp(attr->name, "media_manager") =3D=3D 0) {
>> -		return scnprintf(page, PAGE_SIZE, "%s\n", "gennvm");
>> -	} else if (strcmp(attr->name, "ppa_format") =3D=3D 0) {
>> +	if (strcmp(attr->name, "ppa_format") =3D=3D 0) {
>>  		return nvm_dev_attr_show_ppaf((void *)&dev_geo->c.addrf, =
page);
>> -	} else if (strcmp(attr->name, "media_type") =3D=3D 0) {	/* u8 */
>> -		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.mtype);
>> -	} else if (strcmp(attr->name, "flash_media_type") =3D=3D 0) {
>> -		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.fmtype);
>>  	} else if (strcmp(attr->name, "num_channels") =3D=3D 0) {
>>  		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->num_ch);
>>  	} else if (strcmp(attr->name, "num_luns") =3D=3D 0) {
>> @@ -1011,8 +1019,6 @@ static ssize_t nvm_dev_attr_show_12(struct =
device *dev,
>>  		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.fpg_sz);
>>  	} else if (strcmp(attr->name, "hw_sector_size") =3D=3D 0) {
>>  		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.csecs);
>> -	} else if (strcmp(attr->name, "oob_sector_size") =3D=3D 0) {/* =
u32 */
>> -		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.sos);
>>  	} else if (strcmp(attr->name, "prog_typ") =3D=3D 0) {
>>  		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.tprt);
>>  	} else if (strcmp(attr->name, "prog_max") =3D=3D 0) {
>> @@ -1021,13 +1027,21 @@ static ssize_t nvm_dev_attr_show_12(struct =
device *dev,
>>  		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.tbet);
>>  	} else if (strcmp(attr->name, "erase_max") =3D=3D 0) {
>>  		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.tbem);
>> +	} else if (strcmp(attr->name, "vendor_opcode") =3D=3D 0) {
>> +		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.vmnt);
>> +	} else if (strcmp(attr->name, "device_mode") =3D=3D 0) {
>> +		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.dom);
>> +	/* kept for compatibility */
>> +	} else if (strcmp(attr->name, "media_manager") =3D=3D 0) {
>> +		return scnprintf(page, PAGE_SIZE, "%s\n", "gennvm");
>> +	} else if (strcmp(attr->name, "capabilities") =3D=3D 0) {
>> +		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.cap);
>> +	} else if (strcmp(attr->name, "media_type") =3D=3D 0) {	/* u8 */
>> +		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.mtype);
>> +	} else if (strcmp(attr->name, "flash_media_type") =3D=3D 0) {
>> +		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.fmtype);
>>  	} else if (strcmp(attr->name, "multiplane_modes") =3D=3D 0) {
>>  		return scnprintf(page, PAGE_SIZE, "0x%08x\n", =
dev_geo->c.mpos);
>> -	} else if (strcmp(attr->name, "media_capabilities") =3D=3D 0) {
>> -		return scnprintf(page, PAGE_SIZE, "0x%08x\n", =
dev_geo->c.mccap);
>> -	} else if (strcmp(attr->name, "max_phys_secs") =3D=3D 0) {
>> -		return scnprintf(page, PAGE_SIZE, "%u\n",
>> -				ndev->ops->max_phys_sect);
>>  	} else {
>>  		return scnprintf(page, PAGE_SIZE,
>>  			"Unhandled attr(%s) in =
`nvm_dev_attr_show_12`\n",
>> @@ -1035,6 +1049,17 @@ static ssize_t nvm_dev_attr_show_12(struct =
device *dev,
>>  	}
>>  }
>>  +static ssize_t nvm_dev_attr_show_lbaf(struct nvm_addr_format *lbaf,
>> +					 char *page)
>> +{
>> +	return scnprintf(page, PAGE_SIZE,
>> +		"0x%02x%02x%02x%02x%02x%02x%02x%02x\n",
>> +				lbaf->ch_offset, lbaf->ch_len,
>> +				lbaf->lun_offset, lbaf->lun_len,
>> +				lbaf->chk_offset, lbaf->chk_len,
>> +				lbaf->sec_offset, lbaf->sec_len);
>> +}
>> +
>>  static ssize_t nvm_dev_attr_show_20(struct device *dev,
>>  		struct device_attribute *dattr, char *page)
>>  {
>> @@ -1048,20 +1073,14 @@ static ssize_t nvm_dev_attr_show_20(struct =
device *dev,
>>    	attr =3D &dattr->attr;
>>  -	if (strcmp(attr->name, "groups") =3D=3D 0) {
>> +	if (strcmp(attr->name, "lba_format") =3D=3D 0) {
>> +		return nvm_dev_attr_show_lbaf((void *)&dev_geo->c.addrf, =
page);
>> +	} else if (strcmp(attr->name, "groups") =3D=3D 0) {
>>  		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->num_ch);
>>  	} else if (strcmp(attr->name, "punits") =3D=3D 0) {
>>  		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->num_lun);
>>  	} else if (strcmp(attr->name, "chunks") =3D=3D 0) {
>>  		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.num_chk);
>> -	} else if (strcmp(attr->name, "clba") =3D=3D 0) {
>> -		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.clba);
>> -	} else if (strcmp(attr->name, "ws_min") =3D=3D 0) {
>> -		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.ws_min);
>> -	} else if (strcmp(attr->name, "ws_opt") =3D=3D 0) {
>> -		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.ws_opt);
>> -	} else if (strcmp(attr->name, "mw_cunits") =3D=3D 0) {
>> -		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.mw_cunits);
>>  	} else if (strcmp(attr->name, "write_typ") =3D=3D 0) {
>>  		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.tprt);
>>  	} else if (strcmp(attr->name, "write_max") =3D=3D 0) {
>> @@ -1086,7 +1105,19 @@ static ssize_t nvm_dev_attr_show_20(struct =
device *dev,
>>    /* general attributes */
>>  static NVM_DEV_ATTR_RO(version);
>> -static NVM_DEV_ATTR_RO(capabilities);
>> +
>> +static NVM_DEV_ATTR_RO(ws_min);
>> +static NVM_DEV_ATTR_RO(ws_opt);
>> +static NVM_DEV_ATTR_RO(mw_cunits);
>> +static NVM_DEV_ATTR_RO(maxoc);
>> +static NVM_DEV_ATTR_RO(maxocpu);
>> +
>> +static NVM_DEV_ATTR_RO(media_capabilities);
>> +static NVM_DEV_ATTR_RO(max_phys_secs);
>> +
>> +static NVM_DEV_ATTR_RO(clba);
>> +static NVM_DEV_ATTR_RO(csecs);
>> +static NVM_DEV_ATTR_RO(sos);
>>    static NVM_DEV_ATTR_RO(read_typ);
>>  static NVM_DEV_ATTR_RO(read_max);
>> @@ -1105,42 +1136,53 @@ static NVM_DEV_ATTR_12_RO(num_blocks);
>>  static NVM_DEV_ATTR_12_RO(num_pages);
>>  static NVM_DEV_ATTR_12_RO(page_size);
>>  static NVM_DEV_ATTR_12_RO(hw_sector_size);
>> -static NVM_DEV_ATTR_12_RO(oob_sector_size);
>>  static NVM_DEV_ATTR_12_RO(prog_typ);
>>  static NVM_DEV_ATTR_12_RO(prog_max);
>>  static NVM_DEV_ATTR_12_RO(erase_typ);
>>  static NVM_DEV_ATTR_12_RO(erase_max);
>>  static NVM_DEV_ATTR_12_RO(multiplane_modes);
>> -static NVM_DEV_ATTR_12_RO(media_capabilities);
>> -static NVM_DEV_ATTR_12_RO(max_phys_secs);
>> +static NVM_DEV_ATTR_12_RO(capabilities);
>>    static struct attribute *nvm_dev_attrs_12[] =3D {
>>  	&dev_attr_version.attr,
>> -	&dev_attr_capabilities.attr,
>> -
>> -	&dev_attr_vendor_opcode.attr,
>> -	&dev_attr_device_mode.attr,
>> -	&dev_attr_media_manager.attr,
>>  	&dev_attr_ppa_format.attr,
>> -	&dev_attr_media_type.attr,
>> -	&dev_attr_flash_media_type.attr,
>> +
>>  	&dev_attr_num_channels.attr,
>>  	&dev_attr_num_luns.attr,
>>  	&dev_attr_num_planes.attr,
>>  	&dev_attr_num_blocks.attr,
>>  	&dev_attr_num_pages.attr,
>>  	&dev_attr_page_size.attr,
>> +
>>  	&dev_attr_hw_sector_size.attr,
>> -	&dev_attr_oob_sector_size.attr,
>> +
>> +	&dev_attr_clba.attr,
>> +	&dev_attr_csecs.attr,
>> +	&dev_attr_sos.attr,
>> +
>> +	&dev_attr_ws_min.attr,
>> +	&dev_attr_ws_opt.attr,
>> +	&dev_attr_maxoc.attr,
>> +	&dev_attr_maxocpu.attr,
>> +	&dev_attr_mw_cunits.attr,
>> +
>> +	&dev_attr_media_capabilities.attr,
>> +	&dev_attr_max_phys_secs.attr,
>> +
>=20
> This breaks user-space. The intention is for user-space to decide
> based on version id. Then it can either retrieve the 1.2 or 2.0
> attributes. The 2.0 attributes should not be available when a device
> is 1.2.
>=20

Why does it break it? I'm only adding new entries.

The objective is to expose the genneric geometry, since this is the
structure that is passed on to the targets. Since some of the values are
calculated, there is value on exposing this information, I believe.

Another way of doing it, is adding the generic geometry at the target
level, showing what base values it is getting, including the real number
of channels/groups and luns/pus.

Would this be better in your opinion?


>>  	&dev_attr_read_typ.attr,
>>  	&dev_attr_read_max.attr,
>>  	&dev_attr_prog_typ.attr,
>>  	&dev_attr_prog_max.attr,
>>  	&dev_attr_erase_typ.attr,
>>  	&dev_attr_erase_max.attr,
>> +
>> +	&dev_attr_vendor_opcode.attr,
>> +	&dev_attr_device_mode.attr,
>> +	&dev_attr_media_manager.attr,
>> +	&dev_attr_capabilities.attr,
>> +	&dev_attr_media_type.attr,
>> +	&dev_attr_flash_media_type.attr,
>>  	&dev_attr_multiplane_modes.attr,
>> -	&dev_attr_media_capabilities.attr,
>> -	&dev_attr_max_phys_secs.attr,
>>    	NULL,
>>  };
>> @@ -1152,12 +1194,9 @@ static const struct attribute_group =
nvm_dev_attr_group_12 =3D {
>>    /* 2.0 values */
>>  static NVM_DEV_ATTR_20_RO(groups);
>> +static NVM_DEV_ATTR_20_RO(lba_format);
>>  static NVM_DEV_ATTR_20_RO(punits);
>>  static NVM_DEV_ATTR_20_RO(chunks);
>> -static NVM_DEV_ATTR_20_RO(clba);
>> -static NVM_DEV_ATTR_20_RO(ws_min);
>> -static NVM_DEV_ATTR_20_RO(ws_opt);
>> -static NVM_DEV_ATTR_20_RO(mw_cunits);
>>  static NVM_DEV_ATTR_20_RO(write_typ);
>>  static NVM_DEV_ATTR_20_RO(write_max);
>>  static NVM_DEV_ATTR_20_RO(reset_typ);
>> @@ -1165,16 +1204,25 @@ static NVM_DEV_ATTR_20_RO(reset_max);
>>    static struct attribute *nvm_dev_attrs_20[] =3D {
>>  	&dev_attr_version.attr,
>> -	&dev_attr_capabilities.attr,
>> +	&dev_attr_lba_format.attr,
>>    	&dev_attr_groups.attr,
>>  	&dev_attr_punits.attr,
>>  	&dev_attr_chunks.attr,
>> +
>>  	&dev_attr_clba.attr,
>> +	&dev_attr_csecs.attr,
>> +	&dev_attr_sos.attr,
>=20
> csecs and sos are derived from the the generic block device data =
structures.

As mentioned above, it is to represent the generic geometry.

>=20
>> +
>>  	&dev_attr_ws_min.attr,
>>  	&dev_attr_ws_opt.attr,
>> +	&dev_attr_maxoc.attr,
>> +	&dev_attr_maxocpu.attr,
>=20
> When the maxoc/maxocpu are in another patch, these changes can be =
included.

ok.

>=20
>>  	&dev_attr_mw_cunits.attr,
>>  +	&dev_attr_media_capabilities.attr,
>=20
> What is the meaning of media in this context? The 2.0 spec defines
> vector copy and double resets in its capabilities, it does not have
> media in mind.
>=20

It refers to the mcap (vector copy and double resets for now, as you
mention). I kept the name, name, but I can rename it if it is better...

>> +	&dev_attr_max_phys_secs.attr,
>> +
>=20
> I kill max_phys_secs in another patch. It has been made redundant
> after null_blk has been removed.

I'll answer this on the patch - I have a questions here.

>>  	&dev_attr_read_typ.attr,
>>  	&dev_attr_read_max.attr,
>>  	&dev_attr_write_typ.attr,

Javier


--Apple-Mail=_28767525-53A2-41D6-B123-869EC5AB4AF1
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlqGe6YACgkQIX4xUKFR
nnTMOxAAqjkhlEQMPQk+2c2wTUMthNpxK1blyCyHDkQX/u1SDE1JAC+4frTYCZnF
HI4WGcuofgEmJsGNscQgU8sJSpZzjYVTNyPxNzHbOK5FSzJqtppw79qhJ38HSyiD
Part1AoHuiRR47hX78Vn5Kq6kwegaD/uwKUqxKKoaII1huLIqaWva8XV7PPwl0p4
XOF6N3BUVxAtnK7vyNH9ikpwSiHGyLmEsmpE17ShVff8bwpUI6psL9OZPB+RSgs9
dxSlBLWkJmWW8FXJvm0tGsm+rXzgdaa18eZA+trhIV9faXmfo+nHNg+wNvkfE3Rr
lKePApPBz223wjaOdUb7cL3Nx7HlkNEPN30LZ0BaK758ZEosNMAIIIWprIicKSoA
qfWdNzXxM/o6j03xwXNlrz2vRy5foKiMcH+kJTJC52Rr3dC/FJyTOvRkUV17RwzJ
2GFHMlNzBpgDQjE81TmlvVMdckzlmPEj2iWpt5jKDdAbKHcq81PwyMkMw0SCJCl9
VPdjWymf3ENVKPSmVvBjQALgrIuinUmmqmpkpVxlfVyR1FCJS4hL97OFRN9DReBY
0HYyw9qXskFjx6dHDBNzxguvGlXmoCqLUS4JUEDb5aZ02SgqCNzIMYgrUlcufMQ3
cGYYdHcU+CsBrvmQbas3b6xYh2bINCaXalXIHbDdoWiVey6bIjA=
=HeOZ
-----END PGP SIGNATURE-----

--Apple-Mail=_28767525-53A2-41D6-B123-869EC5AB4AF1--
