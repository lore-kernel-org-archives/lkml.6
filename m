Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751297AbeFAKVb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 06:21:31 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48730 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750831AbeFAKVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 06:21:30 -0400
Date: Fri, 1 Jun 2018 11:21:22 +0100
From: Mark Brown <broonie@kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexander Shiyan <shc_work@mail.ru>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Philipp Zabel <philipp.zabel@gmail.com>,
        Daniel Mack <zonque@gmail.com>, Marc Zyngier <marc.zyngier@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH 01/19 v3] regulator: fixed: Convert to use GPIO
 descriptor only
Message-ID: <20180601102122.GA8677@sirena.org.uk>
References: <20180514080640.12515-1-linus.walleij@linaro.org>
 <20180514080640.12515-2-linus.walleij@linaro.org>
 <20180601093511.GA11734@ulmo>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
In-Reply-To: <20180601093511.GA11734@ulmo>
X-Cookie: OS/2 must die!
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 01, 2018 at 11:35:11AM +0200, Thierry Reding wrote:

> >  	cfg.ena_gpio_invert = !config->enable_high;

> Change this line to:

> 	cfg.ena_gpio_invert = false;

> fixes the regression and is pretty much the implementation of my above
> suggestion to ignore enable-active-high, though we may eventually want
> to get rid of ena_gpio_invert altogether, provided that everyone has
> moved over to GPIO descriptors.

Please send a patch, I can't apply the above :(

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlsRHh8ACgkQJNaLcl1U
h9BcIAf/QVTELfKIuHu25/byjgRxQvS63mkX7wuUnOLje4hf+xwXI5rzhjWuMRo3
aEcBDbU580LLBuzBzaP857w0vUy5NvvLlqQFxH/rYQXoDPyH6vjx4TSuSDbyiluq
Ql9wp/7MDevHTL8ZR9AyuSu0x3S5z2Gfsc7jaGT8qkEJiYiLG4Lt/DbYqYBl7rAi
SMfEelxCNTb37YuEF1O7Pu5jIbqcVmzCNszCdDsqeRxsDStmjeJQYwMJjmhawSal
7FUXl/ntJ1wJFk+EHvp82kfGCLTsOMEs7rEYk1W6JizAAUpLlBDUCKu8HpUx6xOl
++QtllxtiAUz1bgY+If+3KxiFClHrQ==
=YYTp
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
