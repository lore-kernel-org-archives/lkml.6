Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753619AbeBVLM1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 06:12:27 -0500
Received: from mail-by2nam03on0059.outbound.protection.outlook.com ([104.47.42.59]:10890
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753279AbeBVLMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 06:12:25 -0500
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 03/20] lightnvm: fix capabilities for 2.0 sysfs
Thread-Topic: [PATCH 03/20] lightnvm: fix capabilities for 2.0 sysfs
Thread-Index: AQHTqvYqUX4YQRQApUG/o9ZTj4y0DKOwB5CAgAAFSwCAAB8xAIAADQl2gAAMnICAAABkgA==
Date: Thu, 22 Feb 2018 11:12:23 +0000
Message-ID: <C1D66C1C-48B9-4B45-AB28-EEA1D52EB121@cnexlabs.com>
References: <1519205218-26994-1-git-send-email-javier@cnexlabs.com>
 <1519205218-26994-4-git-send-email-javier@cnexlabs.com>
 <23b494fb-264d-a8ef-6172-5330d5a63bea@lightnvm.io>
 <19BA9139-DB6D-4A9B-A0B4-72F38BE648E9@cnexlabs.com>
 <616ad3c9-b10c-0439-2d63-5e9e25abce84@lightnvm.io>
 <A949EA48-27DF-4370-B213-3A4CE4E4F7D1@cnexlabs.com>
 <e4ac9c84-3dd5-41e3-8190-905d2a7f5d5d@lightnvm.io>
