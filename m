Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753999AbeDJOq5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 10:46:57 -0400
Received: from www.zeus03.de ([194.117.254.33]:34324 "EHLO mail.zeus03.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753149AbeDJOq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 10:46:56 -0400
X-UD-Smtp-Session: l3s3148p1@hiXxl39p9pMgAwDPW8txAAId4P/+oMhl
Date: Tue, 10 Apr 2018 16:46:54 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: Joe Perches <joe@perches.com>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: remove me as maintainer for I2C host drivers
Message-ID: <20180410144654.fg2pbvh4d2y3rucv@katana>
References: <20180410141125.4477-1-wsa@the-dreams.de>
 <f0ce07bdb69602450ea1681936706b16962ce41f.camel@perches.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zbllqjolnqtxdax7"
Content-Disposition: inline
In-Reply-To: <f0ce07bdb69602450ea1681936706b16962ce41f.camel@perches.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zbllqjolnqtxdax7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> As far as I understand, all this seems correct to me.

Good. Thank you, Joe!

> You want to maintain the core files in drivers/i2c/
> but not any files in any of algos/, busses/, or muxes/.

More specific: I don't want get_maintainer.pl to print me as a
maintainer for these drivers. This gives a wrong impression to users. I
am not actively maintaining these drivers, I am collecting the odd
fixes (and also review some of them as time permits).

> You might also want to specify which of the
> include/linux/i2c-*.h files you actually want to oversee
> as well.  It seems some are driver specific.

I am just now working on that. Most of them can easily be moved to
platform_data.

> But the git entry for the drivers seems maybe a bit of an issue.  Are
> you intending to somehow pick up patches approved by the i2c
> community?

Yes, I will still be doing that. I think I will also be the one doing
most review for those odd fixes nonetheless.


--zbllqjolnqtxdax7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlrMzloACgkQFA3kzBSg
KbYzKBAApv1Ex0A54fCqYM629/6Rxw/k7yU+dFeYBPuss+YUFYgnVINRdgSI9n8E
pmLiFkTImNwVlMozVD9AxJO6FukuWKyapG/amBwU6E8b90eLD8bg0ZZHXeIFoTxc
rXXxMNBUm3nCu1a2I30PM3D/2I+Mz9sO6Fbyww2hc7q7ithFBjIJ+RjOuBb5EwnZ
WSTHbZKsZujKL8CErDL8Y8qWwdlnCYFQsZhlsY0gHeftldMbzXT5IHPmneRjg003
DJmviVkwNBm27ogwRki339OPp6hOotVhJV6e5ZImgmpy0xYjPrQRS+pqkyQ68oLs
BywyIXNB4QSz26MxNqF2sIypZy+fe+8TMg3zXLFgxunT6tID4GzGFEhpAQwxXglt
RHsN8zA6uvkszCkDVnX5hMG5y1kENbjX5KSpC882gyyqpzQaqgg/W/1vb7jfylBF
FzOJiUoQP8uVk6rEzDXvskR+GHGzvVwOAembCKu3QqUCjnfa7Q0HLOr1Gv+0KnMG
WlfbrTsW0/PYg3Qp2GV2duueg+NhlYfM5CC8bO+GBJjqtTHMC8XZqZq0dQkVc5AK
gbFb14avPkGjbH/Mvf5t1RcwiRW5IoxzoL6M8Ln81E+Rt7GkNH7E5dKvwNqQ2lZJ
da64Ofik65/ktyUdvDMnISjJw4tuhcSSNzzsej9rZVlPHSTIY58=
=Giub
-----END PGP SIGNATURE-----

--zbllqjolnqtxdax7--
