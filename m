Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753278AbeBVKDf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 05:03:35 -0500
Received: from mail-by2nam03on0041.outbound.protection.outlook.com ([104.47.42.41]:59784
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752644AbeBVKDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 05:03:33 -0500
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 08/20] lightnvm: complete geo structure with maxoc*
Thread-Topic: [PATCH 08/20] lightnvm: complete geo structure with maxoc*
Thread-Index: AQHTqvYt5cpllOgM1U67HfLhiBYBOqOwDE2AgAACtoCAAB7QAIAAAdgAgAACcoCAAAC7AA==
Date: Thu, 22 Feb 2018 10:03:30 +0000
Message-ID: <6AB3CE71-8BC1-4D6E-A379-A7CFDF61B7FE@cnexlabs.com>
References: <1519205218-26994-1-git-send-email-javier@cnexlabs.com>
 <1519205218-26994-9-git-send-email-javier@cnexlabs.com>
 <5e2948ed-19a8-7bd5-6c50-df37a1454d16@lightnvm.io>
 <F70FB36A-967C-4B37-8037-C550249A0C3B@cnexlabs.com>
 <ec5d6c53-c3a1-7d66-9db7-407a519f0feb@lightnvm.io>
 <BA0987F5-AEA5-43BD-A065-3BF72E9A8676@cnexlabs.com>
 <9c8c1b50-0c8e-36cd-0f1d-a07753567f43@lightnvm.io>
In-Reply-To: <9c8c1b50-0c8e-36cd-0f1d-a07753567f43@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com;
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR06MB3236;7:rYXot3vKRTf51yywxRe80nfGEFA/xpHA9txTZcXs24uMbqx5KklvCIjTjlcNAVegcyuB0B4qGQwkatJYMaItIS8V1lotQvJrihabQ2S7fQ/71N6ypMz8qPF7hFhHF5C66xSx/o6DVsEnwonWl4f6QmqcV7NGvKZe9B9Q+KCwCUDPgAcBF89ywal4w5od9RJnj9DsFgqPp6K46wxAiyL7ra5NM68BLdy7XLJW4bPGuxwjgHPLY7fx0NDmEEDPorUR
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 9b38f06b-2953-4ce2-379d-08d579db86e6
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7153060)(49563074)(7193020);SRVR:BN6PR06MB3236;
x-ms-traffictypediagnostic: BN6PR06MB3236:
x-microsoft-antispam-prvs: <BN6PR06MB323604E717FBFED450769ED5BACD0@BN6PR06MB3236.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(102415395)(6040501)(2401047)(8121501046)(5005006)(3231101)(944501161)(93006095)(93001095)(10201501046)(3002001)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:BN6PR06MB3236;BCL:0;PCL:0;RULEID:;SRVR:BN6PR06MB3236;
x-forefront-prvs: 059185FE08
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(366004)(39380400002)(39840400004)(189003)(199004)(86362001)(316002)(2950100002)(97736004)(2900100001)(36756003)(6246003)(3846002)(83716003)(81166006)(81156014)(6116002)(26005)(2906002)(77096007)(5890100001)(66066001)(93886005)(186003)(8676002)(105586002)(3280700002)(106356001)(54906003)(53546011)(6506007)(8936002)(102836004)(6436002)(59450400001)(99936001)(76176011)(99286004)(5660300001)(3660700001)(6512007)(14454004)(33656002)(478600001)(305945005)(6916009)(25786009)(53936002)(4326008)(6486002)(7736002)(68736007)(82746002)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR06MB3236;H:BN6PR06MB2626.namprd06.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: GdCa2ko4QnjLOXfkH5UjCDvt+w2X+koagfAxEo/ZXLh7CIQNbA4LPfHYc0U+Ksw7SP035Mqehq69zCVpRc9GPyesN8adZOpiOTm2hf/ViZaLO7m85YMywygFB8/AnZKgb0rxo/iBV1adizCnf19+vR06OCmvpJODTxrLlQ/BgHw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_C6AE8225-AF1E-4834-A51E-2EB850D1EDDD";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b38f06b-2953-4ce2-379d-08d579db86e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2018 10:03:31.0045
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR06MB3236
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_C6AE8225-AF1E-4834-A51E-2EB850D1EDDD
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


Javier

