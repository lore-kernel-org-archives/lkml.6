Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752809AbeD3JTc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 05:19:32 -0400
Received: from mail-co1nam03on0087.outbound.protection.outlook.com ([104.47.40.87]:29424
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751511AbeD3JT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 05:19:28 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: Hans Holmberg <hans.ml.holmberg@owltronix.com>
CC: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: Re: [PATCH v2 3/3] lightnvm: pblk: fix smeta write error path
Thread-Topic: [PATCH v2 3/3] lightnvm: pblk: fix smeta write error path
Thread-Index: AQHT24+GdTq6T0vLJ0OSTqIjMM1W6KQZEYOA
Date: Mon, 30 Apr 2018 09:19:25 +0000
Message-ID: <E2E27D56-61CE-4882-8D78-1427CF70CE7A@cnexlabs.com>
References: <1524548732-4326-1-git-send-email-hans.ml.holmberg@owltronix.com>
 <1524548732-4326-4-git-send-email-hans.ml.holmberg@owltronix.com>
In-Reply-To: <1524548732-4326-4-git-send-email-hans.ml.holmberg@owltronix.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com;
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB489;7:PT5KN99Ytvd1f158JODvJDt/WLSOlWPcEjVXl7TikY6bqjD7Hex0GAtkT9/50jgaUWEFnl5m0C8ZFZ8V/L8qNb5RXDmDD743yqg/sEUCexRoVfbC6XZlwbqFqRWimKT+EIm/8dgxF1s0de/IVuD408453jf4RSSiQMTr24Y7gGqm/B4a7JGjFkSJRim6lOaqxUgx5EoCGQI36H4shXQODdzdveTnS0URcNwgsdAn6qNtddcq6FVv6dB5YwF030nO
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(376002)(346002)(39830400003)(366004)(396003)(39380400002)(199004)(189003)(486006)(2616005)(476003)(6512007)(11346002)(107886003)(446003)(6486002)(81166006)(81156014)(36756003)(66066001)(5660300001)(478600001)(53936002)(229853002)(83716003)(105586002)(14454004)(5250100002)(106356001)(86362001)(6246003)(82746002)(305945005)(54906003)(6506007)(97736004)(102836004)(33656002)(6916009)(2900100001)(26005)(186003)(68736007)(76176011)(8676002)(2906002)(25786009)(6116002)(99936001)(3280700002)(3660700001)(4326008)(8936002)(7736002)(3846002)(6436002)(99286004)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB489;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(49563074)(7193020);SRVR:CO2PR06MB489;
x-ms-traffictypediagnostic: CO2PR06MB489:
x-microsoft-antispam-prvs: <CO2PR06MB48960B34A69A9E9C3E58D6ABA820@CO2PR06MB489.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:CO2PR06MB489;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB489;
x-forefront-prvs: 0658BAF71F
x-microsoft-antispam-message-info: 2ogjgWFUzT2C7azF9WhMJrf7ZvViw3pZPMTaMYhnsMqTmLksHFT0iyIhMOaKUYlnxxetd0W+PY5wWaS8sIg/+PPD/6xDo5/roBiCX7euhhl3KRwYCCSZ3aRJIbjOwSjgk1ohJG9vP6mbgl/Vyt/wta4dEmIkU7cZmt53UpuzNkPqCYGihbNEbfu77/NchAD6
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_458DC4B9-5053-4139-9D6C-1FBF03526C97";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: c863d170-c718-430e-2d9c-08d5ae7b781e
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c863d170-c718-430e-2d9c-08d5ae7b781e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2018 09:19:25.9903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB489
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_458DC4B9-5053-4139-9D6C-1FBF03526C97
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

> On 24 Apr 2018, at 07.45, Hans Holmberg =
<hans.ml.holmberg@owltronix.com> wrote:
>=20
> From: Hans Holmberg <hans.holmberg@cnexlabs.com>
>=20
> Smeta write errors were previously ignored. Skip these
> lines instead and throw them back on the free
> list, so the chunks will go through a reset cycle
> before we attempt to use the line again.
>=20
> Signed-off-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
> ---
> drivers/lightnvm/pblk-core.c | 7 ++++---
> 1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
> index 413cf3b..dec1bb4 100644
> --- a/drivers/lightnvm/pblk-core.c
> +++ b/drivers/lightnvm/pblk-core.c
> @@ -849,9 +849,10 @@ static int pblk_line_submit_smeta_io(struct pblk =
*pblk, struct pblk_line *line,
> 	atomic_dec(&pblk->inflight_io);
>=20
> 	if (rqd.error) {
> -		if (dir =3D=3D PBLK_WRITE)
> +		if (dir =3D=3D PBLK_WRITE) {
> 			pblk_log_write_err(pblk, &rqd);
> -		else if (dir =3D=3D PBLK_READ)
> +			ret =3D 1;
> +		} else if (dir =3D=3D PBLK_READ)
> 			pblk_log_read_err(pblk, &rqd);
> 	}
>=20
> @@ -1120,7 +1121,7 @@ static int pblk_line_init_bb(struct pblk *pblk, =
struct pblk_line *line,
>=20
> 	if (init && pblk_line_submit_smeta_io(pblk, line, off, =
PBLK_WRITE)) {
> 		pr_debug("pblk: line smeta I/O failed. Retry\n");
> -		return 1;
> +		return 0;
> 	}
>=20
> 	bitmap_copy(line->invalid_bitmap, line->map_bitmap, =
lm->sec_per_line);
> --
> 2.7.4

LGTM

Reviewed-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>


--Apple-Mail=_458DC4B9-5053-4139-9D6C-1FBF03526C97
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlrm35cACgkQIX4xUKFR
nnQDUBAA0eiAh9qCF3v0+BO8Gg2bv0P+xq7Bknyt3e10uJbbmcHfClOozEY/uHVp
TKTd117O/sx9JgduHw8zZt3u7NPguVLEs88JoRvSPR3ty49AXpbVbEodjC651a65
lahlbBMO6mn83LiVxbxzexFbtAhHeRXbGb8lvQyXxDs8wF1+beSbT+7WfZxCLjzO
+R6CzKlsF7B7KUj5XLV55ZghG0M7HIa6WtsS75nhYgxyfT+I4YpRonzUciIEmPcw
2wWP1zCil/T+YzqUpF8idgALtjdjWeJgD/uahncpolGwA/95gXAticFChj3VQML9
01iRB5wIbHDTioSlXsC9BV10LDWbYVSFLznP4JFEw5TeAeJU7TG++Pwjyc8oHiiT
7pZyKxVW3eukL9IAWIA6lSOLw/xv4TOwv1igXPg4UFEqCC4iMQMGsWnLWBsDoufh
+wEzrdoGrpmJvSc1ZDU3470pAEXhuuJksIisZl1cYYI+i1khcG+SWc14cQ6zn77T
u3a+kHq47qzPb6w1oEe7TPzWe8mF7MH0GWIww/XyoZg2kXw4nPRS3k0K1a3PGcw7
5WPbh4Lxz4O7hSIVhnyQ0XgxsYRlDK9j/Ut5+cc/x/c6j2zTdYDtHoW1Thu2iIWU
xRbwJ6NcV6DiPLeK7lwHLbz59EixN0hjjPXLCSRQqnRvk3vB73o=
=t/dS
-----END PGP SIGNATURE-----

--Apple-Mail=_458DC4B9-5053-4139-9D6C-1FBF03526C97--
