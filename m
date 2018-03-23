Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751718AbeCWHu7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 03:50:59 -0400
Received: from sauhun.de ([88.99.104.3]:59950 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751294AbeCWHu5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 03:50:57 -0400
Date: Fri, 23 Mar 2018 08:50:54 +0100
From: Wolfram Sang <wsa@the-dreams.de>
To: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc: Rich Felker <dalias@libc.org>,
        "ysato@users.sourceforge.jp" <ysato@users.sourceforge.jp>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] i2c: pca-platform: additional improvements
Message-ID: <20180323075054.jbmoijyikoy5rxgt@ninjato>
References: <20170705101358.17458-1-chris.packham@alliedtelesis.co.nz>
 <20171029172918.2xtz2srh2meq45io@ninjato>
 <20171207104205.h5ejivdmtharmdln@ninjato>
 <8564c3ea3b3c4b08b940b02acf501722@svr-chch-ex1.atlnz.lc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dy3hz6x2vm2qzpbc"
Content-Disposition: inline
In-Reply-To: <8564c3ea3b3c4b08b940b02acf501722@svr-chch-ex1.atlnz.lc>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dy3hz6x2vm2qzpbc
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
>=20
> Just wanted to check if there was anything I need to be doing to get=20
> this through.

No, there wasn't. I was waiting for ACKs from the maintainers, but
checking the arch/sh/-git-history, the last action I see from them is
~18 months ago. So, I'll pick up your patches without those acks...


--dy3hz6x2vm2qzpbc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlq0sdoACgkQFA3kzBSg
KbZSKRAAmNS+tvB4q/eISEo9CnYscjptJWUdYVzx6yl3DCAIpvxNOTJS1DAZl/XR
Axbj4ixJZBVcprS9ptgSYQWTeVCjpuq1xlN+pV6P1kBnzDIN4qi3yEnyTy3NVecE
UguPozfWcz25Vzqvat7NJGJ0CYAY7U3qM1Rpy4OFch1aCEEtYdvrcfLsf1odN3HT
jFcN1L8kHBlm6yakRe/kqZtPhE28CTrCL1cOgoMvTpEh61oRXW4vqQNh1Te5uaUW
3RpS8rjjfufhRJ+Gho8fpfC0q3dbfWExKZZeydKQOV+zPDnouWHlXZLd5qQpVhV9
JcsifL69+Uelu+CFxeZ399AsseIViEDgaDojT2DYI8HN+w0eMAQoHwjVzS6iQTuY
6jz+kEEymqfJKifC/GMYdwIfomU5Jlqjhi/pdPUTSB6IU+ylxXFuQ8+SmMQ/O2ji
msSdh8iXXMnL8GpAriVamQ7IvsPbEbf2wZx4b1hdhfVud+Qx7AiQ9q1ED1FA8pJf
crGdMgwWDkg6Hx3xh8QbGHJnjVsfTRsjEVi6agesaIhBsGPbNN/XFj/Qrm6OwLwq
p56/SjCuUL49NsZwEPrY9sw1PFzp7H8od/CsIdyknRsGX6Noh0kK61c9K93AroPm
E4YoKoFL5xcW8+2ZYKtaXO5nBdsoPd8Meh9VXbDoUtAzZdOGUU0=
=IFQ9
-----END PGP SIGNATURE-----

--dy3hz6x2vm2qzpbc--
