Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752213AbeCXMbR (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 08:31:17 -0400
Received: from sauhun.de ([88.99.104.3]:40886 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751891AbeCXMbP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 08:31:15 -0400
Date: Sat, 24 Mar 2018 13:31:13 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: Rich Felker <dalias@libc.org>,
        "ysato@users.sourceforge.jp" <ysato@users.sourceforge.jp>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] i2c: pca-platform: additional improvements
Message-ID: <20180324123113.u6c3p4u3uxsv2gcc@ninjato>
References: <20170705101358.17458-1-chris.packham@alliedtelesis.co.nz>
 <20171029172918.2xtz2srh2meq45io@ninjato>
 <20171207104205.h5ejivdmtharmdln@ninjato>
 <8564c3ea3b3c4b08b940b02acf501722@svr-chch-ex1.atlnz.lc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sxbkkaxi7blcjj7k"
Content-Disposition: inline
In-Reply-To: <8564c3ea3b3c4b08b940b02acf501722@svr-chch-ex1.atlnz.lc>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--sxbkkaxi7blcjj7k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 23, 2018 at 03:39:47AM +0000, Chris Packham wrote:
> On 07/12/17 23:42, Wolfram Sang wrote:
> > On Sun, Oct 29, 2017 at 06:29:18PM +0100, Wolfram Sang wrote:
> >> On Wed, Jul 05, 2017 at 10:13:54PM +1200, Chris Packham wrote:
> >>> This series addresses some of the points identified by Andy. The seri=
es is
> >>> based on top of i2c/for-next. 2 of the patches from v1 have already b=
een
> >>> applied so I've dropped them from this version.
> >>>
> >>> I have compile tested patch 1/1 but I don't have access to sh hardware
> >>> to actually test the changes on.
> >>>
> >>> Chris Packham (4):
> >>>    sh: sh7785lcr: add GPIO lookup table for i2c controller reset
> >>>    i2c: pca-platform: unconditionally use devm_gpiod_get_optional
> >>>    i2c: pca-platform: use device_property_read_u32
> >>>    i2c: pca-platform: drop gpio from platform data
> >>>
> >>>   arch/blackfin/mach-bf561/boards/acvilon.c |  1 -
> >>>   arch/sh/boards/board-sh7785lcr.c          | 11 +++++++++-
> >>>   drivers/i2c/busses/i2c-pca-platform.c     | 34 +++++++++-----------=
-----------
> >>>   include/linux/i2c-pca-platform.h          |  3 ---
> >>>   4 files changed, 20 insertions(+), 29 deletions(-)
> >>
> >> Series looks good to me, too. I'd need ACKs from the SH maintainers,
> >> though. Technically, from Blackfin maintainers as well. But I haven't
> >> heard from them in months, so I could go without that.
> >=20
> > Adding Rich Felker to CC...
> >=20
>=20
> Ping. Was there any movement on this series? I think this may have been=
=20
> caught up between the holiday period and various merge windows.

Applied to for-next, thanks!


--sxbkkaxi7blcjj7k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlq2RREACgkQFA3kzBSg
KbaGLQ/+Pdv4MVTwB8owtCYe7Z278BRh/Rv/JHGLF8u4DXDeemsYlLr7j6iaP56V
B6jr1YCoPWEI/zeWHdzp5csrVeW7zOViIQ6UMJv8qcOKbBZCwuufktLTGXB3db36
+8r1c40uW2oRJyljP3MkwMbe0iqnXDUHDzxHmwXn6TqRleMxpHTcio/D+HzOH5LJ
mIvk2jdSP2eDKedZ21ZF3z4OZxUgIbo3RvF9R2q/fFCoU1y4vrK9PmiJ9N/fbGVj
7Qx0LBwPET/MS10S+vN2Z6kmivaJvRLzbpsHgHGcqrpAhxqV5I00kU9haO4/sHcv
b/UnLURAsG6Z8Fck3rzZY1Y3zkNHUJWhmth9bzRkXTacdhorhtwHGxExX6eE6uRd
qQt+hJOaG+26kPqVyy3pq3Sqi4/WspZJR8ekUGaLc8xdMTwAtSrLin9FBPZHHOaI
SGvKrAnkadcdchiHGXH4Twb1bE8czLVZxznhHOQwMe7RKeFJpHudVsJ5Mkt6wx73
WcAm8Bqg+YCxveZ9N5DwrXe5SJCrgHz0psxErPU74T7iCvjpH8l1j8cdZnJVZtvL
XlvXn156k6AFCVhFR6CZWfYtf/BYWIcXivduAkc6/G2vPsN2/nFN2mvBI6ejkR/q
4G2wghRF3fr3soEcesC+UEWHB6ayRYwVZ/WqfpY7G8PJJJtsXB8=
=0aTj
-----END PGP SIGNATURE-----

--sxbkkaxi7blcjj7k--
