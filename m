Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752949AbeBVHrl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 02:47:41 -0500
Received: from mail-co1nam03on0079.outbound.protection.outlook.com ([104.47.40.79]:23802
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752627AbeBVHrh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 02:47:37 -0500
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 03/20] lightnvm: fix capabilities for 2.0 sysfs
Thread-Topic: [PATCH 03/20] lightnvm: fix capabilities for 2.0 sysfs
Thread-Index: AQHTqvYqUX4YQRQApUG/o9ZTj4y0DKOwB5CAgAAFSwA=
Date: Thu, 22 Feb 2018 07:47:33 +0000
Message-ID: <19BA9139-DB6D-4A9B-A0B4-72F38BE648E9@cnexlabs.com>
References: <1519205218-26994-1-git-send-email-javier@cnexlabs.com>
 <1519205218-26994-4-git-send-email-javier@cnexlabs.com>
 <23b494fb-264d-a8ef-6172-5330d5a63bea@lightnvm.io>
In-Reply-To: <23b494fb-264d-a8ef-6172-5330d5a63bea@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com;
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR06MB3009;7:wEYD8pRLno8L2LMkOK6eZoVbZfQ7vh9Qw7x3vIBL08GB/fbyl9MBQ02muLnUeG2YMc/5R2I7aYsLPcC4Xy1iVBbpWkD48SZG0PFcExdHPeawma103HITAxJBx/qIauDhf8aiDAzZBu3VUstX4EoHmVPhYg8kgHCzEwzrrDBfV47LyD7X2KRRclzJoFtBB6jVLvzUxaPetbgFmykzlFZpaKPiOpVqoACEfAPjSyehfIMc6x9vBGSvZuQcBF0qTNdp
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: eabb8072-bf26-43b6-3d17-08d579c88865
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7153060)(49563074)(7193020);SRVR:BN6PR06MB3009;
x-ms-traffictypediagnostic: BN6PR06MB3009:
x-microsoft-antispam-prvs: <BN6PR06MB30091DC341B48A6990E61805BACD0@BN6PR06MB3009.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001077)(102415395)(6040501)(2401047)(8121501046)(5005006)(3231101)(944501161)(3002001)(10201501046)(93006095)(93001095)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:BN6PR06MB3009;BCL:0;PCL:0;RULEID:;SRVR:BN6PR06MB3009;
x-forefront-prvs: 059185FE08
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39830400003)(346002)(39380400002)(396003)(366004)(376002)(199004)(189003)(8676002)(81166006)(81156014)(68736007)(2906002)(36756003)(53936002)(6512007)(83716003)(6436002)(6486002)(14454004)(305945005)(229853002)(478600001)(7736002)(8936002)(6116002)(3846002)(97736004)(3660700001)(102836004)(54906003)(106356001)(5660300001)(26005)(77096007)(186003)(53546011)(6506007)(2900100001)(82746002)(6246003)(3280700002)(33656002)(316002)(99286004)(99936001)(105586002)(6916009)(2950100002)(76176011)(86362001)(4326008)(25786009)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR06MB3009;H:BN6PR06MB2626.namprd06.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: 2UH1P39GWQSyr1m1e4flBoAyqYMcEonHiOwI5QZfXLiY3lmtsjLDD3EUqIu2ryiom/nkcoTn0t5gukZjuLTL7L6l52b+tk5kktsNPIg7P/J8n586ulTL2m6HiTQ3XC8tSJVDUEVz9QYLmJgtbOS1W8/p38YipiIn2Q97c3TyEFA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_397BD780-928F-4AAB-918C-0EDB508B4A7B";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eabb8072-bf26-43b6-3d17-08d579c88865
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2018 07:47:33.0143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR06MB3009
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_397BD780-928F-4AAB-918C-0EDB508B4A7B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 22 Feb 2018, at 08.28, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 02/21/2018 10:26 AM, Javier Gonz=C3=A1lez wrote:
>> Both 1.2 and 2.0 specs define a field for media and controller
>> capabilities. Also, 1.2 defines a separate field dedicated to device
>> capabilities.
>> In 2.0 sysfs, this values have been mixed. Revert them to the right
>> value.
>> Signed-off-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
>> ---
>>  drivers/nvme/host/lightnvm.c | 18 +++++++++---------
>>  1 file changed, 9 insertions(+), 9 deletions(-)
>> diff --git a/drivers/nvme/host/lightnvm.c =
b/drivers/nvme/host/lightnvm.c
>> index 969bb874850c..598abba66f52 100644
>> --- a/drivers/nvme/host/lightnvm.c
>> +++ b/drivers/nvme/host/lightnvm.c
>> @@ -914,8 +914,8 @@ static ssize_t nvm_dev_attr_show(struct device =
*dev,
>>    	if (strcmp(attr->name, "version") =3D=3D 0) {
>>  		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->ver_id);
>> -	} else if (strcmp(attr->name, "capabilities") =3D=3D 0) {
>> -		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.cap);
>> +	} else if (strcmp(attr->name, "media_capabilities") =3D=3D 0) {
>> +		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.mccap);
>>  	} else if (strcmp(attr->name, "read_typ") =3D=3D 0) {
>>  		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.trdt);
>>  	} else if (strcmp(attr->name, "read_max") =3D=3D 0) {
>> @@ -993,8 +993,8 @@ static ssize_t nvm_dev_attr_show_12(struct device =
*dev,
>>  		return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.tbem);
>>  	} else if (strcmp(attr->name, "multiplane_modes") =3D=3D 0) {
>>  		return scnprintf(page, PAGE_SIZE, "0x%08x\n", =
dev_geo->c.mpos);
>> -	} else if (strcmp(attr->name, "media_capabilities") =3D=3D 0) {
>> -		return scnprintf(page, PAGE_SIZE, "0x%08x\n", =
dev_geo->c.mccap);
>> +	} else if (strcmp(attr->name, "capabilities") =3D=3D 0) {
>> +		return scnprintf(page, PAGE_SIZE, "0x%08x\n", =
dev_geo->c.cap);
>>  	} else if (strcmp(attr->name, "max_phys_secs") =3D=3D 0) {
>>  		return scnprintf(page, PAGE_SIZE, "%u\n", NVM_MAX_VLBA);
>>  	} else {
>> @@ -1055,7 +1055,7 @@ static ssize_t nvm_dev_attr_show_20(struct =
device *dev,
>>    /* general attributes */
>>  static NVM_DEV_ATTR_RO(version);
>> -static NVM_DEV_ATTR_RO(capabilities);
>> +static NVM_DEV_ATTR_RO(media_capabilities);
>>    static NVM_DEV_ATTR_RO(read_typ);
>>  static NVM_DEV_ATTR_RO(read_max);
>> @@ -1080,12 +1080,12 @@ static NVM_DEV_ATTR_12_RO(prog_max);
>>  static NVM_DEV_ATTR_12_RO(erase_typ);
>>  static NVM_DEV_ATTR_12_RO(erase_max);
>>  static NVM_DEV_ATTR_12_RO(multiplane_modes);
>> -static NVM_DEV_ATTR_12_RO(media_capabilities);
>> +static NVM_DEV_ATTR_12_RO(capabilities);
>>  static NVM_DEV_ATTR_12_RO(max_phys_secs);
>>    static struct attribute *nvm_dev_attrs_12[] =3D {
>>  	&dev_attr_version.attr,
>> -	&dev_attr_capabilities.attr,
>> +	&dev_attr_media_capabilities.attr,
>>    	&dev_attr_vendor_opcode.attr,
>>  	&dev_attr_device_mode.attr,
>> @@ -1108,7 +1108,7 @@ static struct attribute *nvm_dev_attrs_12[] =3D =
{
>>  	&dev_attr_erase_typ.attr,
>>  	&dev_attr_erase_max.attr,
>>  	&dev_attr_multiplane_modes.attr,
>> -	&dev_attr_media_capabilities.attr,
>> +	&dev_attr_capabilities.attr,
>>  	&dev_attr_max_phys_secs.attr,
>>    	NULL,
>> @@ -1134,7 +1134,7 @@ static NVM_DEV_ATTR_20_RO(reset_max);
>>    static struct attribute *nvm_dev_attrs_20[] =3D {
>>  	&dev_attr_version.attr,
>> -	&dev_attr_capabilities.attr,
>> +	&dev_attr_media_capabilities.attr,
>>    	&dev_attr_groups.attr,
>>  	&dev_attr_punits.attr,
>=20
> With the mccap changes, it should make sense to keep the capabilities
> as is.

The change adds mccap, but sysfs points to cap, which is wrong. This
patch is needed. Otherwise, we change the name of mccap to cap, which
is _very_ confusing to people familiar to both specs. We can change
the name of mccap to cap in a future spec revision.

Javier

--Apple-Mail=_397BD780-928F-4AAB-918C-0EDB508B4A7B
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlqOdZIACgkQIX4xUKFR
nnQoURAAtkK91HVURpL7i4HLmx7iIRkLFEdP2VkZEmWMk6UchbN25VIgmDpX0OGF
t1uSmihMYf26Pa16dGij4/qGLuGqWUaHDrrmom5mAtylqbeJUOKFtRMwWbUzodx7
eM/0yYsefLXrQ0g3jtcdKZkhtRCTaLT6Jos9MaacntELOLa0H/s5OX4v+rTrws5i
YG39vVcMno4T5AwEGz5VaTxCBAXoY+fuSdPsG11+5bZHFISUh4sThd4Japx+Zriv
LglRlZLW3p6b8mmJDqW7GE25KTPODRHZ1rDwc86zugEMSTXx6REUTHOhmd0zdpqc
6TT1vviML0HnH3oJ6dYspKXQ1NPry7no7oI0a2Dmqbn/9XuAiVQFWSrEddRFlUL0
EhjAgg/5Kw1zzA49rCyl7KSZzIJw3YxigekuzNTbVjWib/sa0EKoBGJglc8o2wsy
q6Pvp4NtZ5dWQBOrwwhy4q4fLs8obsjMRS/epIOD5+7gCOO8yKgT1Q2+eBO91cnJ
MPEvoUJEmVugfYcO9qZTInCO1/hhNnaCKQudyaoN4QeUklZBYJt1nvZWGadKrnKJ
hQPtuo2j97PnnvozCzt8G6D4o23sigZCN7s4dKITJTUdU4V2xUuGojuJQO4Z8LgF
9Qfh3UmMpsoDkUY2/xsC7m9F6zYFW+lzThMlYIawu6UKrMvc814=
=aZWg
-----END PGP SIGNATURE-----

--Apple-Mail=_397BD780-928F-4AAB-918C-0EDB508B4A7B--
