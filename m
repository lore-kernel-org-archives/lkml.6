Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163848AbeE1Kvj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:51:39 -0400
Received: from mail-dm3nam03on0062.outbound.protection.outlook.com ([104.47.41.62]:24992
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1163822AbeE1Kv2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:51:28 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: Jens Axboe <axboe@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Konopko, Igor J" <igor.j.konopko@intel.com>,
        Marcin Dziegielewski <marcin.dziegielewski@intel.com>
Subject: Re: [GIT PULL 20/20] lightnvm: pblk: sync RB and RL states during GC
Thread-Topic: [GIT PULL 20/20] lightnvm: pblk: sync RB and RL states during GC
Thread-Index: AQHT9nHSfyo6oPsnlE6x4Tk+86i2sA==
Date: Mon, 28 May 2018 10:51:24 +0000
Message-ID: <23C83C0A-B4FC-4472-B88B-4C7725F793FD@cnexlabs.com>
References: <20180528085841.26684-1-mb@lightnvm.io>
 <20180528085841.26684-21-mb@lightnvm.io>
In-Reply-To: <20180528085841.26684-21-mb@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CO2PR06MB681;7:d7ZSVSHDFQ1b3wdavISkykTi7FGSy4mzpv4uNTQruKsGpLjEnr9259JpQg0QcrvuI8HcK0DeJCUZ4u+2SvRorjUwcPtu82sxrkHb/bD52zybrybN8HPjaA/L66LXioEVZpWmdKlSWasefoxprtZEgfYyCz5qtjpYosPJhOvBcdedmbUT7c51cz1kAAqFFpoKVyyMEvrmjkAMcik4aPQmTuftok30HaJQtwY5UpuChoUGDT8ly0GLr12ZQuV9p3cw
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(49563074)(7193020);SRVR:CO2PR06MB681;
x-ms-traffictypediagnostic: CO2PR06MB681:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com;
x-microsoft-antispam-prvs: <CO2PR06MB68160BEABFB2A4023566C0ABA6E0@CO2PR06MB681.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:CO2PR06MB681;BCL:0;PCL:0;RULEID:;SRVR:CO2PR06MB681;
x-forefront-prvs: 06860EDC7B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(39380400002)(39830400003)(396003)(376002)(346002)(51444003)(189003)(199004)(2900100001)(53936002)(106356001)(2906002)(6916009)(99936001)(14454004)(36756003)(102836004)(66066001)(229853002)(4326008)(33656002)(5250100002)(82746002)(476003)(83716003)(11346002)(2616005)(105586002)(97736004)(486006)(6116002)(3280700002)(3846002)(86362001)(5660300001)(26005)(3660700001)(6486002)(25786009)(6436002)(76176011)(81156014)(8676002)(316002)(446003)(54906003)(81166006)(305945005)(59450400001)(186003)(478600001)(6246003)(8936002)(99286004)(68736007)(6512007)(6506007)(7736002)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:CO2PR06MB681;H:CO2PR06MB538.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: eioqh8EOzUMkQG/T0AKXMUftryTiHAxKo+fEm5aBCFAe4GGFmMvJg82RuOhpiqY9JkPS7eG3S6AMbTr/bP7IHRiIkF6bcMC9ivIPLhPlWyk3n/QHMtxNeyzNIQwqqcV6zrkaXeAc96Qw3XNN1kY31c9HmvTimko6lu1KgXeOf1xgmO2+rEH2MLbG2jdYSkMX
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_19158A6F-01B5-4520-B846-F99284BF0963";
        protocol="application/pgp-signature"; micalg=pgp-sha512
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 788f6d83-4b76-4cb7-98ee-08d5c488f514
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 788f6d83-4b76-4cb7-98ee-08d5c488f514
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2018 10:51:24.8376
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR06MB681
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Apple-Mail=_19158A6F-01B5-4520-B846-F99284BF0963
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Javier

I somehow missed these patches in the mailing list. Sorry for coming
with feedback this late. I'll look at my filters - in any case, would
you mind Cc'ing me in the future?

> On 28 May 2018, at 10.58, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> From: Igor Konopko <igor.j.konopko@intel.com>
>=20
> During sequential workloads we can met the case when almost all the
> lines are fully written with data. In that case rate limiter will
> significantly reduce the max number of requests for user IOs.

Do you mean random writes? On fully sequential, a line will either be
fully written, fully invalidated or on its way to be written. When
invalidating the line, then the whole line will be invalidated and GC
will free it without having to move valid data.

>=20
> Unfortunately in the case when round buffer is flushed to drive and
> the entries are not yet removed (which is ok, since there is still
> enough free entries in round buffer for user IO) we hang on user
> IO due to not enough entries in rate limiter. The reason is that
> rate limiter user entries are decreased after freeing the round
> buffer entries, which does not happen if there is still plenty of
> space in round buffer.
>=20
> This patch forces freeing the round buffer by calling
> pblk_rb_sync_l2p and thus making new free entries in rate limiter,
> when there is no enough of them for user IO.

I can see why you might have problems with very low OP due to the rate
limiter, but unfortunately this is not a good way of solving the
problem. When you do this, you basically make the L2P to point to the
device instead of pointing to the write cache, which in essence bypasses
mw_cuints. As a result, if a read comes in to one of the synced entries,
it will violate the device-host contract and most probably fail (for
sure fail on > SLC).

I think that the right way of solving this problem is separating the
write and GC buffers and then assigning tokens to them. The write thread
will then consume both buffers based on these tokens. In this case, user
I/O will have a buffer for itself, which will be guaranteed to advance
at the rate the rate-limiter is allowing it to. Note that the 2 buffers
can be a single buffer with a new set of pointers so that the lookup can
be done with a single bit.

I have been looking for time to implement this for a while. If you want
to give it a go, we can talk and I can give you some pointers on
potential issues I have thought about.

Javier

--Apple-Mail=_19158A6F-01B5-4520-B846-F99284BF0963
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlsL3yoACgkQIX4xUKFR
nnTmiBAAqAAD52nq7BgfThyzUSFH03IaMN0DEGIVSkhA3ihll2jsB1STLJS3mnFD
Mdc4xKE6kV/ZN/U+lz3tLq4ig0QGbGxmX3zkqZf97WyPWmacZ6mzUim78N4eTrvT
YEDdXJM3EZGZ4t/XzSTOh8WavT5o/WUiQ4Mb8MxNH/523Z6Qh/r7CdNxcvTQZAqQ
ifBFoeWYH7Rg3NtPYkdQFOf1U5LuvE0YXPF5BcJza1oe7WG9A1vYzHFB7JTFmFrV
RFDGRz0rM0IoM8Ot6tBogSHue/mlFobc2ELJ/oFZPgU0HKxrvYl+6FH8v16gw//k
uvz+cVd1DRzLWyjHsDl+ODck6eXkwELnqfzT0h4CyppwHWkS+Cl6m5I2BluYnucb
AJ99ASDytDKLl1VAprrmkmLCEIRuW8zspr2ZMNivgIxoHM+QAMA82MZkqM7m8Uk7
D/nHZtXcPs+AKsxYYi4mL6uOnLGKCOdLdf/mN1xzekRyyPpm5/ycARep3/qYAB/b
T24cUUcgtGNdGzylvGKlxijpqiDrES8l/Z8xbwI0rV+saOiuliLMQ4VHAIUeJalm
wy+e+Y31z8MOxRPkhYNFv8NepRf4LkVtFbn94oTKE3CKyiSO7ivyKryGExJH69TL
zCpi/9ZLmNzfdKMEyzyVmRxQZLilxQ9LLppiVB+vIdHyNt3cwTU=
=Bm02
-----END PGP SIGNATURE-----

--Apple-Mail=_19158A6F-01B5-4520-B846-F99284BF0963--
