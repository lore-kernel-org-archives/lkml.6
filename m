Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423534AbeE1MSq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 08:18:46 -0400
Received: from mail-dm3nam03on0047.outbound.protection.outlook.com ([104.47.41.47]:51080
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1164678AbeE1LCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:02:45 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: Jens Axboe <axboe@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marcin Dziegielewski <marcin.dziegielewski@intel.com>,
        "Konopko, Igor J" <igor.j.konopko@intel.com>
Subject: Re: [GIT PULL 18/20] lightnvm: pblk: handle case when mw_cunits
 equals to 0
Thread-Topic: [GIT PULL 18/20] lightnvm: pblk: handle case when mw_cunits
 equals to 0
Thread-Index: AQHT9nNmZ5d7NBWAqUW0dpHncmqcfg==
Date: Mon, 28 May 2018 11:02:43 +0000
Message-ID: <54B2CCDB-B869-4087-8AE2-2AC73381B1FF@cnexlabs.com>
References: <20180528085841.26684-1-mb@lightnvm.io>
 <20180528085841.26684-19-mb@lightnvm.io>
In-Reply-To: <20180528085841.26684-19-mb@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com;
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB491;7:nbmKbYYSF9jufx2UuAWXd99L/VdAR7yg6o7cP7DwYSIyIoYgoBEI+DdYLyZFDvcrbK4xVtZsfesKmTDC2a7ce+5j2bQ5oHXEbzPJHPFZ32i/6QneuUg6KUw3PescvVwY6NgKeSwAQvJLdGgbF85x1CuuxZn7coU0xRSFlclPFLoTBsrcutVEGZvScLc4U7YXZkEqtY3Fj+CjLJoKTD5wbDYqC2K++RrLuU2kjRu5jQICVXbhdKhdJGX3Kje78oX9
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(49563074)(7193020);SRVR:CO2PR06MB491;
x-ms-traffictypediagnostic: CO2PR06MB491:
x-microsoft-antispam-prvs: <CO2PR06MB491F923559E65576BF32437BA6E0@CO2PR06MB491.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:CO2PR06MB491;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB491;
x-forefront-prvs: 06860EDC7B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39830400003)(396003)(366004)(376002)(346002)(39380400002)(189003)(199004)(8676002)(81156014)(8936002)(36756003)(6246003)(186003)(26005)(99286004)(66066001)(6116002)(4326008)(7736002)(106356001)(3846002)(6486002)(33656002)(81166006)(105586002)(6506007)(2616005)(446003)(476003)(11346002)(5660300001)(305945005)(229853002)(6512007)(82746002)(53936002)(5250100002)(102836004)(6436002)(76176011)(6916009)(486006)(86362001)(14454004)(2906002)(3280700002)(316002)(25786009)(68736007)(97736004)(83716003)(54906003)(99936001)(2900100001)(478600001)(3660700001)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB491;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: sM6aexj99mSUT4m+pCpHImZeHAk3FnYTKNbQIh5Y1IFpSprirWYqDQQmGnQGUIhz/wkm7TJ3pLSpGIVWpzLdthyJipcuycXOfQ5BzsSBkdWSc5L+mSyCs848/NvjehWPgqbHu38CTLp6agc48OMpIlN8/pbke3p4d6QQhsg3ILic4j9+uHnqC0amCzZP4XTy
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_546A7123-79FB-4016-A5C3-2B192E5D9485";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 607d2810-ea29-4b20-6203-08d5c48a8953
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 607d2810-ea29-4b20-6203-08d5c48a8953
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2018 11:02:43.0173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB491
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_546A7123-79FB-4016-A5C3-2B192E5D9485
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 28 May 2018, at 10.58, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> From: Marcin Dziegielewski <marcin.dziegielewski@intel.com>
>=20
> Some devices can expose mw_cunits equal to 0, it can cause creation
> of too small write buffer and cause performance to drop on write
> workloads.
>=20
> To handle that, we use the default value for MLC and beacause it
> covers both 1.2 and 2.0 OC specification, setting up mw_cunits
> in nvme_nvm_setup_12 function isn't longer necessary.
>=20
> Signed-off-by: Marcin Dziegielewski <marcin.dziegielewski@intel.com>
> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
> Signed-off-by: Matias Bj=C3=B8rling <mb@lightnvm.io>
> ---
> drivers/lightnvm/pblk-init.c | 10 +++++++++-
> drivers/nvme/host/lightnvm.c |  1 -
> 2 files changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-init.c =
b/drivers/lightnvm/pblk-init.c
> index d65d2f972ccf..0f277744266b 100644
> --- a/drivers/lightnvm/pblk-init.c
> +++ b/drivers/lightnvm/pblk-init.c
> @@ -356,7 +356,15 @@ static int pblk_core_init(struct pblk *pblk)
> 	atomic64_set(&pblk->nr_flush, 0);
> 	pblk->nr_flush_rst =3D 0;
>=20
> -	pblk->pgs_in_buffer =3D geo->mw_cunits * geo->all_luns;
> +	if (geo->mw_cunits) {
> +		pblk->pgs_in_buffer =3D geo->mw_cunits * geo->all_luns;
> +	} else {
> +		pblk->pgs_in_buffer =3D (geo->ws_opt << 3) * =
geo->all_luns;
> +		/*
> +		 * Some devices can expose mw_cunits equal to 0, so =
let's use
> +		 * here default safe value for MLC.
> +		 */
> +	}
>=20
> 	pblk->min_write_pgs =3D geo->ws_opt * (geo->csecs / PAGE_SIZE);
> 	max_write_ppas =3D pblk->min_write_pgs * geo->all_luns;
> diff --git a/drivers/nvme/host/lightnvm.c =
b/drivers/nvme/host/lightnvm.c
> index 41279da799ed..c747792da915 100644
> --- a/drivers/nvme/host/lightnvm.c
> +++ b/drivers/nvme/host/lightnvm.c
> @@ -338,7 +338,6 @@ static int nvme_nvm_setup_12(struct nvme_nvm_id12 =
*id,
>=20
> 	geo->ws_min =3D sec_per_pg;
> 	geo->ws_opt =3D sec_per_pg;
> -	geo->mw_cunits =3D geo->ws_opt << 3;	/* default to MLC safe =
values */
>=20
> 	/* Do not impose values for maximum number of open blocks as it =
is
> 	 * unspecified in 1.2. Users of 1.2 must be aware of this and =
eventually
> --
> 2.11.0

By doing this, 1.2 future users (beyond pblk), will fail to have a valid
mw_cunits value. It's ok to deal with the 0 case in pblk, but I believe
that we should have the default value for 1.2 either way.

A more generic way of doing this would be to have a default value for
2.0 too, in case mw_cunits is reported as 0.

Javier


--Apple-Mail=_546A7123-79FB-4016-A5C3-2B192E5D9485
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlsL4dAACgkQIX4xUKFR
nnSKshAAkdcTIrvO8vsPZqwryh0tsEh4CawV7n4kB8wxTWEZEqTiusIObxyHsx+U
0ZeZI+FLmI4gxb9J7fNzTs7tge+gXUEUQpeRi9U+6cfE7HXC8Tlc/taqT8npxebx
bpeOvr5zLPlo2yRTSCa1OveZoDhz+uG/fd/LAOXG24r+2pR+dlZvkQZBptHywyiQ
Q/jWdm/qhuXldRniz76ahiUYbtblrolx3K94y0CDVTnM1li33xmjlBw6jPckg2+7
Dyt/t43/Rldoce3WBsXGOSiA6GoDixnaMyhPijcAZwT1RxqvuzTGc6bAB3otep/3
Q/tF7DX/yJUTp6paRZF0yMzeat6r+mDcAMfIYqsjTOGS2Avdd79OJDhQtTPn9j8o
8jzrvKAivdEy/LsZyOxjIZF+pXMQ50Dt2CAIhPIlX4Oz8e+YZOifv74jQTh56CsL
80P0tFrBu22J1wrMYCJlyzdtYvvBSn1obcnpZ/C7w/1j8crge3uBUBm2ZrEx6jtO
h92bAoUqB+ojdnTPDYaK7AiL/qmL1RvXgWLiNewVp1DiyCT1TECKguf2SI0GKFJR
upilYJnkEYnG0Owr0mTyKq5XYGdv4tn8KbCICTCQkHapXGAkrnTq+/322vFEhMzM
mmKcmroMlVZWIvC/d9YSYZswA/nDmDaSix3L7l5IMU/HbwQnRoU=
=kcEi
-----END PGP SIGNATURE-----

--Apple-Mail=_546A7123-79FB-4016-A5C3-2B192E5D9485--
