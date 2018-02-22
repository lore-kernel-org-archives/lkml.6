Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752776AbeBVHzU (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 02:55:20 -0500
Received: from mail-by2nam01on0065.outbound.protection.outlook.com ([104.47.34.65]:21792
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751657AbeBVHzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 02:55:18 -0500
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 08/20] lightnvm: complete geo structure with maxoc*
Thread-Topic: [PATCH 08/20] lightnvm: complete geo structure with maxoc*
Thread-Index: AQHTqvYt5cpllOgM1U67HfLhiBYBOqOwDE2AgAACtoA=
Date: Thu, 22 Feb 2018 07:55:16 +0000
Message-ID: <F70FB36A-967C-4B37-8037-C550249A0C3B@cnexlabs.com>
References: <1519205218-26994-1-git-send-email-javier@cnexlabs.com>
 <1519205218-26994-9-git-send-email-javier@cnexlabs.com>
 <5e2948ed-19a8-7bd5-6c50-df37a1454d16@lightnvm.io>
In-Reply-To: <5e2948ed-19a8-7bd5-6c50-df37a1454d16@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com;
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR06MB3266;7:sA4vWF8sDu3q74r98LqJ5mU2MoMfculNPDX+hyn+kY6PxKWNCY9GIp8YuqEiwELB8FiLPJhEKHur75F1rblopuElAHojmrwTfQ3uyLjJF/1AdJ6NDYFP6HTrWMIcVEKrpqibaY0ro75iGiHwjeJSPBmSCDUcmjcm6JiGQ1PJoruoDAVLvdwB2iRFMNMHFEV4DMyU8PBgh1maglxF8xFnlQ8LGuzqHRIChlxTTkxcXt4aOhUWU3wJzQDZ/DxX3bN3
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: ea676870-87ac-4489-193b-08d579c99caf
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7153060)(49563074)(7193020);SRVR:BN6PR06MB3266;
x-ms-traffictypediagnostic: BN6PR06MB3266:
x-microsoft-antispam-prvs: <BN6PR06MB326636F2FE1166FB6E3DFB42BACD0@BN6PR06MB3266.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001077)(102415395)(6040501)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231101)(944501161)(3002001)(6041288)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN6PR06MB3266;BCL:0;PCL:0;RULEID:;SRVR:BN6PR06MB3266;
x-forefront-prvs: 059185FE08
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39380400002)(396003)(39840400004)(346002)(376002)(189003)(199004)(83716003)(6246003)(25786009)(316002)(6916009)(2950100002)(6486002)(6436002)(106356001)(4326008)(5660300001)(105586002)(82746002)(6512007)(3280700002)(7736002)(99936001)(53936002)(3660700001)(305945005)(2900100001)(68736007)(76176011)(186003)(99286004)(26005)(229853002)(86362001)(77096007)(66066001)(3846002)(36756003)(14454004)(54906003)(33656002)(81156014)(6506007)(2906002)(81166006)(8936002)(53546011)(478600001)(6116002)(8676002)(97736004)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR06MB3266;H:BN6PR06MB2626.namprd06.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: LvrjfqEij0XsI0HnCuH8zlMjsBMikdu6p2ENrYnMKEcyp+lDVw/4eSPvlzjC1KyZK7GnLcn/Z7jakhvo7dmUCQe6V8bX+UvXjBQ0m2w6wIQgNoSWWTBmQNCxI3cKrSzyqMw+hg3Dv23x+Z1ee4R4SDRhV2T0Va9znYr+upxnoX8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_46920EEA-63A4-4E90-9A8C-FC633EAEE95A";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea676870-87ac-4489-193b-08d579c99caf
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2018 07:55:16.5182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR06MB3266
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_46920EEA-63A4-4E90-9A8C-FC633EAEE95A
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 22 Feb 2018, at 08.45, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 02/21/2018 10:26 AM, Javier Gonz=C3=A1lez wrote:
>> Complete the generic geometry structure with the maxoc and maxocpu
>> felds, present in the 2.0 spec.
>> Signed-off-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
>> ---
>>  drivers/nvme/host/lightnvm.c | 4 ++++
>>  include/linux/lightnvm.h     | 2 ++
>>  2 files changed, 6 insertions(+)
>> diff --git a/drivers/nvme/host/lightnvm.c =
b/drivers/nvme/host/lightnvm.c
>> index cca32da05316..9c1f8225c4e1 100644
>> --- a/drivers/nvme/host/lightnvm.c
>> +++ b/drivers/nvme/host/lightnvm.c
>> @@ -318,6 +318,8 @@ static int nvme_nvm_setup_12(struct nvme_nvm_id12 =
*id,
>>  	dev_geo->c.ws_min =3D sec_per_pg;
>>  	dev_geo->c.ws_opt =3D sec_per_pg;
>>  	dev_geo->c.mw_cunits =3D 8;		/* default to MLC safe =
values */
>> +	dev_geo->c.maxoc =3D dev_geo->all_luns;	/* default to 1 chunk =
per LUN */
>> +	dev_geo->c.maxocpu =3D 1;			/* default to 1 =
chunk per LUN */
>=20
> One can't assume that it is 1 open chunk per lun. If you need this for =
specific hardware, make a quirk for it.
>=20

Which default you want for 1.2 if not specified then? I use 1 because it
has been the implicit default until now.

Javier

--Apple-Mail=_46920EEA-63A4-4E90-9A8C-FC633EAEE95A
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlqOd2EACgkQIX4xUKFR
nnTrzw//TBAoR1C/1TIN5ZWGevvG9ySmoxeqmG6FIZQ5PAOHUnHz9NtF3Rk3LEra
T4qmH7vm4mr6Hlaqquca+LdXpX2QAzWEr39v8Xh0RDYK5ygx7cPYaijoYkoaQG5o
Meil3lVMBpTg39rWNhOIVRjYYCBykEDGdAhgWdAfSrwfaWkeZ/K3+m6E+fXNllTJ
tcKvRSZDpKl1V5wLAdSgywNTbO6QOf63MzhFQ2N4IbLxeHdu8+0EHArwTq/zZ4S7
sfO5kbDs/y3G1Qr1mB2oHoTxEiNDcXjKIfwzCq3oOdtFmkat8GhPRbHeLJl7h4JF
vfAZh120+WXb9z6xCumPspPqNXcsaW24G4y6S5he+xiwVC+RzNt6oHLC3xIf4lpA
yJwogm0M8vQQHXhZYZRasoOodJ7aURlmmzt6j2UWVNwrJ9XoQa1Uxw6Ahoq3adSg
9YTlomaD9CVN1h0n3pKPZJ2SG3G9gOJV24BgcKHQEmb9w0SoCzSyBbPr3HOYcWTs
JfOQ2wp2amtHIlM6C535/qjdGzuZMKpfie8UOvXKyRpaRxMJptAQPmfG8Ka/zJxz
99zIC+6c+N3Pe2lc1jq3Z0EYg4vRI+O8SwOH7fTCGsnzljp5ootbRYp5TYzfOouW
7hkqB6HOIfw0LTPP3eHLf3uYk6v9vtuueFipNkAoTF0aqWS1M+c=
=NDck
-----END PGP SIGNATURE-----

--Apple-Mail=_46920EEA-63A4-4E90-9A8C-FC633EAEE95A--
