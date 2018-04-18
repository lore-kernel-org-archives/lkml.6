Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753690AbeDRMIx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 08:08:53 -0400
Received: from mail-dm3nam03on0089.outbound.protection.outlook.com ([104.47.41.89]:47872
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752027AbeDRMIv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 08:08:51 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 07/11] lightnvm: pblk: remove unnecessary indirection
Thread-Topic: [PATCH 07/11] lightnvm: pblk: remove unnecessary indirection
Thread-Index: AQHT1W1M0cLBp3Ly+EGuqeEQ98TOUKQE37EAgAGRcgA=
Date: Wed, 18 Apr 2018 12:08:47 +0000
Message-ID: <B2B2C448-938C-49FD-ADA6-D35C8E9F66F1@cnexlabs.com>
References: <1523874332-6272-1-git-send-email-javier@cnexlabs.com>
 <1523874332-6272-8-git-send-email-javier@cnexlabs.com>
 <62002f4f-bfca-03be-c54f-23b15223446b@lightnvm.io>
In-Reply-To: <62002f4f-bfca-03be-c54f-23b15223446b@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: lightnvm.io; dkim=none (message not signed)
 header.d=none;lightnvm.io; dmarc=none action=none header.from=cnexlabs.com;
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB524;7:DA7yjZHzB8Fh9yBIOuSj5vGvNJbRKVURPFQr2fra3jsfKG6Wrh7ktFd1t/rD2ZIod9uED1fUEOyFiC6u9ekOtecrdSn3LDyMLJFjjXQwMIK2xJd6plo1BjiC84TPsq61r8jzjN21qwy0j4nrF34s74z1zpbkVG70n7Re2E82oeIa05V+Fu2cGcZVOAvHlh8WVs2NLw1khEowQYzV9Ih8mkDraQXMDNZBvnZchtMAVAfEoahCv+2WhVcg6l530rNy
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(49563074)(7193020);SRVR:CO2PR06MB524;
x-ms-traffictypediagnostic: CO2PR06MB524:
x-microsoft-antispam-prvs: <CO2PR06MB5248942BD6FE5F5F7AF4AACBAB60@CO2PR06MB524.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231232)(944501327)(52105095)(3002001)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CO2PR06MB524;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB524;
x-forefront-prvs: 06469BCC91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(376002)(396003)(39840400004)(39380400002)(81166006)(2616005)(6512007)(476003)(82746002)(25786009)(86362001)(446003)(229853002)(99936001)(26005)(11346002)(5660300001)(8676002)(6486002)(102836004)(66066001)(76176011)(53936002)(8936002)(6916009)(99286004)(53546011)(83716003)(6506007)(2906002)(4326008)(2900100001)(7736002)(6436002)(5250100002)(6116002)(36756003)(14454004)(33656002)(54906003)(478600001)(3846002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB524;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;MLV:sfv;
x-microsoft-antispam-message-info: IqiTtHpdhQZV52QORkv3HmUHnjILIFqViJopvYKRc+RO4wdjeM+QqzyrDBVPx+/FTVGa+7NYJS4m1ktGHwezdta+k/0OJzL9Ayh5y5JceC9+GT4U3ecr9nbzZ/p5FnPJzQnwy9tCuPwY4f2n0C+X78pYFE3LR7Cn/LM7LsS7Fh8o+j75sHOaJE8F57CFhHJd
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_457CFC07-E92E-4168-9173-8AEE28253AF5";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 6c8600ef-3a67-4e3b-8072-08d5a525245e
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c8600ef-3a67-4e3b-8072-08d5a525245e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2018 12:08:47.6120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB524
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_457CFC07-E92E-4168-9173-8AEE28253AF5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 17 Apr 2018, at 05.11, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 4/16/18 12:25 PM, Javier Gonz=C3=A1lez wrote:
>> Remove unnecessary indirection on the read path.
>=20
> Title and description are the same. Can you elaborate what changed
> since pblk_submit_io now directly can be returned, and doesn't have
> its return value rewritten to NVM_IO_ERR?
>=20

My bad - I assumed submit_io was giving NVM_ errors. I'll resend
returning NVM_IO_ERR - the indirection is still unnecessary (and it's
not used anywhere else in the code).

Javier

--Apple-Mail=_457CFC07-E92E-4168-9173-8AEE28253AF5
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlrXNU0ACgkQIX4xUKFR
nnSKUA/+OTbeU+76Le3pvzM5zNIAsNhUY58fu9jPBVpYEbYgZX2C4ieY94K395az
dKAlSYF8aJ4ZQRKvgctyjXDHBJAj10c98n8cbz/i01Is3pw5uNsQWD3lnsFPUffe
Usrzt+mOXqkejATGDcpsYsL9vv9Hdjs8NweFsKDTkjc0SCEUnQBEy6Zd5QVyvYeB
A2z8OHrOJJ3i8c5wuAjpTO9zYaX88ZkSVNZJidj7wLa0bWtIrwoolClJg76rLth+
EHOa1mkvay5QhW/XeQa1sWbhcNuKl/L7X4wz9FXAphga92sFIYuWxT9Zdrm1qGGC
Q4ZTlSH7AjECNOxiLB77TedIz7ahwOiu5wfW8dS5Mk4VyjK7lxgMuPU0PdkVz8Oy
kJnIoqO/tyUFWXWfEGVj0CiQsN9sUaKHhz5hV4TtBP1S/DQH2bJVwUMrKX/goHuu
rXGas1/caijA4L6T5NECH92PI9Y9aQoHRCnYsm7slxuJSyrTpkMTqHDUJIV6lAZb
uyIBy+EqMrMTzpq+nLahZ9ZfKiudwi3Sp+4ouqypypCQhcrptA4n3gBvr/TmMxHa
ZloIbdj+I+zSPeyBW4LHozwzwkE7Z663uBi7h4rwiQpTZ34DsavQS7BbH+zBVO0L
MAz+xp32e6DOlksvQsc4aPl5f6vXnnQTMgOMnPLJUjbPKuxgHFA=
=H3sQ
-----END PGP SIGNATURE-----

--Apple-Mail=_457CFC07-E92E-4168-9173-8AEE28253AF5--
