Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754309AbeCGK5i (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 05:57:38 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56800 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754248AbeCGK5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 05:57:34 -0500
Date: Wed, 7 Mar 2018 10:57:31 +0000
From: Mark Brown <broonie@kernel.org>
To: JeffyChen <jeffy.chen@rock-chips.com>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 1/3] mfd: syscon: Set name of regmap_config
Message-ID: <20180307105731.GB7290@sirena.org.uk>
References: <20180306110403.14438-1-jeffy.chen@rock-chips.com>
 <5A9EAC92.4050702@rock-chips.com>
 <20180307102006.GA7290@sirena.org.uk>
 <5A9FC3E0.5020600@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zx4FCpZtqtKETZ7O"
Content-Disposition: inline
In-Reply-To: <5A9FC3E0.5020600@rock-chips.com>
X-Cookie: If you can read this, you're too close.
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zx4FCpZtqtKETZ7O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 07, 2018 at 06:50:08PM +0800, JeffyChen wrote:

> so i sent this patch to fix that by using the of_node name to create
> debugfs.

> but later i found we have:
> commit a430ab205d29e7d1537b220fcf989b8080d8267f
> Author: Fabio Estevam <fabio.estevam@nxp.com>
> Date:   Mon Mar 5 15:52:09 2018 -0300

>     regmap: debugfs: Disambiguate dummy debugfs file name

> which would fix that in another way by naming dummy0, dummy1, dummy2.

> even if the issue is fixed, i wonder could we still have this patch to make
> it more readable:

Yes, like I say I think that's a good idea anyway - that sort of usage
is the reason we've got the facility to set an explicit name.

--zx4FCpZtqtKETZ7O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlqfxZoACgkQJNaLcl1U
h9APdQf/Q4izSNZYh9F/+UF/EwZCfLz7J8XPU0TVpPb3wdPnW7WMf/7RdASgEPDI
1LJrJyaNH3t5ocY5n4mCdf8msE8yFFU/Wu5YfySh6OM+zflqlGBlP0+HVsRYzuB0
pzPlebOdoSY1xfCmstUKkQfmJx3zB7DzBmb9FAK8M37m2eh9bpc/6Ci1hByfqF+W
fHy0Md2SPJHML856OHKbm5A2qBrjME+VeMgmiE4WQ0K3Bq6Pu21BF5OZcMNjNWOV
WZQ9XPLfLhbFQO7Z3Ld77GNBndP2VzdnkGYpXa+4i2it7nDeO5g+GPmBgWWlxoAL
yetsi8AlszM9QFB/b7/OS4xibQWSoA==
=XCW5
-----END PGP SIGNATURE-----

--zx4FCpZtqtKETZ7O--
