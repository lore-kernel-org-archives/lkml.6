Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754484AbeDJPZa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 11:25:30 -0400
Received: from sauhun.de ([88.99.104.3]:41192 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754415AbeDJPZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 11:25:28 -0400
Date: Tue, 10 Apr 2018 17:25:26 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Joe Perches <joe@perches.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: remove me as maintainer for I2C host drivers
Message-ID: <20180410152526.grfhc7n4glj62yt3@ninjato>
References: <20180410141125.4477-1-wsa@the-dreams.de>
 <f0ce07bdb69602450ea1681936706b16962ce41f.camel@perches.com>
 <20180410144654.fg2pbvh4d2y3rucv@katana>
 <a3ffaea6a161e667854127d2e021a04034985a97.camel@perches.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="h4qyxy44mnw2iw54"
Content-Disposition: inline
In-Reply-To: <a3ffaea6a161e667854127d2e021a04034985a97.camel@perches.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--h4qyxy44mnw2iw54
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> I believe get_maintainer.pl is still going to do that for
> awhile as you are a commit signer for several of these driver
> files.

Okay, I forgot that I use "--no-git" in the config file. Still, while
not perfect, it is one step better.

> btw: You signed-off using 2 different addresses on one
> of those patches.  I think that's odd.
...
>     Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

I created this patch during work time.

>     Signed-off-by: Wolfram Sang <wsa@the-dreams.de>

But I applied it in my spare time.

I didn't find a better way to encode that.


--h4qyxy44mnw2iw54
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlrM12IACgkQFA3kzBSg
KbZfgg/9HNQfp+JsF4ORr1Gyhl4UWMuy4xzs9q4FhwGH4WaMkgNPUHgAN2Xlen6E
if3kQOQLKAN5x9UlQwNMwOK+jA2ghIQZo9TEbGIxyFtVA8+R1Y6+fnGi3mBwNuhB
geEQyF2y69s5TR3nuBMQYweq/rn4L3N03Rk19YFZU104Wkp2pxFFInDDsO3X+7D7
QXd2uvItW3MJP9QeS8VXVlXcd2nH+uEB5PONH0y+DoVfCw5YsfiOG0S5fwj6lxeq
iYOUYos8wXVxThrm7uUGVwP9oz55FGFu4scGJ5U5yLkl2ODvX57iknFe8lK/w9q3
eA7iTzENS37dNELf1xUTj+x/yaTT8F8YbnE6NC9AdHSK2hZ1dffwnFKRyll5erYs
pUcGNM+OOTTXK6TkISe4A+zRTXt2d+L60qLuJNgZ6+fVblUjnnWyrbSLnlO048zB
vnzjo7Y8BvZw9IhfpArmKbEVh993Tl3FAMPj5ytERJn9Lka2DfyBURz+5z4a0zzp
2z1TnuEFW6r1/laOkY+23k95meFwElNBII/BgETkgldrHLjvD2rkbTdUq+l+UuIs
ZIt1iItVXPIweHPlz2q2720yvt+waEUa2FQIh5u74svwnQJtiRz8BVjRq8AYmbTC
OE8h+H6FI7R9YLnJf7NkS11ajf17NekFyMt7TBAws5txOon+WDo=
=PUdp
-----END PGP SIGNATURE-----

--h4qyxy44mnw2iw54--
