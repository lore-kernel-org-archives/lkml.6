Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936426AbeE2O4E (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 10:56:04 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33066 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935482AbeE2Oyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 10:54:40 -0400
Date: Tue, 29 May 2018 15:54:36 +0100
From: Mark Brown <broonie@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Alexander Shiyan <shc_work@mail.ru>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Daniel Mack <zonque@gmail.com>, Marc Zyngier <marc.zyngier@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH 15/19 v3] regulator: fixed/gpio: Pull inversion/OD into
 gpiolib
Message-ID: <20180529145436.GJ23509@sirena.org.uk>
References: <20180514080640.12515-1-linus.walleij@linaro.org>
 <20180514080640.12515-16-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BEa57a89OpeoUzGD"
Content-Disposition: inline
In-Reply-To: <20180514080640.12515-16-linus.walleij@linaro.org>
X-Cookie: Variables don't
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BEa57a89OpeoUzGD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 14, 2018 at 10:06:36AM +0200, Linus Walleij wrote:

>  arch/arm/mach-pxa/hx4700.c                    |  3 +-

This doesn't apply against the above file in my tree, please check and
resend.

--BEa57a89OpeoUzGD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsNaasACgkQJNaLcl1U
h9CG7gf/RL9REmvD5DqxizjxuG7DraAgaYr15LREMRKRI7W0IIZcWNMzJwYkS/0o
c7LeyivlKBfgC6ev7dEpuU53d4KQ5dyOlAcwBmwo66ym7xh4Y2vBCKB5yGvifxxN
74xVwvb6//bJFgeUb5vJrJU98P7Ka0z9JdBQalIzOjD2Hjf5gHMQdZ6QcW1q8Jht
bQbm7gA3WDpHJLaE/1BP1x9P+H0ljNvma3fqCbiE6sG2WHoHTpE4GDgkWHXBgtG2
D3N0mwAbnfu1GRJU2kVvrjSfgI1ZUlSEHUfTMAhTI0yJdqCnm5v94OG1muKXTYNm
bZN6RhPRzJuizDZLxHWrtLhjTX0dbQ==
=P2Zu
-----END PGP SIGNATURE-----

--BEa57a89OpeoUzGD--