In-Reply-To: <e4ac9c84-3dd5-41e3-8190-905d2a7f5d5d@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com;
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR06MB3489;7:tFBRk4uyV/WxkNwbE/QtneyHEZ+6B3xAvj8UUGKiiGU9FftqTeyEfZAxKi24S9ycuquk6HpQVw6aIles7rSSaIxP7GUVoZl1l63jhKQs/VFUQU4CF9tLoh/aFT5/DLXS+ehysLTTIKnzEjgaEWIO9Aci4dmadgwQsQggjeYyVqYpURktO0uxEnH5WXSCnVVZlZj70UliTJ18otA9P85ho7aUwrlLqvPHhWKPDi65YxgYkh/2UgzoeYqmR9+yXc8p
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: a8a3a3d9-e03d-4bb4-f6b9-08d579e525d2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7153060)(49563074)(7193020);SRVR:BN6PR06MB3489;
x-ms-traffictypediagnostic: BN6PR06MB3489:
x-microsoft-antispam-prvs: <BN6PR06MB34891123D35EE3A7F3CDAB0BBACD0@BN6PR06MB3489.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001078)(102415395)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231101)(944501161)(93006095)(93001095)(6041288)(20161123564045)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN6PR06MB3489;BCL:0;PCL:0;RULEID:;SRVR:BN6PR06MB3489;
x-forefront-prvs: 059185FE08
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39840400004)(39380400002)(376002)(366004)(396003)(346002)(52314003)(189003)(199004)(478600001)(54906003)(6246003)(53936002)(33656002)(82746002)(2906002)(99936001)(105586002)(14454004)(3660700001)(229853002)(106356001)(53546011)(68736007)(6506007)(36756003)(3846002)(102836004)(6116002)(6436002)(3280700002)(8676002)(76176011)(77096007)(186003)(8936002)(6512007)(83716003)(97736004)(4326008)(81166006)(81156014)(99286004)(66066001)(2950100002)(86362001)(6486002)(6916009)(305945005)(25786009)(7736002)(316002)(2900100001)(93886005)(5660300001)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR06MB3489;H:BN6PR06MB2626.namprd06.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: hYW1nX37bd//Xa+zYjkpfMXoaLcpJLlmG63CXIpqxgXe1PS2f55tgpeH4UrZgZXX7D8Wfrn0vXwv1kVyCP8+BRYqeDVvV63d8NUCTYmW7HJXG5HlLlEeVOPUtWVdXnfgXVeHrr/DZ68uvlzx6JdTfTvYvmwM6uOJy3/3S5/FwVg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_6D82E9C4-F34F-4420-8D35-C888EC6865C9";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a3a3d9-e03d-4bb4-f6b9-08d579e525d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2018 11:12:23.1066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR06MB3489
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_6D82E9C4-F34F-4420-8D35-C888EC6865C9
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 22 Feb 2018, at 12.10, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 02/22/2018 11:25 AM, Javier Gonzalez wrote:
>>> On 22 Feb 2018, at 10.39, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>=20
>>> On 02/22/2018 08:47 AM, Javier Gonzalez wrote:
>>>>> On 22 Feb 2018, at 08.28, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>>>=20
>>>>>> On 02/21/2018 10:26 AM, Javier Gonz=C3=A1lez wrote:
>>>>>> Both 1.2 and 2.0 specs define a field for media and controller
>>>>>> capabilities. Also, 1.2 defines a separate field dedicated to =
device
>>>>>> capabilities.
>>>>>> In 2.0 sysfs, this values have been mixed. Revert them to the =
right
>>>>>> value.
>>>>>> Signed-off-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
>>>>>> ---
>>>>>>  drivers/nvme/host/lightnvm.c | 18 +++++++++---------
>>>>>>  1 file changed, 9 insertions(+), 9 deletions(-)
>>>>>> diff --git a/drivers/nvme/host/lightnvm.c =
b/drivers/nvme/host/lightnvm.c
>>>>>> index 969bb874850c..598abba66f52 100644
>>>>>> --- a/drivers/nvme/host/lightnvm.c
>>>>>> +++ b/drivers/nvme/host/lightnvm.c
>>>>>> @@ -914,8 +914,8 @@ static ssize_t nvm_dev_attr_show(struct =
device *dev,
>>>>>>        if (strcmp(attr->name, "version") =3D=3D 0) {
>>>>>>          return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->ver_id);
>>>>>> -    } else if (strcmp(attr->name, "capabilities") =3D=3D 0) {
>>>>>> -        return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.cap);
>>>>>> +    } else if (strcmp(attr->name, "media_capabilities") =3D=3D =
0) {
>>>>>> +        return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.mccap);
>>>>>>      } else if (strcmp(attr->name, "read_typ") =3D=3D 0) {
>>>>>>          return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.trdt);
>>>>>>      } else if (strcmp(attr->name, "read_max") =3D=3D 0) {
>>>>>> @@ -993,8 +993,8 @@ static ssize_t nvm_dev_attr_show_12(struct =
device *dev,
>>>>>>          return scnprintf(page, PAGE_SIZE, "%u\n", =
dev_geo->c.tbem);
>>>>>>      } else if (strcmp(attr->name, "multiplane_modes") =3D=3D 0) =
{
>>>>>>          return scnprintf(page, PAGE_SIZE, "0x%08x\n", =
dev_geo->c.mpos);
>>>>>> -    } else if (strcmp(attr->name, "media_capabilities") =3D=3D =
0) {
>>>>>> -        return scnprintf(page, PAGE_SIZE, "0x%08x\n", =
dev_geo->c.mccap);
>>>>>> +    } else if (strcmp(attr->name, "capabilities") =3D=3D 0) {
>>>>>> +        return scnprintf(page, PAGE_SIZE, "0x%08x\n", =
dev_geo->c.cap);
>>>>>>      } else if (strcmp(attr->name, "max_phys_secs") =3D=3D 0) {
>>>>>>          return scnprintf(page, PAGE_SIZE, "%u\n", NVM_MAX_VLBA);
>>>>>>      } else {
>>>>>> @@ -1055,7 +1055,7 @@ static ssize_t nvm_dev_attr_show_20(struct =
device *dev,
>>>>>>    /* general attributes */
>>>>>>  static NVM_DEV_ATTR_RO(version);
>>>>>> -static NVM_DEV_ATTR_RO(capabilities);
>>>>>> +static NVM_DEV_ATTR_RO(media_capabilities);
>>>>>>    static NVM_DEV_ATTR_RO(read_typ);
>>>>>>  static NVM_DEV_ATTR_RO(read_max);
>>>>>> @@ -1080,12 +1080,12 @@ static NVM_DEV_ATTR_12_RO(prog_max);
>>>>>>  static NVM_DEV_ATTR_12_RO(erase_typ);
>>>>>>  static NVM_DEV_ATTR_12_RO(erase_max);
>>>>>>  static NVM_DEV_ATTR_12_RO(multiplane_modes);
>>>>>> -static NVM_DEV_ATTR_12_RO(media_capabilities);
>>>>>> +static NVM_DEV_ATTR_12_RO(capabilities);
>>>>>>  static NVM_DEV_ATTR_12_RO(max_phys_secs);
>>>>>>    static struct attribute *nvm_dev_attrs_12[] =3D {
>>>>>>      &dev_attr_version.attr,
>>>>>> -    &dev_attr_capabilities.attr,
>>>>>> +    &dev_attr_media_capabilities.attr,
>>>>>>        &dev_attr_vendor_opcode.attr,
>>>>>>      &dev_attr_device_mode.attr,
>>>>>> @@ -1108,7 +1108,7 @@ static struct attribute *nvm_dev_attrs_12[] =
=3D {
>>>>>>      &dev_attr_erase_typ.attr,
>>>>>>      &dev_attr_erase_max.attr,
>>>>>>      &dev_attr_multiplane_modes.attr,
>>>>>> -    &dev_attr_media_capabilities.attr,
>>>>>> +    &dev_attr_capabilities.attr,
>>>>>>      &dev_attr_max_phys_secs.attr,
>>>>>>        NULL,
>>>>>> @@ -1134,7 +1134,7 @@ static NVM_DEV_ATTR_20_RO(reset_max);
>>>>>>    static struct attribute *nvm_dev_attrs_20[] =3D {
>>>>>>      &dev_attr_version.attr,
>>>>>> -    &dev_attr_capabilities.attr,
>>>>>> +    &dev_attr_media_capabilities.attr,
>>>>>>        &dev_attr_groups.attr,
>>>>>>      &dev_attr_punits.attr,
>>>>>=20
>>>>> With the mccap changes, it should make sense to keep the =
capabilities
>>>>> as is.
>>>> The change adds mccap, but sysfs points to cap, which is wrong. =
This
>>>> patch is needed. Otherwise, we change the name of mccap to cap, =
which
>>>> is _very_ confusing to people familiar to both specs. We can change
>>>> the name of mccap to cap in a future spec revision.
>>>> Javier
>>>=20
>>> Think of the sysfs capabilities as an abstract value that defines =
generic capabilities. It is not directly tied to either 1.2 or 2.0.
>> I=E2=80=99m thinking about the user looking at sysfs and at the spec =
at the same time - I myself get confused when names don=E2=80=99t match.
>> Anyway, I=E2=80=99ll keep it the way it was and add a comment for =
clarification. Would that work for you?
>=20
> That works. One may also wait until it is going to be used, e.g., when
> vector copy is implemented. Then it's natural to revisit.

Ok. Let's do that then. I'll drop the 2 patches then.

Javier

--Apple-Mail=_6D82E9C4-F34F-4420-8D35-C888EC6865C9
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlqOpZMACgkQIX4xUKFR
nnRvsxAAiJAn0P9b2pH8Wa96wCR7jCv7o5BWLMuNk+59232/4CBzOx4YrMxJF7hq
jhvhI+AAuxw4/7UsTcHlhfcwmbF9M/KORyuEw6CUCxi7ShyfiH8K+ZpVMxFFIAWJ
dzJmKj4b/5hmdvs2NmoKr3eCpKELUpcIe5qPcnn+N32CIFzrBrMW9ilkqE8CXZ0c
soYmL8Gwfi9gAmwyVSjMedWWIqhae0oYWrndJv7rH65NdYONumf52VlrhBq2jNVJ
DaQB/pEJxNP2+16BE7/etFNbe2NIwV7wRgrgqU1q5sGVPjPdTmJsZrZsBLwM1ixy
5EAJ3wibvKWQqOXeW+Tflz0EuWtSaJdVkcr0vjXhaOm5QhgEmGTEGIsaSi5kj1nc
nH55e1yTiIPr779pRxSPEUXSX9uLCy4DBsV5UzUzsQPHuwx1BeotQFdFKu2AUGek
UbTy4b+ijUbjPIb2QRnOb1bk23ux2go/pKcOoNvps9eQVbNgoH01J2FU2i2oUruf
u8OvGLetxRN5rUwU3Fq0TPwVssAXn37rL7FsvoFXA8ypIh0f5M8p1PGA9kD4fwTq
egDAFCkeJwE3WEnf+p7aPPM90xLObtfT1GtHnBH9YUgnxovYCrASpEzOCJQMoZUF
Bnk7kGsMnQc3JQ1J/zLNLVdEZuIHeLSv8tJs3mzDSP1JGgT3Hck=
=J6zo
-----END PGP SIGNATURE-----

--Apple-Mail=_6D82E9C4-F34F-4420-8D35-C888EC6865C9--
