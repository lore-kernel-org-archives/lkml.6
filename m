Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751819AbeEEA7A (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 20:59:00 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45094 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751742AbeEEA66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 20:58:58 -0400
Date: Sat, 5 May 2018 09:58:36 +0900
From: Mark Brown <broonie@kernel.org>
To: Yixun Lan <yixun.lan@amlogic.com>
Cc: Sunny Luo <sunny.luo@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>,
        linux-spi@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] spi: meson-axg: support MAX 80M clock
Message-ID: <20180505005836.GH13402@sirena.org.uk>
References: <20180503213645.20694-1-yixun.lan@amlogic.com>
 <20180503213645.20694-2-yixun.lan@amlogic.com>
 <20180503231305.GC13402@sirena.org.uk>
 <6cdee2c8-2ca4-2efb-43ac-c233516c0570@amlogic.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WRT3RXLOp/bBMgTI"
Content-Disposition: inline
In-Reply-To: <6cdee2c8-2ca4-2efb-43ac-c233516c0570@amlogic.com>
X-Cookie: Advancement in position.
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WRT3RXLOp/bBMgTI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 04, 2018 at 09:56:10AM +0800, Yixun Lan wrote:

> Here I only introduce the dt compatible data to differentiate the
> old/new controller, the compatible name is not changed, and none of the
> property is introduced.

Right, sorry - this bit is fine.

--WRT3RXLOp/bBMgTI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrtAbsACgkQJNaLcl1U
h9DsVgf+LqnN3HLv16oBmxxco+8CxcWop72eIF4qn90vel2bKF1kUnNoDofzGXSx
mjRjEmy4mg6BaT6ruLNrGZ2yM7MLX/oxXi+YIpuu7PLlGX/9mXt3ygwG6nB6jLpU
nklnM2W7gdYA2dFOhzrjR0AoydeGo+cfUZ8Hqr8+Jk8bwC4FjaREGR2kBAv2IOGB
Gtjdk1Ab6Jcwkkz+dcc5CXsuXQjDC1HpM7vgy+nOaIgvy/y/+8uDNgQxHTbRoQF1
zXrr2BbFHSaw5PeSuydtqrkCQICIf5ghqQQJWfdv4betuzdQpJ986HZ4RLjYzzrT
o4AyZWWkkc9gjX5YmB2TVmaniZNJuw==
=TrpF
-----END PGP SIGNATURE-----

--WRT3RXLOp/bBMgTI--
