Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753280AbeBVJwP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 04:52:15 -0500
Received: from mail-cys01nam02on0067.outbound.protection.outlook.com ([104.47.37.67]:41696
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753101AbeBVJwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 04:52:11 -0500
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 08/20] lightnvm: complete geo structure with maxoc*
Thread-Topic: [PATCH 08/20] lightnvm: complete geo structure with maxoc*
Thread-Index: AQHTqvYt5cpllOgM1U67HfLhiBYBOqOwDE2AgAACtoCAAB7QAIAAAdgA
Date: Thu, 22 Feb 2018 09:52:09 +0000
Message-ID: <BA0987F5-AEA5-43BD-A065-3BF72E9A8676@cnexlabs.com>
References: <1519205218-26994-1-git-send-email-javier@cnexlabs.com>
 <1519205218-26994-9-git-send-email-javier@cnexlabs.com>
 <5e2948ed-19a8-7bd5-6c50-df37a1454d16@lightnvm.io>
 <F70FB36A-967C-4B37-8037-C550249A0C3B@cnexlabs.com>
 <ec5d6c53-c3a1-7d66-9db7-407a519f0feb@lightnvm.io>
In-Reply-To: <ec5d6c53-c3a1-7d66-9db7-407a519f0feb@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com;
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR06MB3474;7:DwgHwuF8I7+fM2XzOMHzXnin2/PQfx1aV+cyGj2F61dYwrL3pozlSBL5IfvCo6GKKKYwPv03AQ0NTbjTp74lpq0Zo4N0hmtK8I14AI9Qb5PToAzIcCTWVJ8Rf3qLLwDXisQ/CYzCSci6S3JcweovHd4j2lzdLrjvdAa4DYY85Hl9C0q1iyAWE9Nnu7bYP7SHRtEYk/KJMxIa5nz7cYSMCzrimHisM4mBtYILGNukPryowjQbIOWlG/TpFl3uOPbj
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 99451bc8-8169-47ba-1264-08d579d9f0bd
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7153060)(49563074)(7193020);SRVR:BN6PR06MB3474;
x-ms-traffictypediagnostic: BN6PR06MB3474:
x-microsoft-antispam-prvs: <BN6PR06MB34740BAB6BE79EED0D9EF67DBACD0@BN6PR06MB3474.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001077)(102415395)(6040501)(2401047)(5005006)(8121501046)(3231101)(944501161)(3002001)(10201501046)(93006095)(93001095)(6041288)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN6PR06MB3474;BCL:0;PCL:0;RULEID:;SRVR:BN6PR06MB3474;
x-forefront-prvs: 059185FE08
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39380400002)(396003)(376002)(346002)(366004)(39840400004)(199004)(189003)(6116002)(186003)(3846002)(53546011)(36756003)(3660700001)(26005)(6506007)(59450400001)(86362001)(478600001)(102836004)(5660300001)(53936002)(97736004)(81166006)(4326008)(99286004)(316002)(25786009)(76176011)(54906003)(305945005)(68736007)(81156014)(3280700002)(7736002)(105586002)(33656002)(77096007)(8676002)(106356001)(93886005)(229853002)(82746002)(2906002)(66066001)(99936001)(8936002)(2950100002)(2900100001)(6916009)(83716003)(6246003)(5890100001)(6436002)(6486002)(6512007)(14454004);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR06MB3474;H:BN6PR06MB2626.namprd06.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: lpneSnqwuo+DQTCfXKao6hmC9xPKDvum7yHPAkdeXLn1wk3J567yJ12Hor5CVuLlQuF58U848ageWFsT69xaUV4YpN6gfgMaPyfqRxQCg8ranr1t+XaPAL9VjLUop4vmdnjVddyTCrc3IlwFrBHDMIN5MhJvZ3RedbA9qzX7JHY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_CBF59D61-849B-47ED-B402-37E9C9C2565D";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99451bc8-8169-47ba-1264-08d579d9f0bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2018 09:52:09.5486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR06MB3474
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_CBF59D61-849B-47ED-B402-37E9C9C2565D
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 22 Feb 2018, at 10.45, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 02/22/2018 08:55 AM, Javier Gonzalez wrote:
>>> On 22 Feb 2018, at 08.45, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>=20
>>> On 02/21/2018 10:26 AM, Javier Gonz=C3=A1lez wrote:
>>>> Complete the generic geometry structure with the maxoc and maxocpu
>>>> felds, present in the 2.0 spec.
>>>> Signed-off-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
>>>> ---
>>>>  drivers/nvme/host/lightnvm.c | 4 ++++
>>>>  include/linux/lightnvm.h     | 2 ++
>>>>  2 files changed, 6 insertions(+)
>>>> diff --git a/drivers/nvme/host/lightnvm.c =
b/drivers/nvme/host/lightnvm.c
>>>> index cca32da05316..9c1f8225c4e1 100644
>>>> --- a/drivers/nvme/host/lightnvm.c
>>>> +++ b/drivers/nvme/host/lightnvm.c
>>>> @@ -318,6 +318,8 @@ static int nvme_nvm_setup_12(struct =
nvme_nvm_id12 *id,
>>>>  	dev_geo->c.ws_min =3D sec_per_pg;
>>>>  	dev_geo->c.ws_opt =3D sec_per_pg;
>>>>  	dev_geo->c.mw_cunits =3D 8;		/* default to MLC safe =
values */
>>>> +	dev_geo->c.maxoc =3D dev_geo->all_luns;	/* default to 1 chunk =
per LUN */
>>>> +	dev_geo->c.maxocpu =3D 1;			/* default to 1 =
chunk per LUN */
>>>=20
>>> One can't assume that it is 1 open chunk per lun. If you need this =
for specific hardware, make a quirk for it.
>> Which default you want for 1.2 if not specified then? I use 1 because =
it
>> has been the implicit default until now.
>=20
> INT_MAX, since it then allows the maximum of open chunks. It cannot be =
assumed that other 1.2 devices is limited to a single open chunk.

So you want the default to be that all blocks on the device can be
opened at the same time. Interesting... I guess that such a SSD will
have a AA battery attached to it, but fine by me if that's how you want
it.

Assuming this, can we instead set it to the reported number of chunks,
since this is the hard limit anyway.

Javier

--Apple-Mail=_CBF59D61-849B-47ED-B402-37E9C9C2565D
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlqOksYACgkQIX4xUKFR
nnQ8YBAA35N6XX/ZmZpJaUmD/6aXZaApD1nlJYznVb0Lw0MnCzF9rkDOLT05kiDH
t4Kx8m7H7Cll4ICzOVDbR2LDRaSgxnHawtUpnl9y6+OfUXlgjubU1zCAVydf++Yq
cP7No0gIYgYlpe34cJ521T7tr/5u+0SCXS6vIQkBdzEaYocCGjPkPDnvur+Oy9aB
Whr2Mi6NEBKTSjexd1OL9k6e846awNyNJgq7ffX7NlG5Jjo9bjTbD/MZEBcS6mdn
pVgbSIEy2PPl+KflXefJYYStWLT42GfmFPWRnXqdh2ajndWbzxtmfs1rklvQeM7E
c8Bm0PniARxIEwIvHdc6j9rIfYEXpcekfvSPS3SDCfV9T72xj87MYeBuvGWZd90n
tFOpWjP2EYck6imIBLe3yFw5XnuqbgvkxNhyP2xccMP3YQ7c3YuqARQD7mYMf9Sw
VhzSZzEWPUQCM8mEYa4qHKlRvoOWrg5s0Lq7wrQ/0Wjw0ngOqoIz+mwOTxL+ZpNg
DxA5UXbKOXEkp2FwTHfcnGqGYBdUwNC0pM2Ol9QzjYrDWqp/Psn6pZvetG0oU68u
g78EDzRus5zIyt0Ljf3Iz86jmo83YALlee+ZNSOdnpqPo05IRa+HVsnzIddFfjYQ
QO0ccPcy+LhbpSIY75ymUriibhQeRnklQPvT+fLkcyYOtN6ql5I=
=naPr
-----END PGP SIGNATURE-----

--Apple-Mail=_CBF59D61-849B-47ED-B402-37E9C9C2565D--