> On 22 Feb 2018, at 11.00, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 02/22/2018 10:52 AM, Javier Gonzalez wrote:
>>> On 22 Feb 2018, at 10.45, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>=20
>>> On 02/22/2018 08:55 AM, Javier Gonzalez wrote:
>>>>> On 22 Feb 2018, at 08.45, Matias Bj=C3=B8rling <mb@lightnvm.io> =
wrote:
>>>>>=20
>>>>> On 02/21/2018 10:26 AM, Javier Gonz=C3=A1lez wrote:
>>>>>> Complete the generic geometry structure with the maxoc and =
maxocpu
>>>>>> felds, present in the 2.0 spec.
>>>>>> Signed-off-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
>>>>>> ---
>>>>>>  drivers/nvme/host/lightnvm.c | 4 ++++
>>>>>>  include/linux/lightnvm.h     | 2 ++
>>>>>>  2 files changed, 6 insertions(+)
>>>>>> diff --git a/drivers/nvme/host/lightnvm.c =
b/drivers/nvme/host/lightnvm.c
>>>>>> index cca32da05316..9c1f8225c4e1 100644
>>>>>> --- a/drivers/nvme/host/lightnvm.c
>>>>>> +++ b/drivers/nvme/host/lightnvm.c
>>>>>> @@ -318,6 +318,8 @@ static int nvme_nvm_setup_12(struct =
nvme_nvm_id12 *id,
>>>>>>  	dev_geo->c.ws_min =3D sec_per_pg;
>>>>>>  	dev_geo->c.ws_opt =3D sec_per_pg;
>>>>>>  	dev_geo->c.mw_cunits =3D 8;		/* default to =
MLC safe values */
>>>>>> +	dev_geo->c.maxoc =3D dev_geo->all_luns;	/* default to 1 =
chunk per LUN */
>>>>>> +	dev_geo->c.maxocpu =3D 1;			/* =
default to 1 chunk per LUN */
>>>>>=20
>>>>> One can't assume that it is 1 open chunk per lun. If you need this =
for specific hardware, make a quirk for it.
>>>> Which default you want for 1.2 if not specified then? I use 1 =
because it
>>>> has been the implicit default until now.
>>>=20
>>> INT_MAX, since it then allows the maximum of open chunks. It cannot =
be assumed that other 1.2 devices is limited to a single open chunk.
>> So you want the default to be that all blocks on the device can be
>> opened at the same time. Interesting... I guess that such a SSD will
>> have a AA battery attached to it, but fine by me if that's how you =
want
>> it.
>=20
> I feel you're a bit sarcastic here. One may think of SLC and other =
memories that does one-shot programming. In that case no caching is =
needed, and therefore power-caps can be limited on the hardware.

Sure. Hope people move to 2.0 then for all >SLC memories out there,
otherwise we'll see a lot of quirks coming in. Thought we wanted to be
generic.

>=20
>> Assuming this, can we instead set it to the reported number of =
chunks,
>> since this is the hard limit anyway.
>=20
> Works for me.

Cool. I'll add this to the next version.

Javier

--Apple-Mail=_C6AE8225-AF1E-4834-A51E-2EB850D1EDDD
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlqOlXAACgkQIX4xUKFR
nnSHwQ/9EgDfYkQ43KyFO1sVLKqWAeOS6c44+Pq9/ULg3XWN/Aw1LTUOIjNW8/Qf
k9rU4TTqtY9H6OLn2qSqq3T0qiUTNeQ0LgDFRWw7ipnJqU+g7umT53MHPyxuYCWB
jQOU/4o95tw4BXtYyo8eH6BijUM/7Mhx+o4FDEjYzsP3yIhJ92l1JO5ql1HRsIhp
wgUyXP2WVTO9d+RdYzCvR8zuPFUVkG+94T+5JAaAP4b9yCqZxRpZ8HRkDkAyHE2c
ab6FgoLnno/ut5oWp7c/DbeAX+QQCLxxhkxdsW2HiCQ9OQhhVyeqqhYO2daVH21p
9i6P0/o+oL49FL7RTkHf1Kfm4tgaQV/yjU5vV0FI+IkOXAdeyAIzDy0i0SXKk8KL
8Q3tSK4x1sF+ni6FyYVfbplkUpJa7MvZDMUkoaa3xcdaIxheDAYD7oAIB5FW1qbt
7Rv7WqaZFogYLkTb5ysCQoUH4EkK195Kky+FIdoU74Yk1ZRA8v1cOXG9nRxYRKbt
O3fypgoYiJdZHhQQH9/WM6FnlNr9Qk88SgdLpXXSalSsv9x+wLzd0/s/57+p4CMM
5NwDWRkP/bz5uTsfLg+sGwPBsoIPO+6HKyleN6gVJ1akLNMuo4Msvh80zTIRkHY2
lZTy2bnCM0pl52C29M7S9tdWqyK6WM0aCLgeDAYjuImcuyYiZK0=
=xMiB
-----END PGP SIGNATURE-----

--Apple-Mail=_C6AE8225-AF1E-4834-A51E-2EB850D1EDDD--
